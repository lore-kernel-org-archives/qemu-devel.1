Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7329CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F870206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ep/Q1xVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F870206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWpv-0007Qc-CB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44711)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwW2U-0003JU-Nh
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwW2R-00089h-Ta
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:56:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38322
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwW2R-00085w-Oj
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580237797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMQU7mVcTDCnN/Er/sQ02BHz1Gv8O/zjiHQrxzf5lT8=;
 b=ep/Q1xVNczgdoXfriKvo39VwSWQjFrk6skQpV3nHGJJkAJNgn+reY36YdDRzW7ejUn5OWG
 y0gNaC8+iZVncw1GRfyvdOF3y1nW1GV3RPgALpqMVL0xz+ZWT7awjlJ41XkYT+CDZVVs2Z
 C2UDXE5JUKWycBxt25iCpDrjic2lGks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-70F24y_4M_28GzZHdqVWWA-1; Tue, 28 Jan 2020 13:56:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E721A107ACC9;
 Tue, 28 Jan 2020 18:56:33 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E207C35A;
 Tue, 28 Jan 2020 18:56:29 +0000 (UTC)
Date: Tue, 28 Jan 2020 18:56:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, eblake@redhat.com
Subject: Re: [PATCH v3 08/13] monitor/hmp: move hmp_nbd_server* to
 block-hmp-cmds.c
Message-ID: <20200128185627.GD3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-9-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-9-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 70F24y_4M_28GzZHdqVWWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

