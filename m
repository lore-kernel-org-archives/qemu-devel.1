Received: from eggs.gnu.org ([2001:4830:134:3::10]:44955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebsyf-00028q-6A
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebsyc-0003bU-3g
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:02:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebsyb-0003ay-R0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:02:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A9BC15D5E9
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 19:02:20 +0000 (UTC)
References: <20180117164118.8510-1-berrange@redhat.com>
	<20180117164118.8510-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2b317c1-4ba9-ee88-2f4f-43be23b382a8@redhat.com>
Date: Wed, 17 Jan 2018 13:02:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180117164118.8510-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LVUd9TmNHEUdqN1sPGRDpT1p4QKfMOE5a"
Subject: Re: [Qemu-devel] [PATCH v7 4/4] hw: convert virtio-input-hid device
 to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LVUd9TmNHEUdqN1sPGRDpT1p4QKfMOE5a
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <d2b317c1-4ba9-ee88-2f4f-43be23b382a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] hw: convert virtio-input-hid device
 to keycodemapdb
References: <20180117164118.8510-1-berrange@redhat.com>
 <20180117164118.8510-5-berrange@redhat.com>
In-Reply-To: <20180117164118.8510-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 10:41 AM, Daniel P. Berrange wrote:
> Replace the keymap_qcode table with automatically generated
> tables.
>=20
> Missing entries in keymap_qcode now fixed:
>=20

>=20
> When a keycode is removed from the list of possible keycodes that host =
can
> send to the guest, it means that the guest OS will think it is possible=

> to receive a key that in pratice can never be generated, which is harml=
ess.

s/pratice/practice/

>=20
> When a keycode is added to the list of possible keycodes that the host =
can
> send to the guest, it means that the guest OS can see an unexpected eve=
nt.
> The Linux virtio_input.c driver code simply forwards this event to the
> input_event() method in the Linux input subsystem. This in turn calls
> input_handle_event(), which then calls input_get_disposition(). This me=
thod
> checks if the input event is present in the permitted keys bitmap, and =
if
> not returns INPUT_IGNORE_EVENT. Thus the unexpected event will get drop=
ped,
> which is harmless.
>=20
> If the guest OS reboots, or otherwise re-initializes the virt-input dev=
ice,
> it will read the new keycode bitmap. No matter how many keys are define=
d,
> the config space has a fixed 128 byte bitmap. There is, however, a size=

> field defiend which says how many bytes in the bitmap are used. So the =
guest

s/defiend/defined/

> OS reads the size of the bitmap, and then it reads the data from bitmap=
 upto

s/upto/up to/

> the designated size. So if the guest OS re-initializes at precisely the=
 time
> that QEMU is migrated across versions, in the worst case, it could conc=
eivably
> read the old size field, but then get the newly updated bitmap.  If a k=
ey were
> added this is harmless, since it simply means it may not process the ne=
wly
> added key. If a key were removed, then it could be readnig a byte from =
the

s/readnig/reading/

> bitmap that was not initialized. Fortunately QEMU always memsets() the =
entire

maybe s/memsets()/memset()s/

> bitmap to 0, prior to setting keybits. Thus the guest OS will simply re=
ad
> zeros, which is again harmless.
>=20
> Based on this analysis, it is believed that there is no need to preserv=
e the
> virtio-input-hid keymaps across migration, as the host<->guest ABI chan=
ge is
> harmless and self-resolving at time of guest reboot.
>=20
> NB, this behaviour should perhaps be formalized in the virtio-input spe=
c
> to declare how guest OS drivers should be written to be robust in their=

> handling of the potentially changable key bitmaps.

Your analysis of the issues, as well as the advice to enhance the
virtio-input spec to document that a guest must not react negatively to
the change, both sound reasonable.

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/input/virtio-input-hid.c | 136 +++---------------------------------=
--------
>  1 file changed, 9 insertions(+), 127 deletions(-)

Fun diffstat ratio!

I have not closely reviewed the series, so much as noticing the grammar
on the fly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LVUd9TmNHEUdqN1sPGRDpT1p4QKfMOE5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfna8ACgkQp6FrSiUn
Q2qtFAf+P2C8IsYt0DzD0aDdDA3WG8XUT7dUoHa0aTdrzqfMq3/gQLF84tFf2mi3
NUkeSlgvHloLwapx68Rh5Jvn9jaz+CU1EKX7oCYbyC4tyGkA+ndxOCro0p+IG8mo
3iRd9H3adn21WmR9SutfjSkyZQRGho299cflaif/L+o+inTdy/N/6oztmUU47oNR
eI680h5h291SPL7/zn9q94b+OoM4z/aELkxIujpVzDZHCvBASA6cVTzi4YPY/yyf
QeNMon/fQBvjOJjleSjoasdKz2F2fcTEE2pCeQuigds4b0Jt+3KijbHa0AGnqpbD
FJch8PTq8k7+Fkn5oVttzDOL1XECXA==
=YVyi
-----END PGP SIGNATURE-----

--LVUd9TmNHEUdqN1sPGRDpT1p4QKfMOE5a--
