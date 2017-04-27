Received: from eggs.gnu.org ([2001:4830:134:3::10]:41400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3d9J-0001qm-L9
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3d9H-0007iZ-RL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:43:33 -0400
Date: Thu, 27 Apr 2017 14:43:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427064317.GJ9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-21-famz@redhat.com>
	<20170426142216.GI4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426142216.GI4538@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 20/21] file-posix: Add image locking to
 perm operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/26 16:22, Kevin Wolf wrote:
> > @@ -455,6 +473,21 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
> >      }
> >      s->fd = fd;
> >  
> > +    s->lock_fd = -1;
> > +    fd = qemu_open(filename, O_RDONLY);
> 
> Note that with /dev/fdset there can be cases where we can open a file
> O_RDWR, but not O_RDONLY. Should we better just use the same flags as
> for the s->fd?

Makes sense.

> 
> > +    if (fd < 0) {
> > +        if (RAW_LOCK_SUPPORTED) {
> > +            ret = -errno;
> > +            error_setg_errno(errp, errno, "Could not open '%s' for locking",
> > +                             filename);
> > +            qemu_close(s->fd);
> > +            goto fail;
> > +        }
> > +    }
> 
> You still open the fd and possibly error out even with s->use_lock ==
> false. Should the code starting from qemu_open() to here be conditional
> on s->use_lock?

Yes.

> 
> > +    s->lock_fd = fd;
> > +    s->perm = 0;
> > +    s->shared_perm = BLK_PERM_ALL;
> > +
> >  #ifdef CONFIG_LINUX_AIO
> >       /* Currently Linux does AIO only for files opened with O_DIRECT */
> >      if (s->use_linux_aio && !(s->open_flags & O_DIRECT)) {
> > @@ -542,6 +575,156 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
> >      return raw_open_common(bs, options, flags, 0, errp);
> >  }
> >  
> > +typedef enum {
> > +    RAW_PL_PREPARE,
> > +    RAW_PL_COMMIT,
> > +    RAW_PL_ABORT,
> > +} RawPermLockOp;
> > +
> > +/* Lock wanted bytes by @perm and ~@shared_perm in the file; if @unlock ==
> 
> This function doesn't take @perm or @shared_perm. This comment is
> especially confusing because shared_perm_lock_bits == ~shared_perm. We
> should be explicit here that shared_perm_lock_bits is the mask of all
> permissions that _cannot_ be shared.

Will update the comment.

> 
> > + * true, also unlock the unneeded bytes. */
> > +static int raw_apply_lock_bytes(BDRVRawState *s,
> > +                                uint64_t perm_lock_bits,
> > +                                uint64_t shared_perm_lock_bits,
> > +                                bool unlock, Error **errp)
> > +{
> > +    int ret;
> > +    int i;
> > +
> > +    for (i = 0; i < BLK_PERM_MAX; ++i) {
> > +        int off = RAW_LOCK_PERM_BASE + i;
> > +        if (perm_lock_bits & (1ULL << i)) {
> > +            ret = qemu_lock_fd(s->lock_fd, off, 1, false);
> > +            if (ret) {
> > +                error_setg(errp, "Failed to lock byte %d", off);
> 
> Should bdrv_perm_names() be used in this function, too? Maybe not that
> important because we never expect this to fail (we don't do any
> exclusive locks).

Ineed, so going a bit of low level is probably better when it does fail. :)

> 
> > +                return ret;
> > +            }
> > +        } else if (unlock) {
> > +            ret = qemu_unlock_fd(s->lock_fd, off, 1);
> > +            if (ret) {
> > +                error_setg(errp, "Failed to unlock byte %d", off);
> > +                return ret;
> > +            }
> > +        }
> > +    }
> > +    for (i = 0; i < BLK_PERM_MAX; ++i) {
> > +        int off = RAW_LOCK_SHARED_BASE + i;
> > +        if (shared_perm_lock_bits & (1ULL << i)) {
> > +            ret = qemu_lock_fd(s->lock_fd, off, 1, false);
> > +            if (ret) {
> > +                error_setg(errp, "Failed to lock byte %d", off);
> > +                return ret;
> > +            }
> > +        } else if (unlock) {
> > +            ret = qemu_unlock_fd(s->lock_fd, off, 1);
> > +            if (ret) {
> > +                error_setg(errp, "Failed to unlock byte %d", off);
> > +                return ret;
> > +            }
> > +        }
> > +    }
> > +    return 0;
> > +}
> 
> Note: If this function returns an error, we may have acquired some of
> the locks. The caller probably wants to call it again to reset the
> permissions to the old mask.

