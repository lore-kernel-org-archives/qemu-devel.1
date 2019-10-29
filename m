Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09778CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 05:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B683020659
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 05:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freimann-org.20150623.gappssmtp.com header.i=@freimann-org.20150623.gappssmtp.com header.b="yXY0Egw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B683020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freimann.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPKRJ-0006W3-MG
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 01:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jens@freimann.org>) id 1iPKQ8-0005Dk-Ru
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 01:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jens@freimann.org>) id 1iPKQ6-00006O-FW
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 01:51:56 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:35012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jens@freimann.org>) id 1iPKQ6-0008W7-5i
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 01:51:54 -0400
Received: by mail-qk1-x741.google.com with SMTP id h6so2974827qkf.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 22:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=freimann-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2mvBPqbc3ndXC2YNcaQjAkbvaVpnPT610EWMUsk3cE8=;
 b=yXY0Egw/gUcCHiyOweKKG6QICLXeSmDSA4hhuqWM3H7Dr/67C6trOSAj1kVbTXMGH2
 v+v/KpORtUDjUUwjECNTS+wdWgWVvjZsEqGpamfebmedMuycK3LdbMaUqIeXmagZOm/2
 S+o7DipzCA9S7MZzLGU5nNtWl5cF7SiRFUMLwobWj/yGQ+x8TyAl9Ab6ObWx+6vorN07
 ciUleGaPa+qjraFKpArR/V4TTu/hdQ0NtyGrnv3sKX7yEaMWIdRXu+8Jh1cHtQ1HEJ38
 FUPd+iV9PuJ9fVxiVsiT0J5E3OFRib2j2gYLrr0uOnPqeG8HE7MOziiaGPxLrJBMr78k
 /Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2mvBPqbc3ndXC2YNcaQjAkbvaVpnPT610EWMUsk3cE8=;
 b=k96RMRAhzv6CdJXMYl7vYKoC4gjvAPp5RTxvg7OQKv2qfPNbH/qwXYKi1p7h+hqxR9
 IqVU60A+m27gz1evtSyi3Yaek34pG/8C/i57sPjqIFv7SZBt4Mu0VMk4Jxh+YI9Ha8aR
 d752I1zAq7CZvy0Zw8USF4VOc6mF3D/KG6J2I0EvQC6vSfa3ChsHJ+V3rNueuV+2z8FQ
 gz8pG0jXhR9Pek+hVDLeYlqJ0iGMrbBuNIUm3JCK+l02AqVrdpEcTonTedYPU+gV8Kcd
 7TQr0GNwgZrroo9S/+fCm+069M431VyKTp+7PI6cjJj8kb04+YWzLM7BoEU8aZ/FPlYP
 yiiQ==
X-Gm-Message-State: APjAAAWPPtzIrd4hrA8yksce+4wTALfmqiRp7iLwiT3Y+2+PJEwtcjfV
 JkkYZy+DCuaZx/KTRXdLdE6zmNVNeurPrhG2jzt9
X-Google-Smtp-Source: APXvYqyMnuTueUx96f3Qk+iEOVGkEBeRFC3WqeyOCQUTBKjs2M0SISWNcms5Dne1VC3erI6nZpnRZd1mSGk0LJVJb5A=
X-Received: by 2002:a05:620a:852:: with SMTP id
 u18mr20138344qku.169.1572328311064; 
 Mon, 28 Oct 2019 22:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-9-jfreimann@redhat.com>
 <20191029025650.GE2508@work-vm>
In-Reply-To: <20191029025650.GE2508@work-vm>
From: Jens Freimann <jens@freimann.org>
Date: Tue, 29 Oct 2019 06:51:37 +0100
Message-ID: <CAO85sR8WHmSf3uRp=fMj=YPu_FNiCZmd7+wnKRL8+pUf7voKBw@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] migration: add new migration state wait-unplug
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000739c910596063666"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 jfreimann@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000739c910596063666
Content-Type: text/plain; charset="UTF-8"

Dr. David Alan Gilbert <dgilbert@redhat.com> schrieb am Di., 29. Okt. 2019,
03:57:

