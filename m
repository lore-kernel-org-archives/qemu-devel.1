Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBE0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949D320878
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+AzgMyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949D320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWrt-0006bT-G1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWqp-00068A-DD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWqn-00066x-0y
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600975455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CQ/dz5WfuuIv731DvM5gHhK+Rs5mXbX8GWISC3eNQo=;
 b=W+AzgMyPdVJi4Nv9BWuqzF6h9NB2mcOOuwRFJ14QH23JSPC2CunsHfhBDMD8V99RXUX707
 cHmsjPHtcqLJXIW/j/VLAtbG63moqMkPK7lTKf4Iv2XAD9PQdB2DcEEBQZuCr/Ihzv9kSh
 OhtzlpX9zlop39/+lobZKs0p9+qwJvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-fkAZ6-YFN0Kt2JTGBDM80A-1; Thu, 24 Sep 2020 15:24:11 -0400
X-MC-Unique: fkAZ6-YFN0Kt2JTGBDM80A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9055E10066FE;
 Thu, 24 Sep 2020 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B545319D7C;
 Thu, 24 Sep 2020 19:24:09 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:24:07 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 02/38] qapi-gen: Separate arg-parsing from generation
Message-ID: <20200924192407.GA347036@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-3-jsnow@redhat.com>
 <20200923000031.GB191229@localhost.localdomain>
 <7920bff4-dd4b-4ef6-ce85-90e693efc749@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7920bff4-dd4b-4ef6-ce85-90e693efc749@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 01:05:47PM -0400, John Snow wrote:
> On 9/22/20 8:00 PM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:25PM -0400, John Snow wrote:
> > > This is a minor re-work of the entrypoint script. It isolates a
> > > generate() method from the actual command-line mechanism.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi-gen.py | 87 ++++++++++++++++++++++++++++++++----------=
---
> > >   1 file changed, 63 insertions(+), 24 deletions(-)
> > >=20
> > > diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> > > index 4b03f7d53b..59becba3e1 100644
> > > --- a/scripts/qapi-gen.py
> > > +++ b/scripts/qapi-gen.py
> > > @@ -1,9 +1,13 @@
> > >   #!/usr/bin/env python3
> > > -# QAPI generator
> > > -#
> > > +
> > >   # This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > >   # See the COPYING file in the top-level directory.
> > > +"""
> > > +QAPI Generator
> > > +
> > > +This script is the main entry point for generating C code from the Q=
API schema.
> > > +"""
> > >   import argparse
> > >   import re
> > > @@ -11,21 +15,65 @@
> > >   from qapi.commands import gen_commands
> > >   from qapi.doc import gen_doc
> > > +from qapi.error import QAPIError
> > >   from qapi.events import gen_events
> > >   from qapi.introspect import gen_introspect
> > > -from qapi.schema import QAPIError, QAPISchema
> > > +from qapi.schema import QAPISchema
> > >   from qapi.types import gen_types
> > >   from qapi.visit import gen_visit
> > > -def main(argv):
> > > +DEFAULT_OUTPUT_DIR =3D ''
> > > +DEFAULT_PREFIX =3D ''
> >=20
> > I did not understand the purpose of these.  If they're used only as
> > the default value for the command line option parsing, I'd suggest
> > dropping them.
> >=20
>=20
> The alternative is setting default=3D'' inline below, which is fine, but =
found
> them kind of buried; and looking a bit too much like a weird magic consta=
nt.
> Aesthetically, I liked making them obvious.
>

I differ in opinion and style, and I don't think you should adopt
mine.  Just for the record, though, consider if would do the same for
dozens of command line options... IMO it'd be fine to declare them for
extra explicitness, but I see no reason for them to be module globals.

> You found them! My plan worked.
>

:)

- Cleber.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s8lMACgkQZX6NM6Xy
CfPx4w/+MDgPLeiQ75hGmjgdRKqsmKrkJMJ8WEIgTd2VT5UHO4DHQbgg1hvAq0Xk
JflcykcqQro5l/ErHpb8YG2yF6+x3Nm3RKqC5VR8AXKjyPrKxZ6o4ayK4wkWdMVB
dSll2yet2hMX0czK0kygkYHhzlGJGNk7sOZH7oEeZ/k7slhKLyjHUFLGzdO/66pD
FSh9fQIECsoUolyuk3J06U7DjhvL/sG8W0zjF4QZ9WePbhx+3ojGR0UNF/T4don6
NqMZf+YuCPBaTLW2EZuu/aeFRe4e01TdAs0Oo7nw51eiqngtfXaKzogJ0uirC6cT
rqLlQAujkDfHBAMuPFobhLD/Jn8JywSJbyBUD5f0pe5uag8FBVfHZOG4Nuo/FPqt
CZgm2w5bRGbnDjPheZavjr1RbrOcii7cDcPP3MfJZG2GkA9MN4nC8ezcLl4mP4Ee
YpynMlNxK15snj1O0ZjHS1m2MXPF5DMi0Y/ygLlQWLuNqZnYGvHjU3kUGukQflBA
l+lVQdBm1jJ0REvh5WpGfsZB1T/sqy+cQHYMaE2KOBfU339d0ggHq31NT6GNhTJY
pmko5rZxchwYmE1wLLfDXdBFkcjiXuUTXCgh/JUbfeLszOijjDk4GbnUSm4CXbZG
+QceowTLuoFuUILGsWXYyYYi1n9ZAqSyPFBYMGA9ze3zA7sISOo=
=FOzl
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--


