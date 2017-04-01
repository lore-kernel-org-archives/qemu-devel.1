Received: from eggs.gnu.org ([2001:4830:134:3::10]:45165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cuIyx-0007va-5E
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cuIyw-0002Na-4K
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:22:19 -0400
MIME-Version: 1.0
In-Reply-To: <20170331060311.GD11195@lemon.lan>
References: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
	<1490440701-12037-4-git-send-email-ashijeetacharya@gmail.com>
	<20170331060311.GD11195@lemon.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 1 Apr 2017 18:52:12 +0530
Message-ID: <CAC2QTZZ8uiPMX6yBV-ayGVFmUY2m96g8amQ1XQpMZhXaxY5mJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 3/7] vmdk: Factor out metadata loading
 code out of get_cluster_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

On Fri, Mar 31, 2017 at 11:33 AM, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 03/25 16:48, Ashijeet Acharya wrote:
>> Move the cluster tables loading code out of the existing
>> get_cluster_offset() function and implement it in separate
>
> Now it's renamed to vmdk_perform_cow() in previous patch, the commit message
> following it should be updated.

No, I think you confused get_cluster_offset() with get_whole_cluster() here :-)
I have a separate patch 5/7 which renames get_cluster_offset(), so the
commit message is fine till this stage.
>
>> get_cluster_table() and vmdk_L2load() functions. This patch will help
>> us avoid code duplication in future patches of this series.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>>  block/vmdk.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index f5fda2c..a42322e 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -1037,6 +1037,105 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
>>  }
>>
>>  /*
>> + * vmdk_L2load
>
> Personally, I think vmdk_l2load is good enough, the upper case doesn't add
> readability but makes it slightly harder to type.

Done.

>
>> + *
>> + * Loads a new L2 table into memory. If the table is in the cache, the cache
>> + * is used; otherwise the L2 table is loaded from the image file.
>> + *
>> + * Returns:
>> + *   VMDK_OK:       on success
>> + *   VMDK_ERROR:    in error cases
>> + */
>> +static int vmdk_L2load(VmdkExtent *extent, uint64_t offset, int l2_offset,
>> +                       uint32_t **new_l2_table, int *new_l2_index)
>> +{
>> +    int min_index, i, j;
>> +    uint32_t *l2_table;
>> +    uint32_t min_count;
>> +
>> +    for (i = 0; i < L2_CACHE_SIZE; i++) {
>> +        if (l2_offset == extent->l2_cache_offsets[i]) {
>> +            /* increment the hit count */
>> +            if (++extent->l2_cache_counts[i] == 0xffffffff) {
>
> Please use UINT32_MAX.

Done.

>
>> +                for (j = 0; j < L2_CACHE_SIZE; j++) {
>> +                    extent->l2_cache_counts[j] >>= 1;
>> +                }
>> +            }
>> +            l2_table = extent->l2_cache + (i * extent->l2_size);
>> +            goto found;
>> +        }
>> +    }
>> +    /* not found: load a new entry in the least used one */
>> +    min_index = 0;
>> +    min_count = 0xffffffff;
>
> Please use UINT32_MAX.

Done.

>
>> +    for (i = 0; i < L2_CACHE_SIZE; i++) {
>> +        if (extent->l2_cache_counts[i] < min_count) {
>> +            min_count = extent->l2_cache_counts[i];
>> +            min_index = i;
>> +        }
>> +    }
>> +    l2_table = extent->l2_cache + (min_index * extent->l2_size);
>> +    if (bdrv_pread(extent->file,
>> +                (int64_t)l2_offset * 512,
>> +                l2_table,
>> +                extent->l2_size * sizeof(uint32_t)
>> +            ) != extent->l2_size * sizeof(uint32_t)) {
>> +        return VMDK_ERROR;
>> +    }
>> +
>> +    extent->l2_cache_offsets[min_index] = l2_offset;
>> +    extent->l2_cache_counts[min_index] = 1;
>> +found:
>> +    *new_l2_index = ((offset >> 9) / extent->cluster_sectors) % extent->l2_size;
>> +    *new_l2_table = l2_table;
>> +
>> +    return VMDK_OK;
>> +}
>> +
>> +/*
>> + * get_cluster_table
>> + *
>> + * for a given offset, load (and allocate if needed) the l2 table.
>> + *
>> + * Returns:
>> + *   VMDK_OK:        on success
>> + *
>> + *   VMDK_UNALLOC:   if cluster is not mapped
>> + *
>> + *   VMDK_ERROR:     in error cases
>> + */
>> +static int get_cluster_table(VmdkExtent *extent, uint64_t offset,
>> +                             int *new_l1_index, int *new_l2_offset,
>> +                             int *new_l2_index, uint32_t **new_l2_table)
>
> Again, a static function must be introduced with the code change where it is
> used, at least for once. It keeps the compiler happy (-Wunused-function) and
> makes reviewing easy.

Done.


Ashijeet
