Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758C1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42712214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izyq3q21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42712214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWdg-0001EE-F1
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwV9i-0006PN-HR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwV9g-0004Km-Lm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:00:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwV9g-0004Bc-CK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580234402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hfmg01+fHEEpsgvb8x8gFLi7anmxciFl+2aHmk2HE1o=;
 b=Izyq3q211MBvXqRiwdXASd5QKdJxN7gTE+95i+b7HXdh2BcZTlVarcMoh9o0L3/Emk39vk
 X4pmG+0Eir7Dxnx5zMlasj5H+W8a6kbDD1GiMUur+hfMfwum8HWtT90YAfGKF7cLkHAEwJ
 bxhnnv+Fj42+SssP4AOact30oO2UGng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-YDA_iXWzOWCkUfVkQXAtQA-1; Tue, 28 Jan 2020 12:59:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45DD8017CC;
 Tue, 28 Jan 2020 17:59:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E231084192;
 Tue, 28 Jan 2020 17:59:53 +0000 (UTC)
Date: Tue, 28 Jan 2020 17:59:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 05/13] monitor/hmp: move hmp_drive_mirror and
 hmp_drive_backup to block-hmp-cmds.c
Message-ID: <20200128175951.GX3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-6-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-6-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YDA_iXWzOWCkUfVkQXAtQA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  block/monitor/block-hmp-cmds.c     | 64 ++++++++++++++++++++++++++++++
>  include/block/block-hmp-commands.h |  3 ++
>  include/monitor/hmp.h              |  2 -
>  monitor/hmp-cmds.c                 | 58 ---------------------------
>  4 files changed, 67 insertions(+), 60 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index 9614c67e77..ae3890aaab 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -2,6 +2,10 @@
>   * Blockdev HMP commands
>   *
>   * Copyright (c) 2004 Fabrice Bellard
> + * Copyright IBM, Corp. 2011
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2.
>   * or (at your option) any later version.
> @@ -15,12 +19,14 @@
>  #include "qapi/qapi-commands-block.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
>  #include "sysemu/sysemu.h"
>  #include "monitor/monitor.h"
>  #include "block/block_int.h"
>  #include "block/block-hmp-commands.h"
> +#include "monitor/hmp.h"
> =20
>  void hmp_drive_add(Monitor *mon, const QDict *qdict)
>  {
> @@ -164,3 +170,61 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>          error_report("'commit' error for '%s': %s", device, strerror(-re=
t));
>      }
>  }
> +
> +void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
> +{
> +    const char *filename =3D qdict_get_str(qdict, "target");
> +    const char *format =3D qdict_get_try_str(qdict, "format");
> +    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> +    bool full =3D qdict_get_try_bool(qdict, "full", false);
> +    Error *err =3D NULL;
> +    DriveMirror mirror =3D {
> +        .device =3D (char *)qdict_get_str(qdict, "device"),
> +        .target =3D (char *)filename,
> +        .has_format =3D !!format,
> +        .format =3D (char *)format,
> +        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> +        .has_mode =3D true,
> +        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOL=
UTE_PATHS,
> +        .unmap =3D true,
> +    };
> +
> +    if (!filename) {
> +        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +    qmp_drive_mirror(&mirror, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_drive_backup(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *filename =3D qdict_get_str(qdict, "target");
> +    const char *format =3D qdict_get_try_str(qdict, "format");
> +    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> +    bool full =3D qdict_get_try_bool(qdict, "full", false);
> +    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
> +    Error *err =3D NULL;
> +    DriveBackup backup =3D {
> +        .device =3D (char *)device,
> +        .target =3D (char *)filename,
> +        .has_format =3D !!format,
> +        .format =3D (char *)format,
> +        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> +        .has_mode =3D true,
> +        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOL=
UTE_PATHS,
> +        .has_compress =3D !!compress,
> +        .compress =3D compress,
> +    };
> +
> +    if (!filename) {
> +        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +
> +    qmp_drive_backup(&backup, &err);
> +    hmp_handle_error(mon, err);
> +}
> diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp=
-commands.h
> index c5e394c0fc..fcaf753118 100644
> --- a/include/block/block-hmp-commands.h
> +++ b/include/block/block-hmp-commands.h
> @@ -8,4 +8,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
>  void hmp_commit(Monitor *mon, const QDict *qdict);
>  void hmp_drive_del(Monitor *mon, const QDict *qdict);
> =20
> +void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
> +void hmp_drive_backup(Monitor *mon, const QDict *qdict);
> +
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 3d329853b2..c1b363ee57 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -64,8 +64,6 @@ void hmp_block_resize(Monitor *mon, const QDict *qdict)=
;
>  void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
>  void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
>  void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdic=
t);
> -void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
> -void hmp_drive_backup(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index d0e0af893a..a70bcb1d16 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1337,64 +1337,6 @@ void hmp_block_resize(Monitor *mon, const QDict *q=
dict)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
> -{
> -    const char *filename =3D qdict_get_str(qdict, "target");
> -    const char *format =3D qdict_get_try_str(qdict, "format");
> -    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> -    bool full =3D qdict_get_try_bool(qdict, "full", false);
> -    Error *err =3D NULL;
> -    DriveMirror mirror =3D {
> -        .device =3D (char *)qdict_get_str(qdict, "device"),
> -        .target =3D (char *)filename,
> -        .has_format =3D !!format,
> -        .format =3D (char *)format,
> -        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> -        .has_mode =3D true,
> -        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOL=
UTE_PATHS,
> -        .unmap =3D true,
> -    };
> -
> -    if (!filename) {
> -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> -        hmp_handle_error(mon, err);
> -        return;
> -    }
> -    qmp_drive_mirror(&mirror, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
> -void hmp_drive_backup(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *filename =3D qdict_get_str(qdict, "target");
> -    const char *format =3D qdict_get_try_str(qdict, "format");
> -    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> -    bool full =3D qdict_get_try_bool(qdict, "full", false);
> -    bool compress =3D qdict_get_try_bool(qdict, "compress", false);
> -    Error *err =3D NULL;
> -    DriveBackup backup =3D {
> -        .device =3D (char *)device,
> -        .target =3D (char *)filename,
> -        .has_format =3D !!format,
> -        .format =3D (char *)format,
> -        .sync =3D full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
> -        .has_mode =3D true,
> -        .mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOL=
UTE_PATHS,
> -        .has_compress =3D !!compress,
> -        .compress =3D compress,
> -    };
> -
> -    if (!filename) {
> -        error_setg(&err, QERR_MISSING_PARAMETER, "target");
> -        hmp_handle_error(mon, err);
> -        return;
> -    }
> -
> -    qmp_drive_backup(&backup, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
>  void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
>  {
>      const char *device =3D qdict_get_str(qdict, "device");
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


