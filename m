Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12693C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03BD20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEZ+sHBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03BD20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHSv-0006tY-VV
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJHSC-0006Pg-S5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJHS7-0003uk-Jr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:01:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJHS7-0003uH-Fc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vykEBNjA9nZlPdKtJJsSdWL9jAVCWnY6L3zQtIGgfUY=;
 b=CEZ+sHBQlQmVy9QH5y9ddB8j4LS/WRpM//xOnSPV6Xm0VZFeoyn4M6RJfT4+yRRV5Tfkrv
 bl0YqUa0Plzvnk4I67bQ/tjZ1GD0MOr12NCuhqylqqKQeFTOp0Gzd7bvfz3xOv5XqAO2iT
 SlBOibpH6s8mtQWnNeVnLpBx/OIWNvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-62g4znLTMFCqzFDCGHWEpA-1; Tue, 31 Mar 2020 10:01:01 -0400
X-MC-Unique: 62g4znLTMFCqzFDCGHWEpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3154801E70;
 Tue, 31 Mar 2020 14:01:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAFE35C541;
 Tue, 31 Mar 2020 14:00:58 +0000 (UTC)
Date: Tue, 31 Mar 2020 16:00:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v10 10/14] iotests: add hmp helper with logging
Message-ID: <20200331140057.GG7030@linux.fritz.box>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-11-jsnow@redhat.com>
 <88146808-4acc-247e-d34b-5dd16baad0b4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <88146808-4acc-247e-d34b-5dd16baad0b4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.03.2020 um 12:21 hat Max Reitz geschrieben:
> On 31.03.20 02:00, John Snow wrote:
> > Minor cleanup for HMP functions; helps with line length and consolidate=
s
> > HMP helpers through one implementation function.
> >=20
> > Although we are adding a universal toggle to turn QMP logging on or off=
,
> > many existing callers to hmp functions don't expect that output to be
> > logged, which causes quite a few changes in the test output.
> >=20
> > For now, offer a use_log parameter.
> >=20
> >=20
> > Typing notes:
> >=20
> > QMPResponse is just an alias for Dict[str, Any]. It holds no special
> > meanings and it is not a formal subtype of Dict[str, Any]. It is best
> > thought of as a lexical synonym.
> >=20
> > We may well wish to add stricter subtypes in the future for certain
> > shapes of data that are not formalized as Python objects, at which poin=
t
> > we can simply retire the alias and allow mypy to more strictly check
> > usages of the name.
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/qemu-iotests/iotests.py | 35 ++++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 13 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> > index b08bcb87e1..dfc753c319 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -37,6 +37,10 @@
> > =20
> >  assert sys.version_info >=3D (3, 6)
> > =20
> > +# Type Aliases
> > +QMPResponse =3D Dict[str, Any]
> > +
> > +
> >  faulthandler.enable()
> > =20
> >  # This will not work if arguments contain spaces but is necessary if w=
e
> > @@ -540,25 +544,30 @@ def add_incoming(self, addr):
> >          self._args.append(addr)
> >          return self
> > =20
> > -    def pause_drive(self, drive, event=3DNone):
> > -        '''Pause drive r/w operations'''
> > +    def hmp(self, command_line: str, use_log: bool =3D False) -> QMPRe=
sponse:
> > +        cmd =3D 'human-monitor-command'
> > +        kwargs =3D {'command-line': command_line}
> > +        if use_log:
> > +            return self.qmp_log(cmd, **kwargs)
> > +        else:
> > +            return self.qmp(cmd, **kwargs)
>=20
> Hm.  I suppose I should take this chance to understand something about
> mypy.  QEMUMachine.qmp() isn=E2=80=99t typed, so mypy can=E2=80=99t check=
 that this
> really returns QMPResponse.  Is there some flag to make it?  Like
> --actually-check-types?

There is --check-untyped-defs, but I'm not sure if that actually changes
the return type of untyped functions from Any to an inferred type. I
kind of doubt it.

> (--strict seems, well, overly strict?  Like not allowing generics, I
> don=E2=80=99t see why.  Or I suppose for the time being we want to allow =
untyped
> definitions, as long as they don=E2=80=99t break type assertions such as =
it kind
> of does here...?)

At least, --strict does actually complain about this one because Any
isn't good enough any more (it includes --warn-return-any):

iotests.py:560: warning: Returning Any from function declared to return "Di=
ct[str, Any]"
iotests.py:560: error: Call to untyped function "qmp_log" in typed context
iotests.py:562: warning: Returning Any from function declared to return "Di=
ct[str, Any]"

Not sure why you think it doesn't allow generics? I never had problems
with that, even in my Python museum. :-)

Kevin

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeg00ZAAoJEH8JsnLIjy/W+EAQALdFDb2wQWEmygG/9RFLys5p
wuZKGtHc+JhwYEQRHAsVbYfGEEHZEREnybH/3by5pmGwcczcrvH2sVldD4cFEqr0
Z34K/pr9aZJ+LLho6MEjwkH3i3PhoAG8yfPbk6LaGKtRsUsQhhr8dxA/Mdia3LHy
x67BaJcT0r+8xOOzIU4Lg8baA5SIEw+CGvkbNz4RU/mN+O6C5jpB3Od8XCLsa+rv
0EwYoMDbIhFn7/NwhYde024AO+MZMhHm1fxCYPazwtzVg3WausHiYnoVGm6MWKqV
qWCdbPxpqE/2SF1AIwrCn8vKdv0ycKE2xVbJboIo7zC67Ia0vft1XKEPRvxtz8rg
lQcjA6VXyet2iMtvH6pBS9fz/X8b+2K9C7mt3hA4u9S7jhqAW4Cx8rn4Dwj5ER/X
mxK22i0X6H1hQ4SWxcWpva89w+K1sTK2waDFoRjZF0DFUkaznY2C/slhsO26coB1
vqbLgMGGduvUA8xFPMwVV6s9xInd+8+YAz+k4cPgQPGpkdrmj9JXIhPm17J4cTzE
2a5F2yun1D2dIRDqfWw1Vsyy5nc1K5apFqvYCbju/FzqX87eiftYeHTMffn9eyXW
A5mIS0ypl7AfT/s0V2ZB2vI42AHXLFgfxdUdI/i6t+O+6JQfhRQwH/zX2Oo9UjcA
mfusmxG6wLdBKPzjB/a7
=7xHU
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


