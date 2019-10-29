Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C8CA9EC2
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 07:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD0020830
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 07:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A16byTk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD0020830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPLeL-0007zr-J6
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 03:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iPLdX-0006nR-2o
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iPLdV-0004S6-Co
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:09:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iPLdV-0004Rl-82
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 03:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572332988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1nH9O/RHZq87zlBHfa+OCKV8kzoo6Li4Fa97muYYT8=;
 b=A16byTk6Fvq+0hsvmHYtl9bKcinS0oNgacQGVUe9sHcr2ZyTfIbgYoo0EuZDKEKpUG35/+
 3V322Y5siWznYh5u4UliftuFCR4SJhQeWz93uTNj8MrQlD8BkVBh/poy03Na34bFrKH2JA
 RhnIbSoURHN/OTyp2Ji+ncX+nsp5NKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-4MexNiASMSakEKnErAeXZw-1; Tue, 29 Oct 2019 03:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C1D18017DF;
 Tue, 29 Oct 2019 07:09:44 +0000 (UTC)
Received: from work-vm (ovpn-116-127.ams2.redhat.com [10.36.116.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA17A5D6C3;
 Tue, 29 Oct 2019 07:09:30 +0000 (UTC)
Date: Tue, 29 Oct 2019 07:09:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jens Freimann <jens@freimann.org>
Subject: Re: [PATCH v6 08/11] migration: add new migration state wait-unplug
Message-ID: <20191029070926.GB16329@work-vm>
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191025121930.6855-9-jfreimann@redhat.com>
 <20191029025650.GE2508@work-vm>
 <CAO85sR8WHmSf3uRp=fMj=YPu_FNiCZmd7+wnKRL8+pUf7voKBw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAO85sR8WHmSf3uRp=fMj=YPu_FNiCZmd7+wnKRL8+pUf7voKBw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4MexNiASMSakEKnErAeXZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 jfreimann@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jens Freimann (jens@freimann.org) wrote:
> Dr. David Alan Gilbert <dgilbert@redhat.com> schrieb am Di., 29. Okt. 201=
9,
> 03:57:
>=20
> > * Jens Freimann (jfreimann@redhat.com) wrote:
> > > This patch adds a new migration state called wait-unplug.  It is ente=
red
> > > after the SETUP state if failover devices are present. It will transi=
tion
> > > into ACTIVE once all devices were succesfully unplugged from the gues=
t.
> > >
> > > So if a guest doesn't respond or takes long to honor the unplug reque=
st
> > > the user will see the migration state 'wait-unplug'.
> > >
> > > In the migration thread we query failover devices if they're are stil=
l
> > > pending the guest unplug. When all are unplugged the migration
> > > continues. If one device won't unplug migration will stay in wait_unp=
lug
> > > state.
> > >
> > > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> >
> > I think this is OK, so
> >
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > but see question below
> >
> > > ---
> > >  include/migration/vmstate.h |  2 ++
> > >  migration/migration.c       | 21 +++++++++++++++++++++
> > >  migration/migration.h       |  3 +++
> > >  migration/savevm.c          | 36 +++++++++++++++++++++++++++++++++++=
+
> > >  migration/savevm.h          |  2 ++
> > >  qapi/migration.json         |  5 ++++-
> > >  6 files changed, 68 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.=
h
> > > index b9ee563aa4..ac4f46a67d 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -186,6 +186,8 @@ struct VMStateDescription {
> > >      int (*pre_save)(void *opaque);
> > >      int (*post_save)(void *opaque);
> > >      bool (*needed)(void *opaque);
> > > +    bool (*dev_unplug_pending)(void *opaque);
> > > +
> > >      const VMStateField *fields;
> > >      const VMStateDescription **subsections;
> > >  };
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 3febd0f8f3..51764f2565 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -52,6 +52,7 @@
> > >  #include "hw/qdev-properties.h"
> > >  #include "monitor/monitor.h"
> > >  #include "net/announce.h"
> > > +#include "qemu/queue.h"
> > >
> > >  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed
> > throttling */
> > >
> > > @@ -819,6 +820,7 @@ bool migration_is_setup_or_active(int state)
> > >      case MIGRATION_STATUS_SETUP:
> > >      case MIGRATION_STATUS_PRE_SWITCHOVER:
> > >      case MIGRATION_STATUS_DEVICE:
> > > +    case MIGRATION_STATUS_WAIT_UNPLUG:
> > >          return true;
> > >
> > >      default:
> > > @@ -954,6 +956,9 @@ static void fill_source_migration_info(MigrationI=
nfo
> > *info)
> > >      case MIGRATION_STATUS_CANCELLED:
> > >          info->has_status =3D true;
> > >          break;
> > > +    case MIGRATION_STATUS_WAIT_UNPLUG:
> > > +        info->has_status =3D true;
> > > +        break;
> > >      }
> > >      info->status =3D s->state;
> > >  }
> > > @@ -1694,6 +1699,7 @@ bool migration_is_idle(void)
> > >      case MIGRATION_STATUS_COLO:
> > >      case MIGRATION_STATUS_PRE_SWITCHOVER:
> > >      case MIGRATION_STATUS_DEVICE:
> > > +    case MIGRATION_STATUS_WAIT_UNPLUG:
> > >          return false;
> > >      case MIGRATION_STATUS__MAX:
> > >          g_assert_not_reached();
> > > @@ -3264,6 +3270,19 @@ static void *migration_thread(void *opaque)
> > >
> > >      qemu_savevm_state_setup(s->to_dst_file);
> > >
> > > +    if (qemu_savevm_nr_failover_devices()) {
> > > +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > > +                          MIGRATION_STATUS_WAIT_UNPLUG);
> > > +
> > > +        while (s->state =3D=3D MIGRATION_STATUS_WAIT_UNPLUG &&
> > > +                !qemu_savevm_state_guest_unplug_pending()) {
> > > +            qemu_sem_timedwait(&s->wait_unplug_sem, 250);
> > > +        }
> > > +
> > > +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
> > > +                MIGRATION_STATUS_ACTIVE);
> > > +    }
> > > +
> > >      s->setup_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_sta=
rt;
> > >      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> > >                        MIGRATION_STATUS_ACTIVE);
> > > @@ -3511,6 +3530,7 @@ static void migration_instance_finalize(Object
> > *obj)
> > >      qemu_mutex_destroy(&ms->qemu_file_lock);
> > >      g_free(params->tls_hostname);
> > >      g_free(params->tls_creds);
> > > +    qemu_sem_destroy(&ms->wait_unplug_sem);
> > >      qemu_sem_destroy(&ms->rate_limit_sem);
> > >      qemu_sem_destroy(&ms->pause_sem);
> > >      qemu_sem_destroy(&ms->postcopy_pause_sem);
> > > @@ -3556,6 +3576,7 @@ static void migration_instance_init(Object *obj=
)
> > >      qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
> > >      qemu_sem_init(&ms->rp_state.rp_sem, 0);
> > >      qemu_sem_init(&ms->rate_limit_sem, 0);
> > > +    qemu_sem_init(&ms->wait_unplug_sem, 0);
> > >      qemu_mutex_init(&ms->qemu_file_lock);
> > >  }
> > >
> > > diff --git a/migration/migration.h b/migration/migration.h
> > > index 4f2fe193dc..79b3dda146 100644
> > > --- a/migration/migration.h
> > > +++ b/migration/migration.h
> > > @@ -206,6 +206,9 @@ struct MigrationState
> > >      /* Flag set once the migration thread called bdrv_inactivate_all=
 */
