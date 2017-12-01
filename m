Received: from eggs.gnu.org ([2001:4830:134:3::10]:53462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKoI4-00043V-R3
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKoI3-0002HB-Vm
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:35:52 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:45377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eKoI3-0002GU-Nm
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:35:51 -0500
Received: by mail-wr0-x22e.google.com with SMTP id h1so10704047wre.12
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 08:35:51 -0800 (PST)
Date: Fri, 1 Dec 2017 10:44:54 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201104454.GI23501@stefanha-x1.localdomain>
References: <20171127043517.22441-1-haozhong.zhang@intel.com>
	<20171127043517.22441-4-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline
In-Reply-To: <20171127043517.22441-4-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] nvdimm: add 'unarmed' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 12:35:17PM +0800, Haozhong Zhang wrote:
> @@ -312,6 +315,10 @@ nvdimm_build_structure_memdev(GArray *structures, De=
viceState *dev)
> =20
>      /* Only one interleave for PMEM. */
>      nfit_memdev->interleave_ways =3D cpu_to_le16(1);
> +
> +    if (nvdimm->unarmed) {
> +        nfit_memdev->flags |=3D ACPI_NFIT_MEM_NOT_ARMED;

Missing cpu_to_le16()?

> +static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
> +{
> +    NVDIMMDevice *nvdimm =3D NVDIMM(obj);
> +    Error *local_err =3D NULL;
> +
> +    if (memory_region_size(&nvdimm->nvdimm_mr)) {
> +        error_setg(&local_err, "cannot change property value");

This error message does not explain why the value cannot be changed.  I
guess this is checking if the device has been realized.

Please call qdev_prop_set_after_realize() instead:

  if (memory_region_size(&nvdimm->nvdimm_mr)) {
      qdev_prop_set_after_realize(DEVICE(obj), "unarmed", &local_err);
      goto out;
  }

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaITKmAAoJEJykq7OBq3PIu20IAKSbwaEPTHvGT8EsjBeUaUIA
6u+H07qNjoEVraD7L4hyDYe8760SKDRKE4Wpk0DG/ZnslWm1GN6TO2mQzqHFGteF
7O0LFWUNfX4EbUfWc66JaxYu0rOUvpBxQNDlA+ziz5KdjLRXRhdHmMMw6i471pRW
UXjkzCGHNFLCntie/l1Sh37wRdGwQ9hOKNYJLl5P4j1kfyG3XAA6Arh0GPoD9uVP
S5ov/898Zsw/n8HJ9p1MdBlY2bpX2WczYpnc3GICeEWFl9CFp8DO8NfETJqVmf9F
kKrEIcA2suxFVSIq3wCBdp+PJQKJrQ8bN5DbWSd1hbYlelI91oUS05kG6TcEMlU=
=me79
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--
