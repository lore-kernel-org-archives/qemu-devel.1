Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxkTJ-00075D-Hc
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1cxkTI-0006VW-G0
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 21:19:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170410160023.GG3214@stefanha-x1.localdomain>
References: <1491741460-10308-1-git-send-email-lidongchen@tencent.com>
	<20170410160023.GG3214@stefanha-x1.localdomain>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 11 Apr 2017 09:19:49 +0800
Message-ID: <CAOGPPbd=xQ_a5VtTdD6Cw0tmmaybjjbVgOPfF2CLw_E6fekZng@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Tue, Apr 11, 2017 at 12:00 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Sun, Apr 09, 2017 at 08:37:40PM +0800, jemmy858585@gmail.com wrote:
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
>
> How about:
>
>   if (blk != blk_prev) {
>       blk_prev = blk;
>       total_sectors = blk_nb_sectors(blk);
>       if (total_sectors <= 0) {
>           error_report("Error getting length of block device %s",
>                        device_name);
>           return -EINVAL;
>       }
>
>       blk_invalidate_cache(blk, &local_err);
>       if (local_err) {
>           error_report_err(local_err);
>           return -EINVAL;
>       }
>
> +     ret = bdrv_get_info(blk_bs(blk), &bdi);
> +     if (ret == 0 && cluster_size > 0 && cluster_size <= BLOCK_SIZE &&
> +         BLOCK_SIZE % cluster_size == 0) {
> +         zero_cluster_size = bdi.cluster_size;
> +     } else {
> +         zero_cluster_size = 0;
> +     }
>   }
>
> That way we only fetch the cluster size once per device.
>
> When processing a block we do without repeatedly fetching the cluster
> size:
>
>   if (zero_cluster_size) {
>      ...detect zeroes...
>   }

good idea, i will test again for this patch.

>
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
>
> Indentation is off here.
>
>> +                        }
>> +
>> +                        if (ret < 0) {
>> +                            g_free(buf);
>> +                            return ret;
>> +                        }
>> +                    }
>> +                } else {
>> +                    ret = blk_pwrite(blk, addr * BDRV_SECTOR_SIZE, buf,
>> +                                     nr_sectors * BDRV_SECTOR_SIZE, 0);
>> +                }
>>                  g_free(buf);
>>              }
>>
>> --
>> 1.8.3.1
>>
