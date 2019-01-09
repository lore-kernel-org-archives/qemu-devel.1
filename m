Received: from eggs.gnu.org ([209.51.188.92]:52119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghFEp-0008Ha-46
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghFEo-0005F6-5O
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:53:47 -0500
References: <20190109132302.22634-1-rjones@redhat.com>
	<20190109134448.GO3998@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abb38a2b-cbb4-71f5-c5c7-58380a2e56f3@redhat.com>
Date: Wed, 9 Jan 2019 08:53:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190109134448.GO3998@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zjxHiBjFlGCpdPuKpViuIkxZqeKA6FIql"
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zjxHiBjFlGCpdPuKpViuIkxZqeKA6FIql
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Message-ID: <abb38a2b-cbb4-71f5-c5c7-58380a2e56f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: Add generic function for
 reinitializing optind.
References: <20190109132302.22634-1-rjones@redhat.com>
 <20190109134448.GO3998@redhat.com>
In-Reply-To: <20190109134448.GO3998@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/9/19 7:44 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 09, 2019 at 01:23:01PM +0000, Richard W.M. Jones wrote:
>> How about this one?  Add a generic osdep function for reinitializing
>> optind, which does optreset on FreeBSD (but is identical on all other
>> OSes).  Use it from qemu-io and qemu-img.
>>
>> I have tested this on Linux, FreeBSD and OpenBSD.
>>

>=20
>> WARNING: architecture specific defines should be avoided
>> #78: FILE: include/qemu/osdep.h:600:
>> +#ifdef __FreeBSD__
>=20
> Normally we'd suggest doing a configure test to for the platform
> feature and then using a feature based ifdef test. In this case
> though that would be difficult and/or overly complex.
>=20
> This does make me wonder about the other *BSDs, OS-X and Mingw
> though ?  Should they all be using the #else codepath, or should
> the other BSDs / OS-X use the __FreeBSD__ codepath.

Indeed, and I already suggested a configure-time probe  on the v2
review.  My preference, if we want to go with this helper function for a
hard reset, would be:

#if HAVE_OPTRESET
  optind =3D 1;
  optreset =3D 1;
#else
  optind =3D 0;
#endif

where HAVE_OPTRESET is based on a configure-time probe.

Basically, any platform that HAS optreset will probably honor it; any
platform that lacks optreset is hopefully okay with the
POSIX-unspecified behavior of optind =3D 0.

But I do like the idea presented in this version of trying to isolate
the reset into a common helper function, so that if we have to make
later changes, we only have to touch the one function rather than all
callsites that reset getopt parsing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zjxHiBjFlGCpdPuKpViuIkxZqeKA6FIql
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2CucACgkQ3g5py3or
ov3csggAgyTNsf8YxRTDHLTZOTITNbc10MIIDK+U6DshCi1a2O+HWgTLk5cUvdFT
PCtvg5GFG4Dpgy7IWAmMgGpo2NGkYxgPnwMVPnLshYKydnRpESccO4amsODhjLG4
4bV7KMZvVvtKrU6mxrAK7Mq0R/3Eb6DpwrCaP6hdvYjozlXG0Xxn74MAjZyQeiXK
8NqC9J6oVgtOWt2+h9FIG8HlFdAIFfTU+ZLJYxoD686Q16rI4Xa1zO7te4xvz9iN
py8HN7gc5L2gFujWrFznoFHnDtg3heZN6+d/IIrJSA17WJicMSy0S4kk99IG05KM
Y4VFl2FhhwdBj63T1A0INyIVa/yd7g==
=GXU3
-----END PGP SIGNATURE-----

--zjxHiBjFlGCpdPuKpViuIkxZqeKA6FIql--
