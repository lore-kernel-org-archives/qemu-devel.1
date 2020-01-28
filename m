Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FF8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45096206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjb/2cUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45096206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWsw-0003Rf-Ck
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iwWeJ-0002WE-It
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iwWeH-0003AR-Ky
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:35:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iwWeH-00039X-I0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580240145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBZvDcth/H/tG4ZadvsPjr+ycfqaAiNbMhj46VR4jeY=;
 b=bjb/2cUC/3cTMsLPfQDQg+T12aXNaayhzUXK+0BXavfMQKOpLkzSd0QKhbFkQhCu+47QxG
 Wf5jWFiZ1vNOUgfYAka8HYbiUffV7YTppQczEhqtTe6H3zvumX50oiiw7FdmOuJHift6Zg
 qiG1oJyM7K1TgfuOMdZMKmhFi998Lks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-jjwwRIqZOZihHZQk4qzX3w-1; Tue, 28 Jan 2020 14:35:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DDAF1005514;
 Tue, 28 Jan 2020 19:35:38 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 268AA19486;
 Tue, 28 Jan 2020 19:35:36 +0000 (UTC)
Date: Tue, 28 Jan 2020 19:35:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 9/9] monitor/hmp: Prefer to use hmp_handle_error for
 error reporting in block hmp commands
Message-ID: <20200128193534.GG3215@work-vm>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-10-mlevitsk@redhat.com>
 <87tv6piuj3.fsf@dusky.pond.sub.org>
 <e59646ae85bce7f38747dc706ca34324393e7441.camel@redhat.com>
 <87zhe9nhdl.fsf@dusky.pond.sub.org>
 <418004b0c3e8bf1c076a46d514f2267d971f6929.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <418004b0c3e8bf1c076a46d514f2267d971f6929.camel@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jjwwRIqZOZihHZQk4qzX3w-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxim Levitsky (mlevitsk@redhat.com) wrote:
> On Mon, 2020-01-27 at 14:44 +0100, Markus Armbruster wrote:
> > Maxim Levitsky <mlevitsk@redhat.com> writes:
> >=20
> > > On Wed, 2019-11-27 at 09:38 +0100, Markus Armbruster wrote:
> > > > Title is too long.  blockdev-hmp-cmds.c will become
> > > > block/monitor/block-hmp-cmds.c in v2.  With this in mind, suggest
> > > >=20
> > > >     block/monitor: Prefer to use hmp_handle_error() to report HMP e=
rrors
> > > >=20
> > > > Maxim Levitsky <mlevitsk@redhat.com> writes:
> > > >=20
> > > > > This way they all will be prefixed with 'Error:' which some parse=
rs
> > > > > (e.g libvirt need)
> > > >=20
> > > > Sadly, "all" is far from true.  Consider
> > > >=20
> > > >     void hmp_drive_add(Monitor *mon, const QDict *qdict)
> > > >     {
> > > >         Error *err =3D NULL;
> > > >         DriveInfo *dinfo =3D NULL;
> > > >         QemuOpts *opts;
> > > >         MachineClass *mc;
> > > >         const char *optstr =3D qdict_get_str(qdict, "opts");
> > > >         bool node =3D qdict_get_try_bool(qdict, "node", false);
> > > >=20
> > > >         if (node) {
> > > >             hmp_drive_add_node(mon, optstr);
> > > >             return;
> > > >         }
> > > >=20
> > > >         opts =3D drive_def(optstr);
> > > >         if (!opts)
> > > >             return;
> > > >=20
> > > >=20
> > > > hmp_drive_add_node() uses error_report() and error_report_err().  E=
asy
> > > > enough to fix if you move the function here, as I suggested in my r=
eview
> > > > of PATCH 8.
> > >=20
> > > To be honest that involves exporting the monitor_bdrv_states variable=
 and
> > > bds_tree_init, which were both static before, but I created a patch t=
hat does that,
> > > If that is all right, I'll squash it with some of my patches.
> > >=20
> > >=20
> > > >=20
> > > > drive_def() is a wrapper around qemu_opts_parse_noisily(), which us=
es
> > > > error_report_err().  You can't change qemu_opts_parse_noisily() to =
use
> > > > hmp_handle_error().  You'd have to convert drive_def() to Error, wh=
ich
> > > > involves switching it to qemu_opts_parse() + qemu_opts_print_help()=
.
> > > >=20
> > > > These are just the first two error paths in this file.  There's muc=
h
> > > > more.  Truly routing all HMP errors through hmp_handle_error() take=
s a
> > > > *massive* Error conversion effort, with a high risk of missing Erro=
r
> > > > conversions, followed by a never-ending risk of non-Error stuff cre=
eping
> > > > in.
> > >=20
> > > Oops. Active can of worms is detected. Take cover!
> >=20
> > :)
> >=20
> > > > There must be an easier way.
> > > >=20
> > > > Consider vreport():
> > > >=20
> > > >     switch (type) {
> > > >     case REPORT_TYPE_ERROR:
> > > >         break;
> > > >     case REPORT_TYPE_WARNING:
> > > >         error_printf("warning: ");
> > > >         break;
> > > >     case REPORT_TYPE_INFO:
> > > >         error_printf("info: ");
> > > >         break;
> > > >     }
> > > >=20
> > > > Adding the prefix here (either unconditionally, or if cur_mon) cove=
rs
> > > > all HMP errors reported with error_report() & friends in one blow.
> > >=20
> > > This is a very good idea.
> > > If feels like this should be done unconditionally, although that will
> > > break probably some scripts that depend on exact value of the error m=
essage (but to be honest,
> > > scripts shouldn't be doing that in first place).
> > >=20
> > > Doing that with cur_mon (took me some time to figure out what that is=
) will
> > > limit the damage but its a bit of a hack.
> > >=20
> > >=20
> > > I think that this is a very good change anyway though so if everyone =
agrees,
> > > I will be more that happy to do this change.
> > > Thoughts?
> >=20
> > I think adding an "error: " tag has been proposed before.
> >=20
> > I dislike overly decorated error messages, because decoration tends to
> > obscure information.
> >=20
> > However, when there's significant non-error output, or even uncertainty
> > of what's an error and what's something else, decoration can help.
> Yes, also this way it is consistent

Yes I also like it; I wouldn't worry too much about things parsing error
messages for the exact error message; if anything is doing that then the
corresponding case needs to have big red flags around it.

Dave

> >=20
> > Perhaps you can give some examples where the proposed decoration helps.
> It helps to tag most monitor messages with error prefix which was the roo=
t cause of
> me starting to work on this refactoring.
> You suggested this, and I kind of like that idea.
>=20
> >=20
> > > > That leaves the ones that are still reported with monitor_printf().
> > > > Converting those to error_report() looks far more tractable to me.
> > >=20
> > > Yep, in fact I grepped the tree for monitor_printf and there are not
> > > that much instances of this used for error reporting, so it might
> > > be possible to have 'error' prefix on all monitor errors that way
> > > and not only for the block layer.
> >=20
> > I figure "all" would be more useful than "just for the block layer".
> Yep, the cover letter is outdated, now this patch series touch way
> more that the block layer.
>=20
> Best regards,
> =09Maxim Levitsky
>=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