I think callers do.

> 
> > +/* Check "unshared" bytes implied by @perm and ~@shared_perm in the file. */
> > +static int raw_check_lock_bytes(BDRVRawState *s,
> > +                                uint64_t perm, uint64_t shared_perm,
> > +                                Error **errp)
> > +{
> > +    int ret;
> > +    int i;
> > +
> > +    for (i = 0; i < BLK_PERM_MAX; ++i) {
> > +        int off = RAW_LOCK_SHARED_BASE + i;
> > +        uint64_t p = 1ULL << i;
> > +        if (perm & p) {
> > +            ret = qemu_lock_fd_test(s->lock_fd, off, 1, true);
> > +            if (ret) {
> > +                error_setg(errp,
> > +                           "Failed to check byte %d for \"%s\" permission",
> > +                           off, bdrv_perm_names(p));
> 
> bdrv_perm_names() returns a malloced string, which is leaked here.

Neglected that, will fix.

> 
> > +                error_append_hint(errp,
> > +                                  "Is another process using the image?\n");
> 
> We probably need to tweak the error messages a bit. When I saw this one
> this morning, I felt that if I didn't know how you were going to
> implement the locking, it would make zero sense to me:
> 
> $ ./qemu-img snapshot -l /tmp/test.qcow2
> qemu-img: Could not open '/tmp/test.qcow2': Failed to check byte 101 for shared "write" permission
> Is another process using the image?
> 
> Something shorter and less technical like 'Failed to get "write" lock'
> is probably the friendlier message.

OK, it's shorter and friendlier.

> 
> > +                return ret;
> > +            }
> > +        }
> > +    }
> > +    for (i = 0; i < BLK_PERM_MAX; ++i) {
> > +        int off = RAW_LOCK_PERM_BASE + i;
> > +        uint64_t p = 1ULL << i;
> > +        if (!(shared_perm & p)) {
> > +            ret = qemu_lock_fd_test(s->lock_fd, off, 1, true);
> > +            if (ret) {
> > +                error_setg(errp,
> > +                           "Failed to check byte %d for shared \"%s\" permission",
> > +                           off, bdrv_perm_names(p));
> > +                error_append_hint(errp,
> > +                                  "Is another process using the image?\n");
> > +                return ret;
> > +            }
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int raw_handle_perm_lock(BlockDriverState *bs,
> > +                                RawPermLockOp op,
> > +                                uint64_t new_perm, uint64_t new_shared,
> > +                                Error **errp)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > +    int ret = 0;
> > +    Error *local_err = NULL;
> > +
> > +    if (!RAW_LOCK_SUPPORTED) {
> > +        return 0;
> > +    }
> > +
> > +    if (!s->use_lock) {
> > +        return 0;
> > +    }
> > +
> > +    if (bdrv_get_flags(bs) & BDRV_O_INACTIVE) {
> > +        return 0;
> > +    }
> 
> I don't like the handling of BDRV_O_INACTIVE here in the file-posix
> driver. In theory, the users of the node already shouldn't be requesting
> any problematic permissions while the image is inactive.
> 
> What are the actual problems that we're solving with this and the
> .bdrv_invalidate_cache/.bdrv_inactivate callbacks?

To handle locks in "-incoming" case. Removing this check will result in an
early locking error:

    (gdb) bt
    #0  0x0000555555ba40e7 in raw_check_lock_bytes 
    #1  0x0000555555ba4351 in raw_handle_perm_lock 
        at /stor/work/qemu/block/file-posix.c:729
    #2  0x0000555555ba6984 in raw_check_perm 
    #3  0x0000555555b4b3b2 in bdrv_check_perm 
        at /stor/work/qemu/block.c:1480
    #4  0x0000555555b4baae in bdrv_check_update_perm 
        at /stor/work/qemu/block.c:1665
    #5  0x0000555555b4c0da in bdrv_root_attach_child 
    #6  0x0000555555b4c299 in bdrv_attach_child 
    #7  0x0000555555b4cbc1 in bdrv_open_child 
    #8  0x0000555555b74703 in qcow2_open 
    #9  0x0000555555b4a362 in bdrv_open_driver 
    #10 0x0000555555b4acc2 in bdrv_open_common 
    #11 0x0000555555b4d592 in bdrv_open_inherit 
    #12 0x0000555555b4d9a9 in bdrv_open 
        at /stor/work/qemu/block.c:2538
    #13 0x0000555555b9c185 in blk_new_open 
        at /stor/work/qemu/block/block-backend.c:212
    #14 0x00005555558dcc0c in blockdev_init 
    #15 0x00005555558ddcee in drive_new 
    #16 0x00005555558ed6fd in drive_init_func 
    #17 0x0000555555c58fa0 in qemu_opts_foreach 
        at /stor/work/qemu/util/qemu-option.c:1114
    #18 0x00005555558f620f in main 

> 
> > +    assert(s->lock_fd > 0);
> > +
> > +    switch (op) {
> > +    case RAW_PL_PREPARE:
> > +        ret = raw_apply_lock_bytes(s, s->perm | new_perm,
> > +                                   ~s->shared_perm | ~new_shared,
> > +                                   false, errp);
> > +        if (!ret) {
> > +            ret = raw_check_lock_bytes(s, new_perm, new_shared, errp);
> > +            if (!ret) {
> > +                return 0;
> > +            }
> > +        }
> > +        op = RAW_PL_ABORT;
> 
> op isn't used after this place, I wouldn't be surprised if some compiler
> or static analyser complained about it.

I just don't want to surprise the "case RAW_PL_ABORT:" code. :)

> 
> > +        /* fall through to unlock bytes. */
> 
> Good, this undoes whatever raw_apply_lock_bytes() already has done.
> 
> > +    case RAW_PL_ABORT:
> > +        raw_apply_lock_bytes(s, s->perm, ~s->shared_perm, true, &local_err);
> > +        if (local_err) {
> > +            /* Theoretically the above call only unlocks bytes and it cannot
> > +             * fail. Something weird happened, report it.
> > +             */
> > +            error_report_err(local_err);
> > +        }
> > +        break;
> > +    case RAW_PL_COMMIT:
> > +        raw_apply_lock_bytes(s, new_perm, ~new_shared, true, &local_err);
> > +        if (local_err) {
> > +            /* Theoretically the above call only unlocks bytes and it cannot
> > +             * fail. Something weird happened, report it.
> > +             */
> > +            error_report_err(local_err);
> > +        }
> > +        break;
> > +    }
> > +    return ret;
> > +}
> > +
> >  static int raw_reopen_prepare(BDRVReopenState *state,
> >                                BlockReopenQueue *queue, Error **errp)
> >  {
> > @@ -549,6 +732,8 @@ static int raw_reopen_prepare(BDRVReopenState *state,
> >      BDRVRawReopenState *rs;
> >      int ret = 0;
> >      Error *local_err = NULL;
> > +    uint64_t clear_perms = state->flags & BDRV_O_RDWR ? 0 :
> > +        BLK_PERM_WRITE | BLK_PERM_RESIZE | BLK_PERM_WRITE_UNCHANGED;
> >  
> >      assert(state != NULL);
> >      assert(state->bs != NULL);
> > @@ -613,13 +798,22 @@ static int raw_reopen_prepare(BDRVReopenState *state,
> >      if (rs->fd != -1) {
> >          raw_probe_alignment(state->bs, rs->fd, &local_err);
> >          if (local_err) {
> > -            qemu_close(rs->fd);
> > -            rs->fd = -1;
> >              error_propagate(errp, local_err);
> >              ret = -EINVAL;
> > +            goto fail;
> >          }
> >      }
> >  
> > +    ret = raw_handle_perm_lock(state->bs, RAW_PL_PREPARE,
> > +                               s->perm & ~clear_perms,
> > +                               s->shared_perm, errp);
> 
> Is this a workaround for bdrv_can_set_read_only() not checking whether
> there are still writers attached? Because I think in theory, we should
> be able to assert() that clear_perms are already clear.

You are right, it seems these reopen hunks are superfluous. I will drop them.

> 
> > +    if (ret) {
> > +        goto fail;
> > +    }
> > +    return 0;
> > +fail:
> > +    qemu_close(rs->fd);
> > +    rs->fd = -1;
> >      return ret;
> >  }
> >  
> > @@ -627,6 +821,8 @@ static void raw_reopen_commit(BDRVReopenState *state)
> >  {
> >      BDRVRawReopenState *rs = state->opaque;
> >      BDRVRawState *s = state->bs->opaque;
> > +    uint64_t clear_perms = state->flags & BDRV_O_RDWR ? 0 :
> > +        BLK_PERM_WRITE | BLK_PERM_RESIZE | BLK_PERM_WRITE_UNCHANGED;
> >  
> >      s->open_flags = rs->open_flags;
> >  
> > @@ -635,12 +831,17 @@ static void raw_reopen_commit(BDRVReopenState *state)
> >  
> >      g_free(state->opaque);
> >      state->opaque = NULL;
> > +    raw_handle_perm_lock(state->bs, RAW_PL_COMMIT, s->perm & ~clear_perms,
> > +                         s->shared_perm, NULL);
> 
> Shouldn't we update s->perm here? Or probably move the update into
> raw_handle_perm_lock(). Or even more probably, as said above, replace
> the permission handling in raw_reopen_* by checking permissions in the
> generic block layer beforehand.
> 
> >  }
> >  
> >  
> >  static void raw_reopen_abort(BDRVReopenState *state)
> >  {
> > +    BDRVRawState *s = state->bs->opaque;
> >      BDRVRawReopenState *rs = state->opaque;
> > +    uint64_t clear_perms = state->flags & BDRV_O_RDWR ? 0 :
> > +        BLK_PERM_WRITE | BLK_PERM_RESIZE | BLK_PERM_WRITE_UNCHANGED;
> >  
> >       /* nothing to do if NULL, we didn't get far enough */
> >      if (rs == NULL) {
> > @@ -653,6 +854,8 @@ static void raw_reopen_abort(BDRVReopenState *state)
> >      }
> >      g_free(state->opaque);
> >      state->opaque = NULL;
> > +    raw_handle_perm_lock(state->bs, RAW_PL_ABORT, s->perm & ~clear_perms,
> > +                         s->shared_perm, NULL);
> >  }
> >  
> >  static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> > @@ -1410,6 +1613,10 @@ static void raw_close(BlockDriverState *bs)
> >          qemu_close(s->fd);
> >          s->fd = -1;
> >      }
> > +    if (s->lock_fd >= 0) {
> > +        qemu_close(s->lock_fd);
> > +        s->lock_fd = -1;
> > +    }
> >  }
> >  
> >  static int raw_truncate(BlockDriverState *bs, int64_t offset)
> > @@ -1947,6 +2154,56 @@ static QemuOptsList raw_create_opts = {
> >      }
> >  };
> >  
> > +static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
> > +                          Error **errp)
> > +{
> > +    return raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, errp);
> > +}
> > +
> > +static void raw_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > +    raw_handle_perm_lock(bs, RAW_PL_COMMIT, perm, shared, NULL);
> > +    s->perm = perm;
> > +    s->shared_perm = shared;
> > +}
> > +
> > +static void raw_abort_perm_update(BlockDriverState *bs)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > +
> > +    raw_handle_perm_lock(bs, RAW_PL_ABORT, s->perm, s->shared_perm, NULL);
> 
> The parameters are supposed to be the new permissions, which are
> obviously ignored in the case of RAW_PL_ABORT. Would passing 0 for
> both be more obvious?

OK, I'll change that.

> 
> > +}
> > +
> > +static int raw_inactivate(BlockDriverState *bs)
> > +{
> > +    int ret;
> > +    uint64_t perm = 0;
> > +    uint64_t shared = BLK_PERM_ALL;
> > +
> > +    ret = raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, NULL);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +    raw_handle_perm_lock(bs, RAW_PL_COMMIT, perm, shared, NULL);
> > +    return 0;
> > +}
> > +
> > +
> > +static void raw_invalidate_cache(BlockDriverState *bs, Error **errp)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > +    int ret;
> > +
> > +    assert(!(bdrv_get_flags(bs) & BDRV_O_INACTIVE));
> > +    ret = raw_handle_perm_lock(bs, RAW_PL_PREPARE, s->perm, s->shared_perm,
> > +                               errp);
> > +    if (ret) {
> > +        return;
> > +    }
> > +    raw_handle_perm_lock(bs, RAW_PL_COMMIT, s->perm, s->shared_perm, NULL);
> > +}
> 
> Looks okay if we really need BDRV_O_INACTIVE handling in file-posix.
> 
> Kevin

Fam
