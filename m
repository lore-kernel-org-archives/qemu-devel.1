Received: from eggs.gnu.org ([2001:4830:134:3::10]:36601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.kucera@gmail.com>) id 1d7zgA-0006em-8b
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.kucera@gmail.com>) id 1d7zg6-0004aP-0Y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:35:30 -0400
MIME-Version: 1.0
In-Reply-To: <c86e58d0-920a-0a09-fe3e-a522759af1c7@redhat.com>
References: <CAKVPjOZ8Y8U2zHgo_06aozrdd9_Cq6txWrX5F4HnFefAUjimyQ@mail.gmail.com>
	<971bcdf7-046f-4fea-223c-ebd75505b94b@redhat.com>
	<CAKVPjObJA2Vhz58AQG74E3AuH7Eus1wc_phrS2VqNbWX65COMA@mail.gmail.com>
	<c86e58d0-920a-0a09-fe3e-a522759af1c7@redhat.com>
From: =?UTF-8?Q?Daniel_Ku=C4=8Dera?= <daniel.kucera@gmail.com>
Date: Tue, 9 May 2017 09:35:23 +0200
Message-ID: <CAKVPjOa9WJrTEbX8mG=pyrjngT1dvx_Bw5L0s0ME1CGik1879Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] migration: add incremental drive-mirror and
 blockdev-mirror with dirtymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:Block Jobs" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

2017-05-08 19:29 GMT+02:00 John Snow <jsnow@redhat.com>:

>
>
> On 05/04/2017 03:45 AM, Daniel Ku=C4=8Dera wrote:
> >
> > 2017-05-04 1:44 GMT+02:00 John Snow <jsnow@redhat.com
> > <mailto:jsnow@redhat.com>>:
> >
> >
> >
> >     On 05/03/2017 03:56 AM, Daniel Ku=C4=8Dera wrote:
> >     > Hi all,
> >     >
> >     > this patch adds possibility to start mirroring since specific
> dirtyblock
> >     > bitmap.
> >     > The use-case is, for live migrations with ZFS volume used as bloc=
k
> device:
> >     > 1. make dirtyblock bitmap in qemu
> >
> >     A "block dirty bitmap," I assume you mean. Through which interface?
> >     "block dirty bitmap add" via QMP?
> >
> >
> > Yes.
> >
> >
> >     > 2. make ZFS volume snapshot
> >
> >     ZFS Volume Snapshot is going to be a filesystem-level operation,
> isn't
> >     it? That is, creating this snapshot will necessarily create new dir=
ty
> >     sectors, yes?
> >
> >
> > No, we are using "zfs volumes" which are block devices (similar to LVM)
> >
> > # blockdev --report /dev/zstore/storage4
> > RO    RA   SSZ   BSZ   StartSec            Size   Device
> > rw   256   512  4096          0     42949672960   /dev/zstore/storage4
> >
> > -drive
> > file=3D/dev/zstore/storage4,format=3Draw,if=3Dnone,id=3Ddrive-
> scsi0-0-0-0,cache=3Dnone,discard=3Dunmap
> >
> >
>
> Ah, I see. Clearly I don't know much about ZFS in practice.
>
> >     > 3. zfs send/receive the snapshot to target machine
> >
> >     Why? Is this an attempt to make the process faster?
> >
> >
> > This preserves and transfers the whole chain of snapshots to destinatio=
n
> > host, not only current state as it would be with drive-mirror sync: ful=
l
> >
> >
> >
> >     > 4. start mirroring to destination with block map from step 1
> >
> >     This makes me a little nervous: what guarantees do you have that th=
e
> >     bitmap and the ZFS snapshot were synchronous?
> >
> >
> > It doesn't have to be synchronous (or atomic). The "block dirty bitmap"
> > just needs to be done prior to ZFS snapshot. Those few writes done in
> > the meantime don't hurt to be done twice.
> >
>
> Hm, I suppose that's right, pending cache issues, perhaps?
>
> (1) Write occurs; cached
> (2) Bitmap is added
> (3) Write occurs, cached
> (4) ZFS snapshot is taken
> (5) Data is flushed to backing storage.
>
> Now, the ZFS snapshot is migrated, but is missing the writes that
> occurred in (1) and (3).
>
> Next, we mirror the data in the bitmap, but it only includes the data
> from (3).
>
> The target now appears to be missing the write from (1) -- maybe,
> depending on how the volume snapshot occurs.
>

Yes, that's why I'm using cache=3Dnone. Libvirt doesn't allow you to migrat=
e
VM which uses drive cache anyway (unless you specify flag unsafe).