> * Jens Freimann (jfreimann@redhat.com) wrote:
> > This patch adds a new migration state called wait-unplug.  It is entered
> > after the SETUP state if failover devices are present. It will transition
> > into ACTIVE once all devices were succesfully unplugged from the guest.
> >
> > So if a guest doesn't respond or takes long to honor the unplug request
> > the user will see the migration state 'wait-unplug'.
> >
> > In the migration thread we query failover devices if they're are still
> > pending the guest unplug. When all are unplugged the migration
> > continues. If one device won't unplug migration will stay in wait_unplug
> > state.
> >
> > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> > Acked-by: Cornelia Huck <cohuck@redhat.com>
>
> I think this is OK, so
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> but see question below
>
> > ---
> >  include/migration/vmstate.h |  2 ++
> >  migration/migration.c       | 21 +++++++++++++++++++++
> >  migration/migration.h       |  3 +++
> >  migration/savevm.c          | 36 ++++++++++++++++++++++++++++++++++++
> >  migration/savevm.h          |  2 ++
> >  qapi/migration.json         |  5 ++++-
> >  6 files changed, 68 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index b9ee563aa4..ac4f46a67d 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -186,6 +186,8 @@ struct VMStateDescription {
> >      int (*pre_save)(void *opaque);
> >      int (*post_save)(void *opaque);
> >      bool (*needed)(void *opaque);
> > +    bool (*dev_unplug_pending)(void *opaque);
> > +
> >      const VMStateField *fields;
> >      const VMStateDescription **subsections;
> >  };
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 3febd0f8f3..51764f2565 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -52,6 +52,7 @@
> >  #include "hw/qdev-properties.h"
> >  #include "monitor/monitor.h"
> >  #include "net/announce.h"
> > +#include "qemu/queue.h"
> >
> >  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed
> throttling */
> >
> > @@ -819,6 +820,7 @@ bool migration_is_setup_or_active(int state)
> >      case MIGRATION_STATUS_SETUP:
> >      case MIGRATION_STATUS_PRE_SWITCHOVER:
> >      case MIGRATION_STATUS_DEVICE:
> > +    case MIGRATION_STATUS_WAIT_UNPLUG:
> >          return true;
> >
> >      default:
> > @@ -954,6 +956,9 @@ static void fill_source_migration_info(MigrationInfo
> *info)
> >      case MIGRATION_STATUS_CANCELLED:
> >          info->has_status = true;
> >          break;
> > +    case MIGRATION_STATUS_WAIT_UNPLUG:
> > +        info->has_status = true;
> > +        break;
> >      }
> >      info->status = s->state;
> >  }
> > @@ -1694,6 +1699,7 @@ bool migration_is_idle(void)
> >      case MIGRATION_STATUS_COLO:
> >      case MIGRATION_STATUS_PRE_SWITCHOVER:
> >      case MIGRATION_STATUS_DEVICE:
> > +    case MIGRATION_STATUS_WAIT_UNPLUG:
> >          return false;
> >      case MIGRATION_STATUS__MAX:
> >          g_assert_not_reached();
> > @@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)
> >
> >      qemu_savevm_state_setup(s->to_dst_file);
> >
> > +    if (qemu_savevm_nr_failover_devices()) {
> > +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > +                          MIGRATION_STATUS_WAIT_UNPLUG);
> > +
> > +        while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
> > +                !qemu_savevm_state_guest_unplug_pending()) {
> > +            qemu_sem_timedwait(&s->wait_unplug_sem, 250);
> > +        }
> > +
> > +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
> > +                MIGRATION_STATUS_ACTIVE);
> > +    }
> > +
> >      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> >      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> >                        MIGRATION_STATUS_ACTIVE);
> > @@ -3511,6 +3530,7 @@ static void migration_instance_finalize(Object
> *obj)
> >      qemu_mutex_destroy(&ms->qemu_file_lock);
> >      g_free(params->tls_hostname);
> >      g_free(params->tls_creds);
> > +    qemu_sem_destroy(&ms->wait_unplug_sem);
> >      qemu_sem_destroy(&ms->rate_limit_sem);
> >      qemu_sem_destroy(&ms->pause_sem);
> >      qemu_sem_destroy(&ms->postcopy_pause_sem);
> > @@ -3556,6 +3576,7 @@ static void migration_instance_init(Object *obj)
> >      qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
> >      qemu_sem_init(&ms->rp_state.rp_sem, 0);
> >      qemu_sem_init(&ms->rate_limit_sem, 0);
> > +    qemu_sem_init(&ms->wait_unplug_sem, 0);
> >      qemu_mutex_init(&ms->qemu_file_lock);
> >  }
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 4f2fe193dc..79b3dda146 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -206,6 +206,9 @@ struct MigrationState
> >      /* Flag set once the migration thread called bdrv_inactivate_all */
> >      bool block_inactive;
> >
> > +    /* Migration is waiting for guest to unplug device */
> > +    QemuSemaphore wait_unplug_sem;
> > +
> >      /* Migration is paused due to pause-before-switchover */
> >      QemuSemaphore pause_sem;
> >
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 8d95e261f6..0f18dea49e 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1113,6 +1113,42 @@ void qemu_savevm_state_header(QEMUFile *f)
> >      }
> >  }
> >
> > +int qemu_savevm_nr_failover_devices(void)
> > +{
> > +    SaveStateEntry *se;
> > +    int n = 0;
> > +
> > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > +        if (se->vmsd && se->vmsd->dev_unplug_pending) {
> > +            n++;
> > +        }
> > +    }
> > +
> > +    return n;
> > +}
> > +
> > +bool qemu_savevm_state_guest_unplug_pending(void)
> > +{
> > +    int nr_failover_devs;
> > +    SaveStateEntry *se;
> > +    bool ret = false;
> > +    int n = 0;
> > +
> > +    nr_failover_devs = qemu_savevm_nr_failover_devices();
> > +
> > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > +        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
> > +            continue;
> > +        }
> > +        ret = se->vmsd->dev_unplug_pending(se->opaque);
> > +        if (!ret) {
> > +            n++;
> > +        }
> > +    }
> > +
> > +    return n == nr_failover_devs;
>
> I was expecting != I think?  If all the devices say
> they've got one pending then doesn't n==nr_failover_devs and
> it returns true? But then what happens if only one has one pending?
>

