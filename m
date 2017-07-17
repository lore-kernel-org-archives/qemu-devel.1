Received: from eggs.gnu.org ([2001:4830:134:3::10]:47596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6Np-0000K3-FZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX6Nk-00019b-SO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:48:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX6Nk-000190-Ho
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:48:16 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
Date: Mon, 17 Jul 2017 08:48:08 -0500
MIME-Version: 1.0
In-Reply-To: <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EtaVmeMwEiRtm0xnu3XXjswDC4In14m8c"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EtaVmeMwEiRtm0xnu3XXjswDC4In14m8c
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
In-Reply-To: <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 08:42 AM, Eric Blake wrote:
> On 07/13/2017 08:07 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 04/07/2017 04:21 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Dave,
>>>
>>> On 04/07/2017 11:38 AM, Dr. David Alan Gilbert wrote:
>>>> Hi,
>>>>    Fedora 26 has gcc 7.0.1 which has the normal compliment
>>>> of new fussy warnings; so far I've posted :
>>>>
>>>> tests/check-qdict: Fix missing brackets
>>>> slirp/smb: Replace constant strings by glib string
>>>>
>>>> that fix one actual mistake and work around something it's being
>>>> fussy over.
>>>>
>>>> But I've also got a pile of hacks, attached below that I'm
>>>> not too sure what I'll do with them yet, but they're attached
>>
>> ping ... What do we do with them?
>=20
> Well, now that I've upgraded to the just-released Fedora 26, it is now
> mainline gcc and affecting my builds.  So we should really try and find=

> patches that silence the warnings (although it counts as bug fixes, so
> it won't hurt if it doesn't make tomorrow's freeze deadline).

FWIW, most of these have been fixed in the meantime; the only remaining
hack I had to add was:

diff --git i/hw/usb/bus.c w/hw/usb/bus.c
index 5939b273b9..bce011058b 100644
--- i/hw/usb/bus.c
+++ w/hw/usb/bus.c
@@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,
USBPort *ports[],
 void usb_port_location(USBPort *downstream, USBPort *upstream, int portn=
r)
 {
     if (upstream) {
-        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
-                 upstream->path, portnr);
+        int l =3D snprintf(downstream->path, sizeof(downstream->path),
"%s.%d",
+                         upstream->path, portnr);
+        assert(l < sizeof(downstream->path));
         downstream->hubcount =3D upstream->hubcount + 1;
     } else {
         snprintf(downstream->path, sizeof(downstream->path), "%d", portn=
r);

Gerd, MAINTAINERS lists you; can you come up with something more robust?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EtaVmeMwEiRtm0xnu3XXjswDC4In14m8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllswBkACgkQp6FrSiUn
Q2qYAwf/TSxdd8Uc4RZw59JXRMtwh7GcYjQhkitDrdTPNs0p4ldLRb+FCk7ndO8p
V7beCedbY7X3eLP2AyIxZ1LT99k3aAuujOv83HbKSwEo6m7jY4otWvGs1XphTBUR
s6N0kmlgygWysieMgu7kUZv5LhC8PEYSTJgUAUmrrr9X4yXHlOovzT/lwi4OXvY6
g1uJX+OarpvJ/EXykrccRhGIzyrizk/ZdKLh7ib/Vhcrjq0nS2bwpc3xbMOpNaxU
NvglUeaKE3Gc2q5x01qZSr+6dwlZMlkCsBVMdt+yb2MbMnjYfbQAI6uQhxe7I9LQ
il9bMzWmd4Vd82i6vFoeyh/NkIOfEg==
=ThSe
-----END PGP SIGNATURE-----

--EtaVmeMwEiRtm0xnu3XXjswDC4In14m8c--
