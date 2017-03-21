Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqKMK-000414-Gy
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqKME-0006Yx-G3
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:02:00 -0400
References: <148968198512.5555.1880820193606077571.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2deb61ba-f800-8774-6dfa-aa4e7c605e55@redhat.com>
Date: Tue, 21 Mar 2017 09:01:50 -0500
MIME-Version: 1.0
In-Reply-To: <148968198512.5555.1880820193606077571.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vv2K1SmI9RLeW7Hi1TAS9D6CrmUd1gBI9"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: don't try to flush self and avoid
 QEMU hang on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vv2K1SmI9RLeW7Hi1TAS9D6CrmUd1gBI9
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <2deb61ba-f800-8774-6dfa-aa4e7c605e55@redhat.com>
Subject: Re: [PATCH] 9pfs: don't try to flush self and avoid QEMU hang on
 reset
References: <148968198512.5555.1880820193606077571.stgit@bahia>
In-Reply-To: <148968198512.5555.1880820193606077571.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 11:33 AM, Greg Kurz wrote:
> According to the 9P spec [*], when a client wants to cancel a pending I=
/O
> request identified by a given tag (uint16), it must send a Tflush messa=
ge
> and wait for the server to respond with a Rflush message before reusing=
 this
> tag for another I/O. The server may still send a completion message for=
 the
> I/O if it wasn't actually cancelled but the Rflush message must arrive =
after
> that.
>=20
> QEMU hence waits for the flushed PDU to complete before sending the Rfl=
ush
> message back to the client.
>=20
> If a client sends 'Tflush tag oldtag' and tag =3D=3D oldtag, QEMU will =
then
> allocate a PDU identified by tag, find it in the PDU list and wait for
> this same PDU to complete... i.e. wait for a completion that will never=

> happen. This causes a tag and ring slot leak in the guest, and a PDU
> leak in QEMU, all of them limited by the maximal number of PDUs (128).
> But, worse, this causes QEMU to hang on device reset since v9fs_reset()=

> wants to drain all pending I/O.
>=20
> This insane behavior is likely to denote a bug in the client, and it wo=
uld
> deserve an Rerror message to be sent back. Unfortunately, the protocol
> allows it and requires all flush requests to suceed (only a Tflush resp=
onse

s/suceed/succeed/

> is expected).
>=20
> The only option is to detect when we have to handle a self-referencing
> flush request and report success to the client right away.
>=20
> [*] http://man.cat-v.org/plan_9/5/flush
>=20
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vv2K1SmI9RLeW7Hi1TAS9D6CrmUd1gBI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0TJOAAoJEKeha0olJ0Nq4S0H/1/y1w1WYS5eTtmNzlq41ou9
xtnesHFGjq2MNIDQiAAfJl+Um4tQuViaUR2K2xmdc6HZZ1yBJSvsStQZztTrWFrA
WJ9Ygc2RjStAML9in8P/7n2MlvPRIUannU4a5msTXA3WHttIFrdBhHv0zzdsquhC
5WRgAGLpA/JHTZniKbxt4AGl24nGo+7PlT9l/XEUf5V3L4UApk1bVWC9I1mRypsZ
Lh5TGtaQfhGIXv8AJSh+dY5055tFj87h3S0lOwfYE+8FL4kW/GeoTdmeZ3Ujtwbk
dtFu3zpEOuavAONK4ndPPir8LnT9jQJLt9+nz2bhbR7XOMiSs1jaBXt8+7tDEqM=
=bmE5
-----END PGP SIGNATURE-----

--vv2K1SmI9RLeW7Hi1TAS9D6CrmUd1gBI9--
