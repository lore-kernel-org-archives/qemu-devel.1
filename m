Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dH7Xw-0007yv-I9
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dH7Xv-0004io-EI
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 07:48:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170601135758.GG13127@lemon.lan>
References: <1492838021-10538-1-git-send-email-ashijeetacharya@gmail.com>
	<1492838021-10538-7-git-send-email-ashijeetacharya@gmail.com>
	<20170601135758.GG13127@lemon.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 3 Jun 2017 17:18:37 +0530
Message-ID: <CAC2QTZaFDpJMoUTDyxm9ukkY1aji40oZxjJWQ3SnoRb=aqfr4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 6/8] vmdk: New functions to assist
 allocating multiple clusters
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

On Thu, Jun 1, 2017 at 7:27 PM, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 04/22 10:43, Ashijeet Acharya wrote:
>> Introduce two new helper functions handle_alloc() and
>> vmdk_alloc_cluster_offset(). handle_alloc() helps to allocate multiple
>> clusters at once starting from a given offset on disk and performs COW
>> if necessary for first and last allocated clusters.
>> vmdk_alloc_cluster_offset() helps to return the offset of the first of
>> the many newly allocated clusters. Also, provide proper documentation
>> for both.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>>  block/vmdk.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 182 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 7862791..8d34cd9 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -136,6 +136,7 @@ typedef struct VmdkMetaData {
>>      unsigned int l2_offset;
>>      int valid;
>>      uint32_t *l2_cache_entry;
>> +    uint32_t nb_clusters;
>>  } VmdkMetaData;
>>
>>  typedef struct VmdkGrainMarker {
>> @@ -1242,6 +1243,174 @@ static int get_cluster_table(VmdkExtent *extent, uint64_t offset,
>>      return VMDK_OK;
>>  }
>>
>> +/*
>> + * handle_alloc
>> + *
>> + * Allocate new clusters for an area that either is yet unallocated or needs a
>> + * copy on write. If *cluster_offset is non_zero, clusters are only allocated if
>> + * the new allocation can match the specified host offset.
>> + *
>> + * Returns:
>> + *   VMDK_OK:       if new clusters were allocated, *bytes may be decreased if
>> + *                  the new allocation doesn't cover all of the requested area.
>> + *                  *cluster_offset is updated to contain the offset of the
>> + *                  first newly allocated cluster.
>> + *
>> + *   VMDK_UNALLOC:  if no clusters could be allocated. *cluster_offset is left
>> + *                  unchanged.
>> + *
>> + *   VMDK_ERROR:    in error cases
>> + */
>> +static int handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
>> +                        uint64_t offset, uint64_t *cluster_offset,
>> +                        int64_t *bytes, VmdkMetaData *m_data,
>> +                        bool allocate, uint32_t *total_alloc_clusters)
>
> Not super important but personally I always prefer to stick to a "vmdk_" prefix
> when naming local identifiers, so that ctags and git grep can take it easy.

Done.

>
>> +{
>> +    int l1_index, l2_offset, l2_index;
>> +    uint32_t *l2_table;
>> +    uint32_t cluster_sector;
>> +    uint32_t nb_clusters;
>> +    bool zeroed = false;
>> +    uint64_t skip_start_bytes, skip_end_bytes;
>> +    int ret;
>> +
>> +    ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
>> +                            &l2_index, &l2_table);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    cluster_sector = le32_to_cpu(l2_table[l2_index]);
>> +
>> +    skip_start_bytes = vmdk_find_offset_in_cluster(extent, offset);
>> +    /* Calculate the number of clusters to look for. Here we truncate the last
>> +     * cluster, i.e. 1 less than the actual value calculated as we may need to
>> +     * perform COW for the last one. */
>> +    nb_clusters = DIV_ROUND_UP(skip_start_bytes + *bytes,
>> +                            extent->cluster_sectors << BDRV_SECTOR_BITS) - 1;
>
> Alignment could be improved: here ^

Done.

>
>> +
>> +    nb_clusters = MIN(nb_clusters, extent->l2_size - l2_index);
>> +    assert(nb_clusters <= INT_MAX);
>> +
>> +    /* update bytes according to final nb_clusters value */
>> +    if (nb_clusters != 0) {
>> +        *bytes = ((nb_clusters * extent->cluster_sectors) << 9)
>
> Better use BDRV_SECTOR_BITS instead of 9.

Done.

>
>> +                                            - skip_start_bytes;
>> +    } else {
>> +        nb_clusters = 1;
>> +    }
>> +    *total_alloc_clusters += nb_clusters;
>
> It is weird that you increment *total_alloc_clusters instead of simply assigning
> to it, because it's not clear why before reading the caller code.
>
I am incrementing it because we allocate clusters in every iteration
and *total_alloc_clusters contains number of clusters allocated in
total and not just in one iteration. So basically it is a sum of all
the m_data->nb_clusters present in every element of the linked list I
prepare.

> It's better if you just return nb_clusters from this function (either as a
> return value, or assign to *total_alloc_clusters), then do the accumulation in
> vmdk_pwritev by adding m_data->nb_clusters, which is simpler.

If I understood it correctly, you mean to say that I should add all
the m_data->nb_clusters present in my linked list inside
vmdk_pwritev() using a loop? If yes, I think that's what I have been
doing earlier by incrementing *total_alloc_clusters there itself and
is better, no?
Also, please correct me if I am wrong :-)

Ashijeet
