Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE22C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487B92467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK2Ffd/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487B92467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWWc-0003iu-FT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwVy9-0004eb-95
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwVy6-0008N5-AM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:52:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57515
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwVy4-0008Jy-JI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580237527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//OPQMYIIL8FX6VvWWkcpVZqyUAuETIBp0TOUprAVB4=;
 b=TK2Ffd/PJQLhOFDwxCJDhme3VYINmdFpbFervYVfEMN/fQjA72Ql57aPeLLv1LLSXn4OeI
 wXq0V9Ei8qStrAqK4KXcdyuqJc/6qjX7iTY4krria4vX9dCqACzFevMn3zXRM22aNzHKdQ
 1Y4tWKGjBXKkf48wUWsspv/ZJr/W2R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-y66BEAW8Pyq7xfsbFdTI0g-1; Tue, 28 Jan 2020 13:52:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C61019251A0;
 Tue, 28 Jan 2020 18:52:04 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEA9F46;
 Tue, 28 Jan 2020 18:51:59 +0000 (UTC)
Date: Tue, 28 Jan 2020 18:51:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 09/13] monitor/hmp: move remaining hmp_block*
 functions to block-hmp-cmds.c
Message-ID: <20200128185157.GB3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-10-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-10-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: y66BEAW8Pyq7xfsbFdTI0g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
>  block/monitor/block-hmp-cmds.c     | 138 +++++++++++++++++++++++++++++
>  include/block/block-hmp-commands.h |   9 ++
>  include/monitor/hmp.h              |   6 --
>  monitor/hmp-cmds.c                 | 137 ----------------------------
>  4 files changed, 147 insertions(+), 143 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index df0178d0f9..60d63bfe18 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -29,6 +29,7 @@
>  #include "block/block_int.h"
>  #include "block/block-hmp-commands.h"
>  #include "monitor/hmp.h"
> +#include "qemu-io.h"
> =20
>  void hmp_drive_add(Monitor *mon, const QDict *qdict)
>  {
> @@ -415,3 +416,140 @@ void hmp_nbd_server_stop(Monitor *mon, const QDict =
*qdict)
>      qmp_nbd_server_stop(&err);
>      hmp_handle_error(mon, err);
>  }
> +
> +void hmp_block_resize(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    int64_t size =3D qdict_get_int(qdict, "size");
> +    Error *err =3D NULL;
> +
> +    qmp_block_resize(true, device, false, NULL, size, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_block_stream(Monitor *mon, const QDict *qdict)
> +{
> +    Error *error =3D NULL;
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *base =3D qdict_get_try_str(qdict, "base");
> +    int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
> +
> +    qmp_block_stream(true, device, device, base !=3D NULL, base, false, =
NULL,
> +                     false, NULL, qdict_haskey(qdict, "speed"), speed, t=
rue,
> +                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, fals=
e,
> +                     &error);
> +
> +    hmp_handle_error(mon, error);
> +}
> +
> +void hmp_block_passwd(Monitor *mon, const QDict *qdict)
> +{
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    const char *password =3D qdict_get_str(qdict, "password");
> +    Error *err =3D NULL;
> +
> +    qmp_block_passwd(true, device, false, NULL, password, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err =3D NULL;
> +    char *device =3D (char *) qdict_get_str(qdict, "device");
> +    BlockIOThrottle throttle =3D {
> +        .bps =3D qdict_get_int(qdict, "bps"),
> +        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
> +        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
> +        .iops =3D qdict_get_int(qdict, "iops"),
> +        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
> +        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
> +    };
> +
> +    /* qmp_block_set_io_throttle has separate parameters for the
> +     * (deprecated) block device name and the qdev ID but the HMP
> +     * version has only one, so we must decide which one to pass. */
> +    if (blk_by_name(device)) {
> +        throttle.has_device =3D true;
> +        throttle.device =3D device;
> +    } else {
> +        throttle.has_id =3D true;
> +        throttle.id =3D device;
> +    }
> +
> +    qmp_block_set_io_throttle(&throttle, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_eject(Monitor *mon, const QDict *qdict)
> +{
> +    bool force =3D qdict_get_try_bool(qdict, "force", false);
> +    const char *device =3D qdict_get_str(qdict, "device");
> +    Error *err =3D NULL;
> +
> +    qmp_eject(true, device, false, NULL, true, force, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_qemu_io(Monitor *mon, const QDict *qdict)
> +{
> +    BlockBackend *blk;
> +    BlockBackend *local_blk =3D NULL;
> +    bool qdev =3D qdict_get_try_bool(qdict, "qdev", false);
> +    const char* device =3D qdict_get_str(qdict, "device");
> +    const char* command =3D qdict_get_str(qdict, "command");
> +    Error *err =3D NULL;
> +    int ret;
> +
> +    if (qdev) {
> +        blk =3D blk_by_qdev_id(device, &err);
> +        if (!blk) {
> +            goto fail;
> +        }
> +    } else {
> +        blk =3D blk_by_name(device);
> +        if (!blk) {
> +            BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
> +            if (bs) {
> +                blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
> +                                          0, BLK_PERM_ALL);
> +                ret =3D blk_insert_bs(blk, bs, &err);
> +                if (ret < 0) {
> +                    goto fail;
> +                }
> +            } else {
> +                goto fail;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * Notably absent: Proper permission management. This is sad, but it=
 seems
> +     * almost impossible to achieve without changing the semantics and t=
hereby
> +     * limiting the use cases of the qemu-io HMP command.
> +     *
> +     * In an ideal world we would unconditionally create a new BlockBack=
end for
> +     * qemuio_command(), but we have commands like 'reopen' and want the=
m to
> +     * take effect on the exact BlockBackend whose name the user passed =
instead
> +     * of just on a temporary copy of it.
> +     *
> +     * Another problem is that deleting the temporary BlockBackend invol=
ves
> +     * draining all requests on it first, but some qemu-iotests cases wa=
nt to
> +     * issue multiple aio_read/write requests and expect them to complet=
e in
> +     * the background while the monitor has already returned.
> +     *
> +     * This is also what prevents us from saving the original permission=
s and
> +     * restoring them later: We can't revoke permissions until all reque=
sts
> +     * have completed, and we don't know when that is nor can we really =
let
> +     * anything else run before we have revoken them to avoid race condi=
tions.
> +     *
> +     * What happens now is that command() in qemu-io-cmds.c can extend t=
he
> +     * permissions if necessary for the qemu-io command. And they simply=
 stay
> +     * extended, possibly resulting in a read-only guest device keeping =
write
> +     * permissions. Ugly, but it appears to be the lesser evil.
> +     */
> +    qemuio_command(blk, command);
> +
> +fail:
> +    blk_unref(local_blk);
> +    hmp_handle_error(mon, err);
> +}
> diff --git a/include/block/block-hmp-commands.h b/include/block/block-hmp=
-commands.h
> index 721b9a1978..99145c8fcf 100644
> --- a/include/block/block-hmp-commands.h
> +++ b/include/block/block-hmp-commands.h
> @@ -26,4 +26,13 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *qdi=
ct);
>  void hmp_nbd_server_remove(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
> =20
> +void hmp_block_resize(Monitor *mon, const QDict *qdict);
> +void hmp_block_stream(Monitor *mon, const QDict *qdict);
> +void hmp_block_passwd(Monitor *mon, const QDict *qdict);
> +void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
> +void hmp_eject(Monitor *mon, const QDict *qdict);
> +
> +void hmp_qemu_io(Monitor *mon, const QDict *qdict);
> +
> +
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 736a969131..47a7cad734 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -58,9 +58,7 @@ void hmp_cont(Monitor *mon, const QDict *qdict);
>  void hmp_system_wakeup(Monitor *mon, const QDict *qdict);
>  void hmp_nmi(Monitor *mon, const QDict *qdict);
>  void hmp_set_link(Monitor *mon, const QDict *qdict);
> -void hmp_block_passwd(Monitor *mon, const QDict *qdict);
>  void hmp_balloon(Monitor *mon, const QDict *qdict);
> -void hmp_block_resize(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> @@ -80,10 +78,7 @@ void hmp_migrate_start_postcopy(Monitor *mon, const QD=
ict *qdict);
>  void hmp_x_colo_lost_heartbeat(Monitor *mon, const QDict *qdict);
>  void hmp_set_password(Monitor *mon, const QDict *qdict);
>  void hmp_expire_password(Monitor *mon, const QDict *qdict);
> -void hmp_eject(Monitor *mon, const QDict *qdict);
>  void hmp_change(Monitor *mon, const QDict *qdict);
> -void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
> -void hmp_block_stream(Monitor *mon, const QDict *qdict);
>  void hmp_migrate(Monitor *mon, const QDict *qdict);
>  void hmp_device_add(Monitor *mon, const QDict *qdict);
>  void hmp_device_del(Monitor *mon, const QDict *qdict);
> @@ -98,7 +93,6 @@ void hmp_chardev_add(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_change(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
> -void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>  void hmp_cpu_add(Monitor *mon, const QDict *qdict);
>  void hmp_object_add(Monitor *mon, const QDict *qdict);
>  void hmp_object_del(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 67d2ca8a4c..c224e0f338 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -46,7 +46,6 @@
>  #include "qom/object_interfaces.h"
>  #include "ui/console.h"
>  #include "block/qapi.h"
> -#include "qemu-io.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "exec/ramlist.h"
> @@ -1307,16 +1306,6 @@ void hmp_set_link(Monitor *mon, const QDict *qdict=
)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_block_passwd(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *password =3D qdict_get_str(qdict, "password");
> -    Error *err =3D NULL;
> -
> -    qmp_block_passwd(true, device, false, NULL, password, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
>  void hmp_balloon(Monitor *mon, const QDict *qdict)
>  {
>      int64_t value =3D qdict_get_int(qdict, "value");
> @@ -1326,16 +1315,6 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_block_resize(Monitor *mon, const QDict *qdict)
> -{
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    int64_t size =3D qdict_get_int(qdict, "size");
> -    Error *err =3D NULL;
> -
> -    qmp_block_resize(true, device, false, NULL, size, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
>  void hmp_loadvm(Monitor *mon, const QDict *qdict)
>  {
>      int saved_vm_running  =3D runstate_is_running();
> @@ -1818,15 +1797,6 @@ void hmp_expire_password(Monitor *mon, const QDict=
 *qdict)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_eject(Monitor *mon, const QDict *qdict)
> -{
> -    bool force =3D qdict_get_try_bool(qdict, "force", false);
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    Error *err =3D NULL;
> -
> -    qmp_eject(true, device, false, NULL, true, force, &err);
> -    hmp_handle_error(mon, err);
> -}
> =20
>  #ifdef CONFIG_VNC
>  static void hmp_change_read_arg(void *opaque, const char *password,
> @@ -1884,49 +1854,6 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, err);
>  }
> =20
> -void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
> -{
> -    Error *err =3D NULL;
> -    char *device =3D (char *) qdict_get_str(qdict, "device");
> -    BlockIOThrottle throttle =3D {
> -        .bps =3D qdict_get_int(qdict, "bps"),
> -        .bps_rd =3D qdict_get_int(qdict, "bps_rd"),
> -        .bps_wr =3D qdict_get_int(qdict, "bps_wr"),
> -        .iops =3D qdict_get_int(qdict, "iops"),
> -        .iops_rd =3D qdict_get_int(qdict, "iops_rd"),
> -        .iops_wr =3D qdict_get_int(qdict, "iops_wr"),
> -    };
> -
> -    /* qmp_block_set_io_throttle has separate parameters for the
> -     * (deprecated) block device name and the qdev ID but the HMP
> -     * version has only one, so we must decide which one to pass. */
> -    if (blk_by_name(device)) {
> -        throttle.has_device =3D true;
> -        throttle.device =3D device;
> -    } else {
> -        throttle.has_id =3D true;
> -        throttle.id =3D device;
> -    }
> -
> -    qmp_block_set_io_throttle(&throttle, &err);
> -    hmp_handle_error(mon, err);
> -}
> -
> -void hmp_block_stream(Monitor *mon, const QDict *qdict)
> -{
> -    Error *error =3D NULL;
> -    const char *device =3D qdict_get_str(qdict, "device");
> -    const char *base =3D qdict_get_try_str(qdict, "base");
> -    int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
> -
> -    qmp_block_stream(true, device, device, base !=3D NULL, base, false, =
NULL,
> -                     false, NULL, qdict_haskey(qdict, "speed"), speed, t=
rue,
> -                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, fals=
e,
> -                     &error);
> -
> -    hmp_handle_error(mon, error);
> -}
> -
>  typedef struct HMPMigrationStatus
>  {
>      QEMUTimer *timer;
> @@ -2219,70 +2146,6 @@ void hmp_chardev_send_break(Monitor *mon, const QD=
ict *qdict)
>      hmp_handle_error(mon, local_err);
>  }
> =20
> -void hmp_qemu_io(Monitor *mon, const QDict *qdict)
> -{
> -    BlockBackend *blk;
> -    BlockBackend *local_blk =3D NULL;
> -    bool qdev =3D qdict_get_try_bool(qdict, "qdev", false);
> -    const char* device =3D qdict_get_str(qdict, "device");
> -    const char* command =3D qdict_get_str(qdict, "command");
> -    Error *err =3D NULL;
> -    int ret;
> -
> -    if (qdev) {
> -        blk =3D blk_by_qdev_id(device, &err);
> -        if (!blk) {
> -            goto fail;
> -        }
> -    } else {
> -        blk =3D blk_by_name(device);
> -        if (!blk) {
> -            BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
> -            if (bs) {
> -                blk =3D local_blk =3D blk_new(bdrv_get_aio_context(bs),
> -                                          0, BLK_PERM_ALL);
> -                ret =3D blk_insert_bs(blk, bs, &err);
> -                if (ret < 0) {
> -                    goto fail;
> -                }
> -            } else {
> -                goto fail;
> -            }
> -        }
> -    }
> -
> -    /*
> -     * Notably absent: Proper permission management. This is sad, but it=
 seems
> -     * almost impossible to achieve without changing the semantics and t=
hereby
> -     * limiting the use cases of the qemu-io HMP command.
> -     *
> -     * In an ideal world we would unconditionally create a new BlockBack=
end for
> -     * qemuio_command(), but we have commands like 'reopen' and want the=
m to
> -     * take effect on the exact BlockBackend whose name the user passed =
instead
> -     * of just on a temporary copy of it.
> -     *
> -     * Another problem is that deleting the temporary BlockBackend invol=
ves
> -     * draining all requests on it first, but some qemu-iotests cases wa=
nt to
> -     * issue multiple aio_read/write requests and expect them to complet=
e in
> -     * the background while the monitor has already returned.
> -     *
> -     * This is also what prevents us from saving the original permission=
s and
> -     * restoring them later: We can't revoke permissions until all reque=
sts
> -     * have completed, and we don't know when that is nor can we really =
let
> -     * anything else run before we have revoken them to avoid race condi=
tions.
> -     *
> -     * What happens now is that command() in qemu-io-cmds.c can extend t=
he
> -     * permissions if necessary for the qemu-io command. And they simply=
 stay
> -     * extended, possibly resulting in a read-only guest device keeping =
write
> -     * permissions. Ugly, but it appears to be the lesser evil.
> -     */
> -    qemuio_command(blk, command);
> -
> -fail:
> -    blk_unref(local_blk);
> -    hmp_handle_error(mon, err);
> -}
> -
>  void hmp_object_del(Monitor *mon, const QDict *qdict)
>  {
>      const char *id =3D qdict_get_str(qdict, "id");
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


