Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB5C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D6E206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 13:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaijjQ/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D6E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJdn2-0004qZ-G9
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 09:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJdmL-0004Gu-Um
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJdmK-0001yK-7U
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:51:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJdmJ-0001y9-UC
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 09:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585749094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5ihu7wuea/BZTRKQHmpqVZH23PSAULOBnt2fe+aCOBs=;
 b=LaijjQ/hiHEEerp0dF3oi7SRXrz6BHAkqx6rOR8lTU0qmaalJIdkR1XXsxC4UffQA4XepU
 pEbcSstX7+zT1Ltj74TzFQtTfiGZWrJOE0zoEqey9Esnno0z6cLst9B87dO/Frj74eeh3w
 dGb969dHFWxgxONAjxwT5/EoS34cHm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-u-eJ8r2mNsKDXlnDMlKSyg-1; Wed, 01 Apr 2020 09:51:32 -0400
X-MC-Unique: u-eJ8r2mNsKDXlnDMlKSyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 877081005509;
 Wed,  1 Apr 2020 13:51:31 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-172.ams2.redhat.com [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65DCA5D9CA;
 Wed,  1 Apr 2020 13:51:27 +0000 (UTC)
Date: Wed, 1 Apr 2020 15:51:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v10 10/14] iotests: add hmp helper with logging
Message-ID: <20200401135126.GA27663@linux.fritz.box>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-11-jsnow@redhat.com>
 <88146808-4acc-247e-d34b-5dd16baad0b4@redhat.com>
 <20200331140057.GG7030@linux.fritz.box>
 <19eedbae-0660-5a28-e20b-ddf82a36fe73@redhat.com>
MIME-Version: 1.0
In-Reply-To: <19eedbae-0660-5a28-e20b-ddf82a36fe73@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
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

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.04.2020 um 14:28 hat Max Reitz geschrieben:
> On 31.03.20 16:00, Kevin Wolf wrote:
> > Am 31.03.2020 um 12:21 hat Max Reitz geschrieben:
> >> On 31.03.20 02:00, John Snow wrote:
> >>> Minor cleanup for HMP functions; helps with line length and consolida=
tes
> >>> HMP helpers through one implementation function.
> >>>
> >>> Although we are adding a universal toggle to turn QMP logging on or o=
ff,
> >>> many existing callers to hmp functions don't expect that output to be
> >>> logged, which causes quite a few changes in the test output.
> >>>
> >>> For now, offer a use_log parameter.
> >>>
> >>>
> >>> Typing notes:
> >>>
> >>> QMPResponse is just an alias for Dict[str, Any]. It holds no special
> >>> meanings and it is not a formal subtype of Dict[str, Any]. It is best
> >>> thought of as a lexical synonym.
> >>>
> >>> We may well wish to add stricter subtypes in the future for certain
> >>> shapes of data that are not formalized as Python objects, at which po=
int
> >>> we can simply retire the alias and allow mypy to more strictly check
> >>> usages of the name.
> >>>
> >>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>> ---
> >>>  tests/qemu-iotests/iotests.py | 35 ++++++++++++++++++++++-----------=
--
> >>>  1 file changed, 22 insertions(+), 13 deletions(-)
> >>
> >> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >>
> >>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
> >>> index b08bcb87e1..dfc753c319 100644
> >>> --- a/tests/qemu-iotests/iotests.py
> >>> +++ b/tests/qemu-iotests/iotests.py
> >>> @@ -37,6 +37,10 @@
> >>> =20
> >>>  assert sys.version_info >=3D (3, 6)
> >>> =20
> >>> +# Type Aliases
> >>> +QMPResponse =3D Dict[str, Any]
> >>> +
> >>> +
> >>>  faulthandler.enable()
> >>> =20
> >>>  # This will not work if arguments contain spaces but is necessary if=
 we
> >>> @@ -540,25 +544,30 @@ def add_incoming(self, addr):
> >>>          self._args.append(addr)
> >>>          return self
> >>> =20
> >>> -    def pause_drive(self, drive, event=3DNone):
> >>> -        '''Pause drive r/w operations'''
> >>> +    def hmp(self, command_line: str, use_log: bool =3D False) -> QMP=
Response:
> >>> +        cmd =3D 'human-monitor-command'
> >>> +        kwargs =3D {'command-line': command_line}
> >>> +        if use_log:
> >>> +            return self.qmp_log(cmd, **kwargs)
> >>> +        else:
> >>> +            return self.qmp(cmd, **kwargs)
> >>
> >> Hm.  I suppose I should take this chance to understand something about
> >> mypy.  QEMUMachine.qmp() isn=E2=80=99t typed, so mypy can=E2=80=99t ch=
eck that this
> >> really returns QMPResponse.  Is there some flag to make it?  Like
> >> --actually-check-types?
> >=20
> > There is --check-untyped-defs, but I'm not sure if that actually change=
s
> > the return type of untyped functions from Any to an inferred type. I
> > kind of doubt it.
>=20
> Well, but Any doesn=E2=80=99t fit into QMPResponse, so there should be an=
 error
> reported somewhere.

Any is the void* of Python typing. It's compatible with everything else,
in both directions.

> >> (--strict seems, well, overly strict?  Like not allowing generics, I
> >> don=E2=80=99t see why.  Or I suppose for the time being we want to all=
ow untyped
> >> definitions, as long as they don=E2=80=99t break type assertions such =
as it kind
> >> of does here...?)
> >=20
> > At least, --strict does actually complain about this one because Any
> > isn't good enough any more (it includes --warn-return-any):
>=20
> Hm, yes, but we=E2=80=99re not at a point where it=E2=80=99s really feasi=
ble to enable
> --strict...

We're not yet, but I think it's a reasonable goal.

Kevin

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJehJxdAAoJEH8JsnLIjy/W8b0P/18IP4YDLcEd4QghrlLA9dCb
jyWxJavBpI1zxgtsxFXJRawR9AmJTuF6m89ey26K5Wgr67bZDp6ljPLgkLUnPJcM
FbGsoxNZptM/4Abzn26zI0aPdTNRnfxPo7OqQM7UhTkK9CiDY0w47DEQy6my95uP
oc8M11+blKchgsyE60TuztJ1EAYTbxMsFKpF9Ddb9enTj9zS5Zav6anRIOie2T+T
MKExDVN2j0SC69yubEhkhhF1CExoKzrUrzQojL/YpJOyWIBovkEBVfjyvAKQ28ac
0pzLWkyTwnTIrRfj9QmxOBFplFE5xriPybyAYSnKNRhBjsZzq7+94LIneI4+svsd
GIwNQQUfLHGyW6EasBkgbDdcNx+tNGBkxkYzUBL6CdTVlXmMWKfig0i+BDG+RPpY
0XzuknyPYe6AGv47E47+64l/CLUZjC1B7TN+7OCiAwTcHyUdd1uGCtDAbBrdHpZ3
uDzv5IOGbsjBDKu4Jx1CSyxDLfjYyHtER91fuugNcF/dp5z6eIuJohsBap9n+AOk
y4BPSf3kajkn2m1mxhLV2G+AQJrp6KODjGGbDa8hWlhqUd+RrT1pQ7iTddB2xiM2
R3lCbNIoRKFxzRxZF6HVKbW0YJG2xmkTKXPWvVt4+CdK7pld3vjZhAG6BOrMAFtG
/hJubVUIggSbhSlKLBgM
=xekf
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--


