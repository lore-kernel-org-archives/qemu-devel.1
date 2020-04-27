Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EEC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 19:10:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA1D20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c837OH1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA1D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT98w-0001dD-A7
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 15:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT97t-0000gI-31
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jT97o-0007tU-Hs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:09:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jT97o-0007tA-2j
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 15:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588014542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHIIlBZoZ2t/HVqolnuRfa1DqTM/PJSHham9OOL3aUc=;
 b=c837OH1dTCQXO9JA95R1Xsab0j9ipj+W+UaOgpHV0rOdH+aprEiNtSK5qpwE74vvzyC7Gq
 GGxSY9ej4XaghdXTmRHR7CVD87I8M7HXtkqGUYUzVaRY9BZ3ypwNdqOyK8dSBGj/KDz2PN
 NcoYIpAqv4B/7Skxv07DNDHSbkc0h9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Esbbb5nmMdG31XmCn5YabA-1; Mon, 27 Apr 2020 15:09:00 -0400
X-MC-Unique: Esbbb5nmMdG31XmCn5YabA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D102835B40;
 Mon, 27 Apr 2020 19:08:59 +0000 (UTC)
Received: from work-vm (ovpn-112-96.ams2.redhat.com [10.36.112.96])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F328C50F53;
 Mon, 27 Apr 2020 19:08:57 +0000 (UTC)
Date: Mon, 27 Apr 2020 20:08:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
Message-ID: <20200427190855.GN2923@work-vm>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-21-alazar@bitdefender.com>
MIME-Version: 1.0
In-Reply-To: <20200415005938.23895-21-alazar@bitdefender.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
> From: Marian Rotariu <marian.c.rotariu@gmail.com>
>=20
> It is possible that the introspection tool has made some changes inside
> the introspected VM which can make the guest crash if the introspection
> connection is suddenly closed.
>=20
> When the live migration starts, for now, the introspection tool is
> signaled to remove its hooks from the introspected VM.
>=20
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
> Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>

OK, so this isn't too intrusive to the migration code; and other than
renaming 'start_live_migration_thread' to
'start_outgoing_migration_thread' I think I'd be OK with this,

but it might depend what your overall aim is.

For example, you might be better intercepting each migration_state
change in your notifier, that's much finer grain than just the start of
migration.

The other thing I worry about is that there doesn't seem to be much
guard against odd orderings of things - for example, what happens
if the introspection client was to issue the  INTERCEPT_MIGRATE command
twice while a migration was already running?  Or before an actual
incoming channel connetion had happened?

Dave

