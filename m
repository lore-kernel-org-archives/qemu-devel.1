Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21448C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF84A207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrIoSqNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF84A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4q0-0000cf-2N
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw4pP-000076-QV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw4pO-0007fD-8G
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:53:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw4pO-0007em-4A
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580133201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1D61Euv1G/m5Jy7tdIIUeBtYkylxNxa3L9FastLvNuU=;
 b=JrIoSqNO16klvqevtas7n1uFagG/Wx9riVKv7W0qHw7lraV8yRpfKyxnGDjnHuDhH5TmL8
 vwBa4vYHG90/h3pokVOeN8y9EqY/Dic0debO6AUm/XPPCH1BxPUS4jrVS3O1/y9u1xI9XP
 tFHkheOSPy2lMFb8XtGX9abOkzqwC6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-DWKjHauXOKiMWszBeF85rA-1; Mon, 27 Jan 2020 08:53:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8902A13FF;
 Mon, 27 Jan 2020 13:53:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5F1D4521;
 Mon, 27 Jan 2020 13:53:16 +0000 (UTC)
Message-ID: <418004b0c3e8bf1c076a46d514f2267d971f6929.camel@redhat.com>
Subject: Re: [PATCH 9/9] monitor/hmp: Prefer to use hmp_handle_error for
 error reporting in block hmp commands
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 15:53:15 +0200
In-Reply-To: <87zhe9nhdl.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-10-mlevitsk@redhat.com>
 <87tv6piuj3.fsf@dusky.pond.sub.org>
 <e59646ae85bce7f38747dc706ca34324393e7441.camel@redhat.com>
 <87zhe9nhdl.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: DWKjHauXOKiMWszBeF85rA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-01-27 at 14:44 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Wed, 2019-11-27 at 09:38 +0100, Markus Armbruster wrote:
> > > Title is too long.  blockdev-hmp-cmds.c will become
> > > block/monitor/block-hmp-cmds.c in v2.  With this in mind, suggest
> > > 
> > >     block/monitor: Prefer to use hmp_handle_error() to report HMP errors
> > > 
> > > Maxim Levitsky <mlevitsk@redhat.com> writes:
> > > 
> > > > This way they all will be prefixed with 'Error:' which some parsers
> > > > (e.g libvirt need)
> > > 
> > > Sadly, "all" is far from true.  Consider
> > > 
> > >     void hmp_drive_add(Monitor *mon, const QDict *qdict)
> > >     {
> > >         Error *err = NULL;
> > >         DriveInfo *dinfo = NULL;
> > >         QemuOpts *opts;
> > >         MachineClass *mc;
> > >         const char *optstr = qdict_get_str(qdict, "opts");
> > >         bool node = qdict_get_try_bool(qdict, "node", false);
> > > 
> > >         if (node) {
> > >             hmp_drive_add_node(mon, optstr);
> > >             return;
> > >         }
> > > 
> > >         opts = drive_def(optstr);
> > >         if (!opts)
> > >             return;
> > > 
> > > 
> > > hmp_drive_add_node() uses error_report() and error_report_err().  Easy
> > > enough to fix if you move the function here, as I suggested in my review
> > > of PATCH 8.
> > 
> > To be honest that involves exporting the monitor_bdrv_states variable and
> > bds_tree_init, which were both static before, but I created a patch that does that,
> > If that is all right, I'll squash it with some of my patches.
> > 
> > 
> > > 
> > > drive_def() is a wrapper around qemu_opts_parse_noisily(), which uses
> > > error_report_err().  You can't change qemu_opts_parse_noisily() to use
> > > hmp_handle_error().  You'd have to convert drive_def() to Error, which
> > > involves switching it to qemu_opts_parse() + qemu_opts_print_help().
> > > 
> > > These are just the first two error paths in this file.  There's much
> > > more.  Truly routing all HMP errors through hmp_handle_error() takes a
> > > *massive* Error conversion effort, with a high risk of missing Error
> > > conversions, followed by a never-ending risk of non-Error stuff creeping
> > > in.
> > 
> > Oops. Active can of worms is detected. Take cover!
> 
> :)
> 
> > > There must be an easier way.
> > > 
> > > Consider vreport():
> > > 
> > >     switch (type) {
> > >     case REPORT_TYPE_ERROR:
> > >         break;
> > >     case REPORT_TYPE_WARNING:
> > >         error_printf("warning: ");
> > >         break;
> > >     case REPORT_TYPE_INFO:
> > >         error_printf("info: ");
> > >         break;
> > >     }
> > > 
> > > Adding the prefix here (either unconditionally, or if cur_mon) covers
> > > all HMP errors reported with error_report() & friends in one blow.
> > 
> > This is a very good idea.
> > If feels like this should be done unconditionally, although that will
> > break probably some scripts that depend on exact value of the error message (but to be honest,
> > scripts shouldn't be doing that in first place).
> > 
> > Doing that with cur_mon (took me some time to figure out what that is) will
> > limit the damage but its a bit of a hack.
> > 
> > 
> > I think that this is a very good change anyway though so if everyone agrees,
> > I will be more that happy to do this change.
> > Thoughts?
> 
> I think adding an "error: " tag has been proposed before.
> 
> I dislike overly decorated error messages, because decoration tends to
> obscure information.
> 
> However, when there's significant non-error output, or even uncertainty
> of what's an error and what's something else, decoration can help.
Yes, also this way it is consistent

> 
> Perhaps you can give some examples where the proposed decoration helps.
It helps to tag most monitor messages with error prefix which was the root cause of
me starting to work on this refactoring.
You suggested this, and I kind of like that idea.

> 
> > > That leaves the ones that are still reported with monitor_printf().
> > > Converting those to error_report() looks far more tractable to me.
> > 
> > Yep, in fact I grepped the tree for monitor_printf and there are not
> > that much instances of this used for error reporting, so it might
> > be possible to have 'error' prefix on all monitor errors that way
> > and not only for the block layer.
> 
> I figure "all" would be more useful than "just for the block layer".
Yep, the cover letter is outdated, now this patch series touch way
more that the block layer.

Best regards,
	Maxim Levitsky




