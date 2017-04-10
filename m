Received: from eggs.gnu.org ([2001:4830:134:3::10]:59208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxNqJ-0005YH-TS
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 21:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxNqI-0004uH-MD
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 21:10:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170410005142.GA14050@lemon>
References: <1491741460-10308-1-git-send-email-lidongchen@tencent.com>
	<20170410005142.GA14050@lemon>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 10 Apr 2017 09:10:05 +0800
Message-ID: <CAOGPPbdkQnTU66wpFcuF7oF4_LcUUED2z7aaBZwMNLjqpLLdGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] migration/block: use blk_pwrite_zeroes
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, Apr 10, 2017 at 8:51 AM, Fam Zheng <famz@redhat.com> wrote:
> On Sun, 04/09 20:37, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
>> this maybe cause the qcow2 file size is bigger after migration.
>> This patch check each cluster, use blk_pwrite_zeroes for each
>> zero cluster.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  migration/block.c | 38 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 7734ff7..fe613db 100644
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
>> @@ -934,8 +936,40 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
>>              } else {
>>                  buf = g_malloc(BLOCK_SIZE);
>>                  qemu_get_buffer(f, buf, BLOCK_SIZE);
>> -                ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>> -                                 nr_sectors * BDRV_SECTOR_SIZE, 0);
>> +
>> +                ret = bdrv_get_info(blk_bs(blk), &bdi);
>> +                cluster_size = bdi.cluster_size;
>> +
>> +                if (ret == 0 && cluster_size > 0 &&
>> +                    cluster_size <= BLOCK_SIZE &&
>> +                    BLOCK_SIZE % cluster_size == 0) {
>> +                    int i;
>> +                    int64_t cur_addr;
>> +                    uint8_t *cur_buf;
>> +
>> +                    for (i = 0; i < BLOCK_SIZE / cluster_size; i++) {
>> +                        cur_addr = addr * BDRV_SECTOR_SIZE
>> +                                        + i * cluster_size;
>> +                        cur_buf = buf + i * cluster_size;
>> +
>> +                        if (buffer_is_zero(cur_buf, cluster_size)) {
>> +                            ret = blk_pwrite_zeroes(blk, cur_addr,
>> +                                                    cluster_size,
>> +                                                    BDRV_REQ_MAY_UNMAP);
>> +                        } else {
>> +                             ret = blk_pwrite(blk, cur_addr, cur_buf,
>> +                                              cluster_size, 0);
>> +                        }
>> +
>> +                        if (ret < 0) {
>> +                            g_free(buf);
>> +                            return ret;
>> +                        }
>
> This if block is not necessary because...

Hi Fam:
      It's necessary to check each cluster is written successfully.
      if we remove this if block, it maybe ignore some error, and only check
      the last cluster.
      Thanks.

>
>> +                    }
>> +                } else {
>> +                    ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>> +                                     nr_sectors * BDRV_SECTOR_SIZE, 0);
>> +                }
>>                  g_free(buf);
> ...
>
>
>             if (ret < 0) {
>                 return ret;
>             }
>>              }
>>
>> --
>> 1.8.3.1
>>
>>
>
> If you remove that:
>
> Reviewed-by: Fam Zheng <famz@redhat.com>
