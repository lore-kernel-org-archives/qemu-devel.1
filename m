Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DEFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E661E204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaybVous"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZszM-0008Pf-PW
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZsx7-0005j1-Dj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:45:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZspz-0008W3-Fw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:38:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22038
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZspz-0008VY-Cc
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574843894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPEs8/pE+VTcAuOtELiV3djIrMn+FYJwvQ1eE27/WCg=;
 b=eaybVousphY+zzM/XVYk2BITd7SMeQ8C91c7vkhTcmqp62P40Nt9VsYfjbK3Z1o75+aUqF
 93h4+bZZWUaGPmrHHLQquNv/h4W9t0DapGPRwz2DYYszpWJpqk2NGXuQLhCy8T6Jv2ve+X
 xyYLuineHyVtz4/4RrWChX7jbf7onyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-sbHI71EXN_WG2WLQCNZfRQ-1; Wed, 27 Nov 2019 03:38:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 229FE1083E83;
 Wed, 27 Nov 2019 08:38:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA1FD19C69;
 Wed, 27 Nov 2019 08:38:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B8861138606; Wed, 27 Nov 2019 09:38:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 9/9] monitor/hmp: Prefer to use hmp_handle_error for error
 reporting in block hmp commands
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-10-mlevitsk@redhat.com>
Date: Wed, 27 Nov 2019 09:38:08 +0100
In-Reply-To: <20191120185850.18986-10-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 20 Nov 2019 20:58:50 +0200")
Message-ID: <87tv6piuj3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sbHI71EXN_WG2WLQCNZfRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Title is too long.  blockdev-hmp-cmds.c will become
block/monitor/block-hmp-cmds.c in v2.  With this in mind, suggest

    block/monitor: Prefer to use hmp_handle_error() to report HMP errors

Maxim Levitsky <mlevitsk@redhat.com> writes:

> This way they all will be prefixed with 'Error:' which some parsers
> (e.g libvirt need)

Sadly, "all" is far from true.  Consider

    void hmp_drive_add(Monitor *mon, const QDict *qdict)
    {
        Error *err =3D NULL;
        DriveInfo *dinfo =3D NULL;
        QemuOpts *opts;
        MachineClass *mc;
        const char *optstr =3D qdict_get_str(qdict, "opts");
        bool node =3D qdict_get_try_bool(qdict, "node", false);

        if (node) {
            hmp_drive_add_node(mon, optstr);
            return;
        }

        opts =3D drive_def(optstr);
        if (!opts)
            return;


hmp_drive_add_node() uses error_report() and error_report_err().  Easy
enough to fix if you move the function here, as I suggested in my review
of PATCH 8.

drive_def() is a wrapper around qemu_opts_parse_noisily(), which uses
error_report_err().  You can't change qemu_opts_parse_noisily() to use
hmp_handle_error().  You'd have to convert drive_def() to Error, which
involves switching it to qemu_opts_parse() + qemu_opts_print_help().

These are just the first two error paths in this file.  There's much
more.  Truly routing all HMP errors through hmp_handle_error() takes a
*massive* Error conversion effort, with a high risk of missing Error
conversions, followed by a never-ending risk of non-Error stuff creeping
in.

There must be an easier way.

Consider vreport():

    switch (type) {
    case REPORT_TYPE_ERROR:
        break;
    case REPORT_TYPE_WARNING:
        error_printf("warning: ");
        break;
    case REPORT_TYPE_INFO:
        error_printf("info: ");
        break;
    }

Adding the prefix here (either unconditionally, or if cur_mon) covers
all HMP errors reported with error_report() & friends in one blow.

That leaves the ones that are still reported with monitor_printf().
Converting those to error_report() looks far more tractable to me.

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  blockdev-hmp-cmds.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
> index c943dccd03..197994716f 100644
> --- a/blockdev-hmp-cmds.c
> +++ b/blockdev-hmp-cmds.c
> @@ -59,7 +59,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
>      mc =3D MACHINE_GET_CLASS(current_machine);
>      dinfo =3D drive_new(opts, mc->block_default_type, &err);
>      if (err) {
> -        error_report_err(err);
>          qemu_opts_del(opts);
>          goto err;
>      }
> @@ -73,7 +72,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "OK\n");
>          break;
>      default:
> -        monitor_printf(mon, "Can't hot-add drive to type %d\n", dinfo->t=
ype);
> +        error_setg(&err, "Can't hot-add drive to type %d", dinfo->type);
>          goto err;
>      }
>      return;
> @@ -84,6 +83,7 @@ err:
>          monitor_remove_blk(blk);
>          blk_unref(blk);
>      }
> +    hmp_handle_error(mon, &err);
>  }
> =20
>  void hmp_drive_del(Monitor *mon, const QDict *qdict)
> @@ -105,14 +105,14 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict=
)
> =20
>      blk =3D blk_by_name(id);
>      if (!blk) {
> -        error_report("Device '%s' not found", id);
> -        return;
> +        error_setg(&local_err, "Device '%s' not found", id);
> +        goto err;

Having to create Error objects just so we can use hmp_handle_error() is
awkward.  Tolerable if using hmp_handle_error() improves matters.  I'm
not sure it does.

>      }
> =20
>      if (!blk_legacy_dinfo(blk)) {
> -        error_report("Deleting device added with blockdev-add"
> -                     " is not supported");
> -        return;
> +        error_setg(&local_err,
> +                   "Deleting device added with blockdev-add is not suppo=
rted");
> +        goto err;
>      }
> =20
>      aio_context =3D blk_get_aio_context(blk);
> @@ -121,9 +121,8 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
>      bs =3D blk_bs(blk);
>      if (bs) {
>          if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err))=
 {
> -            error_report_err(local_err);
>              aio_context_release(aio_context);
> -            return;
> +            goto err;
>          }
> =20
>          blk_remove_bs(blk);
> @@ -144,12 +143,15 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict=
)
>      }
> =20
>      aio_context_release(aio_context);
> +err:
> +    hmp_handle_error(mon, &local_err);
>  }
> =20
>  void hmp_commit(Monitor *mon, const QDict *qdict)
>  {
>      const char *device =3D qdict_get_str(qdict, "device");
>      BlockBackend *blk;
> +    Error *local_err =3D NULL;
>      int ret;
> =20
>      if (!strcmp(device, "all")) {
> @@ -160,12 +162,12 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
> =20
>          blk =3D blk_by_name(device);
>          if (!blk) {
> -            error_report("Device '%s' not found", device);
> -            return;
> +            error_setg(&local_err, "Device '%s' not found", device);
> +            goto err;
>          }
>          if (!blk_is_available(blk)) {
> -            error_report("Device '%s' has no medium", device);
> -            return;
> +            error_setg(&local_err, "Device '%s' has no medium", device);
> +            goto err;
>          }
> =20
>          bs =3D blk_bs(blk);
> @@ -177,8 +179,13 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>          aio_context_release(aio_context);
>      }
>      if (ret < 0) {
> -        error_report("'commit' error for '%s': %s", device, strerror(-re=
t));
> +        error_setg(&local_err,
> +                   "'commit' error for '%s': %s", device, strerror(-ret)=
);
> +        goto err;
>      }
> +    return;
> +err:
> +    hmp_handle_error(mon, &local_err);
>  }
> =20
>  void hmp_drive_mirror(Monitor *mon, const QDict *qdict)


