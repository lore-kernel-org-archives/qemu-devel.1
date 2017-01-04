Received: from eggs.gnu.org ([2001:4830:134:3::10]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOp0g-0004KD-LY
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOp0c-0002yr-C4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:05:58 -0500
References: <20170104150525.4246-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfd6fda1-a6a1-8001-2e69-6890ab7948c5@redhat.com>
Date: Wed, 4 Jan 2017 11:05:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170104150525.4246-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Me86KTIEkUtse54tOFBp1K87beHEgv6PP"
Subject: Re: [Qemu-devel] [PATCH] pci-assign: avoid pointless stat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Me86KTIEkUtse54tOFBp1K87beHEgv6PP
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <dfd6fda1-a6a1-8001-2e69-6890ab7948c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pci-assign: avoid pointless stat
References: <20170104150525.4246-1-pbonzini@redhat.com>
In-Reply-To: <20170104150525.4246-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 09:05 AM, Paolo Bonzini wrote:
> Just check the errno value after fopen and follow it with fstat.
> This shuts up Coverity's complaint about TOC/TOU violation.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/pci-assign-load-rom.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/hw/i386/pci-assign-load-rom.c b/hw/i386/pci-assign-load-ro=
m.c
> index 0d8e4b2..fd59076 100644
> --- a/hw/i386/pci-assign-load-rom.c
> +++ b/hw/i386/pci-assign-load-rom.c
> @@ -39,19 +39,19 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev=
, struct Object *owner,
>               "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/rom",
>               domain, bus, slot, function);
> =20
> -    if (stat(rom_file, &st)) {
> -        if (errno !=3D ENOENT) {
> -            error_report("pci-assign: Invalid ROM.");
> -        }
> -        return NULL;
> -    }
> -
>      /* Write "1" to the ROM file to enable it */
>      fp =3D fopen(rom_file, "r+");
>      if (fp =3D=3D NULL) {
> -        error_report("pci-assign: Cannot open %s: %s", rom_file, strer=
ror(errno));
> +        if (errno !=3D ENOENT) {
> +            error_report("pci-assign: Cannot open %s: %s", rom_file, s=
trerror(errno));
> +        }
>          return NULL;
>      }
> +    if (fstat(fileno(fp), &st) =3D=3D -1) {
> +        error_report("pci-assign: Cannot stat %s: %s", rom_file, strer=
ror(errno));
> +        goto close_rom;

fstat() failure after fopen() success is quite unlikely, but I suppose
it is still possible in some weird situations.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Me86KTIEkUtse54tOFBp1K87beHEgv6PP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbStvAAoJEKeha0olJ0Nqo4gH/05gm6A7E/WWzU67pz5SpSPG
zw/KfNw9+FJvL1unQC7SUstF2/cdKF5RNdWodWRebFy2x8fycFhDuceLFxhbTwdR
cqqMBhxx5DNYGqTVVVB+x6fko8TO7OTWq4s+mm+UobpnnpG5A5eMNRM15kSh72ZV
l8QPn2AWBZ42xKncZe8cvn+IHRVi2RL0AdCa5uASorx75b+UJ1a2kNHtoX02J1lL
ssMGstEcsXVQYExLb5jri8CWeiij0emdC9mkb8xwgM+YOVi8O6woyFF0BH5ACZCL
5UERRYMmJRVoBQrzuLoSM2d2H6jB85tP2MWlCuwxPPCqjSX6iU9xjhcgOrZ44SY=
=bGeN
-----END PGP SIGNATURE-----

--Me86KTIEkUtse54tOFBp1K87beHEgv6PP--
