Received: from eggs.gnu.org ([2001:4830:134:3::10]:56162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1ctsD6-0003Db-5k
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1ctsD4-0004zL-EZ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 04:47:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170331072609.GE11195@lemon.lan>
References: <1490440701-12037-1-git-send-email-ashijeetacharya@gmail.com>
	<1490440701-12037-8-git-send-email-ashijeetacharya@gmail.com>
	<20170331072609.GE11195@lemon.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 31 Mar 2017 14:17:01 +0530
Message-ID: <CAC2QTZaL2aDatNoKoxEWn0XYxtfD6RDpB9gWn9h4+QE0vg2mMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 7/7] vmdk: Update metadata for multiple
 clusters
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

On Fri, Mar 31, 2017 at 12:56 PM, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 03/25 16:48, Ashijeet Acharya wrote:
>> Include a next pointer in VmdkMetaData struct to point to the previous
>> allocated L2 table. Modify vmdk_L2update to start updating metadata for
>> allocation of multiple clusters at once.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>>  block/vmdk.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 102 insertions(+), 29 deletions(-)
>>
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 3de8b8f..4517409 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>> @@ -137,6 +137,8 @@ typedef struct VmdkMetaData {
>>      int valid;
>>      uint32_t *l2_cache_entry;
>>      uint32_t nb_clusters;
>> +    uint32_t offset;
>> +    struct VmdkMetaData *next;
>>  } VmdkMetaData;
>>
>>  typedef struct VmdkGrainMarker {
>> @@ -1037,29 +1039,81 @@ static void vmdk_refresh_limits(BlockDriverState *bs, Error **errp)
>>      }
>>  }
>>
>> -static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
>> -                         uint32_t offset)
>> +static int vmdk_alloc_cluster_link_l2(VmdkExtent *extent,
>> +                                      VmdkMetaData *m_data, bool zeroed)
>>  {
>> -    offset = cpu_to_le32(offset);
>> +    int i;
>> +    uint32_t offset, temp_offset;
>> +
>> +    if (zeroed) {
>> +        temp_offset = VMDK_GTE_ZEROED;
>> +    } else {
>> +        temp_offset = m_data->offset;
>> +    }
>> +
>> +    temp_offset = cpu_to_le32(temp_offset);
>> +
>>      /* update L2 table */
>> -    if (bdrv_pwrite_sync(extent->file,
>> +    offset = temp_offset;
>> +    for (i = 0; i < m_data->nb_clusters; i++) {
>> +        if (bdrv_pwrite_sync(extent->file,
>>                  ((int64_t)m_data->l2_offset * 512)
>> -                    + (m_data->l2_index * sizeof(offset)),
>> -                &offset, sizeof(offset)) < 0) {
>> -        return VMDK_ERROR;
>> +                    + ((m_data->l2_index + i) * sizeof(offset)),
>> +                &(offset), sizeof(offset)) < 0) {
>> +            return VMDK_ERROR;
>> +        }
>> +        if (!zeroed) {
>> +            offset += 128;
>> +        }
>>      }
>> +
>>      /* update backup L2 table */
>> +    offset = temp_offset;
>>      if (extent->l1_backup_table_offset != 0) {
>>          m_data->l2_offset = extent->l1_backup_table[m_data->l1_index];
>> -        if (bdrv_pwrite_sync(extent->file,
>> -                    ((int64_t)m_data->l2_offset * 512)
>> -                        + (m_data->l2_index * sizeof(offset)),
>> -                    &offset, sizeof(offset)) < 0) {
>> -            return VMDK_ERROR;
>> +        for (i = 0; i < m_data->nb_clusters; i++) {
>> +            if (bdrv_pwrite_sync(extent->file,
>> +                        ((int64_t)m_data->l2_offset * 512)
>> +                            + ((m_data->l2_index + i) * sizeof(offset)),
>> +                        &(offset), sizeof(offset)) < 0) {
>> +                return VMDK_ERROR;
>> +            }
>> +            if (!zeroed) {
>> +                offset += 128;
>> +            }
>>          }
>>      }
>> +
>> +    offset = temp_offset;
>>      if (m_data->l2_cache_entry) {
>> -        *m_data->l2_cache_entry = offset;
>> +        for (i = 0; i < m_data->nb_clusters; i++) {
>> +            *m_data->l2_cache_entry = offset;
>> +            m_data->l2_cache_entry++;
>> +
>> +            if (!zeroed) {
>> +                offset += 128;
>> +            }
>> +        }
>> +    }
>> +
>> +    return VMDK_OK;
>> +}
>> +
>> +static int vmdk_L2update(VmdkExtent *extent, VmdkMetaData *m_data,
>> +                         bool zeroed)
>> +{
>> +    int ret;
>> +
>> +    while (m_data->next != NULL) {
>> +        VmdkMetaData *next;
>> +
>> +        ret = vmdk_alloc_cluster_link_l2(extent, m_data, zeroed);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +
>> +        next = m_data->next;
>> +        m_data = next;
>
> I don't see why the next pointer is necessary.  Also the tail is always unused,
> why do you need to allocate it?

If I don't allocate the tail, I was getting a segfault in vmdk_pwritev().

> But more importantly, I think you could further batch multiple updates in the
> same L2 table and only do one bdrv_pwrite_sync.

Wouldn't the l2_offset need to change change for every subsequent L2
table i.e. after ever 512 cluster boundary?

Ashijeet

>
> Fam
>
>>      }
>>
>>      return VMDK_OK;
>> @@ -1271,7 +1325,7 @@ exit:
>>   */
>>  static int handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
>>                          uint64_t offset, uint64_t *cluster_offset,
>> -                        int64_t *bytes, VmdkMetaData *m_data,
>> +                        int64_t *bytes, VmdkMetaData **m_data,
>>                          bool allocate, uint32_t *total_alloc_clusters)
>>  {
>>      int l1_index, l2_offset, l2_index;
>> @@ -1280,6 +1334,7 @@ static int handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
>>      uint32_t nb_clusters;
>>      bool zeroed = false;
>>      uint64_t skip_start_bytes, skip_end_bytes;
>> +    VmdkMetaData *old_m_data;
>>      int ret;
>>
>>      ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
>> @@ -1330,13 +1385,21 @@ static int handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
>>          if (ret < 0) {
>>              return ret;
>>          }
>> -        if (m_data) {
>> -            m_data->valid = 1;
>> -            m_data->l1_index = l1_index;
>> -            m_data->l2_index = l2_index;
>> -            m_data->l2_offset = l2_offset;
>> -            m_data->l2_cache_entry = &l2_table[l2_index];
>> -            m_data->nb_clusters = nb_clusters;
>> +
>> +        if (*m_data) {
>> +            old_m_data = *m_data;
>> +            *m_data = g_malloc0(sizeof(**m_data));
>> +
>> +            **m_data = (VmdkMetaData) {
>> +                .valid            =    1,
>> +                .l1_index         =    l1_index,
>> +                .l2_index         =    l2_index,
>> +                .l2_offset        =    l2_offset,
>> +                .l2_cache_entry   =    &l2_table[l2_index],
>> +                .nb_clusters      =    nb_clusters,
>> +                .offset           =    cluster_sector,
>> +                .next             =    old_m_data,
>> +            };
>>          }
>>      }
>>      *cluster_offset = cluster_sector << BDRV_SECTOR_BITS;
>> @@ -1365,7 +1428,7 @@ static int handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
>>   */
>>  static int vmdk_alloc_cluster_offset(BlockDriverState *bs,
>>                                       VmdkExtent *extent,
>> -                                     VmdkMetaData *m_data, uint64_t offset,
>> +                                     VmdkMetaData **m_data, uint64_t offset,
>>                                       bool allocate, uint64_t *cluster_offset,
>>                                       int64_t bytes,
>>                                       uint32_t *total_alloc_clusters)
>> @@ -1385,8 +1448,8 @@ static int vmdk_alloc_cluster_offset(BlockDriverState *bs,
>>      new_cluster_offset = 0;
>>      *cluster_offset = 0;
>>      n_bytes = 0;
>> -    if (m_data) {
>> -        m_data->valid = 0;
>> +    if (*m_data) {
>> +        (*m_data)->valid = 0;
>>      }
>>
>>      /* due to L2 table margins all bytes may not get allocated at once */
>> @@ -1768,9 +1831,11 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>      uint64_t cluster_offset;
>>      uint64_t bytes_done = 0;
>>      uint64_t extent_size;
>> -    VmdkMetaData m_data;
>> +    VmdkMetaData *m_data;
>>      uint32_t total_alloc_clusters = 0;
>>
>> +    m_data = g_malloc0(sizeof(*m_data));
>> +
>>      if (DIV_ROUND_UP(offset, BDRV_SECTOR_SIZE) > bs->total_sectors) {
>>          error_report("Wrong offset: offset=0x%" PRIx64
>>                       " total_sectors=0x%" PRIx64,
>> @@ -1779,6 +1844,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>      }
>>
>>      while (bytes > 0) {
>> +        m_data->next = NULL;
>>          extent = find_extent(s, offset >> BDRV_SECTOR_BITS, extent);
>>          if (!extent) {
>>              return -EIO;
>> @@ -1825,7 +1891,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>                                          total_alloc_clusters;
>>                  if (!zero_dry_run) {
>>                      /* update L2 tables */
>> -                    if (vmdk_L2update(extent, &m_data, VMDK_GTE_ZEROED)
>> +                    if (vmdk_L2update(extent, m_data, zeroed)
>>                              != VMDK_OK) {
>>                          return -EIO;
>>                      }
>> @@ -1839,10 +1905,9 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>              if (ret) {
>>                  return ret;
>>              }
>> -            if (m_data.valid) {
>> +            if (m_data->valid) {
>>                  /* update L2 tables */
>> -                if (vmdk_L2update(extent, &m_data,
>> -                                  cluster_offset >> BDRV_SECTOR_BITS)
>> +                if (vmdk_L2update(extent, m_data, zeroed)
>>                          != VMDK_OK) {
>>                      return -EIO;
>>                  }
>> @@ -1852,6 +1917,13 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>          offset += n_bytes;
>>          bytes_done += n_bytes;
>>
>> +        while (m_data->next != NULL) {
>> +            VmdkMetaData *next;
>> +            next = m_data->next;
>> +            g_free(m_data);
>> +            m_data = next;
>> +        }
>> +
>>          /* update CID on the first write every time the virtual disk is
>>           * opened */
>>          if (!s->cid_updated) {
>> @@ -1862,6 +1934,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>              s->cid_updated = true;
>>          }
>>      }
>> +    g_free(m_data);
>>      return 0;
>>  }
>>
>> --
>> 2.6.2
>>
>>
