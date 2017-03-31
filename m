Received: from eggs.gnu.org ([2001:4830:134:3::10]:55217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cttsh-0001y9-6Y
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cttse-0004Pj-1m
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cttsd-0004OF-Ph
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:34:07 -0400
References: <20170331044711.21749-1-aik@ozlabs.ru>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c436e7e1-83be-e30f-5ce9-aa3b993d6be2@redhat.com>
Date: Fri, 31 Mar 2017 12:33:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170331044711.21749-1-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XTUR26Uen7UkshC5klaqV6h9wVEluGbeU"
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Only unmap
 bus_master_enabled_region if was added previously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XTUR26Uen7UkshC5klaqV6h9wVEluGbeU
From: Max Reitz <mreitz@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c436e7e1-83be-e30f-5ce9-aa3b993d6be2@redhat.com>
Subject: Re: [PATCH qemu] pci: Only unmap bus_master_enabled_region if was
 added previously
References: <20170331044711.21749-1-aik@ozlabs.ru>
In-Reply-To: <20170331044711.21749-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 06:47, Alexey Kardashevskiy wrote:
> Normally pci_init_bus_master() would be called either via
> bus->machine_done.notify or directly from do_pci_register_device().
>=20
> However if a device's realize() failed, pci_init_bus_master() is not
> called, and do_pci_unregister_device() fails on
> memory_region_del_subregion() as it was not mapped.
>=20
> This adds a check that subregion was mapped before unmapping it.
>=20
> Fixes: c53598ed18e4 ("pci: Add missing drop of bus master AS reference"=
)
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> This is to pass iotest 051 which does run QEMU like this:
>=20
> ppc64-softmmu/qemu-system-ppc64 -nodefaults -machine accel=3Dqtest -nog=
raphic -monitor stdio -serial none -drive if=3Dvirtio
>=20
> which normally fails with:
>=20
> qemu-system-ppc64: -drive if=3Dvirtio: Device needs media, but drive is=
 empty
>=20
> or asserts (without this patch):
>=20
> qemu-system-ppc64: /home/aik/p/qemu-kvm/memory.c:2118: memory_region_de=
l_subregion: Assertion `subregion->container =3D=3D mr' failed.
> ---
>  hw/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bd8043c460..259483b1c0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -869,8 +869,10 @@ static void do_pci_unregister_device(PCIDevice *pc=
i_dev)
>      pci_dev->bus->devices[pci_dev->devfn] =3D NULL;
>      pci_config_free(pci_dev);
> =20
> -    memory_region_del_subregion(&pci_dev->bus_master_container_region,=

> -                                &pci_dev->bus_master_enable_region);
> +    if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) {=

> +        memory_region_del_subregion(&pci_dev->bus_master_container_reg=
ion,
> +                                    &pci_dev->bus_master_enable_region=
);
> +    }
>      address_space_destroy(&pci_dev->bus_master_as);
>  }

I'm not sure whether it's generally assumed to be safe to call
memory_region_is_mapped() on "uninitialized" memory regions
(bus_master_enable_region is just completely zeroed out before
pci_init_bus_master(), as far as I can see and guess), but it certainly
works in practice, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--XTUR26Uen7UkshC5klaqV6h9wVEluGbeU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeMJQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5p8H/29iUT81dpJNSXSlj2zKp8pOqYcKutB+
ocRUhxHz/+1CUXAFyGSsklkw30DVOGWkPlwrvy0Ly7oUhnMsTWEll4kIFVDy7d8B
oCYFCKD3bu2A7UDdzCKTEvV2v3eFHXvBntdBZlx2c7iyTOjdbDQSBlW+EhGKq0qN
NoYyUJpVruskBJ+LXGbrlL7zkGYaH3rsESkaWpL/pH1Dvcf7UiuOMftKOhdeAiLu
g2BnB0qqzYjFwDqSOFxunshwmW5htXjWSGeZBcxH9AR+KVPTHvh7oHZY52SJWubn
Op1Iaq4KzgO/NAk6HKttLX5r4oLgcjrTx7/Nf20HpRzfb8eaYu4Mfuk=
=fBtq
-----END PGP SIGNATURE-----

--XTUR26Uen7UkshC5klaqV6h9wVEluGbeU--
