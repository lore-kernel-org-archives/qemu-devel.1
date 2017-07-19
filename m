Received: from eggs.gnu.org ([2001:4830:134:3::10]:54324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXcxC-00045Y-As
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXcx7-0003h5-Pu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:35:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXcx7-0003fT-FP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 20:34:57 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<d47138bd-1257-19c0-418e-4a4addf7fd8a@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4348196f-c0bc-df80-6ae1-5ea4b8cbba9f@redhat.com>
Date: Tue, 18 Jul 2017 19:34:51 -0500
MIME-Version: 1.0
In-Reply-To: <d47138bd-1257-19c0-418e-4a4addf7fd8a@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="roBqWb2Nj0WMwtrLpn56AGjn3k268WpPl"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--roBqWb2Nj0WMwtrLpn56AGjn3k268WpPl
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <4348196f-c0bc-df80-6ae1-5ea4b8cbba9f@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
 <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
 <d47138bd-1257-19c0-418e-4a4addf7fd8a@twiddle.net>
In-Reply-To: <d47138bd-1257-19c0-418e-4a4addf7fd8a@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 06:59 PM, Richard Henderson wrote:

>> +++ w/hw/usb/bus.c
>> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,=

>> USBPort *ports[],
>>   void usb_port_location(USBPort *downstream, USBPort *upstream, int
>> portnr)
>>   {
>>       if (upstream) {
>> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",=

>> -                 upstream->path, portnr);
>> +        int l =3D snprintf(downstream->path, sizeof(downstream->path)=
,
>> "%s.%d",
>> +                         upstream->path, portnr);
>> +        assert(l < sizeof(downstream->path));
>=20
> Do you really need an assert there, or will
>=20
>     (void)l; /* "used" */
>=20
> work as well?  You didn't mention what the reported error is, so I'm
> guessing.

The original error is that gcc 7 complains that snprintf is prone to
buffer overflow if the input is unbounded.  Adding the assert that we
KNOW the input is not unbounded is enough to shut up gcc, on Linux.
What was then drawn into question is whether assert still has that
property on mingw (since assert on mingw lacks the noreturn marking that
it has on Linux).

At this point, unless someone posts an actual failure of gcc 7 compiling
this code for mingw, I don't see why we have to change it; shutting up
the warning on Linux is good enough for the purpose of this patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--roBqWb2Nj0WMwtrLpn56AGjn3k268WpPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluqSwACgkQp6FrSiUn
Q2oSugf9FNuR7JYbLGzQV3xx4uKkOo969e4lII6Mn1T+UzbKrywyus0sfDODmLdR
3dDbmu9Q0pkdaLagovvR7YM6fKXY2MuA6tXRgJ9yvFjJ2Rqa4dH6wbp+yKWtWqRW
NVyLpSse6YqhlTWOJVxjkrFvoQtfY1wKtLkNg7L7N+87IrVSdTfuhf8DI3fRPk+J
MNj/cFXN4xQ3KU9NxPmZ1kw+ZOp9STeRPQx4wq/D3nlIZrhudJDGDswfMG2SIyk2
/tcKkmNfCfSPQIDfADdswDParoWpvBRFz26xVbXrWTQ0EWPjpepCN93uj18lo7XI
MLQJyHSGWdLeAM0ukQ1gvR4ebnR4Cw==
=HzN2
-----END PGP SIGNATURE-----

--roBqWb2Nj0WMwtrLpn56AGjn3k268WpPl--
