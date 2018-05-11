Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fH5Zm-0006a5-Ms
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <renyime@gmail.com>) id 1fH5Zk-0004zW-1h
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:47:02 -0400
MIME-Version: 1.0
References: <1525782441-2224-1-git-send-email-ivanren@tencent.com>
	<84eb5455-cfd9-ba2b-9a7b-12c5204290bc@redhat.com>
In-Reply-To: <84eb5455-cfd9-ba2b-9a7b-12c5204290bc@redhat.com>
From: Ivan Ren <renyime@gmail.com>
Date: Fri, 11 May 2018 18:46:47 +0800
Message-ID: <CA+6E1=kV_RN8t8=9n=gdWu8g4UqaaBzwpnG7eSR0PmEBdELe9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qcow2: fix preallocation with metadata on
 bare block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: mreitz@redhat.com, kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

> This says what the patch does, but not why.  What is the actual use case
> scenario where changing semantics to have the qcow2 overwrite the
> garbage to read 0 instead of any pre-existing garbage, when dealing with
> portions of the disk that have not yet been written by the guest?  Are
> you trying to prevent a security leak of previous information that may
> be resident on the block device?

Yes, any pre-existing data on the device should not be read, otherwise it
may lead security leak in cloud environment.
For metadata preallocated qcow2 on bare block device, I think
QCOW_OFLAG_ZERO is more suitable to prevent this problem than other(such as
do "dd" before create a preallocated qcow2).

> > +            /* Check the underlying device type.
> > +             * If the underlying device is a block device, we add
> > +             * QCOW_OFLAG_ZERO for all preallocated l2 entry to ignore
dirty
> > +             * data on block device.
> > +             * If the underlying device can't be used with stat(return
< 0),
> > +             * treat it as a regular file.
> > +             */
> > +            if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
>
> Won't work.  You cannot guarantee that bs->filename is a local file; it
> could be a remote protocol, such as NBD or gluster.  If you need to know
> whether bs->filename has a property that it reads as all zeroes when
> first initialized, we already have
> BlockDriverInfo::unallocated_blocks_are_zero, which is set to true for
> regular files and false for block devices.

Yes, BlockDriverInfo::unallocated_blocks_are_zero is enough and better to
distinguish the device.

