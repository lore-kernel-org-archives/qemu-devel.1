Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC7C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C433621D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/K3F5zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C433621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46647 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLKZ-0003hE-Uq
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jBLJO-0002jL-S9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jBLJN-0005vM-80
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:31:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jBLJN-0005tg-01
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583771483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJ+SRXuViyixeOqrXtlGMe9JlsKPI3j7BCyN6fOo6to=;
 b=Q/K3F5zuWS/3nSQlIo9vDYZ6d3/9Q2VocMxEwNBr3HDYGIffzGnXd7ewkUC/NCGtO87DUV
 buF9aL/K69o1ol9JFXd0Zsy0fOcDBEhVTVN/MQoudhMR1D2B47qmVYSBZuDZGY69Hewg05
 lI/D65OGW1vRdXN0jesEu+wj6RtoE3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-ejeWfV0NNTGodyPCOeJOsA-1; Mon, 09 Mar 2020 12:31:21 -0400
X-MC-Unique: ejeWfV0NNTGodyPCOeJOsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881E41005509;
 Mon,  9 Mar 2020 16:31:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 127C073892;
 Mon,  9 Mar 2020 16:31:15 +0000 (UTC)
Date: Mon, 9 Mar 2020 16:31:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v5 05/11] monitor/hmp: move hmp_drive_mirror and
 hmp_drive_backup to block-hmp-cmds.c Moved code was added after 2012-01-13,
 thus under GPLv2+
Message-ID: <20200309163113.GH3088@work-vm>
References: <20200308092440.23564-1-mlevitsk@redhat.com>
 <20200308092440.23564-6-mlevitsk@redhat.com>
 <9cf9655745608e9a12208524dc72196493644290.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9cf9655745608e9a12208524dc72196493644290.camel@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
>=20
> I see that I have the same issue of long subject line here.
> Its because I forgot the space after first line, when adding this.
> If I need to resend another version of this patchset I'll fix this,
> but otherwise maybe that can be fixed when applying this to one of mainta=
iner's
> trees.
>=20
> Sorry for noise.

I can just fix the commit message.

Dave

