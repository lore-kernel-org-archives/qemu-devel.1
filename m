Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C969BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9609420716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMGZquG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9609420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4ht-0006k6-Oe
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iw4h5-00063V-UE
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iw4h4-0008Qv-Lp
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:44:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iw4h4-0008QZ-IA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580132685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdOnJjixyvvGBpZQ5oqpbn2lOIQ7nT8t2wAgVHZOEFs=;
 b=AMGZquG9ITIudzyZspMQ5LdFFDm80O75rliiQNADKP5VfchrtOxzw6sEyWfXHv38Hbrk4e
 sg5VsSoZaeyiBmW/1sdrrEuoTORxMmBdqoZfPR3O+/R0jrbQPA1nc+4NEWamZ+c3MzLI40
 +isgNI9MW2pAhHB/oKMR3zYAsMzR5Bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-h9QmG7VzNz22KWnqHvMEHQ-1; Mon, 27 Jan 2020 08:44:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8D9E13E1;
 Mon, 27 Jan 2020 13:44:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3F1F5D9CA;
 Mon, 27 Jan 2020 13:44:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 393CD1138600; Mon, 27 Jan 2020 14:44:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 9/9] monitor/hmp: Prefer to use hmp_handle_error for error
 reporting in block hmp commands
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-10-mlevitsk@redhat.com>
 <87tv6piuj3.fsf@dusky.pond.sub.org>
 <e59646ae85bce7f38747dc706ca34324393e7441.camel@redhat.com>
Date: Mon, 27 Jan 2020 14:44:38 +0100
In-Reply-To: <e59646ae85bce7f38747dc706ca34324393e7441.camel@redhat.com>
 (Maxim Levitsky's message of "Mon, 27 Jan 2020 13:04:48 +0200")
Message-ID: <87zhe9nhdl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: h9QmG7VzNz22KWnqHvMEHQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Wed, 2019-11-27 at 09:38 +0100, Markus Armbruster wrote:
>> Title is too long.  blockdev-hmp-cmds.c will become
>> block/monitor/block-hmp-cmds.c in v2.  With this in mind, suggest
>>=20
>>     block/monitor: Prefer to use hmp_handle_error() to report HMP errors
>>=20
>> Maxim Levitsky <mlevitsk@redhat.com> writes:
>>=20
>> > This way they all will be prefixed with 'Error:' which some parsers
>> > (e.g libvirt need)
>>=20
>> Sadly, "all" is far from true.  Consider
>>=20
>>     void hmp_drive_add(Monitor *mon, const QDict *qdict)
>>     {
>>         Error *err =3D NULL;
>>         DriveInfo *dinfo =3D NULL;
>>         QemuOpts *opts;
>>         MachineClass *mc;
>>         const char *optstr =3D qdict_get_str(qdict, "opts");
>>         bool node =3D qdict_get_try_bool(qdict, "node", false);
>>=20
>>         if (node) {
>>             hmp_drive_add_node(mon, optstr);
>>             return;
>>         }
>>=20
>>         opts =3D drive_def(optstr);
>>         if (!opts)
>>             return;
>>=20
>>=20
>> hmp_drive_add_node() uses error_report() and error_report_err().  Easy
>> enough to fix if you move the function here, as I suggested in my review
>> of PATCH 8.
> To be honest that involves exporting the monitor_bdrv_states variable and
> bds_tree_init, which were both static before, but I created a patch that =
does that,
> If that is all right, I'll squash it with some of my patches.
>
>
>>=20
>> drive_def() is a wrapper around qemu_opts_parse_noisily(), which uses
>> error_report_err().  You can't change qemu_opts_parse_noisily() to use
>> hmp_handle_error().  You'd have to convert drive_def() to Error, which
>> involves switching it to qemu_opts_parse() + qemu_opts_print_help().
>>=20
>> These are just the first two error paths in this file.  There's much
>> more.  Truly routing all HMP errors through hmp_handle_error() takes a
>> *massive* Error conversion effort, with a high risk of missing Error
>> conversions, followed by a never-ending risk of non-Error stuff creeping
>> in.
> Oops. Active can of worms is detected. Take cover!

:)

>> There must be an easier way.
>>=20
>> Consider vreport():
>>=20
>>     switch (type) {
>>     case REPORT_TYPE_ERROR:
>>         break;
>>     case REPORT_TYPE_WARNING:
>>         error_printf("warning: ");
>>         break;
>>     case REPORT_TYPE_INFO:
>>         error_printf("info: ");
>>         break;
>>     }
>>=20
>> Adding the prefix here (either unconditionally, or if cur_mon) covers
>> all HMP errors reported with error_report() & friends in one blow.
>
> This is a very good idea.
> If feels like this should be done unconditionally, although that will
> break probably some scripts that depend on exact value of the error messa=
ge (but to be honest,
> scripts shouldn't be doing that in first place).
>
> Doing that with cur_mon (took me some time to figure out what that is) wi=
ll
> limit the damage but its a bit of a hack.
>
>
> I think that this is a very good change anyway though so if everyone agre=
es,
> I will be more that happy to do this change.
> Thoughts?

I think adding an "error: " tag has been proposed before.

I dislike overly decorated error messages, because decoration tends to
obscure information.

However, when there's significant non-error output, or even uncertainty
of what's an error and what's something else, decoration can help.

Perhaps you can give some examples where the proposed decoration helps.

>> That leaves the ones that are still reported with monitor_printf().
>> Converting those to error_report() looks far more tractable to me.
> Yep, in fact I grepped the tree for monitor_printf and there are not
> that much instances of this used for error reporting, so it might
> be possible to have 'error' prefix on all monitor errors that way
> and not only for the block layer.

I figure "all" would be more useful than "just for the block layer".

[...]


