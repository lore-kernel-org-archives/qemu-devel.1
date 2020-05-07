Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB3FC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FE42083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrZMGUS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FE42083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk4o-0003YX-Ok
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjyd-0001jb-HY
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:06:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjyc-00047t-A2
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588871185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGKlQzkeI97KLcQnvca86pZXSsDM0sRGmqg6SbvFaek=;
 b=NrZMGUS2/vbinZmPuobJQ03aUEdHIFGTtpWkAOo90udsozj5GINa0KpkwRsPhTTqUhyMQy
 lKul54DOOjRCgtk61ERcwHB7PocMwOq7hpG/q2XQ5ugFxXeRw6PF+D177JSwkKjEqERzxL
 GaHftoTcBcMtzZjF8c/cZ3AkTup9CSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-llqWwXyxOdWZUe7-eLFUGw-1; Thu, 07 May 2020 13:06:24 -0400
X-MC-Unique: llqWwXyxOdWZUe7-eLFUGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13F698014D6;
 Thu,  7 May 2020 17:06:23 +0000 (UTC)
Received: from work-vm (ovpn-114-224.ams2.redhat.com [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BBC610002AA;
 Thu,  7 May 2020 17:06:13 +0000 (UTC)
Date: Thu, 7 May 2020 18:06:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
Message-ID: <20200507170611.GF2699@work-vm>
References: <20200407114449.482532-1-clg@kaod.org>
 <87a72q6fi4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a72q6fi4.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> C=E9dric Le Goater <clg@kaod.org> writes:
>=20
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Reimplement it based on qmp_qom_get() to avoid converting QObjects back
> > to strings.
> >
> > Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> >
> > Slight fix for bit-rot:
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > [clg: updates for QEMU 5.0 ]
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >
> >  I would like to restart the discussion on qom-get command to understan=
d
> >  what was the conclusion and see if things have changed since.
>=20
> I've since learned more about QOM.  I believe we should do HMP qom-get,
> but not quite like this patch does.  Let me explain.
>=20
> A QOM property has ->get() and ->set() methods to expose the property
> via the Visitor interface.
>=20
> ->get() works with an output visitor.  With the QObject output visitor,
> you can get the property value as a QObject.  QMP qom-get uses this.
> With the string output visitor, you can get it as a string.  Your
> proposed HMP qom-get uses this.
>=20
> ->set() works with an input visitor.  With the QObject input visitor,
> you can set the property value from a QObject.  QMP qom-set uses this.
> With the string input visitor, you can set it from a string.  HMP
> qom-set uses this.  With the options visitor, you can set it from a
> QemuOpts.  CLI -object uses this.
>=20
> The Visitor interface supports arbitrary QAPI types.  The ->get() and
> ->set() methods can use them all.
>=20
> Some visitors, howerver, carry restrictions:
>=20
>  * The string output visitor does not implement support for visiting
>  * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>  * requires a non-null list argument to visit_start_list().
>=20
>  * The string input visitor does not implement support for visiting
>  * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lists
>  * of integers (except type "size") are supported.
>=20
>  * The Opts input visitor does not implement support for visiting QAPI
>  * alternates, numbers (other than integers), null, or arbitrary
>  * QTypes.  It also requires a non-null list argument to
>  * visit_start_list().
>=20
> If you try to qom-set a property whose ->set() uses something the string
> input visitor doesn't support, QEMU crashes.  Same for -object, and your
> proposed qom-get.

Crashing would be bad.

> I'm not aware of such a ->set(), but this is a death trap all the same.
>=20
> The obvious way to disarm it is removing the restrictions.
>=20
> One small step we took towards that goal is visible in the comments
> above: support for flat lists of integers.  The code for that will make
> your eyes bleed.  It's been a thorn in my side ever since I inherited
> QAPI.  Perhaps it could be done better.  But there's a reason why it
> should not be done at all: it's language design.
>=20
> The QObject visitors translate between QAPI types and our internal
> representation of JSON.  The JSON parser and formatter complete the
> translation to and from JSON.  Sensible enough.
>=20
> The string visitors translate between QAPI and ...  well, a barely
> documented language of our own "design".  Tolerable when the language it
> limited to numbers, booleans and strings.  Foolish when it grows into
> something isomorphic to JSON.
>=20
> This is a dead end.
>=20
> Can we still implement a safe and tolerably useful HMP qom-get and
> qom-set?  I think we can.  Remember the basic rule of HMP command
> implementation: wrap around the QMP command.  So let's try that.
>=20
> hmp_qom_get() calls qmp_qom_get() and formats the resulting QObject with
> qobject_to_json_pretty().

Why don't we *just* do this?
OK, we wont fix the qom-set or the CLI, but if we just get hmp_qom_get
to call QMP, format it into json and then dump the json to the user,
then we get a usable, if not pretty, qom-get command, without having to
solve all these hard problems to move it forward?

Dave

> hmp_qom_get() parses the value with qobject_from_json(), and feeds the
> resulting QObject to qmp_qom_set().  To avoid interference with the HMP
> parser, we probably want argument type 'S'.
>=20
> The two commands then parse / print JSON instead of the string visitors'
> language.  Is that bad?
>=20
> * Integers: qom-set loses support for hexadecimal and octal.
>=20
> * Bools: qom-set loses alternate spellings of true and false.
>=20
> * Floating-point numbers: no change
>=20
> * Strings: gain enclosing quotes.
>=20
> * List of integers: gain enclosing square brackets.  qom-set loses
>   support for ranges.
>=20
>   The only use of lists I can find is memory-backend property
>   host-nodes.
>=20
> * Everything else: lose support for crashing QEMU.
>=20
>   Again, I'm not aware of properties that crash now.
>=20
> I think these changes are just fine.  If you disagree, you could try to
> mitigate with convenience magic like "if it doesn't parse as JSON, and
> it looks hexadecimal, convert to decimal and try again", or "looks kind
> of stringy, enclose in double-quotes and try again".  Bad idea if you
> ask me, but I'm not the HMP maintainer anymore.
>=20
> Here's an idea I hate less.  Remember, since the opts visitor also has
> restrictions, -object is also prone to crashing.  But that's an instance
> of a problem we've thought about at some depth, and where we have a
> plan: we intend to replace QemuOpts with QObject (which means we can
> switch to the QObject visitors), and have CLI options take either JSON
> or a relatively simple KEY=3DVALUE,... language similar to what QemuOpts
> accepts now.
>=20
> Yes, that's also a language of our own design, but it comes with a few
> excuses:
>=20
> 0. It lets us avoid radical change of QEMU's CLI.
>=20
> 1. It's fairly simple.  It does not try to be isomorphic to JSON.  It
> doesn't have to, because you can always fall back to JSON when things
> get wonky.
>=20
> 2. It's documented.  So far only in util/keyval.c.  No good for users
> there, but at least it demonstrates we know what language we're parsing
> (modulo parser bugs).  More than what can be said for many ad hoc
> languages...
>=20
> We could use this for a friendlier qom-set.  I'm not sure it's worth the
> trouble at this time.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


