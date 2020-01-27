Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212E8C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C83208CD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhzDykO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C83208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2Ds-0005jA-4u
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2CR-0003EA-5V
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2CN-0005FN-U8
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:04:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw2CM-0005Ef-5F
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580123094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkvGlEtNKtMQvc4X8ggKLsWIRCpIZkVHsImx1ftYn/A=;
 b=BhzDykO6Q0LVocVINVEWUBYay2XPzi1AtBHuLABlgbPQJDQcs6fsSGmO0yWDPNSTOdzA9L
 /AlZOGj1bOXu07iqHiwYZNU0kYg8S9QsmWYRXakLmRIqbml68xVMJ9GgORzhvjS2rIqXW7
 mpQanlBK0ulASJvvf49oRGp99HPMOsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-94BtBKBGNT2Cgvap2hjBNg-1; Mon, 27 Jan 2020 06:04:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8F9108BD19;
 Mon, 27 Jan 2020 11:04:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC565C1D6;
 Mon, 27 Jan 2020 11:04:49 +0000 (UTC)
Message-ID: <e59646ae85bce7f38747dc706ca34324393e7441.camel@redhat.com>
Subject: Re: [PATCH 9/9] monitor/hmp: Prefer to use hmp_handle_error for
 error reporting in block hmp commands
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 13:04:48 +0200
In-Reply-To: <87tv6piuj3.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-10-mlevitsk@redhat.com>
 <87tv6piuj3.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 94BtBKBGNT2Cgvap2hjBNg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-27 at 09:38 +0100, Markus Armbruster wrote:
