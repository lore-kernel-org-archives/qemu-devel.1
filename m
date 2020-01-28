Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB3AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D20206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEvEOe5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D20206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWrL-0001BQ-MT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwW9Q-0004Pb-RL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwW9O-00031W-Jo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:03:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwW9O-00030r-Dn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580238230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bCu431ef1W1SGQrfrMVh8YOIfJwnYc/nLYO6SJTHIk=;
 b=iEvEOe5OGM0VMKvpndOT744zkGQjX0TNcDSqQEou/11HVJoNSgnUAsL5qekKY3PAUWlCmN
 Fi/UNKuC67woAZs/i3bWHh8iMq0qUJ3YEf8Y6k5F8bHx7spSO6O3MHLEqnnQ12SBG+bXOB
 3H8I9AYSKOWo5a29Z8j3PtRaWv3fDlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-N9yEshnFOIKcGFWj1_bCnA-1; Tue, 28 Jan 2020 14:03:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95E3510054E3;
 Tue, 28 Jan 2020 19:03:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 838F15C1D8;
 Tue, 28 Jan 2020 19:03:39 +0000 (UTC)
Date: Tue, 28 Jan 2020 19:03:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 11/13] monitor: Move hmp_drive_add_node to
 block-hmp-cmds.c
Message-ID: <20200128190337.GF3215@work-vm>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-12-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200127103647.17761-12-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: N9yEshnFOIKcGFWj1_bCnA-1
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

Looks OK to me, I'm not clear on the name for 'bdrv_set_monitor_owned'
I'd want a block person to OK that, but:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  block/monitor/block-hmp-cmds.c | 30 ++++++++++++++++++++++++
>  blockdev.c                     | 42 +++++++---------------------------
>  include/block/block_int.h      |  5 ++--
>  3 files changed, 41 insertions(+), 36 deletions(-)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index a4b1604aee..7bbe4e3814 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -33,6 +33,36 @@
>  #include "monitor/hmp.h"
>  #include "qemu-io.h"
> =20
> +static void hmp_drive_add_node(Monitor *mon, const char *optstr)
> +{
> +    QemuOpts *opts;
> +    QDict *qdict;
> +    Error *local_err =3D NULL;
> +
> +    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
> +    if (!opts) {
> +        return;
> +    }
> +
> +    qdict =3D qemu_opts_to_qdict(opts, NULL);
> +
> +    if (!qdict_get_try_str(qdict, "node-name")) {
> +        qobject_unref(qdict);
> +        error_report("'node-name' needs to be specified");
> +        goto out;
> +    }
> +
> +    BlockDriverState *bs =3D bds_tree_init(qdict, &local_err);
> +    if (!bs) {
> +        error_report_err(local_err);
> +        goto out;
> +    }
> +
> +    bdrv_set_monitor_owned(bs);
> +out:
> +    qemu_opts_del(opts);
> +}
> +
>  void hmp_drive_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err =3D NULL;
> diff --git a/blockdev.c b/blockdev.c
> index df43e0aaef..63805f34b5 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -64,7 +64,7 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/throttle-options.h"
> =20
> -static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
> +QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =3D
>      QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
> =20
>  static int do_open_tray(const char *blk_name, const char *qdev_id,
> @@ -75,6 +75,11 @@ static void blockdev_insert_medium(bool has_device, co=
nst char *device,
>                                     bool has_id, const char *id,
>                                     const char *node_name, Error **errp);
> =20
> +void bdrv_set_monitor_owned(BlockDriverState *bs)
> +{
> +    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
> +}
> +
>  static const char *const if_name[IF_COUNT] =3D {
>      [IF_NONE] =3D "none",
>      [IF_IDE] =3D "ide",
> @@ -652,7 +657,7 @@ err_no_opts:
>  }
> =20
>  /* Takes the ownership of bs_opts */
> -static BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
> +BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
>  {
>      int bdrv_flags =3D 0;
> =20
> @@ -4201,37 +4206,6 @@ out:
>      aio_context_release(aio_context);
>  }
> =20
> -void hmp_drive_add_node(Monitor *mon, const char *optstr)
> -{
> -    QemuOpts *opts;
> -    QDict *qdict;
> -    Error *local_err =3D NULL;
> -
> -    opts =3D qemu_opts_parse_noisily(&qemu_drive_opts, optstr, false);
> -    if (!opts) {
> -        return;
> -    }
> -
> -    qdict =3D qemu_opts_to_qdict(opts, NULL);
> -
> -    if (!qdict_get_try_str(qdict, "node-name")) {
> -        qobject_unref(qdict);
> -        error_report("'node-name' needs to be specified");
> -        goto out;
> -    }
> -
> -    BlockDriverState *bs =3D bds_tree_init(qdict, &local_err);
> -    if (!bs) {
> -        error_report_err(local_err);
> -        goto out;
> -    }
> -
> -    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
> -
> -out:
> -    qemu_opts_del(opts);
> -}
> -
>  void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
>  {
>      BlockDriverState *bs;
> @@ -4261,7 +4235,7 @@ void qmp_blockdev_add(BlockdevOptions *options, Err=
or **errp)
>          goto fail;
>      }
> =20
> -    QTAILQ_INSERT_TAIL(&monitor_bdrv_states, bs, monitor_list);
> +    bdrv_set_monitor_owned(bs);
> =20
>  fail:
>      visit_free(v);
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index dd033d0b37..10df257a61 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1217,8 +1217,6 @@ BlockJob *backup_job_create(const char *job_id, Blo=
ckDriverState *bs,
>                              BlockCompletionFunc *cb, void *opaque,
>                              JobTxn *txn, Error **errp);
> =20
> -void hmp_drive_add_node(Monitor *mon, const char *optstr);
> -
>  BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
>                                    const char *child_name,
>                                    const BdrvChildRole *child_role,
> @@ -1320,4 +1318,7 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *s=
rc, uint64_t src_offset,
> =20
>  int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
> =20
> +void bdrv_set_monitor_owned(BlockDriverState *bs);
> +BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp);
> +
>  #endif /* BLOCK_INT_H */
> --=20
> 2.17.2
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


