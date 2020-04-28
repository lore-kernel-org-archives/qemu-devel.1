Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C3DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A8F206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTsF34qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A8F206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTPJ8-0003yA-DF
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 08:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTPII-0002pC-IV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTPIA-0003l4-8d
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:24:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTPI9-0003kw-Qv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588076689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7hkUQ4wypClX0Yqobd8XDMFm6Y+ETc6u2haNjiS3Ns=;
 b=GTsF34qjpwnQSq6CGrwR0RGPewL5LvoFBil+evMCgQ6HDPHMyWbtLc3oF8zwUMhy8E53j/
 zwi4ud6Vn9mnuY9x+4MM3FSgVCOUHwfQK36JBfv+I9+1X0oN+um+WtFsJS+f9hwKHscchR
 xFgnh1j7qQGg6Dmq3fn9hr6Pf1rLEt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-y8KCYNTqPGi_u1eXpej4mA-1; Tue, 28 Apr 2020 08:24:44 -0400
X-MC-Unique: y8KCYNTqPGi_u1eXpej4mA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC60800688;
 Tue, 28 Apr 2020 12:24:43 +0000 (UTC)
Received: from work-vm (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72A7A272A7;
 Tue, 28 Apr 2020 12:24:42 +0000 (UTC)
Date: Tue, 28 Apr 2020 13:24:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
Message-ID: <20200428122439.GD2794@work-vm>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-21-alazar@bitdefender.com>
 <20200427190855.GN2923@work-vm> <15880760940.91F7391B.25850@host>
MIME-Version: 1.0
In-Reply-To: <15880760940.91F7391B.25850@host>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marian Rotariu <marian.c.rotariu@gmail.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Adalbert Laz=C4=83r (alazar@bitdefender.com) wrote:
> On Mon, 27 Apr 2020 20:08:55 +0100, "Dr. David Alan Gilbert" <dgilbert@re=
dhat.com> wrote:
> > * Adalbert Laz=C4=83r (alazar@bitdefender.com) wrote:
> > > From: Marian Rotariu <marian.c.rotariu@gmail.com>
> > >=20
> > > It is possible that the introspection tool has made some changes insi=
de
> > > the introspected VM which can make the guest crash if the introspecti=
on
> > > connection is suddenly closed.
> > >=20
> > > When the live migration starts, for now, the introspection tool is
> > > signaled to remove its hooks from the introspected VM.
> > >=20
> > > CC: Juan Quintela <quintela@redhat.com>
> > > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
> > > Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
> >=20
> > OK, so this isn't too intrusive to the migration code; and other than
> > renaming 'start_live_migration_thread' to
> > 'start_outgoing_migration_thread' I think I'd be OK with this,
> >=20
> > but it might depend what your overall aim is.
> >=20
> > For example, you might be better intercepting each migration_state
> > change in your notifier, that's much finer grain than just the start of
> > migration.
>=20
> Thank you, Dave.
>=20
> We want to intercept the live migration and 'block' it while the guest
> is running (some changes made to the guest by the introspection app has
> to be undone while the vCPUs are in certain states).
>=20
> I'm not sure what is the best way to block these kind of events
> (including the pause/shutdown commands). If calling main_loop_wait()
> is enough (patch [22/26] kvm: vmi: add 'async_unhook' property [1])
> then we can drop a lot of code.
>=20
> The use of a notifier will be nice, but from what I understand, we can't
> block the migration from a notification callback.

Oh, if your intention is *just* to block a migration starting then you
can use 'migrate_add_blocker' - see hw/9pfs/9p.c for an example where
it's used and then removed; they use it to stop migration while the fs
 is mounted.  That causes an attempt to start a migration to give an
error (of your choosing).

> > The other thing I worry about is that there doesn't seem to be much
> > guard against odd orderings of things - for example, what happens
> > if the introspection client was to issue the  INTERCEPT_MIGRATE command
> > twice while a migration was already running?  Or before an actual
> > incoming channel connetion had happened?
> >=20
> > Dave
>=20
> Sorry that I haven't described the interception. When we intercept
> an action that we want to 'block', we set a static variable first,
> regardless if the introspection channel is connected or not, and :
>=20
>    - if the introspection channel is not connected we don't block the
>    action, but this (variable) will prevent the activation of this
>    channel until the action (ie. migrate) is completed (a). I assume
>    that there could be only one migrate (or suspend/pause) user command
>    at any given time (b).
>=20
>    - if the introspection channel is connected, the introspection app
>    is signaled to start its unhook/undo process. We let the code flow
>    continue, but the action (migrate/suspend/pause) is delayed until
>    the introspection channel is closed. Meanwhile, any other intercepted
>    action will not be blocked/delayed (c), but the fact that these action=
s
>    are in progress is saved to static variables and the introspecton
>    channel won't be reactivated.
>=20
> Indeed, there are cases that are not handled well:
>=20
>   a) if the migration is started and canceled before the introspection
>   object is created (through QMP), the introspection channel will be
>   disabled until the next migration starts and finishes.
>=20
>   b) if a migration command has been delayed, a following migrate command
>   (if this is possible) won't be delayed and we will have two migration
>   threads started.
>=20
>   c) if a migration command has been delayed, a following suspend/pause
>   command won't be delayed and the introspection app might not have
>   enough time to finish its unhook/undo process.