> > +                ret = qcow2_alloc_cluster_link_l2(bs, meta, 0);
> > +            } else {
> > +                ret = qcow2_alloc_cluster_link_l2(bs, meta,
QCOW_OFLAG_ZERO);
>
> Why would we not want to pass QCOW_OFLAG_ZERO always, rather than
> special-casing it based on what the underlying protocol might already
> have in place?

Yea, it sounds good. Always pass QCOW_OFLAG_ZERO in preallocation has no
problem and can guarantee no garbage will be read when preallcate metadata
for qcow2 on any underlying device.

I will send a v2 patch.

Thanks.

On Thu, May 10, 2018 at 11:57 PM Eric Blake <eblake@redhat.com> wrote:

> On 05/08/2018 07:27 AM, Ivan Ren wrote:
> > Create a qcow2 directly on bare block device with
> > "-o preallocation=metadata" option. When read this qcow2, it will
> > return dirty data of block device.
>
> Yes, reading garbage is expected.
>
> > This patch add QCOW_OFLAG_ZERO
> > for all preallocated l2 entry if the underlying device is a bare
> > block device.
>
> This says what the patch does, but not why.  What is the actual use case
> scenario where changing semantics to have the qcow2 overwrite the
> garbage to read 0 instead of any pre-existing garbage, when dealing with
> portions of the disk that have not yet been written by the guest?  Are
> you trying to prevent a security leak of previous information that may
> be resident on the block device?
>
> >
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
> > ---
> >   block/qcow2-cluster.c |  5 +++--
> >   block/qcow2.c         | 19 ++++++++++++++++---
> >   block/qcow2.h         |  3 ++-
> >   3 files changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index 1aee726..b9e0ceb 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -919,7 +919,8 @@ fail:
> >       return ret;
> >   }
> >
> > -int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
> > +int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m,
> > +                                uint64_t flags)
> >   {
> >       BDRVQcow2State *s = bs->opaque;
> >       int i, j = 0, l2_index, ret;
> > @@ -969,7 +970,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState
> *bs, QCowL2Meta *m)
> >           }
> >
> >           l2_slice[l2_index + i] = cpu_to_be64((cluster_offset +
> > -                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
> > +                    (i << s->cluster_bits)) | QCOW_OFLAG_COPIED |
> flags);
> >        }
> >
> >
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 2f36e63..093735c 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -2044,7 +2044,7 @@ static coroutine_fn int
> qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
> >           while (l2meta != NULL) {
> >               QCowL2Meta *next;
> >
> > -            ret = qcow2_alloc_cluster_link_l2(bs, l2meta);
> > +            ret = qcow2_alloc_cluster_link_l2(bs, l2meta, 0);
> >               if (ret < 0) {
> >                   goto fail;
> >               }
> > @@ -2534,6 +2534,7 @@ static void coroutine_fn preallocate_co(void
> *opaque)
> >       uint64_t host_offset = 0;
> >       unsigned int cur_bytes;
> >       int ret;
> > +    struct stat st;
> >       QCowL2Meta *meta;
> >
> >       qemu_co_mutex_lock(&s->lock);
> > @@ -2552,7 +2553,19 @@ static void coroutine_fn preallocate_co(void
> *opaque)
> >           while (meta) {
> >               QCowL2Meta *next = meta->next;
> >
> > -            ret = qcow2_alloc_cluster_link_l2(bs, meta);
> > +            /* Check the underlying device type.
> > +             * If the underlying device is a block device, we add
> > +             * QCOW_OFLAG_ZERO for all preallocated l2 entry to ignore
> dirty
> > +             * data on block device.
> > +             * If the underlying device can't be used with stat(return
> < 0),
> > +             * treat it as a regular file.
> > +             */
> > +            if (stat(bs->filename, &st) < 0 || !S_ISBLK(st.st_mode)) {
>
> Won't work.  You cannot guarantee that bs->filename is a local file; it
> could be a remote protocol, such as NBD or gluster.  If you need to know
> whether bs->filename has a property that it reads as all zeroes when
> first initialized, we already have
> BlockDriverInfo::unallocated_blocks_are_zero, which is set to true for
> regular files and false for block devices.
>
> > +                ret = qcow2_alloc_cluster_link_l2(bs, meta, 0);
> > +            } else {
> > +                ret = qcow2_alloc_cluster_link_l2(bs, meta,
> QCOW_OFLAG_ZERO);
>
> Why would we not want to pass QCOW_OFLAG_ZERO always, rather than
> special-casing it based on what the underlying protocol might already
> have in place?
>
> > +            }
> > +
> >               if (ret < 0) {
> >                   qcow2_free_any_clusters(bs, meta->alloc_offset,
> >                                           meta->nb_clusters,
> QCOW2_DISCARD_NEVER);
> > @@ -3458,7 +3471,7 @@ static int qcow2_truncate(BlockDriverState *bs,
> int64_t offset,
> >               };
> >               qemu_co_queue_init(&allocation.dependent_requests);
> >
> > -            ret = qcow2_alloc_cluster_link_l2(bs, &allocation);
> > +            ret = qcow2_alloc_cluster_link_l2(bs, &allocation, 0);
> >               if (ret < 0) {
> >                   error_setg_errno(errp, -ret, "Failed to update L2
> tables");
> >                   qcow2_free_clusters(bs, host_offset,
> > diff --git a/block/qcow2.h b/block/qcow2.h
> > index adf5c39..9a59602 100644
> > --- a/block/qcow2.h
> > +++ b/block/qcow2.h
> > @@ -617,7 +617,8 @@ uint64_t
> qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
> >                                            uint64_t offset,
> >                                            int compressed_size);
> >
> > -int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
> > +int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m,
> > +                                uint64_t flags);
> >   int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
> >                             uint64_t bytes, enum qcow2_discard_type type,
> >                             bool full_discard);
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
