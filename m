Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF15C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B99F2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwRmDxGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B99F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isP7Y-0001FC-B0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isP6Q-0000I6-Mp
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isP6O-00044v-Tq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:43:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isP6O-00044L-Q5
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579257824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drS6Sr7D2ITK2ECqBM4+3feJCoJ15PTl7z8oaBQgYOU=;
 b=XwRmDxGqsp3exv/8ts5BjoUp7zfp912JvOxEPOqpOsbTeJcLG7v/SFzpuYOt+umF6dclx8
 LNRMSCjZMGSOKHOl+H2OiDQDsBSujp9s5MNdYZzWBrUWTG7eO3M9lLjVwlgnbv5caaJbet
 ddElKesVyeXxHS+4ar0gupuM2Zl2VuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-8GRychTIMBiEbDiTrobbcQ-1; Fri, 17 Jan 2020 05:43:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E35B9800D41;
 Fri, 17 Jan 2020 10:43:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 277DA845B3;
 Fri, 17 Jan 2020 10:43:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA5AA1138600; Fri, 17 Jan 2020 11:43:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-2-kwolf@redhat.com>
 <875zhc9360.fsf@dusky.pond.sub.org>
 <20200115155850.GG5505@linux.fritz.box>
 <871rrzy2sg.fsf@dusky.pond.sub.org>
 <20200116150214.GH9470@linux.fritz.box>
 <87o8v2o6r2.fsf@dusky.pond.sub.org>
 <20200117094050.GA7394@dhcp-200-226.str.redhat.com>
Date: Fri, 17 Jan 2020 11:43:35 +0100
In-Reply-To: <20200117094050.GA7394@dhcp-200-226.str.redhat.com> (Kevin Wolf's
 message of "Fri, 17 Jan 2020 10:40:50 +0100")
Message-ID: <8736cemkh4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 8GRychTIMBiEbDiTrobbcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 17.01.2020 um 08:57 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 16.01.2020 um 14:00 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >> > I have no idea if we will eventually get a case where the command w=
ants
>> >> > to behave different between the two modes and actually has use for =
a
>> >> > coroutine. I hope not.
>> >> >
>> >> > But using two bools rather than a single enum keeps the code simple=
 and
>> >> > leaves us all options open if it turns out that we do have a use ca=
se.
>> >>=20
>> >> I can buy the argument "the two are conceptually orthogonal, although=
 we
>> >> don't haven't found a use for one of the four cases".
>> >>=20
>> >> Let's review the four combinations of the two flags once more:
>> >>=20
>> >> * allow-oob: false, coroutine: false
>> >>=20
>> >>   Handler runs in main loop, outside coroutine context.  Okay.
>> >>=20
>> >> * allow-oob: false, coroutine: true
>> >>=20
>> >>   Handler runs in main loop, in coroutine context.  Okay.
>> >>=20
>> >> * allow-oob: true, coroutine: false
>> >>=20
>> >>   Handler may run in main loop or in iothread, outside coroutine
>> >>   context.  Okay.
>> >>=20
>> >> * allow-oob: true, coroutine: true
>> >>=20
>> >>   Handler may run (in main loop, in coroutine context) or (in iothrea=
d,
>> >>   outside coroutine context).  This "in coroutine context only with
>> >>   execute, not with exec-oob" behavior is a bit surprising.
>> >>=20
>> >>   We could document it, noting that it may change to always run in
>> >>   coroutine context.  Or we simply reject this case as "not
>> >>   implemented".  Since we have no uses, I'm leaning towards reject.  =
One
>> >>   fewer case to test then.
>> >
>> > What would be the right mode of rejecting it?
>> >
>> > I assume we should catch it somewhere in the QAPI generator (where?) a=
nd
>>=20
>> check_flags() in expr.py?
>
> Looks like the right place, thanks.
>
>> > then just assert in the C code that both flags aren't set at the same
>> > time?
>>=20
>> I think you already do, in do_qmp_dispatch():
>>=20
>>     assert(!(oob && qemu_in_coroutine()));
>>=20
>> Not sure that's the best spot.  Let's see when I review PATCH 3.
>
> This asserts that exec-oob handlers aren't executed in coroutine
> context. It doesn't assert that the handler doesn't have QCO_COROUTINE
> and QCO_ALLOW_OOB set at the same time.

Asserting this explicitly can't hurt.  qmp_register_command()?

>> >> >> > @@ -194,8 +195,9 @@ out:
>> >> >> >      return ret
>> >> >> > =20
>> >> >> > =20
>> >> >> > -def gen_register_command(name, success_response, allow_oob, all=
ow_preconfig):
>> >> >> > -    options =3D []
>> >> >> > +def gen_register_command(name: str, success_response: bool, all=
ow_oob: bool,
>> >> >> > +                         allow_preconfig: bool, coroutine: bool=
) -> str:
>> >> >> > +    options =3D [] # type: List[str]
>> >>=20
>> >> One more: this is a PEP 484 type hint.  With Python 3, we can use PEP
>> >> 526 instead:
>> >>=20
>> >>           options: List[str] =3D []
>> >>=20
>> >> I think we should.
>> >
>> > This requires Python 3.6, unfortunately. The minimum requirement for
>> > building QEMU is 3.5.
>>=20
>> *Sigh*
>
> One of the reasons why I would have preferred 3.6 as the minimum, but
> our policy says that Debian oldstabe is still relevant for another two
> years. *shrug*

3.5 EOL is scheduled for 2020-09-13.
https://devguide.python.org/#status-of-python-branches

Whether Debian can support it beyond that date seems doubtful.

For another reason to want 3.6, see
[PATCH] qapi: Fix code generation with Python 3.5
Message-Id: <20200116202558.31473-1-armbru@redhat.com>