Yes, I think that's OK; I can imagine nbd might want to move on it's own
somewhere since it's not really core block code; copying in Eric.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  block/monitor/block-hmp-cmds.c     | 88 ++++++++++++++++++++++++++++++
>  include/block/block-hmp-commands.h |  5 ++
>  include/monitor/hmp.h              |  4 --
>  monitor/hmp-cmds.c                 | 87 -----------------------------
>  4 files changed, 93 insertions(+), 91 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index 9aa94ea6e0..df0178d0f9 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -22,8 +22,10 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/config-file.h"
>  #include "qemu/option.h"
> +#include "qemu/sockets.h"
>  #include "sysemu/sysemu.h"
>  #include "monitor/monitor.h"
> +#include "block/nbd.h"
>  #include "block/block_int.h"
>  #include "block/block-hmp-commands.h"
>  #include "monitor/hmp.h"
> @@ -327,3 +329,89 @@ void hmp_snapshot_delete_blkdev_internal(Monitor *mo=
n, const QDict *qdict)
>                                                 true, name, &err);
>      hmp_handle_error(mon, err);
>  }
> +
> +void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
> +{
> +    const char *uri =3D qdict_get_str(qdict, "uri");
> +    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
> +    bool all =3D qdict_get_try_bool(qdict, "all", false);
> +    Error *local_err =3D NULL;
> +    BlockInfoList *block_list, *info;
> +    SocketAddress *addr;
> +
> +    if (writable && !all) {
> +        error_setg(&local_err, "-w only valid together with -a");
> +        goto exit;
> +    }
> +
> +    /* First check if the address is valid and start the server.  */
> +    addr =3D socket_parse(uri, &local_err);
> +    if (local_err !=3D NULL) {
> +        goto exit;
> +    }
> +
> +    nbd_server_start(addr, NULL, NULL, &local_err);
> +    qapi_free_SocketAddress(addr);
> +    if (local_err !=3D NULL) {
> +        goto exit;
> +    }
> +
> +    if (!all) {
> +        return;
> +    }
> +
> +    /* Then try adding all block devices.  If one fails, close all and
> +     * exit.
> +     */
> +    block_list =3D qmp_query_block(NULL);
> +
> +    for (info =3D block_list; info; info =3D info->next) {
> +        if (!info->value->has_inserted) {
> +            continue;
> +        }
> +
> +        qmp_nbd_server_add(info->value->device, false, NULL,
> +                           true, writable, false, NULL, &local_err);
> +
> +        if (local_err !=3D NULL) {
> +            qmp_nbd_server_stop(NULL);
> +            break;
> +        }
> +    }
> +
> +    qapi_free_BlockInfoList(block_list);
> +
> +exit:
> +    hmp_handle_error(mon, local_err);
> +}
> +
> +void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *name =3D qdict_get_try_str(qdict, "name");
> +    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
> +    Error *local_err =3D NULL;
> +
> +    qmp_nbd_server_add(device, !!name, name, true, writable,
> +                       false, NULL, &local_err);
> +    hmp_handle_error(mon, local_err);
> +}
> +
> +void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
> +{
> +    const char *name =3D qdict_get_str(qdict, "name");
> +    bool force =3D qdict_get_try_bool(qdict, "force", false);
> +    Error *err =3D NULL;
> +
> +    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
> +    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err=
);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err =3D NULL;
> +
> +    qmp_nbd_server_stop(&err);
> +    hmp_handle_error(mon, err);
> +}
> diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp=
-commands.h
> index 3fc2daf3a9..721b9a1978 100644
> --- a/include/block/block-hmp-commands.h
> +++ b/include/block/block-hmp-commands.h
> @@ -21,4 +21,9 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdi=
ct);
>  void hmp_snapshot_blkdev_internal(Monitor *mon, const QDict *qdict);
>  void hmp_snapshot_delete_blkdev_internal(Monitor *mon, const QDict *qdic=
t);
> =20
> +void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
> +void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
> +void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
> +void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
> +
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 6d34e29bb6..736a969131 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -94,10 +94,6 @@ void hmp_getfd(Monitor *mon, const QDict *qdict);
>  void hmp_closefd(Monitor *mon, const QDict *qdict);
>  void hmp_sendkey(Monitor *mon, const QDict *qdict);
>  void hmp_screendump(Monitor *mon, const QDict *qdict);
> -void hmp_nbd_server_start(Monitor *mon, const QDict *qdict);
> -void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
> -void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
> -void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_change(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 46b46b6dd7..67d2ca8a4c 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -45,7 +45,6 @@
>  #include "qapi/string-output-visitor.h"
>  #include "qom/object_interfaces.h"
>  #include "ui/console.h"
> -#include "block/nbd.h"
>  #include "block/qapi.h"
>  #include "qemu-io.h"
>  #include "qemu/cutils.h"
> @@ -2154,92 +2153,6 @@ void hmp_screendump(Monitor *mon, const QDict *qdi=
ct)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
> -{
> -    const char *uri =3D qdict_get_str(qdict, "uri");
> -    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
> -    bool all =3D qdict_get_try_bool(qdict, "all", false);
> -    Error *local_err =3D NULL;
> -    BlockInfoList *block_list, *info;
> -    SocketAddress *addr;
> -
> -    if (writable && !all) {
> -        error_setg(&local_err, "-w only valid together with -a");
> -        goto exit;
> -    }
> -
> -    /* First check if the address is valid and start the server.  */
> -    addr =3D socket_parse(uri, &local_err);
> -    if (local_err !=3D NULL) {
> -        goto exit;
> -    }
> -
> -    nbd_server_start(addr, NULL, NULL, &local_err);
> -    qapi_free_SocketAddress(addr);
> -    if (local_err !=3D NULL) {
> -        goto exit;
> -    }
> -
> -    if (!all) {
> -        return;
> -    }
> -
> -    /* Then try adding all block devices.  If one fails, close all and
> -     * exit.
> -     */
> -    block_list =3D qmp_query_block(NULL);
> -
> -    for (info =3D block_list; info; info =3D info->next) {
> -        if (!info->value->has_inserted) {
> -            continue;
> -        }
> -
> -        qmp_nbd_server_add(info->value->device, false, NULL,
> -                           true, writable, false, NULL, &local_err);
> -
> -        if (local_err !=3D NULL) {
> -            qmp_nbd_server_stop(NULL);
> -            break;
> -        }
> -    }
> -
> -    qapi_free_BlockInfoList(block_list);
> -
> -exit:
> -    hmp_handle_error(mon, local_err);
> -}
> -
> -void hmp_nbd_server_add(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *name =3D qdict_get_try_str(qdict, "name");
> -    bool writable =3D qdict_get_try_bool(qdict, "writable", false);
> -    Error *local_err =3D NULL;
> -
> -    qmp_nbd_server_add(device, !!name, name, true, writable,
> -                       false, NULL, &local_err);
> -    hmp_handle_error(mon, local_err);
> -}
> -
> -void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict)
> -{
> -    const char *name =3D qdict_get_str(qdict, "name");
> -    bool force =3D qdict_get_try_bool(qdict, "force", false);
> -    Error *err =3D NULL;
> -
> -    /* Rely on NBD_SERVER_REMOVE_MODE_SAFE being the default */
> -    qmp_nbd_server_remove(name, force, NBD_SERVER_REMOVE_MODE_HARD, &err=
);
> -    hmp_handle_error(mon, err);
> -}
> -
> -void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict)
> -{
> -    Error *err =3D NULL;
> -
> -    qmp_nbd_server_stop(&err);
> -    hmp_handle_error(mon, err);
> -}
> -
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict)
>  {
>      const char *args =3D qdict_get_str(qdict, "args");
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