> Best regards,
> =09Maxim Levitsky
>=20
> On Sun, 2020-03-08 at 11:24 +0200, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  block/monitor/block-hmp-cmds.c | 60 ++++++++++++++++++++++++++++++++++
> >  include/block/block-hmp-cmds.h | 12 +++++--
> >  include/monitor/hmp.h          |  2 --
> >  monitor/hmp-cmds.c             | 58 --------------------------------
> >  4 files changed, 69 insertions(+), 63 deletions(-)
> >=20
> > diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-c=
mds.c
> > index ad727a6b08..d6dd5d97f7 100644
> > --- a/block/monitor/block-hmp-cmds.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -37,10 +37,12 @@
> >  #include "qapi/qapi-commands-block.h"
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/error.h"
> > +#include "qapi/qmp/qerror.h"
> >  #include "qemu/config-file.h"
> >  #include "qemu/option.h"
> >  #include "sysemu/sysemu.h"
> >  #include "monitor/monitor.h"
> > +#include "monitor/hmp.h"
> >  #include "block/block_int.h"
> >  #include "block/block-hmp-cmds.h"
> > =20
> > @@ -187,3 +189,61 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
> >          error_report("'commit' error for '%s': %s", device, strerror(-=
ret));
> >      }
> >  }
> > +
> > +void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
> > +{
> > +    const char *filename =3D qdict_get_str(qdict, "target");
> > +    const char *format =3D qdict_get_try_str(qdict, "format");
> > +    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> > +    bool full =3D qdict_get_try_bool(qdict, "full", false);
> > +    Error *err =3D NULL;
> > +    DriveMirror mirror =3D {
> > +        .device =3D (char *)qdict_get_str(qdict, "device"),
> > +        .target =3D (char *)filename,
> > +        .has_format =3D !!format,
> > +        .format =3D (char *)format,
> > +        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> > +        .has_mode =3D true,
> > +        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABS=
OLUTE_PATHS,
> > +        .unmap =3D true,
> > +    };
> > +
> > +    if (!filename) {
> > +        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> > +        hmp_handle_error(mon, err);
> > +        return;
> > +    }
> > +    qmp_drive_mirror(&mirror, &err);
> > +    hmp_handle_error(mon, err);
> > +}
> > +
> > +void hmp_drive_backup(Monitor *mon, const QDict *qdict)
> > +{
> > +    const char *device =3D qdict_get_str(qdict, "device");
> > +    const char *filename =3D qdict_get_str(qdict, "target");
> > +    const char *format =3D qdict_get_try_str(qdict, "format");
> > +    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> > +    bool full =3D qdict_get_try_bool(qdict, "full", false);
> > +    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
> > +    Error *err =3D NULL;
> > +    DriveBackup backup =3D {
> > +        .device =3D (char *)device,
> > +        .target =3D (char *)filename,
> > +        .has_format =3D !!format,
> > +        .format =3D (char *)format,
> > +        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> > +        .has_mode =3D true,
> > +        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABS=
OLUTE_PATHS,
> > +        .has_compress =3D !!compress,
> > +        .compress =3D compress,
> > +    };
> > +
> > +    if (!filename) {
> > +        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> > +        hmp_handle_error(mon, err);
> > +        return;
> > +    }
> > +
> > +    qmp_drive_backup(&backup, &err);
> > +    hmp_handle_error(mon, err);
> > +}
> > diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-c=
mds.h
> > index 30b0f56415..a64b737b3a 100644
> > --- a/include/block/block-hmp-cmds.h
> > +++ b/include/block/block-hmp-cmds.h
> > @@ -3,10 +3,13 @@
> >   *
> >   * Copyright (c) 2003-2008 Fabrice Bellard
> >   * Copyright (c) 2020 Red Hat, Inc.
> > + * Copyright IBM, Corp. 2011
> >   *
> > - * This work is licensed under the terms of the GNU GPL, version 2.
> > - * or (at your option) any later version.
> > - * See the COPYING file in the top-level directory.
> > + * Authors:
> > + *  Anthony Liguori   <aliguori@us.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> > + * the COPYING file in the top-level directory.
> >   */
> > =20
> >  #ifndef BLOCK_HMP_COMMANDS_H
> > @@ -17,4 +20,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
> >  void hmp_commit(Monitor *mon, const QDict *qdict);
> >  void hmp_drive_del(Monitor *mon, const QDict *qdict);
> > =20
> > +void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
> > +void hmp_drive_backup(Monitor *mon, const QDict *qdict);
> > +
> >  #endif
> > diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> > index 3d329853b2..c1b363ee57 100644
> > --- a/include/monitor/hmp.h
> > +++ b/include/monitor/hmp.h
> > @@ -64,8 +64,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdic=
t);
> >  void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
> >  void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
> >  void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qd=
ict);
> > -void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
> > -void hmp_drive_backup(Monitor *mon, const QDict *qdict);
> >  void hmp_loadvm(Monitor *mon, const QDict *qdict);
> >  void hmp_savevm(Monitor *mon, const QDict *qdict);
> >  void hmp_delvm(Monitor *mon, const QDict *qdict);
> > diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> > index fb4c2fd2a8..06f0cb4bb9 100644
> > --- a/monitor/hmp-cmds.c
> > +++ b/monitor/hmp-cmds.c
> > @@ -1342,64 +1342,6 @@ void hmp_block_resize(Monitor *mon, const QDict =
*qdict)
> >      hmp_handle_error(mon, err);
> >  }
> > =20
> > -void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
> > -{
> > -    const char *filename =3D qdict_get_str(qdict, "target");
> > -    const char *format =3D qdict_get_try_str(qdict, "format");
> > -    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> > -    bool full =3D qdict_get_try_bool(qdict, "full", false);
> > -    Error *err =3D NULL;
> > -    DriveMirror mirror =3D {
> > -        .device =3D (char *)qdict_get_str(qdict, "device"),
> > -        .target =3D (char *)filename,
> > -        .has_format =3D !!format,
> > -        .format =3D (char *)format,
> > -        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> > -        .has_mode =3D true,
> > -        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABS=
OLUTE_PATHS,
> > -        .unmap =3D true,
> > -    };
> > -
> > -    if (!filename) {
> > -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> > -        hmp_handle_error(mon, err);
> > -        return;
> > -    }
> > -    qmp_drive_mirror(&mirror, &err);
> > -    hmp_handle_error(mon, err);
> > -}
> > -
> > -void hmp_drive_backup(Monitor *mon, const QDict *qdict)
> > -{
> > -    const char *device =3D qdict_get_str(qdict, "device");
> > -    const char *filename =3D qdict_get_str(qdict, "target");
> > -    const char *format =3D qdict_get_try_str(qdict, "format");
> > -    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> > -    bool full =3D qdict_get_try_bool(qdict, "full", false);
> > -    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
> > -    Error *err =3D NULL;
> > -    DriveBackup backup =3D {
> > -        .device =3D (char *)device,
> > -        .target =3D (char *)filename,
> > -        .has_format =3D !!format,
> > -        .format =3D (char *)format,
> > -        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> > -        .has_mode =3D true,
> > -        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABS=
OLUTE_PATHS,
> > -        .has_compress =3D !!compress,
> > -        .compress =3D compress,
> > -    };
> > -
> > -    if (!filename) {
> > -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> > -        hmp_handle_error(mon, err);
> > -        return;
> > -    }
> > -
> > -    qmp_drive_backup(&backup, &err);
> > -    hmp_handle_error(mon, err);
> > -}
> > -
> >  void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
> >  {
> >      const char *device =3D qdict_get_str(qdict, "device");
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