It's increased when unplug pending is false, which means the device is
done. So it returns true when all devices are done with unplugging. It is
correct but not obvious. I can reverse it in a follow up to make it more
clear.

regards,
Jens

>
> Dave
>
> > +}
> > +
> >  void qemu_savevm_state_setup(QEMUFile *f)
> >  {
> >      SaveStateEntry *se;
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 51a4b9caa8..c42b9c80ee 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -31,6 +31,8 @@
> >
> >  bool qemu_savevm_state_blocked(Error **errp);
> >  void qemu_savevm_state_setup(QEMUFile *f);
> > +int qemu_savevm_nr_failover_devices(void);
> > +bool qemu_savevm_state_guest_unplug_pending(void);
> >  int qemu_savevm_state_resume_prepare(MigrationState *s);
> >  void qemu_savevm_state_header(QEMUFile *f);
> >  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index e9e7a97c03..b7348d0c8b 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -133,6 +133,9 @@
> >  # @device: During device serialisation when pause-before-switchover is
> enabled
> >  #        (since 2.11)
> >  #
> > +# @wait-unplug: wait for device unplug request by guest OS to be
> completed.
> > +#               (since 4.2)
> > +#
> >  # Since: 2.3
> >  #
> >  ##
> > @@ -140,7 +143,7 @@
> >    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
> >              'active', 'postcopy-active', 'postcopy-paused',
> >              'postcopy-recover', 'completed', 'failed', 'colo',
> > -            'pre-switchover', 'device' ] }
> > +            'pre-switchover', 'device', 'wait-unplug' ] }
> >
> >  ##
> >  # @MigrationInfo:
> > --
> > 2.21.0
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>

