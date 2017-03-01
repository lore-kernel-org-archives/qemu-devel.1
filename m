Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj6Iy-0007bP-5A
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cj6It-0006Yq-A1
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cj6It-0006YW-17
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:36:35 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 009DEC054901
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 15:36:35 +0000 (UTC)
References: <20170301123223.12489-1-berrange@redhat.com>
	<a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
	<20170301144809.GE10160@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbb1b965-e370-a6e6-48a1-cbfc53326551@redhat.com>
Date: Wed, 1 Mar 2017 09:36:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170301144809.GE10160@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oxRrKHreKrEBLFvNgqoDmQX7OupWTmQ30"
Subject: Re: [Qemu-devel] [PATCH] migration: allow clearing migration string
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oxRrKHreKrEBLFvNgqoDmQX7OupWTmQ30
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <fbb1b965-e370-a6e6-48a1-cbfc53326551@redhat.com>
Subject: Re: [PATCH] migration: allow clearing migration string parameters
References: <20170301123223.12489-1-berrange@redhat.com>
 <a08dc58b-a169-cb17-2187-1b66c6878a39@redhat.com>
 <20170301144809.GE10160@redhat.com>
In-Reply-To: <20170301144809.GE10160@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/01/2017 08:48 AM, Daniel P. Berrange wrote:

>>
>> So now we have a dilemma: do we special case "" here, to be stuck with=

>> it even if we later add nullable-string support later, or do we go all=

>> the way to nullable-string support now?  We've missed soft freeze for
>> 2.9, so my vote is that it is okay to special case "" in  this instanc=
e,
>> even though we'll have to continue to support it indefinitely even if =
we
>> gain nullable-string QMP.
>=20
> FYI, if QEMU ever sends a QMP reply whose value comes from a NULL strin=
g,
> it turns that into "". IOW, on output "" and NULL are indistinguishable=


That's a bug. My work to add a JSON output visitor requires a non-null
string (it is only the qobject output visitor that silently converts
NULL into "", and only because we haven't yet audited the broken
callers).  We WANT to reach the point where "" must be supplied when it
is intended, and where a NULL string can be output as JSON null where
appropriate.

>=20
> So from that POV, treating JSON nil and "" as indistiguishable on input=

> would be consistent with what we do on output.

What we do on output is a result of laziness, not of user input.
Codifying "" as NULL on user input is different than the existing
treatment of NULL as "" on output.

>=20
> I'd only suggest allowing JSON nil on input, if we're willing change th=
e
> output code to map NULL -> nil, instead of NULL -> "".

And yes, I think there ARE cases where we probably want to allow output
of JSON null (probably in the same contexts where we want to allow null
on input).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oxRrKHreKrEBLFvNgqoDmQX7OupWTmQ30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtuqAAAoJEKeha0olJ0NqzuwH/20ZZx1A2zcK8JdkoKl4nvBo
tpSH68GL4K1OfX55/i4ObnxYmwDTL14NLNrwJmj9hinfm/XzARNpP7Zmyuxe9Pe0
QHUl4j1zDAReXDzL7v3CCkol89G3kJUkd8H/sTz9vDAh3iAgFIKauvPaJ/1Q4jQK
UBrETz3GIZVfWSdyLdPlwnDfJXIh3PhSulXNpmk3+xIxISmyUjzscqFkj8bX3lf9
GExonEZrOJ4n0rcK89+ugC6FdgZU5iI7ZFTvoxgndyAdVMWNCQZkUAcCjJvduMbZ
56Fk1cybd/+dzg/f+n0OlPdb03ZKQHqZRIpgGiB+7LzluCHTdegF+sbVHsU4/qE=
=Jc3Q
-----END PGP SIGNATURE-----

--oxRrKHreKrEBLFvNgqoDmQX7OupWTmQ30--
