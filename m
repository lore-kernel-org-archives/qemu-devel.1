Received: from eggs.gnu.org ([2001:4830:134:3::10]:41672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7aC-00047i-6H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7a8-0000SC-6w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX7a7-0000Qf-TU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:05:08 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<1500300997.12570.8.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b16c5afc-e9ff-2e8b-3c5b-ae7ca0799b96@redhat.com>
Date: Mon, 17 Jul 2017 10:04:59 -0500
MIME-Version: 1.0
In-Reply-To: <1500300997.12570.8.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3L9woAOkUsHAPnN9udElpEonj9Sg79Aus"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3L9woAOkUsHAPnN9udElpEonj9Sg79Aus
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b16c5afc-e9ff-2e8b-3c5b-ae7ca0799b96@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
 <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
 <1500300997.12570.8.camel@redhat.com>
In-Reply-To: <1500300997.12570.8.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 09:16 AM, Gerd Hoffmann wrote:
>   Hi,
>=20
>> FWIW, most of these have been fixed in the meantime; the only
>> remaining
>> hack I had to add was:
>>
>> diff --git i/hw/usb/bus.c w/hw/usb/bus.c
>> index 5939b273b9..bce011058b 100644
>> --- i/hw/usb/bus.c
>> +++ w/hw/usb/bus.c
>> @@ -407,8 +407,9 @@ void usb_register_companion(const char
>> *masterbus,
>> USBPort *ports[],
>>  void usb_port_location(USBPort *downstream, USBPort *upstream, int
>> portnr)
>>  {
>>      if (upstream) {
>> -        snprintf(downstream->path, sizeof(downstream->path),
>> "%s.%d",
>> -                 upstream->path, portnr);
>> +        int l =3D snprintf(downstream->path, sizeof(downstream->path)=
,
>> "%s.%d",
>> +                         upstream->path, portnr);
>> +        assert(l < sizeof(downstream->path));
>=20
> Approach looks ok to me.
>=20
> Maximum hub chain length is 5, number of ports hubs is limited too,
> you'll never need more that two digits for port numbers.  So 2*5 plus 4=

> connecting dots =3D> 14 chars is the max strlen.  path size is 16, so i=
t
> will fit, including the terminating \0.

Cool! With that text in the commit message and/or code comment, we can
turn this from a hack into an actual patch, with no change in code.
I'll go ahead and spin this as a formal patch.

>=20
> Trying things like "assert(portnr <=3D 99)" have no effect on the
> possible string length calculated by gcc7.

Perhaps a limitation that ought to be reported to the gcc folks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3L9woAOkUsHAPnN9udElpEonj9Sg79Aus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls0hsACgkQp6FrSiUn
Q2rdcwgArVCb+ylJzpte4Ki1vPemHJNa71xCnu0mGwVxV1uWsa6R6A1hyz7d/efW
FJNptbMM/CoTXplqb6378pDY0FOGR1zCpucrQESe7qVtTfyApEyjTt4GixuZKZXx
VkQQt5ksHu4Rk6EXfdXa5/Mdv4G1QbNovd6vk1XikvXWFLs54LrFdlvkgRe5zw7l
Q2s4HAfkTVS0J2nPIU/gujZmKJ2fSMneMvutaBdujH030qKlAXzx2Bsvx8aTs5Nu
ByxVpd1t9pbZQCTj/IUs1avt8cKsqqIn6Ouh8ZV3hFfEIOxwnB4PkclAeRgRcB4Z
7DCX3W2+LpWFhTcBYh+lmKs6FWhKiw==
=vlO2
-----END PGP SIGNATURE-----

--3L9woAOkUsHAPnN9udElpEonj9Sg79Aus--
