Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3286B206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4ecHTQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3286B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWln-0000VN-DK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWaI-0003Lz-H1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iwWaH-0007vN-4J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:31:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iwWaG-0007tP-UB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580239896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hsLLmGn/WGerjpy1AwcfxDBPWiex+yPQIOQP6w9yEg=;
 b=b4ecHTQLhBOMrjE/UAjsBHVUO8rY1v2YVin7ReYoKV0PI2nH7se7gslPZosjBSGCutVgkT
 IKdnwW/rCI5E8ffAqZyuxYfnaNu065l+M176se/y/1jyibqZF6YnfZl/tiM3lAEIcqca2t
 ulmdznSJQQlgcEcyPORbyuzWQXz6v8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-BoWU1QPVMXyLQOWgm8LnUw-1; Tue, 28 Jan 2020 14:31:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A3FB100550E;
 Tue, 28 Jan 2020 19:31:32 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DFDC88820;
 Tue, 28 Jan 2020 19:31:27 +0000 (UTC)
Message-ID: <f6c782743639a93ac06c8a6ef0e110b66eb613c4.camel@redhat.com>
Subject: Re: [PATCH v3 13/13] monitor/hmp: Prefer to use hmp_handle_error
 for error reporting in block hmp commands
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 Jan 2020 21:31:27 +0200
In-Reply-To: <20200127103647.17761-14-mlevitsk@redhat.com>
References: <20200127103647.17761-1-mlevitsk@redhat.com>
 <20200127103647.17761-14-mlevitsk@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BoWU1QPVMXyLQOWgm8LnUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-01-27 at 12:36 +0200, Maxim Levitsky wrote:
> This way they all will be prefixed with 'Error:' which some parsers
> (e.g libvirt) need
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1719169
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

And I probably will keep that patch since it is not invasive and
still does a nice refactoring.
Thoughts?

Best regards,
	Maxim Levitsky

> ---
>  block/monitor/block-hmp-cmds.c | 35 ++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 7bbe4e3814..5b060d380d 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -84,7 +84,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
>      mc = MACHINE_GET_CLASS(current_machine);
>      dinfo = drive_new(opts, mc->block_default_type, &err);
>      if (err) {
> -        error_report_err(err);
>          qemu_opts_del(opts);
>          goto err;
>      }
> @@ -98,7 +97,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "OK\n");
>          break;
>      default:
> -        monitor_printf(mon, "Can't hot-add drive to type %d\n", dinfo->type);
> +        error_setg(&err, "Can't hot-add drive to type %d", dinfo->type);
>          goto err;
>      }
>      return;
> @@ -109,6 +108,7 @@ err:
>          monitor_remove_blk(blk);
>          blk_unref(blk);
>      }
> +    hmp_handle_error(mon, err);
>  }
>  
>  void hmp_drive_del(Monitor *mon, const QDict *qdict)
> @@ -130,14 +130,14 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
>  
>      blk = blk_by_name(id);
>      if (!blk) {
> -        error_report("Device '%s' not found", id);
> -        return;
> +        error_setg(&local_err, "Device '%s' not found", id);
> +        goto err;
>      }
>  
>      if (!blk_legacy_dinfo(blk)) {
> -        error_report("Deleting device added with blockdev-add"
> -                     " is not supported");
> -        return;
> +        error_setg(&local_err,
> +                   "Deleting device added with blockdev-add is not supported");
> +        goto err;
>      }
>  
>      aio_context = blk_get_aio_context(blk);
> @@ -146,9 +146,8 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
>      bs = blk_bs(blk);
>      if (bs) {
>          if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
> -            error_report_err(local_err);
>              aio_context_release(aio_context);
> -            return;
> +            goto err;
>          }
>  
>          blk_remove_bs(blk);
> @@ -169,12 +168,15 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
>      }
>  
>      aio_context_release(aio_context);
> +err:
> +    hmp_handle_error(mon, local_err);
>  }
>  
>  void hmp_commit(Monitor *mon, const QDict *qdict)
>  {
>      const char *device = qdict_get_str(qdict, "device");
>      BlockBackend *blk;
> +    Error *local_err = NULL;
>      int ret;
>  
>      if (!strcmp(device, "all")) {
> @@ -185,12 +187,12 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>  
>          blk = blk_by_name(device);
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
>  
>          bs = blk_bs(blk);
> @@ -202,8 +204,13 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>          aio_context_release(aio_context);
>      }
>      if (ret < 0) {
> -        error_report("'commit' error for '%s': %s", device, strerror(-ret));
> +        error_setg(&local_err,
> +                   "'commit' error for '%s': %s", device, strerror(-ret));
> +        goto err;
>      }
> +    return;
> +err:
> +    hmp_handle_error(mon, local_err);
>  }
>  
>  void hmp_drive_mirror(Monitor *mon, const QDict *qdict)



