Received: from eggs.gnu.org ([2001:4830:134:3::10]:58410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSXUC-0003MT-EJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSXUA-00045N-WC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:48:36 -0400
Date: Tue, 12 Jun 2018 10:28:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612002809.GL2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 03/11] pc: factor out pc-dimm checks
 into pc_dimm_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:47PM +0200, David Hildenbrand wrote:
> We can perform these checks before the device is actually realized.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f3befe6721..85c040482e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1674,6 +1674,29 @@ void ioapic_init_gsi(GSIState *gsi_state, const ch=
ar *parent_name)
>      }
>  }
> =20
> +static void pc_dimm_pre_plug(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
> +                             Error **errp)
> +{
> +    const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
> +
> +    /*
> +     * When -no-acpi is used with Q35 machine type, no ACPI is built,
> +     * but pcms->acpi_dev is still created. Check !acpi_enabled in
> +     * addition to cover this case.
> +     */
> +    if (!pcms->acpi_dev || !acpi_enabled) {
> +        error_setg(errp,
> +                   "memory hotplug is not enabled: missing acpi device o=
r acpi disabled");
> +        return;
> +    }
> +
> +    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> +        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
> +        return;
> +    }
> +}
> +
>  static void pc_dimm_plug(HotplugHandler *hotplug_dev,
>                           DeviceState *dev, Error **errp)
>  {
> @@ -1696,23 +1719,6 @@ static void pc_dimm_plug(HotplugHandler *hotplug_d=
ev,
>          align =3D memory_region_get_alignment(mr);
>      }
> =20
> -    /*
> -     * When -no-acpi is used with Q35 machine type, no ACPI is built,
> -     * but pcms->acpi_dev is still created. Check !acpi_enabled in
> -     * addition to cover this case.
> -     */
> -    if (!pcms->acpi_dev || !acpi_enabled) {
> -        error_setg(&local_err,
> -                   "memory hotplug is not enabled: missing acpi device o=
r acpi disabled");
> -        goto out;
> -    }
> -
> -    if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> -        error_setg(&local_err,
> -                   "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> -        goto out;
> -    }
> -
>      pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
>      if (local_err) {
>          goto out;
> @@ -2006,7 +2012,9 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug=
_dev,
>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        pc_dimm_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_pre_plug(hotplug_dev, dev, errp);
>      }
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfE5kACgkQbDjKyiDZ
s5KtoRAAvWLTN9B7VpsaS8PWgq3om4r35JLelHzo3SlPmLBsGIaMu3esP7Juev+q
8HQrd+ruJ/34kZnOWIp1Jbb5kkuW+0wUQRXp/2nzDicar6dsAyWGwvYEom81L9eF
8206xCdVDFbVJpzwUpQPcYy6FhhfXhi9PM/ZKzl3ddk/rvEUOHGBEnqQxW4uB299
305claDwxvVsqmGdMrJFInHzSsIm6KHzyJ/fN2t8fNheXo+oAHVhE0mlOZ1gCnF/
gQOAwx15Aj62xl3IdCpvpdkD4nLpSeze2IjHGJ88G95R3eJY6fo0t7WZnFbv0+fx
uXnXmgvTpcb7n9dXP5KbvWWIM8Ljl3ZXm67V7yahfhVes1I/7DpSkMbXYpimidHd
pBebQdv+Z9jyUUTALyUZF31LqULdjmC+sXzOE2OZ+wKTJSCeE6wh1Wd9J7nZ3mLk
poV/+1arwh5FaRTYTMntC8r9jEPb5DIcgM6ZYWLl8yW3ZSXlTImkN8UgtxfxY1GC
LdehC7DApKN8BMciklOvJcKOipKwfuu+nzWe0Q8uLdLQjL7Rah6v65KMXsilR+8b
2u71FrIXxKR7sp8LJz9glMnXxy7+9Ui9lNKL8HQpLiZa+vPCEMQpBP3R7wkv/gZW
CKUwZLZuYgeF/paK+rug2rnvJEPZAerfwdQ+Oj6dtF9T7XV/P3A=
=1p+m
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--
