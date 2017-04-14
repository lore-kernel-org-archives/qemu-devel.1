Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cyukO-0003TP-Hz
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cyukN-00083S-Jn
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:30:20 -0400
MIME-Version: 1.0
In-Reply-To: <20170414060015.GA12191@lemon>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 14 Apr 2017 14:30:18 +0800
Message-ID: <CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Fri, Apr 14, 2017 at 2:00 PM, Fam Zheng <famz@redhat.com> wrote:
> On Thu, 04/13 10:34, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
>> this may cause the qcow2 file size to be bigger after migration.
>> This patch checks each cluster, using blk_pwrite_zeroes for each
>> zero cluster.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>> v6 changelog:
>> Fix up some grammar in the comment.
>> ---
>>  migration/block.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 7734ff7..41c7a55 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -885,6 +885,8 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>      int64_t total_sectors = 0;
>>      int nr_sectors;
>>      int ret;
>> +    BlockDriverInfo bdi;
>> +    int cluster_size;
>>
>>      do {
>>          addr = qemu_get_be64(f);
>> @@ -919,6 +921,15 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>                      error_report_err(local_err);
>>                      return -EINVAL;
>>                  }
>> +
>> +                ret = bdrv_get_info(blk_bs(blk), &bdi);
>> +                if (ret == 0 && bdi.cluster_size > 0 &&
>> +                    bdi.cluster_size <= BLOCK_SIZE &&
>> +                    BLOCK_SIZE % bdi.cluster_size == 0) {
>> +                    cluster_size = bdi.cluster_size;
>> +                } else {
>> +                    cluster_size = BLOCK_SIZE;
>> +                }
>>              }
>>
>>              if (total_sectors - addr < BDRV_SECTORS_PER_DIRTY_CHUNK) {
>> @@ -932,10 +943,30 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>                                          nr_sectors * BDRV_SECTOR_SIZE,
>>                                          BDRV_REQ_MAY_UNMAP);
>>              } else {
>> +                int i;
>> +                int64_t cur_addr;
>> +                uint8_t *cur_buf;
>> +
>>                  buf = g_malloc(BLOCK_SIZE);
>>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
>> -                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
>> +                for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
>> +                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
>> +                    cur_buf = buf + i * cluster_size;
>> +
>> +                    if ((!block_mig_state.zero_blocks ||
>> +                        cluster_size < BLOCK_SIZE) &&
>> +                        buffer_is_zero(cur_buf, cluster_size)) {
>> +                        ret = blk_pwrite_zeroes(blk, cur_addr,
>> +                                                cluster_size,
>> +                                                BDRV_REQ_MAY_UNMAP);
>> +                    } else {
>> +                        ret = blk_pwrite(blk, cur_addr, cur_buf,
>> +                                         cluster_size, 0);
>> +                    }
>> +                    if (ret < 0) {
>> +                        break;
>> +                    }
>> +                }
>>                  g_free(buf);
>>              }
>
> Sorry for asking this question so late, but, before it gets too late: did you
> evaluate the performance impact of this change under real world workload?
>
> Effectively, if no cluster is zero, this patch still splits a big write into
> small ones, which is the opposition of usual performance optimizations (i.e.
> trying to coalesce requests).

I test this patch for qcow2, the migration speed is the same before
apply this patch.

Do you know some other format which have very small cluster size?

>
> Fam
