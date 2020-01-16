Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B95C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFD020730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKz5cMJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFD020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6gv-0001xA-SI
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1is6fH-0000UY-6y
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1is6fD-0003aF-B3
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:02:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1is6fD-0003Zi-6t
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579186946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NW7PPPAdqnnJsmPouApanHPH3Yb4Z/0IPWbgTpYewA4=;
 b=jKz5cMJp3XuL0qEHM7V47PRs0LWjJGqIRhG1KqWZNJl6Qbe78uRe0PJxki29CcJihzFqYC
 dPzR/+P2Z1j7Yv14FcYpSZgGey+1NlrEkpg7XxVoOYQsuQEiBKA0xKtGofi6RekJpgR9fg
 C8ic6eAhknNSeJpa96AczjWeG0m597M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-QkwydbuLMdib1P-RHx8P4g-1; Thu, 16 Jan 2020 10:02:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C27B3E5D33;
 Thu, 16 Jan 2020 15:02:19 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F0A386;
 Thu, 16 Jan 2020 15:02:15 +0000 (UTC)
Date: Thu, 16 Jan 2020 16:02:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200116150214.GH9470@linux.fritz.box>
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-2-kwolf@redhat.com>
 <875zhc9360.fsf@dusky.pond.sub.org>
 <20200115155850.GG5505@linux.fritz.box>
 <871rrzy2sg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <871rrzy2sg.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: QkwydbuLMdib1P-RHx8P4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.01.2020 um 14:00 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> > I have no idea if we will eventually get a case where the command wants
> > to behave different between the two modes and actually has use for a
> > coroutine. I hope not.
> >
> > But using two bools rather than a single enum keeps the code simple and
> > leaves us all options open if it turns out that we do have a use case.
>=20
> I can buy the argument "the two are conceptually orthogonal, although we
> don't haven't found a use for one of the four cases".
>=20
> Let's review the four combinations of the two flags once more:
>=20
> * allow-oob: false, coroutine: false
>=20
>   Handler runs in main loop, outside coroutine context.  Okay.
>=20
> * allow-oob: false, coroutine: true
>=20
>   Handler runs in main loop, in coroutine context.  Okay.
>=20
> * allow-oob: true, coroutine: false
>=20
>   Handler may run in main loop or in iothread, outside coroutine
>   context.  Okay.
>=20
> * allow-oob: true, coroutine: true
>=20
>   Handler may run (in main loop, in coroutine context) or (in iothread,
>   outside coroutine context).  This "in coroutine context only with
>   execute, not with exec-oob" behavior is a bit surprising.
>=20
>   We could document it, noting that it may change to always run in
>   coroutine context.  Or we simply reject this case as "not
>   implemented".  Since we have no uses, I'm leaning towards reject.  One
>   fewer case to test then.

What would be the right mode of rejecting it?

I assume we should catch it somewhere in the QAPI generator (where?) and
then just assert in the C code that both flags aren't set at the same
time?

> >> > @@ -194,8 +195,9 @@ out:
> >> >      return ret
> >> > =20
> >> > =20
> >> > -def gen_register_command(name, success_response, allow_oob, allow_p=
reconfig):
> >> > -    options =3D []
> >> > +def gen_register_command(name: str, success_response: bool, allow_o=
ob: bool,
> >> > +                         allow_preconfig: bool, coroutine: bool) ->=
 str:
> >> > +    options =3D [] # type: List[str]
>=20
> One more: this is a PEP 484 type hint.  With Python 3, we can use PEP
> 526 instead:
>=20
>           options: List[str] =3D []
>=20
> I think we should.

This requires Python 3.6, unfortunately. The minimum requirement for
building QEMU is 3.5.

> >> Some extra churn due to type hints here.  Distracting.  Suggest not to
> >> mix adding type hints to existing code with feature work.
> >
> > If you would be open for a compromise, I could leave options
> > unannotated, but keep the typed parameter list.
>=20
> Keeping just the function annotation is much less distracting.  I can't
> reject that with a "separate patches for separate things" argument.
>=20
> I'd still prefer not to, because:
>=20
> * If we do add systematic type hints in the near future, then delaying
>   this one until then shouldn't hurt your productivity.
>=20
> * If we don't, this lone one won't help your productivity much, but
>   it'll look out of place.
>=20
> I really don't want us to add type hints as we go, because such
> open-ended "while we touch it anyway" conversions take forever and a
> day.  Maximizes the confusion integral over time.

I think it's a first time that I'm asked not to document things, but
I'll remove them.

Kevin