> > >      bool block_inactive;
> > >
> > > +    /* Migration is waiting for guest to unplug device */
> > > +    QemuSemaphore wait_unplug_sem;
> > > +
> > >      /* Migration is paused due to pause-before-switchover */
> > >      QemuSemaphore pause_sem;
> > >
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 8d95e261f6..0f18dea49e 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -1113,6 +1113,42 @@ void qemu_savevm_state_header(QEMUFile *f)
> > >      }
> > >  }
> > >
> > > +int qemu_savevm_nr_failover_devices(void)
> > > +{
> > > +    SaveStateEntry *se;
> > > +    int n =3D 0;
> > > +
> > > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > > +        if (se->vmsd && se->vmsd->dev_unplug_pending) {
> > > +            n++;
> > > +        }
> > > +    }
> > > +
> > > +    return n;
> > > +}
> > > +
> > > +bool qemu_savevm_state_guest_unplug_pending(void)
> > > +{
> > > +    int nr_failover_devs;
> > > +    SaveStateEntry *se;
> > > +    bool ret =3D false;
> > > +    int n =3D 0;
> > > +
> > > +    nr_failover_devs =3D qemu_savevm_nr_failover_devices();
> > > +
> > > +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > > +        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
> > > +            continue;
> > > +        }
> > > +        ret =3D se->vmsd->dev_unplug_pending(se->opaque);
> > > +        if (!ret) {
> > > +            n++;
> > > +        }
> > > +    }
> > > +
> > > +    return n =3D=3D nr_failover_devs;
> >
> > I was expecting !=3D I think?  If all the devices say
> > they've got one pending then doesn't n=3D=3Dnr_failover_devs and
> > it returns true? But then what happens if only one has one pending?
> >
>=20
> It's increased when unplug pending is false, which means the device is
> done. So it returns true when all devices are done with unplugging. It is
> correct but not obvious. I can reverse it in a follow up to make it more
> clear.

Yes it doesn't quite match the name of the function; and/or add some
comments!

Dave

> regards,
> Jens
>=20
> >
> > Dave
> >
> > > +}
> > > +
> > >  void qemu_savevm_state_setup(QEMUFile *f)
> > >  {
> > >      SaveStateEntry *se;
> > > diff --git a/migration/savevm.h b/migration/savevm.h
> > > index 51a4b9caa8..c42b9c80ee 100644
> > > --- a/migration/savevm.h
> > > +++ b/migration/savevm.h
> > > @@ -31,6 +31,8 @@
> > >
> > >  bool qemu_savevm_state_blocked(Error **errp);
> > >  void qemu_savevm_state_setup(QEMUFile *f);
> > > +int qemu_savevm_nr_failover_devices(void);
> > > +bool qemu_savevm_state_guest_unplug_pending(void);
> > >  int qemu_savevm_state_resume_prepare(MigrationState *s);
> > >  void qemu_savevm_state_header(QEMUFile *f);
> > >  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > index e9e7a97c03..b7348d0c8b 100644
> > > --- a/qapi/migration.json
> > > +++ b/qapi/migration.json
> > > @@ -133,6 +133,9 @@
> > >  # @device: During device serialisation when pause-before-switchover =
is
> > enabled
> > >  #        (since 2.11)
> > >  #
> > > +# @wait-unplug: wait for device unplug request by guest OS to be
> > completed.
> > > +#               (since 4.2)
> > > +#
> > >  # Since: 2.3
> > >  #
> > >  ##
> > > @@ -140,7 +143,7 @@
> > >    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
> > >              'active', 'postcopy-active', 'postcopy-paused',
> > >              'postcopy-recover', 'completed', 'failed', 'colo',
> > > -            'pre-switchover', 'device' ] }
> > > +            'pre-switchover', 'device', 'wait-unplug' ] }
> > >
> > >  ##
> > >  # @MigrationInfo:
> > > --
> > > 2.21.0
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


