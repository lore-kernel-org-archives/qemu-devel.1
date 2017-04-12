Received: from eggs.gnu.org ([2001:4830:134:3::10]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cy7RN-0000mz-Ov
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cy7RM-0007aF-J5
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:51:25 -0400
MIME-Version: 1.0
In-Reply-To: <CAOGPPbepj9RiVXt8XnNBfkofre1t3oqAU3d3d9CsBDwLNR91_w@mail.gmail.com>
References: <1491912312-23393-1-git-send-email-lidongchen@tencent.com>
	<20170411155958.GE5940@stefanha-x1.localdomain>
	<CAOGPPbepj9RiVXt8XnNBfkofre1t3oqAU3d3d9CsBDwLNR91_w@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 12 Apr 2017 09:51:23 +0800
Message-ID: <CAOGPPbcwg99ZSDKmqv3K2X6C0SLkQJ3WjRzSBWRtT-+V0besmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Wed, Apr 12, 2017 at 9:27 AM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Tue, Apr 11, 2017 at 11:59 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> On Tue, Apr 11, 2017 at 08:05:12PM +0800, jemmy858585@gmail.com wrote:
>>> From: Lidong Chen <lidongchen@tencent.com>
>>>
>>> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
>>> this maybe cause the qcow2 file size is bigger after migration.
>>> This patch check each cluster, use blk_pwrite_zeroes for each
>>> zero cluster.
>>>
>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>> ---
>>>  migration/block.c | 33 +++++++++++++++++++++++++++++++--
>>>  1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/block.c b/migration/block.c
>>> index 7734ff7..5d0635a 100644
>>> --- a/migration/block.c
>>> +++ b/migration/block.c
>>> @@ -885,6 +885,8 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>>      int64_t total_sectors = 0;
>>>      int nr_sectors;
>>>      int ret;
>>> +    BlockDriverInfo bdi;
>>> +    int cluster_size;
>>>
>>>      do {
>>>          addr = qemu_get_be64(f);
>>> @@ -919,6 +921,15 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>>                      error_report_err(local_err);
>>>                      return -EINVAL;
>>>                  }
>>> +
>>> +                ret = bdrv_get_info(blk_bs(blk), &bdi);
>>> +                if (ret == 0 && bdi.cluster_size > 0 &&
>>> +                    bdi.cluster_size <= BLOCK_SIZE &&
>>> +                    BLOCK_SIZE % bdi.cluster_size == 0) {
>>> +                    cluster_size = bdi.cluster_size;
>>> +                } else {
>>> +                    cluster_size = BLOCK_SIZE;
>>
>> This is a nice trick to unify code paths.  It has a disadvantage though:
>>
>> If the "zero blocks" migration capability is enabled and the drive has
>> no cluster_size (e.g. raw files), then the source QEMU process has
>> already scanned for zeroes.  CPU is wasted scanning for zeroes in the
>> destination QEMU process.
>>
>> Given that disk images can be large we should probably avoid unnecessary
>> scanning.  This is especially true because there's no other reason
>> (besides zero detection) to pollute the CPU cache with data from the
>> disk image.
>>
>> In other words, we should only scan for zeroes when
>> !block_mig_state.zero_blocks || cluster_size < BLOCK_SIZE.
>
> This case, the source qemu process will add BLK_MIG_FLAG_ZERO_BLOCK flag.
> It will call blk_pwrite_zeroes already before apply this patch.
> so destination QEMU process will not scanning for zero cluster.
>
> There are two reason cause the destination QEMU process receive the
> block which don't have
> BLK_MIG_FLAG_ZERO_BLOCK flag.
> 1.the source QEMU process is old version, or !block_mig_state.zero_blocks.
> 2.the content of BLOCK_SIZE is not zero.
>
> So if the destination QEMU process receive the block which don't have
> BLK_MIG_FLAG_ZERO_BLOCK flag, it already mee the condition
> !block_mig_state.zero_blocks || cluster_size < BLOCK_SIZE.
>
> so i think it's unnecessary to check this condition again.
>
> Thanks.

Sorry,  you are right.
it will cause the destination QEMU process scanning for zeroes again.

How about this?

                for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
                    cur_buf = buf + i * cluster_size;

                    if ((!block_mig_state.zero_blocks || cluster_size
< BLOCK_SIZE)
                        && buffer_is_zero(cur_buf, cluster_size)) {
                        ret = blk_pwrite_zeroes(blk, cur_addr,
                                                cluster_size,
                                                BDRV_REQ_MAY_UNMAP);
                    } else {
                        ret = blk_pwrite(blk, cur_addr, cur_buf,
                                         cluster_size, 0);
                    }
                    if (ret < 0) {
                        break;
                    }
                }


>
>>
>>> +                }
>>>              }
>>>
>>>              if (total_sectors - addr < BDRV_SECTORS_PER_DIRTY_CHUNK) {
>>> @@ -932,10 +943,28 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>>                                          nr_sectors * BDRV_SECTOR_SIZE,
>>>                                          BDRV_REQ_MAY_UNMAP);
>>>              } else {
>>> +                int i;
>>> +                int64_t cur_addr;
>>> +                uint8_t *cur_buf;
>>> +
>>>                  buf = g_malloc(BLOCK_SIZE);
>>>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
>>> -                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>>> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
>>> +                for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
>>> +                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
>>> +                    cur_buf = buf + i * cluster_size;
>>> +
>>> +                    if (buffer_is_zero(cur_buf, cluster_size)) {
>>> +                        ret = blk_pwrite_zeroes(blk, cur_addr,
>>> +                                                cluster_size,
>>> +                                                BDRV_REQ_MAY_UNMAP);
>>> +                    } else {
>>> +                        ret = blk_pwrite(blk, cur_addr, cur_buf,
>>> +                                         cluster_size, 0);
>>> +                    }
>>> +                    if (ret < 0) {
>>> +                        break;
>>> +                    }
>>> +                }
>>>                  g_free(buf);
>>>              }
