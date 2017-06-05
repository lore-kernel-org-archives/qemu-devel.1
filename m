Received: from eggs.gnu.org ([2001:4830:134:3::10]:48655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dHlg0-0003m1-Ts
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 02:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dHlfz-0008UH-TE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 02:39:44 -0400
Date: Mon, 5 Jun 2017 14:39:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170605063930.GB14337@lemon.lan>
References: <1496642007-8309-1-git-send-email-ashijeetacharya@gmail.com>
	<1496642007-8309-7-git-send-email-ashijeetacharya@gmail.com>
	<CAC2QTZZgzsQPVgcwNrFqy3vov-rx8DTUucoJ5JfsSaTUeOuQCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC2QTZZgzsQPVgcwNrFqy3vov-rx8DTUucoJ5JfsSaTUeOuQCQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/8] vmdk: New functions to assist
 allocating multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Mon, 06/05 11:37, Ashijeet Acharya wrote:
> On Mon, Jun 5, 2017 at 11:23 AM, Ashijeet Acharya
> <ashijeetacharya@gmail.com> wrote:
> > Introduce two new helper functions handle_alloc() and
> > vmdk_alloc_cluster_offset(). handle_alloc() helps to allocate multiple
> > clusters at once starting from a given offset on disk and performs COW
> > if necessary for first and last allocated clusters.
> > vmdk_alloc_cluster_offset() helps to return the offset of the first of
> > the many newly allocated clusters. Also, provide proper documentation
> > for both.
> >
> > Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
> > ---
> >  block/vmdk.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 182 insertions(+), 10 deletions(-)
> >
> > diff --git a/block/vmdk.c b/block/vmdk.c
> > index fe2046b..b671dc9 100644
> > --- a/block/vmdk.c
> > +++ b/block/vmdk.c
> > @@ -136,6 +136,7 @@ typedef struct VmdkMetaData {
> >      unsigned int l2_offset;
> >      int valid;
> >      uint32_t *l2_cache_entry;
> > +    uint32_t nb_clusters;
> >  } VmdkMetaData;
> >
> >  typedef struct VmdkGrainMarker {
> > @@ -1242,6 +1243,174 @@ static int get_cluster_table(VmdkExtent *extent, uint64_t offset,
> >      return VMDK_OK;
> >  }
> >
> > +/*
> > + * vmdk_handle_alloc
> > + *
> > + * Allocate new clusters for an area that either is yet unallocated or needs a
> > + * copy on write. If *cluster_offset is non_zero, clusters are only allocated if
> > + * the new allocation can match the specified host offset.
> > + *
> > + * Returns:
> > + *   VMDK_OK:       if new clusters were allocated, *bytes may be decreased if
> > + *                  the new allocation doesn't cover all of the requested area.
> > + *                  *cluster_offset is updated to contain the offset of the
> > + *                  first newly allocated cluster.
> > + *
> > + *   VMDK_UNALLOC:  if no clusters could be allocated. *cluster_offset is left
> > + *                  unchanged.
> > + *
> > + *   VMDK_ERROR:    in error cases
> > + */
> > +static int vmdk_handle_alloc(BlockDriverState *bs, VmdkExtent *extent,
> > +                             uint64_t offset, uint64_t *cluster_offset,
> > +                             int64_t *bytes, VmdkMetaData *m_data,
> > +                             bool allocate, uint32_t *total_alloc_clusters)
> > +{
> > +    int l1_index, l2_offset, l2_index;
> > +    uint32_t *l2_table;
> > +    uint32_t cluster_sector;
> > +    uint32_t nb_clusters;
> > +    bool zeroed = false;
> > +    uint64_t skip_start_bytes, skip_end_bytes;
> > +    int ret;
> > +
> > +    ret = get_cluster_table(extent, offset, &l1_index, &l2_offset,
> > +                            &l2_index, &l2_table);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    cluster_sector = le32_to_cpu(l2_table[l2_index]);
> > +
> > +    skip_start_bytes = vmdk_find_offset_in_cluster(extent, offset);
> > +    /* Calculate the number of clusters to look for. Here we truncate the last
> > +     * cluster, i.e. 1 less than the actual value calculated as we may need to
> > +     * perform COW for the last one. */
> > +    nb_clusters = DIV_ROUND_UP(skip_start_bytes + *bytes,
> > +                               extent->cluster_sectors << BDRV_SECTOR_BITS) - 1;
> > +
> > +    nb_clusters = MIN(nb_clusters, extent->l2_size - l2_index);
> > +    assert(nb_clusters <= INT_MAX);
> > +
> > +    /* update bytes according to final nb_clusters value */
> > +    if (nb_clusters != 0) {
> > +        *bytes = ((nb_clusters * extent->cluster_sectors) << BDRV_SECTOR_BITS)
> > +                 - skip_start_bytes;
> > +    } else {
> > +        nb_clusters = 1;
> > +    }
> > +    *total_alloc_clusters += nb_clusters;
> 
> I have left it as it is for now as I wasn't sure about what you meant.
> You can check my query I posted on v4 of this thread for more so that
> we can solve this soon. :-)

What I meant is to change this to "*total_alloc_clusters = nb_clusters" here,
and pass in a temporary variable from vmdk_pwritev, then do a
"total_alloc_clusters += temp" there. This is more readable than the current
way.

Alternatively, rename "total_alloc_clusters" parameter of this function to
"alloc_clusters_counter" and be done.

Ideally a function's interface should be as localized and stateless as possible.

Fam
