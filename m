Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C02C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FC6206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm3L1FSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FC6206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWp6-0005qi-EI
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwVzr-0007iV-Mi
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwVzq-0003Gy-4u
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:53:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwVzq-0003Fx-1D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580237637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5nZs7dVN0QzDeTjZKyvMDGSlHbZj1Af0kEOiD8AKC5A=;
 b=Dm3L1FSOlxq7KmkJTKJBeGGowVGHKwunj/Y7LBdOvHoSpia/kyfMZCSpGtni2PHNUb/DOO
 zb14kUO4J/XLA06qdI/P/zV+S2HoG3otb35eugRWFNhYMW0qonOZxTxx/DOws8yLJ9kwdb
 0ZFdQclP+TKLTM3+bl00+AFaeKoUt2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-_yqpdXD6O3yZTM7U-ilGDQ-1; Tue, 28 Jan 2020 13:53:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0983477;
 Tue, 28 Jan 2020 18:53:51 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3AE019486;
 Tue, 28 Jan 2020 18:53:47 +0000 (UTC)
Date: Tue, 28 Jan 2020 18:53:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 07/13] monitor/hmp: move hmp_snapshot_* to
 block-hmp-cmds.c
Message-ID: <20200128185345.GC3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-8-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-8-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _yqpdXD6O3yZTM7U-ilGDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
>  block/monitor/block-hmp-cmds.c     | 47 ++++++++++++++++++++++++++++++
>  include/block/block-hmp-commands.h |  4 +++
>  include/monitor/hmp.h              |  3 --
>  monitor/hmp-cmds.c                 | 47 ------------------------------
>  4 files changed, 51 insertions(+), 50 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index ed3c350143..9aa94ea6e0 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -280,3 +280,50 @@ void hmp_block_job_complete(Monitor *mon, const QDic=
t *qdict)
> =20
>      hmp_handle_error(mon, error);
>  }
> +
> +void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *filename =3D qdict_get_try_str(qdict, "snapshot-file");
> +    const char *format =3D qdict_get_try_str(qdict, "format");
> +    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> +    enum NewImageMode mode;
> +    Error *err =3D NULL;
> +
> +    if (!filename) {
> +        /* In the future, if 'snapshot-file' is not specified, the snaps=
hot
> +           will be taken internally. Today it's actually required. */
> +        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +
> +    mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_P=
ATHS;
> +    qmp_blockdev_snapshot_sync(true, device, false, NULL,
> +                               filename, false, NULL,
> +                               !!format, format,
> +                               true, mode, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *name =3D qdict_get_str(qdict, "name");
> +    Error *err =3D NULL;
> +
> +    qmp_blockdev_snapshot_internal_sync(device, name, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdic=
t)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *name =3D qdict_get_str(qdict, "name");
> +    const char *id =3D qdict_get_try_str(qdict, "id");
> +    Error *err =3D NULL;
> +
> +    qmp_blockdev_snapshot_delete_internal_sync(device, !!id, id,
> +                                               true, name, &err);
> +    hmp_handle_error(mon, err);
> +}
> diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp=
-commands.h
> index ea6578a5f6..3fc2daf3a9 100644
> --- a/include/block/block-hmp-commands.h
> +++ b/include/block/block-hmp-commands.h
> @@ -17,4 +17,8 @@ void hmp_block_job_pause(Monitor *mon, const QDict *qdi=
ct);
>  void hmp_block_job_resume(Monitor *mon, const QDict *qdict);
>  void hmp_block_job_complete(Monitor *mon, const QDict *qdict);
> =20
> +void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
> +void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
> +void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdic=
t);
> +
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 592ce0ccfe..6d34e29bb6 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -61,9 +61,6 @@ void hmp_set_link(Monitor *mon, const QDict *qdict);
>  void hmp_block_passwd(Monitor *mon, const QDict *qdict);
>  void hmp_balloon(Monitor *mon, const QDict *qdict);
>  void hmp_block_resize(Monitor *mon, const QDict *qdict);
> -void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict);
> -void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
> -void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdic=
t);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 996ce96430..46b46b6dd7 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1337,53 +1337,6 @@ void hmp_block_resize(Monitor *mon, const QDict *q=
dict)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *filename =3D qdict_get_try_str(qdict, "snapshot-file");
> -    const char *format =3D qdict_get_try_str(qdict, "format");
> -    bool reuse =3D qdict_get_try_bool(qdict, "reuse", false);
> -    enum NewImageMode mode;
> -    Error *err =3D NULL;
> -
> -    if (!filename) {
> -        /* In the future, if 'snapshot-file' is not specified, the snaps=
hot
> -           will be taken internally. Today it's actually required. */
> -        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
> -        hmp_handle_error(mon, err);
> -        return;
> -    }
> -
> -    mode =3D reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_P=
ATHS;
> -    qmp_blockdev_snapshot_sync(true, device, false, NULL,
> -                               filename, false, NULL,
> -                               !!format, format,
> -                               true, mode, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
> -void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *name =3D qdict_get_str(qdict, "name");
> -    Error *err =3D NULL;
> -
> -    qmp_blockdev_snapshot_internal_sync(device, name, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
> -void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdic=
t)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *name =3D qdict_get_str(qdict, "name");
> -    const char *id =3D qdict_get_try_str(qdict, "id");
> -    Error *err =3D NULL;
> -
> -    qmp_blockdev_snapshot_delete_internal_sync(device, !!id, id,
> -                                               true, name, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
>  void hmp_loadvm(Monitor *mon, const QDict *qdict)
>  {
>      int saved_vm_running  =3D runstate_is_running();
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