>
> >
> >
> >     > 5. live migrate VM state to destination
> >     >
> >     > The point is, that I'm not able to live stream zfs changed data t=
o
> >     > destination
> >     > to ensure same volume state in the moment of switchover of
> migrated VM
> >     > to the new hypervisor.
> >
> >     I'm a little concerned about the mixing of filesystem and block lev=
el
> >     snapshots...
> >
> >
> > As I explained above, ZFS snapshots are also block level.
> >
> >
> >
> >     >
> >     >
> >     > From 7317d731d51c5d743d7a4081b368f0a6862856d7 Mon Sep 17 00:00:00
> 2001
> >
> >     What happened to your timestamp?
> >
> >     > From: Daniel Kucera <daniel.kucera@gmail.com <mailto:
> daniel.kucera@gmail.com>>
> >     > Date: Tue, 2 May 2017 15:00:39 +0000
> >     > Subject: [PATCH] migration: add incremental drive-mirror and
> blockdev-mirror
> >
> >     Your actual email subject here, however, is missing the [PATCH] tag=
,
> >     which is useful for it getting picked up by the patchew build bot.
> >
> >     >  with dirtymap added parameter bitmap which will be used instead
> >     of newly
> >     >  created dirtymap in mirror_start_job
> >     >
> >     > Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com
> >     <mailto:daniel.kucera@gmail.com>>
> >     > ---
> >     >  block/mirror.c            | 41
> >     ++++++++++++++++++++++++-----------------
> >     >  blockdev.c                |  6 +++++-
> >     >  include/block/block_int.h |  4 +++-
> >     >  qapi/block-core.json      | 12 ++++++++++--
> >     >  4 files changed, 42 insertions(+), 21 deletions(-)
> >     >
> >     > diff --git a/block/mirror.c b/block/mirror.c
> >     > index 9f5eb69..02b2f69 100644
> >     > --- a/block/mirror.c
> >     > +++ b/block/mirror.c
> >     > @@ -49,7 +49,7 @@ typedef struct MirrorBlockJob {
> >     >      BlockDriverState *to_replace;
> >     >      /* Used to block operations on the drive-mirror-replace
> target */
> >     >      Error *replace_blocker;
> >     > -    bool is_none_mode;
> >     > +    MirrorSyncMode sync_mode;
> >     >      BlockMirrorBackingMode backing_mode;
> >     >      BlockdevOnError on_source_error, on_target_error;
> >     >      bool synced;
> >     > @@ -523,7 +523,9 @@ static void mirror_exit(BlockJob *job, void
> >     *opaque)
> >     >      bdrv_child_try_set_perm(mirror_top_bs->backing, 0,
> BLK_PERM_ALL,
> >     >                              &error_abort);
> >     >      if (s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
> >     > -        BlockDriverState *backing =3D s->is_none_mode ? src :
> s->base;
> >     > +        BlockDriverState *backing =3D
> >     > +        (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) ||
> >     > +        (s->sync_mode =3D=3D MIRROR_SYNC_MODE_NONE) ? src : s->b=
ase;
> >     >          if (backing_bs(target_bs) !=3D backing) {
> >     >              bdrv_set_backing_hd(target_bs, backing, &local_err);
> >     >              if (local_err) {
> >     > @@ -771,7 +773,8 @@ static void coroutine_fn mirror_run(void
> *opaque)
> >     >      mirror_free_init(s);
> >     >
> >     >      s->last_pause_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> >     > -    if (!s->is_none_mode) {
> >     > +    if ((s->sync_mode !=3D MIRROR_SYNC_MODE_INCREMENTAL) &&
> >     > +      (s->sync_mode !=3D MIRROR_SYNC_MODE_NONE)) {
> >     >          ret =3D mirror_dirty_init(s);
> >     >          if (ret < 0 || block_job_is_cancelled(&s->common)) {
> >     >              goto immediate_exit;
> >     > @@ -1114,7 +1117,8 @@ static void mirror_start_job(const char
> *job_id,
> >     > BlockDriverState *bs,
> >
> >     Something appears to have corrupted your patch. Did you copy/paste
> this
> >     into gmail? I am unable to apply it.
> >
> >     Please use "git send-email" as detailed in the wiki contributors
> guide.
> >
> >
> > Okay, I'll try to fix these issues and send the patch again, ha
> >
> >
> >
> >     >                               BlockCompletionFunc *cb,
> >     >                               void *opaque,
> >     >                               const BlockJobDriver *driver,
> >     > -                             bool is_none_mode, BlockDriverState
> >     *base,
> >     > +                             MirrorSyncMode sync_mode, const cha=
r
> >     *bitmap,
> >     > +                             BlockDriverState *base,
> >     >                               bool auto_complete, const char
> >     > *filter_node_name,
> >     >                               Error **errp)
> >     >  {
> >     > @@ -1203,7 +1207,7 @@ static void mirror_start_job(const char
> *job_id,
> >     > BlockDriverState *bs,
> >     >      s->replaces =3D g_strdup(replaces);
> >     >      s->on_source_error =3D on_source_error;
> >     >      s->on_target_error =3D on_target_error;
> >     > -    s->is_none_mode =3D is_none_mode;
> >     > +    s->sync_mode =3D sync_mode;
> >     >      s->backing_mode =3D backing_mode;
> >     >      s->base =3D base;
> >     >      s->granularity =3D granularity;
> >     > @@ -1213,9 +1217,16 @@ static void mirror_start_job(const char
> >     *job_id,
> >     > BlockDriverState *bs,
> >     >          s->should_complete =3D true;
> >     >      }
> >     >
> >     > -    s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs, granularity=
,
> NULL,
> >     > errp);
> >     > -    if (!s->dirty_bitmap) {
> >     > -        goto fail;
> >     > +    if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
> >     > +        s->dirty_bitmap =3D bdrv_find_dirty_bitmap(bs, bitmap);
> >
> >     You're using a potentially undefined string here. You've also now
> split
> >     the error case for if we fail to start the coroutine -- one case ha=
s
> >     created a new bitmap, the other has merely picked up a handle to it=
.
> On
> >     failure in one case, we wish to free the bitmap -- in the other, we
> >     don't.
> >
> >     Whoa, actually, it looks like the code as-is doesn't free the bitma=
p
> on
> >     failure! that's a problem. I think there should be a call to
> >     release_dirty_bitmap somewhere here. The only one I can see is in
> >     mirror_run.
> >
> >     > +        if (!s->dirty_bitmap) {
> >     > +            goto fail;
> >
> >     You can't jump straight to the failure label without setting an err=
or
> >     message. Prior instances in this function do not because functions
> they
> >     are calling have set errp for them. Please use err_setg.
> >
> >     > +        }
> >     > +    } else {
> >
> >     You're not checking to see if a bitmap was provided but the sync mo=
de
> >     wasn't incremental, which we also need to validate.
> >
> >     > +        s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs,
> >     granularity, NULL,
> >     > errp);
> >     > +        if (!s->dirty_bitmap) {
> >     > +            goto fail;
> >     > +        }
> >     >      }
> >     >
> >     >      /* Required permissions are already taken with blk_new() */
> >     > @@ -1265,24 +1276,19 @@ fail:
> >     >  void mirror_start(const char *job_id, BlockDriverState *bs,
> >     >                    BlockDriverState *target, const char *replaces=
,
> >     >                    int64_t speed, uint32_t granularity, int64_t
> >     buf_size,
> >     > -                  MirrorSyncMode mode, BlockMirrorBackingMode
> >     backing_mode,
> >     > +                  MirrorSyncMode mode, const char *bitmap,
> >     > +                  BlockMirrorBackingMode backing_mode,
> >     >                    BlockdevOnError on_source_error,
> >     >                    BlockdevOnError on_target_error,
> >     >                    bool unmap, const char *filter_node_name, Erro=
r
> >     **errp)
> >     >  {
> >     > -    bool is_none_mode;
> >     >      BlockDriverState *base;
> >     >
> >     > -    if (mode =3D=3D MIRROR_SYNC_MODE_INCREMENTAL) {
> >     > -        error_setg(errp, "Sync mode 'incremental' not supported"=
);
> >     > -        return;
> >     > -    }
> >     > -    is_none_mode =3D mode =3D=3D MIRROR_SYNC_MODE_NONE;
> >     >      base =3D mode =3D=3D MIRROR_SYNC_MODE_TOP ? backing_bs(bs) :=
 NULL;
> >     >      mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target,
> replaces,
> >     >                       speed, granularity, buf_size, backing_mode,
> >     >                       on_source_error, on_target_error, unmap,
> >     NULL, NULL,
> >     > -                     &mirror_job_driver, is_none_mode, base,
> false,
> >     > +                     &mirror_job_driver, mode, bitmap, base,
> false,
> >     >                       filter_node_name, errp);
> >     >  }
> >     >
> >     > @@ -1305,7 +1311,8 @@ void commit_active_start(const char *job_id=
,
> >     > BlockDriverState *bs,
> >     >      mirror_start_job(job_id, bs, creation_flags, base, NULL,
> >     speed, 0, 0,
> >     >                       MIRROR_LEAVE_BACKING_CHAIN,
> >     >                       on_error, on_error, true, cb, opaque,
> >     > -                     &commit_active_job_driver, false, base,
> >     auto_complete,
> >     > +                     &commit_active_job_driver,
> >     MIRROR_SYNC_MODE_FULL,
> >     > +                     NULL, base, auto_complete,
> >     >                       filter_node_name, &local_err);
> >     >      if (local_err) {
> >     >          error_propagate(errp, local_err);
> >     > diff --git a/blockdev.c b/blockdev.c
> >     > index 6428206..2569924 100644
> >     > --- a/blockdev.c
> >     > +++ b/blockdev.c
> >     > @@ -3379,6 +3379,7 @@ static void blockdev_mirror_common(const ch=
ar
> >     > *job_id, BlockDriverState *bs,
> >     >                                     enum MirrorSyncMode sync,
> >     >                                     BlockMirrorBackingMode
> >     backing_mode,
> >     >                                     bool has_speed, int64_t speed=
,
> >     > +                                   bool has_bitmap, const char
> >     *bitmap,
> >     >                                     bool has_granularity, uint32_=
t
> >     > granularity,
> >     >                                     bool has_buf_size, int64_t
> >     buf_size,
> >     >                                     bool has_on_source_error,
> >     > @@ -3440,7 +3441,7 @@ static void blockdev_mirror_common(const ch=
ar
> >     > *job_id, BlockDriverState *bs,
> >     >       */
> >     >      mirror_start(job_id, bs, target,
> >     >                   has_replaces ? replaces : NULL,
> >     > -                 speed, granularity, buf_size, sync, backing_mod=
e,
> >     > +                 speed, granularity, buf_size, sync, bitmap,
> >     backing_mode,
> >
> >     You never validate the string passed in by the user before passing
> it on
> >     to internal routines; you don't check the value of "has_bitmap" at
> any
> >     point. You need to check has_bitmap and find that the user has
> provided
> >     a valid bitmap name before handing off to mirror_start.
> >
> >     Take a look at do_drive_backup for how this is handled there.
> >
> >     >                   on_source_error, on_target_error, unmap,
> >     filter_node_name,
> >     >                   errp);
> >     >  }
> >     > @@ -3575,6 +3576,7 @@ void qmp_drive_mirror(DriveMirror *arg,
> >     Error **errp)
> >     >      blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL,
> bs,
> >     > target_bs,
> >     >                             arg->has_replaces, arg->replaces,
> >     arg->sync,
> >     >                             backing_mode, arg->has_speed,
> arg->speed,
> >     > +                           arg->has_bitmap, arg->bitmap,
> >     >                             arg->has_granularity, arg->granularit=
y,
> >     >                             arg->has_buf_size, arg->buf_size,
> >     >                             arg->has_on_source_error,
> >     arg->on_source_error,
> >     > @@ -3593,6 +3595,7 @@ void qmp_blockdev_mirror(bool has_job_id,
> >     const char
> >     > *job_id,
> >     >                           bool has_replaces, const char *replaces=
,
> >     >                           MirrorSyncMode sync,
> >     >                           bool has_speed, int64_t speed,
> >     > +                         bool has_bitmap, const char *bitmap,
> >     >                           bool has_granularity, uint32_t
> granularity,
> >     >                           bool has_buf_size, int64_t buf_size,
> >     >                           bool has_on_source_error,
> >     > @@ -3627,6 +3630,7 @@ void qmp_blockdev_mirror(bool has_job_id,
> >     const char
> >     > *job_id,
> >     >      blockdev_mirror_common(has_job_id ? job_id : NULL, bs,
> target_bs,
> >     >                             has_replaces, replaces, sync,
> >     backing_mode,
> >     >                             has_speed, speed,
> >     > +                           has_bitmap, bitmap,
> >     >                             has_granularity, granularity,
> >     >                             has_buf_size, buf_size,
> >     >                             has_on_source_error, on_source_error,
> >     > diff --git a/include/block/block_int.h b/include/block/block_int.=
h
> >     > index 4f8cd29..3c59d69 100644
> >     > --- a/include/block/block_int.h
> >     > +++ b/include/block/block_int.h
> >     > @@ -827,6 +827,7 @@ void commit_active_start(const char *job_id,
> >     > BlockDriverState *bs,
> >     >   * @granularity: The chosen granularity for the dirty bitmap.
> >     >   * @buf_size: The amount of data that can be in flight at one
> time.
> >     >   * @mode: Whether to collapse all images in the chain to the
> target.
> >     > + * @bitmap: The dirty bitmap if sync_mode is
> >     MIRROR_SYNC_MODE_INCREMENTAL.
> >
> >     This doesn't match what this field is in practice, which is a
> >     user-string from the QMP monitor, which is never checked to see if
> it is
> >     valid or not (or present or not.)
> >
> >     The documentation here reflects what it should be, but not what it
> is.
> >
> >     >   * @backing_mode: How to establish the target's backing chain
> after
> >     > completion.
> >     >   * @on_source_error: The action to take upon error reading from
> >     the source.
> >     >   * @on_target_error: The action to take upon error writing to th=
e
> >     target.
> >     > @@ -844,7 +845,8 @@ void commit_active_start(const char *job_id,
> >     > BlockDriverState *bs,
> >     >  void mirror_start(const char *job_id, BlockDriverState *bs,
> >     >                    BlockDriverState *target, const char *replaces=
,
> >     >                    int64_t speed, uint32_t granularity, int64_t
> >     buf_size,
> >     > -                  MirrorSyncMode mode, BlockMirrorBackingMode
> >     backing_mode,
> >     > +                  MirrorSyncMode mode, const char *bitmap,
> >     > +                  BlockMirrorBackingMode backing_mode,
> >     >                    BlockdevOnError on_source_error,
> >     >                    BlockdevOnError on_target_error,
> >     >                    bool unmap, const char *filter_node_name, Erro=
r
> >     **errp);
> >     > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >     > index 87fb747..8e3d9b2 100644
> >     > --- a/qapi/block-core.json
> >     > +++ b/qapi/block-core.json
> >     > @@ -1502,6 +1502,10 @@
> >     >  #
> >     >  # @speed:  the maximum speed, in bytes per second
> >     >  #
> >     > +# @bitmap: the name of dirty bitmap if sync is "incremental".
> >     > +#          Must be present if sync is "incremental", must NOT be
> >     present
> >     > +#          otherwise. (Since 2.10)
> >     > +#
> >     >  # @sync: what parts of the disk image should be copied to the
> >     destination
> >     >  #        (all the disk, only the sectors allocated in the topmos=
t
> >     image, or
> >     >  #        only new I/O).
> >     > @@ -1533,7 +1537,7 @@
> >     >    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
> >     >              '*format': 'str', '*node-name': 'str', '*replaces':
> >     'str',
> >     >              'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
> >     > -            '*speed': 'int', '*granularity': 'uint32',
> >     > +            '*speed': 'int', '*bitmap': 'str', '*granularity':
> >     'uint32',
> >     >              '*buf-size': 'int', '*on-source-error':
> >     'BlockdevOnError',
> >     >              '*on-target-error': 'BlockdevOnError',
> >     >              '*unmap': 'bool' } }
> >     > @@ -1652,6 +1656,10 @@
> >     >  #
> >     >  # @speed:  the maximum speed, in bytes per second
> >     >  #
> >     > +# @bitmap: the name of dirty bitmap if sync is "incremental".
> >     > +#          Must be present if sync is "incremental", must NOT be
> >     present
> >     > +#          otherwise. (Since 2.10)
> >     > +#
> >     >  # @sync: what parts of the disk image should be copied to the
> >     destination
> >     >  #        (all the disk, only the sectors allocated in the topmos=
t
> >     image, or
> >     >  #        only new I/O).
> >     > @@ -1694,7 +1702,7 @@
> >     >    'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
> >     >              '*replaces': 'str',
> >     >              'sync': 'MirrorSyncMode',
> >     > -            '*speed': 'int', '*granularity': 'uint32',
> >     > +            '*speed': 'int', '*bitmap': 'str', '*granularity':
> >     'uint32',
> >     >              '*buf-size': 'int', '*on-source-error':
> >     'BlockdevOnError',
> >     >              '*on-target-error': 'BlockdevOnError',
> >     >              '*filter-node-name': 'str' } }
> >     >
> >
> >     --
> >     =E2=80=94js
> >
> >
> > Thanks for the notes.
> >
> > D.
>
> Thanks for explaining the use-case, I'll take a look at the newer
> version shortly.
>
> --js
>



S pozdravom / Best regards
Daniel Kucera.