Yeh that sounds a bit messy.

Dave


> [1]: https://lore.kernel.org/qemu-devel/20200415005938.23895-23-alazar@bi=
tdefender.com/
>=20
> > > ---
> > >  accel/kvm/vmi.c                | 31 +++++++++++++++++++++++++++----
> > >  include/sysemu/vmi-intercept.h |  1 +
> > >  migration/migration.c          | 18 +++++++++++++++---
> > >  migration/migration.h          |  2 ++
> > >  4 files changed, 45 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
> > > index 90906478b4..ea7191e48d 100644
> > > --- a/accel/kvm/vmi.c
> > > +++ b/accel/kvm/vmi.c
> > > @@ -21,6 +21,8 @@
> > >  #include "chardev/char.h"
> > >  #include "chardev/char-fe.h"
> > >  #include "migration/vmstate.h"
> > > +#include "migration/migration.h"
> > > +#include "migration/misc.h"
> > > =20
> > >  #include "sysemu/vmi-intercept.h"
> > >  #include "sysemu/vmi-handshake.h"
> > > @@ -58,6 +60,7 @@ typedef struct VMIntrospection {
> > >      int64_t vm_start_time;
> > > =20
> > >      Notifier machine_ready;
> > > +    Notifier migration_state_change;
> > >      bool created_from_command_line;
> > > =20
> > >      bool kvmi_hooked;
> > > @@ -74,9 +77,11 @@ static const char *action_string[] =3D {
> > >      "suspend",
> > >      "resume",
> > >      "force-reset",
> > > +    "migrate",
> > >  };
> > > =20
> > >  static bool suspend_pending;
> > > +static bool migrate_pending;
> > > =20
> > >  #define TYPE_VM_INTROSPECTION "introspection"
> > > =20
> > > @@ -88,6 +93,15 @@ static bool suspend_pending;
> > >  static Error *vm_introspection_init(VMIntrospection *i);
> > >  static void vm_introspection_reset(void *opaque);
> > > =20
> > > +static void migration_state_notifier(Notifier *notifier, void *data)
> > > +{
> > > +    MigrationState *s =3D data;
> > > +
> > > +    if (migration_has_failed(s)) {
> > > +        migrate_pending =3D false;
> > > +    }
> > > +}
> > > +
> > >  static void machine_ready(Notifier *notifier, void *data)
> > >  {
> > >      VMIntrospection *i =3D container_of(notifier, VMIntrospection, m=
achine_ready);
> > > @@ -144,6 +158,9 @@ static void complete(UserCreatable *uc, Error **e=
rrp)
> > > =20
> > >      ic->uniq =3D i;
> > > =20
> > > +    i->migration_state_change.notify =3D migration_state_notifier;
> > > +    add_migration_state_change_notifier(&i->migration_state_change);
> > > +
> > >      qemu_register_reset(vm_introspection_reset, i);
> > >  }
> > > =20
> > > @@ -478,6 +495,9 @@ static void continue_with_the_intercepted_action(=
VMIntrospection *i)
> > >      case VMI_INTERCEPT_SUSPEND:
> > >          vm_stop(RUN_STATE_PAUSED);
> > >          break;
> > > +    case VMI_INTERCEPT_MIGRATE:
> > > +        start_live_migration_thread(migrate_get_current());
> > > +        break;
> > >      default:
> > >          error_report("VMI: %s: unexpected action %d",
> > >                       __func__, i->intercepted_action);
> > > @@ -571,9 +591,9 @@ static void chr_event_open(VMIntrospection *i)
> > >  {
> > >      Error *local_err =3D NULL;
> > > =20
> > > -    if (suspend_pending) {
> > > -        info_report("VMI: %s: too soon (suspend=3D%d)",
> > > -                    __func__, suspend_pending);
> > > +    if (suspend_pending || migrate_pending) {
> > > +        info_report("VMI: %s: too soon (suspend=3D%d, migrate=3D%d)"=
,
> > > +                    __func__, suspend_pending, migrate_pending);
> > >          maybe_disable_socket_reconnect(i);
> > >          qemu_chr_fe_disconnect(&i->sock);
> > >          return;
> > > @@ -608,7 +628,7 @@ static void chr_event_close(VMIntrospection *i)
> > >      cancel_unhook_timer(i);
> > >      cancel_handshake_timer(i);
> > > =20
> > > -    if (suspend_pending) {
> > > +    if (suspend_pending || migrate_pending) {
> > >          maybe_disable_socket_reconnect(i);
> > > =20
> > >          if (i->intercepted_action !=3D VMI_INTERCEPT_NONE) {
> > > @@ -680,6 +700,9 @@ static bool record_intercept_action(VMI_intercept=
_command action)
> > >          break;
> > >      case VMI_INTERCEPT_FORCE_RESET:
> > >          break;
> > > +    case VMI_INTERCEPT_MIGRATE:
> > > +        migrate_pending =3D true;
> > > +        break;
> > >      default:
> > >          return false;
> > >      }
> > > diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-inte=
rcept.h
> > > index ef591b49e7..b4a9a3faa7 100644
> > > --- a/include/sysemu/vmi-intercept.h
> > > +++ b/include/sysemu/vmi-intercept.h
> > > @@ -15,6 +15,7 @@ typedef enum {
> > >      VMI_INTERCEPT_SUSPEND,
> > >      VMI_INTERCEPT_RESUME,
> > >      VMI_INTERCEPT_FORCE_RESET,
> > > +    VMI_INTERCEPT_MIGRATE,
> > >  } VMI_intercept_command;
> > > =20
> > >  bool vm_introspection_intercept(VMI_intercept_command ic, Error **er=
rp);
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 187ac0410c..222037d739 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -55,6 +55,8 @@
> > >  #include "qemu/queue.h"
> > >  #include "multifd.h"
> > > =20
> > > +#include "sysemu/vmi-intercept.h"
> > > +
> > >  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed th=
rottling */
> > > =20
> > >  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
> > > @@ -3471,6 +3473,13 @@ static void *migration_thread(void *opaque)
> > >      return NULL;
> > >  }
> > > =20
> > > +void start_live_migration_thread(MigrationState *s)
> > > +{
> > > +    qemu_thread_create(&s->thread, "live_migration", migration_threa=
d, s,
> > > +                    QEMU_THREAD_JOINABLE);
> > > +    s->migration_thread_running =3D true;
> > > +}
> > > +
> > >  void migrate_fd_connect(MigrationState *s, Error *error_in)
> > >  {
> > >      Error *local_err =3D NULL;
> > > @@ -3534,9 +3543,12 @@ void migrate_fd_connect(MigrationState *s, Err=
or *error_in)
> > >          migrate_fd_cleanup(s);
> > >          return;
> > >      }
> > > -    qemu_thread_create(&s->thread, "live_migration", migration_threa=
d, s,
> > > -                       QEMU_THREAD_JOINABLE);
> > > -    s->migration_thread_running =3D true;
> > > +
> > > +    if (vm_introspection_intercept(VMI_INTERCEPT_MIGRATE, &error_in)=
) {
> > > +        return;
> > > +    }
> > > +
> > > +    start_live_migration_thread(s);
> > >  }
> > > =20
> > >  void migration_global_dump(Monitor *mon)
> > > diff --git a/migration/migration.h b/migration/migration.h
> > > index 507284e563..eb5668e1f2 100644
> > > --- a/migration/migration.h
> > > +++ b/migration/migration.h
> > > @@ -263,6 +263,8 @@ struct MigrationState
> > >      uint8_t clear_bitmap_shift;
> > >  };
> > > =20
> > > +void start_live_migration_thread(MigrationState *s);
> > > +
> > >  void migrate_set_state(int *state, int old_state, int new_state);
> > > =20
> > >  void migration_fd_process_incoming(QEMUFile *f, Error **errp);
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