> ---
>  accel/kvm/vmi.c                | 31 +++++++++++++++++++++++++++----
>  include/sysemu/vmi-intercept.h |  1 +
>  migration/migration.c          | 18 +++++++++++++++---
>  migration/migration.h          |  2 ++
>  4 files changed, 45 insertions(+), 7 deletions(-)
>=20
> diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
> index 90906478b4..ea7191e48d 100644
> --- a/accel/kvm/vmi.c
> +++ b/accel/kvm/vmi.c
> @@ -21,6 +21,8 @@
>  #include "chardev/char.h"
>  #include "chardev/char-fe.h"
>  #include "migration/vmstate.h"
> +#include "migration/migration.h"
> +#include "migration/misc.h"
> =20
>  #include "sysemu/vmi-intercept.h"
>  #include "sysemu/vmi-handshake.h"
> @@ -58,6 +60,7 @@ typedef struct VMIntrospection {
>      int64_t vm_start_time;
> =20
>      Notifier machine_ready;
> +    Notifier migration_state_change;
>      bool created_from_command_line;
> =20
>      bool kvmi_hooked;
> @@ -74,9 +77,11 @@ static const char *action_string[] =3D {
>      "suspend",
>      "resume",
>      "force-reset",
> +    "migrate",
>  };
> =20
>  static bool suspend_pending;
> +static bool migrate_pending;
> =20
>  #define TYPE_VM_INTROSPECTION "introspection"
> =20
> @@ -88,6 +93,15 @@ static bool suspend_pending;
>  static Error *vm_introspection_init(VMIntrospection *i);
>  static void vm_introspection_reset(void *opaque);
> =20
> +static void migration_state_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s =3D data;
> +
> +    if (migration_has_failed(s)) {
> +        migrate_pending =3D false;
> +    }
> +}
> +
>  static void machine_ready(Notifier *notifier, void *data)
>  {
>      VMIntrospection *i =3D container_of(notifier, VMIntrospection, machi=
ne_ready);
> @@ -144,6 +158,9 @@ static void complete(UserCreatable *uc, Error **errp)
> =20
>      ic->uniq =3D i;
> =20
> +    i->migration_state_change.notify =3D migration_state_notifier;
> +    add_migration_state_change_notifier(&i->migration_state_change);
> +
>      qemu_register_reset(vm_introspection_reset, i);
>  }
> =20
> @@ -478,6 +495,9 @@ static void continue_with_the_intercepted_action(VMIn=
trospection *i)
>      case VMI_INTERCEPT_SUSPEND:
>          vm_stop(RUN_STATE_PAUSED);
>          break;
> +    case VMI_INTERCEPT_MIGRATE:
> +        start_live_migration_thread(migrate_get_current());
> +        break;
>      default:
>          error_report("VMI: %s: unexpected action %d",
>                       __func__, i->intercepted_action);
> @@ -571,9 +591,9 @@ static void chr_event_open(VMIntrospection *i)
>  {
>      Error *local_err =3D NULL;
> =20
> -    if (suspend_pending) {
> -        info_report("VMI: %s: too soon (suspend=3D%d)",
> -                    __func__, suspend_pending);
> +    if (suspend_pending || migrate_pending) {
> +        info_report("VMI: %s: too soon (suspend=3D%d, migrate=3D%d)",
> +                    __func__, suspend_pending, migrate_pending);
>          maybe_disable_socket_reconnect(i);
>          qemu_chr_fe_disconnect(&i->sock);
>          return;
> @@ -608,7 +628,7 @@ static void chr_event_close(VMIntrospection *i)
>      cancel_unhook_timer(i);
>      cancel_handshake_timer(i);
> =20
> -    if (suspend_pending) {
> +    if (suspend_pending || migrate_pending) {
>          maybe_disable_socket_reconnect(i);
> =20
>          if (i->intercepted_action !=3D VMI_INTERCEPT_NONE) {
> @@ -680,6 +700,9 @@ static bool record_intercept_action(VMI_intercept_com=
mand action)
>          break;
>      case VMI_INTERCEPT_FORCE_RESET:
>          break;
> +    case VMI_INTERCEPT_MIGRATE:
> +        migrate_pending =3D true;
> +        break;
>      default:
>          return false;
>      }
> diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-intercep=
t.h
> index ef591b49e7..b4a9a3faa7 100644
> --- a/include/sysemu/vmi-intercept.h
> +++ b/include/sysemu/vmi-intercept.h
> @@ -15,6 +15,7 @@ typedef enum {
>      VMI_INTERCEPT_SUSPEND,
>      VMI_INTERCEPT_RESUME,
>      VMI_INTERCEPT_FORCE_RESET,
> +    VMI_INTERCEPT_MIGRATE,
>  } VMI_intercept_command;
> =20
>  bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp);
> diff --git a/migration/migration.c b/migration/migration.c
> index 187ac0410c..222037d739 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -55,6 +55,8 @@
>  #include "qemu/queue.h"
>  #include "multifd.h"
> =20
> +#include "sysemu/vmi-intercept.h"
> +
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed thrott=
ling */
> =20
>  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
> @@ -3471,6 +3473,13 @@ static void *migration_thread(void *opaque)
>      return NULL;
>  }
> =20
> +void start_live_migration_thread(MigrationState *s)
> +{
> +    qemu_thread_create(&s->thread, "live_migration", migration_thread, s=
,
> +                    QEMU_THREAD_JOINABLE);
> +    s->migration_thread_running =3D true;
> +}
> +
>  void migrate_fd_connect(MigrationState *s, Error *error_in)
>  {
>      Error *local_err =3D NULL;
> @@ -3534,9 +3543,12 @@ void migrate_fd_connect(MigrationState *s, Error *=
error_in)
>          migrate_fd_cleanup(s);
>          return;
>      }
> -    qemu_thread_create(&s->thread, "live_migration", migration_thread, s=
,
> -                       QEMU_THREAD_JOINABLE);
> -    s->migration_thread_running =3D true;
> +
> +    if (vm_introspection_intercept(VMI_INTERCEPT_MIGRATE, &error_in)) {
> +        return;
> +    }
> +
> +    start_live_migration_thread(s);
>  }
> =20
>  void migration_global_dump(Monitor *mon)
> diff --git a/migration/migration.h b/migration/migration.h
> index 507284e563..eb5668e1f2 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -263,6 +263,8 @@ struct MigrationState
>      uint8_t clear_bitmap_shift;
>  };
> =20
> +void start_live_migration_thread(MigrationState *s);
> +
>  void migrate_set_state(int *state, int old_state, int new_state);
> =20
>  void migration_fd_process_incoming(QEMUFile *f, Error **errp);
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


