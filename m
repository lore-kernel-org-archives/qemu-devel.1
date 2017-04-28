Received: from eggs.gnu.org ([2001:4830:134:3::10]:47246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d48Wt-0000Va-Lu
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d48Wp-0002Ui-IR
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d48Wp-0002TB-7R
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39F2AC057FA4
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 16:13:54 +0000 (UTC)
Date: Fri, 28 Apr 2017 17:13:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428161347.GD3276@work-vm>
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-7-quintela@redhat.com>
	<20170428144729.GB3276@work-vm> <87y3uk8src.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3uk8src.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 6/6] migration: Pass Error ** argument to
 {save, load}_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> This way we use the "normal" way of printing errors for hmp commands.
> >> 
> >> --
> >> Paolo suggestion
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >
> > <snip>
> >
> >> +int save_vmstate(const char *name, Error **errp)
> >>  {
> >>      BlockDriverState *bs, *bs1;
> >>      QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> >> @@ -2076,29 +2076,27 @@ int save_vmstate(const char *name)
> >>      uint64_t vm_state_size;
> >>      qemu_timeval tv;
> >>      struct tm tm;
> >> -    Error *local_err = NULL;
> >>      AioContext *aio_context;
> >>  
> >>      if (!bdrv_all_can_snapshot(&bs)) {
> >> -        error_report("Device '%s' is writable but does not support snapshots",
> >> -                     bdrv_get_device_name(bs));
> >> +        error_setg(errp, "Device '%s' is writable but does not support "
> >> +                   "snapshots", bdrv_get_device_name(bs));
> >>          return ret;
> >>      }
> >>  
> >>      /* Delete old snapshots of the same name */
> >>      if (name) {
> >> -        ret = bdrv_all_delete_snapshot(name, &bs1, &local_err);
> >> +        ret = bdrv_all_delete_snapshot(name, &bs1, errp);
> >>          if (ret < 0) {
> >> -            error_reportf_err(local_err,
> >> -                              "Error while deleting snapshot on device '%s': ",
> >> -                              bdrv_get_device_name(bs1));
> >> +            error_prepend(errp, "Error while deleting snapshot on device "
> >> +                          "'%s': ", bdrv_get_device_name(bs1));
> >
> > I thought the rule was that you had to use a local_err and use error_propagate?
> > (I hate that rule)
> 
> Quote qapi/error.h:
> 
>  * Receive an error and pass it on to the caller:
>  *     Error *err = NULL;
>  *     foo(arg, &err);
>  *     if (err) {
>  *         handle the error...
>  *         error_propagate(errp, err);
>  *     }
>  * where Error **errp is a parameter, by convention the last one.
>  *
>  * Do *not* "optimize" this to
>  *     foo(arg, errp);
>  *     if (*errp) { // WRONG!
>  *         handle the error...
>  *     }
>  * because errp may be NULL!
>  *
>  * But when all you do with the error is pass it on, please use
>  *     foo(arg, errp);
>  * for readability.
> 
> Neglects to mention you can error_prepend() and still avoid
> error_propagate(), but the comment is long enough as it is.

Ah ok, that does make life easier.

> >>              return ret;
> >>          }
> >>      }
> >>  
> >>      bs = bdrv_all_find_vmstate_bs();
> >>      if (bs == NULL) {
> >> -        error_report("No block device can accept snapshots");
> >> +        error_setg(errp, "No block device can accept snapshots");
> >>          return ret;
> >>      }
> >>      aio_context = bdrv_get_aio_context(bs);
> >> @@ -2107,7 +2105,7 @@ int save_vmstate(const char *name)
> >>  
> >>      ret = global_state_store();
> >>      if (ret) {
> >> -        error_report("Error saving global state");
> >> +        error_setg(errp, "Error saving global state");
> >>          return ret;
> >>      }
> >>      vm_stop(RUN_STATE_SAVE_VM);
> >> @@ -2139,21 +2137,20 @@ int save_vmstate(const char *name)
> >>      /* save the VM state */
> >>      f = qemu_fopen_bdrv(bs, 1);
> >>      if (!f) {
> >> -        error_report("Could not open VM state file");
> >> +        error_setg(errp, "Could not open VM state file");
> >>          goto the_end;
> >>      }
> >> -    ret = qemu_savevm_state(f, &local_err);
> >> +    ret = qemu_savevm_state(f, errp);
> >>      vm_state_size = qemu_ftell(f);
> >>      qemu_fclose(f);
> >>      if (ret < 0) {
> >> -        error_report_err(local_err);
> >>          goto the_end;
> >>      }
> >>  
> >>      ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
> >>      if (ret < 0) {
> >> -        error_report("Error while creating snapshot on '%s'",
> >> -                     bdrv_get_device_name(bs));
> >> +        error_setg(errp, "Error while creating snapshot on '%s'",
> >> +                   bdrv_get_device_name(bs));
> >>          goto the_end;
> >>      }
> >>  
> >> @@ -2226,7 +2223,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >>      migration_incoming_state_destroy();
> >>  }
> >>  
> >> -int load_vmstate(const char *name)
> >> +int load_vmstate(const char *name, Error **errp)
> >>  {
> >>      BlockDriverState *bs, *bs_vm_state;
> >>      QEMUSnapshotInfo sn;
> >> @@ -2236,20 +2233,22 @@ int load_vmstate(const char *name)
> >>      MigrationIncomingState *mis = migration_incoming_get_current();
> >>  
> >>      if (!bdrv_all_can_snapshot(&bs)) {
> >> -        error_report("Device '%s' is writable but does not support snapshots",
> >> -                     bdrv_get_device_name(bs));
> >> +        error_setg(errp,
> >> +                   "Device '%s' is writable but does not support snapshots",
> >> +                   bdrv_get_device_name(bs));
> >>          return -ENOTSUP;
> >>      }
> >>      ret = bdrv_all_find_snapshot(name, &bs);
> >>      if (ret < 0) {
> >> -        error_report("Device '%s' does not have the requested snapshot '%s'",
> >> -                     bdrv_get_device_name(bs), name);
> >> +        error_setg(errp,
> >> +                   "Device '%s' does not have the requested snapshot '%s'",
> >> +                   bdrv_get_device_name(bs), name);
> >>          return ret;
> >>      }
> >>  
> >>      bs_vm_state = bdrv_all_find_vmstate_bs();
> >>      if (!bs_vm_state) {
> >> -        error_report("No block device supports snapshots");
> >> +        error_setg(errp, "No block device supports snapshots");
> >>          return -ENOTSUP;
> >>      }
> >>      aio_context = bdrv_get_aio_context(bs_vm_state);
> >> @@ -2261,8 +2260,8 @@ int load_vmstate(const char *name)
> >>      if (ret < 0) {
> >>          return ret;
> >>      } else if (sn.vm_state_size == 0) {
> >> -        error_report("This is a disk-only snapshot. Revert to it offline "
> >> -            "using qemu-img.");
> >> +        error_setg(errp, "This is a disk-only snapshot. Revert to it "
> >> +                   " offline using qemu-img");
> >>          return -EINVAL;
> >>      }
> >>  
> >> @@ -2271,7 +2270,7 @@ int load_vmstate(const char *name)
> >>  
> >>      ret = bdrv_all_goto_snapshot(name, &bs);
> >>      if (ret < 0) {
> >> -        error_report("Error %d while activating snapshot '%s' on '%s'",
> >> +        error_setg(errp, "Error %d while activating snapshot '%s' on '%s'",
> >>                       ret, name, bdrv_get_device_name(bs));
> >>          return ret;
> >>      }
> >> @@ -2279,7 +2278,7 @@ int load_vmstate(const char *name)
> >>      /* restore the VM state */
> >>      f = qemu_fopen_bdrv(bs_vm_state, 0);
> >>      if (!f) {
> >> -        error_report("Could not open VM state file");
> >> +        error_setg(errp, "Could not open VM state file");
> >>          return -EINVAL;
> >>      }
> >>  
> >> @@ -2293,7 +2292,7 @@ int load_vmstate(const char *name)
> >>  
> >>      migration_incoming_state_destroy();
> >>      if (ret < 0) {
> >> -        error_report("Error %d while loading VM state", ret);
> >> +        error_setg(errp, "Error %d while loading VM state", ret);
> >>          return ret;
> >>      }
> >>  
> >> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> >> index 8cced46..fdc4353 100644
> >> --- a/replay/replay-snapshot.c
> >> +++ b/replay/replay-snapshot.c
> >> @@ -62,14 +62,16 @@ void replay_vmstate_register(void)
> >>  
> >>  void replay_vmstate_init(void)
> >>  {
> >> +    Error *err = NULL;
> >> +
> >>      if (replay_snapshot) {
> >>          if (replay_mode == REPLAY_MODE_RECORD) {
> >> -            if (save_vmstate(replay_snapshot) != 0) {
> >> +            if (save_vmstate(replay_snapshot, &err) != 0) {
> >>                  error_report("Could not create snapshot for icount record");
> >>                  exit(1);
> >>              }
> >>          } else if (replay_mode == REPLAY_MODE_PLAY) {
> >> -            if (load_vmstate(replay_snapshot) != 0) {
> >> +            if (load_vmstate(replay_snapshot, &err) != 0) {
> >>                  error_report("Could not load snapshot for icount replay");
> >>                  exit(1);
> >>              }
> >
> > How do either of the contents of the 'err' get reported - they're not
> > printed at all are they?
> > (I don't like error_abort, I'd rather see the other message as well).
> 
> I guess you mean &error_fatal.
> 
> Consider error_report_err().

Yes, thanks.

Dave

> >
> > Dave
> >
> >> diff --git a/vl.c b/vl.c
> >> index 0b4ed52..8b3ec2e 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -4681,7 +4681,9 @@ int main(int argc, char **argv, char **envp)
> >>      if (replay_mode != REPLAY_MODE_NONE) {
> >>          replay_vmstate_init();
> >>      } else if (loadvm) {
> >> -        if (load_vmstate(loadvm) < 0) {
> >> +        Error *local_err = NULL;
> >> +        if (load_vmstate(loadvm, &local_err) < 0) {
> >> +            error_report_err(local_err);
> >>              autostart = 0;
> >>          }
> >>      }
> >> -- 
> >> 2.9.3
> >> 
> >> 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