--000000000000739c910596063666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@=
redhat.com">dgilbert@redhat.com</a>&gt; schrieb am Di., 29. Okt. 2019, 03:5=
7:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">* Jens Freimann (<a href=3D"mail=
to:jfreimann@redhat.com" target=3D"_blank" rel=3D"noreferrer">jfreimann@red=
hat.com</a>) wrote:<br>
&gt; This patch adds a new migration state called wait-unplug.=C2=A0 It is =
entered<br>
&gt; after the SETUP state if failover devices are present. It will transit=
ion<br>
&gt; into ACTIVE once all devices were succesfully unplugged from the guest=
.<br>
&gt; <br>
&gt; So if a guest doesn&#39;t respond or takes long to honor the unplug re=
quest<br>
&gt; the user will see the migration state &#39;wait-unplug&#39;.<br>
&gt; <br>
&gt; In the migration thread we query failover devices if they&#39;re are s=
till<br>
&gt; pending the guest unplug. When all are unplugged the migration<br>
&gt; continues. If one device won&#39;t unplug migration will stay in wait_=
unplug<br>
&gt; state.<br>
&gt; <br>
&gt; Signed-off-by: Jens Freimann &lt;<a href=3D"mailto:jfreimann@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">jfreimann@redhat.com</a>&gt;<br>
&gt; Acked-by: Cornelia Huck &lt;<a href=3D"mailto:cohuck@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">cohuck@redhat.com</a>&gt;<br>
<br>
I think this is OK, so <br>
<br>
<br>
Reviewed-by: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dgilbert@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">dgilbert@redhat.com</a>&gt;<br>
<br>
but see question below<br>
<br>
&gt; ---<br>
&gt;=C2=A0 include/migration/vmstate.h |=C2=A0 2 ++<br>
&gt;=C2=A0 migration/migration.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 +++++++++++=
++++++++++<br>
&gt;=C2=A0 migration/migration.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br=
>
&gt;=C2=A0 migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 36 ++++++=
++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 migration/savevm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +=
+<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +=
+++-<br>
&gt;=C2=A0 6 files changed, 68 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h=
<br>
&gt; index b9ee563aa4..ac4f46a67d 100644<br>
&gt; --- a/include/migration/vmstate.h<br>
&gt; +++ b/include/migration/vmstate.h<br>
&gt; @@ -186,6 +186,8 @@ struct VMStateDescription {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int (*pre_save)(void *opaque);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int (*post_save)(void *opaque);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool (*needed)(void *opaque);<br>
&gt; +=C2=A0 =C2=A0 bool (*dev_unplug_pending)(void *opaque);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const VMStateField *fields;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 const VMStateDescription **subsections;<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/migration/migration.c b/migration/migration.c<br>
&gt; index 3febd0f8f3..51764f2565 100644<br>
&gt; --- a/migration/migration.c<br>
&gt; +++ b/migration/migration.c<br>
&gt; @@ -52,6 +52,7 @@<br>
&gt;=C2=A0 #include &quot;hw/qdev-properties.h&quot;<br>
&gt;=C2=A0 #include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 #include &quot;net/announce.h&quot;<br>
&gt; +#include &quot;qemu/queue.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #define MAX_THROTTLE=C2=A0 (32 &lt;&lt; 20)=C2=A0 =C2=A0 =C2=A0 =
/* Migration transfer speed throttling */<br>
&gt;=C2=A0 <br>
&gt; @@ -819,6 +820,7 @@ bool migration_is_setup_or_active(int state)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_SETUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_PRE_SWITCHOVER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_DEVICE:<br>
&gt; +=C2=A0 =C2=A0 case MIGRATION_STATUS_WAIT_UNPLUG:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; @@ -954,6 +956,9 @@ static void fill_source_migration_info(MigrationIn=
fo *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_CANCELLED:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_status =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case MIGRATION_STATUS_WAIT_UNPLUG:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_status =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;status =3D s-&gt;state;<br>
&gt;=C2=A0 }<br>
&gt; @@ -1694,6 +1699,7 @@ bool migration_is_idle(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_COLO:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_PRE_SWITCHOVER:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS_DEVICE:<br>
&gt; +=C2=A0 =C2=A0 case MIGRATION_STATUS_WAIT_UNPLUG:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case MIGRATION_STATUS__MAX:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; @@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_savevm_state_setup(s-&gt;to_dst_file);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (qemu_savevm_nr_failover_devices()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;state, MIGRA=
TION_STATUS_SETUP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 MIGRATION_STATUS_WAIT_UNPLUG);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (s-&gt;state =3D=3D MIGRATION_STATU=
S_WAIT_UNPLUG &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !qemu_savevm_=
state_guest_unplug_pending()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_sem_timedwait(&amp;s-&=
gt;wait_unplug_sem, 250);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;state, MIGRA=
TION_STATUS_WAIT_UNPLUG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIGRATION_STA=
TUS_ACTIVE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 s-&gt;setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_=
HOST) - setup_start;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 migrate_set_state(&amp;s-&gt;state, MIGRATION_STAT=
US_SETUP,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 MIGRATION_STATUS_ACTIVE);<br>
&gt; @@ -3511,6 +3530,7 @@ static void migration_instance_finalize(Object *=
obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_destroy(&amp;ms-&gt;qemu_file_lock);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(params-&gt;tls_hostname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(params-&gt;tls_creds);<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_destroy(&amp;ms-&gt;wait_unplug_sem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_destroy(&amp;ms-&gt;rate_limit_sem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_destroy(&amp;ms-&gt;pause_sem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_destroy(&amp;ms-&gt;postcopy_pause_sem);<=
br>
&gt; @@ -3556,6 +3576,7 @@ static void migration_instance_init(Object *obj)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_init(&amp;ms-&gt;postcopy_pause_rp_sem, 0=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_init(&amp;ms-&gt;rp_state.rp_sem, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_sem_init(&amp;ms-&gt;rate_limit_sem, 0);<br>
&gt; +=C2=A0 =C2=A0 qemu_sem_init(&amp;ms-&gt;wait_unplug_sem, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_init(&amp;ms-&gt;qemu_file_lock);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; diff --git a/migration/migration.h b/migration/migration.h<br>
&gt; index 4f2fe193dc..79b3dda146 100644<br>
&gt; --- a/migration/migration.h<br>
&gt; +++ b/migration/migration.h<br>
&gt; @@ -206,6 +206,9 @@ struct MigrationState<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Flag set once the migration thread called bdrv_=
inactivate_all */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool block_inactive;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 /* Migration is waiting for guest to unplug device */<b=
r>
&gt; +=C2=A0 =C2=A0 QemuSemaphore wait_unplug_sem;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Migration is paused due to pause-before-switcho=
ver */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuSemaphore pause_sem;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/migration/savevm.c b/migration/savevm.c<br>
&gt; index 8d95e261f6..0f18dea49e 100644<br>
&gt; --- a/migration/savevm.c<br>
&gt; +++ b/migration/savevm.c<br>
&gt; @@ -1113,6 +1113,42 @@ void qemu_savevm_state_header(QEMUFile *f)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +int qemu_savevm_nr_failover_devices(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SaveStateEntry *se;<br>
&gt; +=C2=A0 =C2=A0 int n =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH(se, &amp;savevm_state.handlers, entry) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (se-&gt;vmsd &amp;&amp; se-&gt;vmsd-&g=
t;dev_unplug_pending) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return n;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_savevm_state_guest_unplug_pending(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int nr_failover_devs;<br>
&gt; +=C2=A0 =C2=A0 SaveStateEntry *se;<br>
&gt; +=C2=A0 =C2=A0 bool ret =3D false;<br>
&gt; +=C2=A0 =C2=A0 int n =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 nr_failover_devs =3D qemu_savevm_nr_failover_devices();=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH(se, &amp;savevm_state.handlers, entry) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!se-&gt;vmsd || !se-&gt;vmsd-&gt;dev_=
unplug_pending) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D se-&gt;vmsd-&gt;dev_unplug_pendin=
g(se-&gt;opaque);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return n =3D=3D nr_failover_devs;<br>
<br>
I was expecting !=3D I think?=C2=A0 If all the devices say<br>
they&#39;ve got one pending then doesn&#39;t n=3D=3Dnr_failover_devs and<br=
>
it returns true? But then what happens if only one has one pending?<br></bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s=
 increased when unplug pending is false, which means the device is done. So=
 it returns true when all devices are done with unplugging. It is correct b=
ut not obvious. I can reverse it in a follow up to make it more clear.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">regards,</div><div dir=3D"au=
to">Jens</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
Dave<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void qemu_savevm_state_setup(QEMUFile *f)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SaveStateEntry *se;<br>
&gt; diff --git a/migration/savevm.h b/migration/savevm.h<br>
&gt; index 51a4b9caa8..c42b9c80ee 100644<br>
&gt; --- a/migration/savevm.h<br>
&gt; +++ b/migration/savevm.h<br>
&gt; @@ -31,6 +31,8 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 bool qemu_savevm_state_blocked(Error **errp);<br>
&gt;=C2=A0 void qemu_savevm_state_setup(QEMUFile *f);<br>
&gt; +int qemu_savevm_nr_failover_devices(void);<br>
&gt; +bool qemu_savevm_state_guest_unplug_pending(void);<br>
&gt;=C2=A0 int qemu_savevm_state_resume_prepare(MigrationState *s);<br>
&gt;=C2=A0 void qemu_savevm_state_header(QEMUFile *f);<br>
&gt;=C2=A0 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index e9e7a97c03..b7348d0c8b 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -133,6 +133,9 @@<br>
&gt;=C2=A0 # @device: During device serialisation when pause-before-switcho=
ver is enabled<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 (since 2.11)<br>
&gt;=C2=A0 #<br>
&gt; +# @wait-unplug: wait for device unplug request by guest OS to be comp=
leted.<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(since 4.2)<b=
r>
&gt; +#<br>
&gt;=C2=A0 # Since: 2.3<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 ##<br>
&gt; @@ -140,7 +143,7 @@<br>
&gt;=C2=A0 =C2=A0 &#39;data&#39;: [ &#39;none&#39;, &#39;setup&#39;, &#39;c=
ancelling&#39;, &#39;cancelled&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;active&#39;, &#39=
;postcopy-active&#39;, &#39;postcopy-paused&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;postcopy-recover&=
#39;, &#39;completed&#39;, &#39;failed&#39;, &#39;colo&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pre-switchover&#39;, &=
#39;device&#39; ] }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;pre-switchover&#39;, &=
#39;device&#39;, &#39;wait-unplug&#39; ] }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @MigrationInfo:<br>
&gt; -- <br>
&gt; 2.21.0<br>
&gt; <br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank" rel=3D"noreferrer">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000739c910596063666--