> Title is too long.  blockdev-hmp-cmds.c will become
> block/monitor/block-hmp-cmds.c in v2.  With this in mind, suggest
> 
>     block/monitor: Prefer to use hmp_handle_error() to report HMP errors
> 
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > This way they all will be prefixed with 'Error:' which some parsers
> > (e.g libvirt need)
> 
> Sadly, "all" is far from true.  Consider
> 
>     void hmp_drive_add(Monitor *mon, const QDict *qdict)
>     {
>         Error *err = NULL;
>         DriveInfo *dinfo = NULL;
>         QemuOpts *opts;
>         MachineClass *mc;
>         const char *optstr = qdict_get_str(qdict, "opts");
>         bool node = qdict_get_try_bool(qdict, "node", false);
> 
>         if (node) {
>             hmp_drive_add_node(mon, optstr);
>             return;
>         }
> 
>         opts = drive_def(optstr);
>         if (!opts)
>             return;
> 
> 
> hmp_drive_add_node() uses error_report() and error_report_err().  Easy
> enough to fix if you move the function here, as I suggested in my review
> of PATCH 8.
To be honest that involves exporting the monitor_bdrv_states variable and
bds_tree_init, which were both static before, but I created a patch that does that,
If that is all right, I'll squash it with some of my patches.


> 
> drive_def() is a wrapper around qemu_opts_parse_noisily(), which uses
> error_report_err().  You can't change qemu_opts_parse_noisily() to use
> hmp_handle_error().  You'd have to convert drive_def() to Error, which
> involves switching it to qemu_opts_parse() + qemu_opts_print_help().
> 
> These are just the first two error paths in this file.  There's much
> more.  Truly routing all HMP errors through hmp_handle_error() takes a
> *massive* Error conversion effort, with a high risk of missing Error
> conversions, followed by a never-ending risk of non-Error stuff creeping
> in.
Oops. Active can of worms is detected. Take cover!

> 
> There must be an easier way.
> 
> Consider vreport():
> 
>     switch (type) {
>     case REPORT_TYPE_ERROR:
>         break;
>     case REPORT_TYPE_WARNING:
>         error_printf("warning: ");
>         break;
>     case REPORT_TYPE_INFO:
>         error_printf("info: ");
>         break;
>     }
> 
> Adding the prefix here (either unconditionally, or if cur_mon) covers
> all HMP errors reported with error_report() & friends in one blow.

This is a very good idea.
If feels like this should be done unconditionally, although that will
break probably some scripts that depend on exact value of the error message (but to be honest,
scripts shouldn't be doing that in first place).

Doing that with cur_mon (took me some time to figure out what that is) will
limit the damage but its a bit of a hack.


I think that this is a very good change anyway though so if everyone agrees,
I will be more that happy to do this change.
Thoughts?

> 
> That leaves the ones that are still reported with monitor_printf().
> Converting those to error_report() looks far more tractable to me.
Yep, in fact I grepped the tree for monitor_printf and there are not
that much instances of this used for error reporting, so it might
be possible to have 'error' prefix on all monitor errors that way
and not only for the block layer.

> 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  blockdev-hmp-cmds.c | 35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> > 
> > diff --git a/blockdev-hmp-cmds.c b/blockdev-hmp-cmds.c
> > index c943dccd03..197994716f 100644
> > --- a/blockdev-hmp-cmds.c
> > +++ b/blockdev-hmp-cmds.c
> > @@ -59,7 +59,6 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
> >      mc = MACHINE_GET_CLASS(current_machine);
> >      dinfo = drive_new(opts, mc->block_default_type, &err);
> >      if (err) {
> > -        error_report_err(err);
> >          qemu_opts_del(opts);
> >          goto err;
> >      }
> > @@ -73,7 +72,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict)
> >          monitor_printf(mon, "OK\n");
> >          break;
> >      default:
> > -        monitor_printf(mon, "Can't hot-add drive to type %d\n", dinfo->type);
> > +        error_setg(&err, "Can't hot-add drive to type %d", dinfo->type);
> >          goto err;
> >      }
> >      return;
> > @@ -84,6 +83,7 @@ err:
> >          monitor_remove_blk(blk);
> >          blk_unref(blk);
> >      }
> > +    hmp_handle_error(mon, &err);
> >  }
> >  
> >  void hmp_drive_del(Monitor *mon, const QDict *qdict)
> > @@ -105,14 +105,14 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
> >  
> >      blk = blk_by_name(id);
> >      if (!blk) {
> > -        error_report("Device '%s' not found", id);
> > -        return;
> > +        error_setg(&local_err, "Device '%s' not found", id);
> > +        goto err;
> 
> Having to create Error objects just so we can use hmp_handle_error() is
> awkward.  Tolerable if using hmp_handle_error() improves matters.  I'm
> not sure it does.

Well, if we go with your suggestion of adding the 'error' prefix to vreport
that will not be needed. In fact then the only use of hmp_handle_error
would be to skip reporting if err is NULL, thus this function can be either
dropped or moved to common monitor code.

> 
> >      }
> >  
> >      if (!blk_legacy_dinfo(blk)) {
> > -        error_report("Deleting device added with blockdev-add"
> > -                     " is not supported");
> > -        return;
> > +        error_setg(&local_err,
> > +                   "Deleting device added with blockdev-add is not supported");
> > +        goto err;
> >      }
> >  
> >      aio_context = blk_get_aio_context(blk);
> > @@ -121,9 +121,8 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
> >      bs = blk_bs(blk);
> >      if (bs) {
> >          if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
> > -            error_report_err(local_err);
> >              aio_context_release(aio_context);
> > -            return;
> > +            goto err;
> >          }
> >  
> >          blk_remove_bs(blk);
> > @@ -144,12 +143,15 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
> >      }
> >  
> >      aio_context_release(aio_context);
> > +err:
> > +    hmp_handle_error(mon, &local_err);
> >  }
> >  
> >  void hmp_commit(Monitor *mon, const QDict *qdict)
> >  {
> >      const char *device = qdict_get_str(qdict, "device");
> >      BlockBackend *blk;
> > +    Error *local_err = NULL;
> >      int ret;
> >  
> >      if (!strcmp(device, "all")) {
> > @@ -160,12 +162,12 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
> >  
> >          blk = blk_by_name(device);
> >          if (!blk) {
> > -            error_report("Device '%s' not found", device);
> > -            return;
> > +            error_setg(&local_err, "Device '%s' not found", device);
> > +            goto err;
> >          }
> >          if (!blk_is_available(blk)) {
> > -            error_report("Device '%s' has no medium", device);
> > -            return;
> > +            error_setg(&local_err, "Device '%s' has no medium", device);
> > +            goto err;
> >          }
> >  
> >          bs = blk_bs(blk);
> > @@ -177,8 +179,13 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
> >          aio_context_release(aio_context);
> >      }
> >      if (ret < 0) {
> > -        error_report("'commit' error for '%s': %s", device, strerror(-ret));
> > +        error_setg(&local_err,
> > +                   "'commit' error for '%s': %s", device, strerror(-ret));
> > +        goto err;
> >      }
> > +    return;
> > +err:
> > +    hmp_handle_error(mon, &local_err);
> >  }
> >  
> >  void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
> 
> 

Best regards,
	Maxim Levitsky



