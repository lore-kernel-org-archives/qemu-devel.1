Received: from eggs.gnu.org ([2001:4830:134:3::10]:36314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdFH-0008H6-0Y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFdFD-0000KO-0c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:15:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFdFC-0000KC-Qo
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:15:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id b84so23682978wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:15:14 -0700 (PDT)
Date: Tue, 30 May 2017 10:15:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530091511.GD11362@stefanha-x1.localdomain>
References: <20170526022438.17478-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20170526022438.17478-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] nvdimm: warn if the backend is not a
 DAX device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:24:37AM +0800, Haozhong Zhang wrote:
> Applications in Linux guest that use device-dax never trigger flush
> that can be trapped by KVM/QEMU. Meanwhile, if the host backend is not
> device-dax, QEMU cannot guarantee the persistence of guest writes.
> Before solving this flushing problem, QEMU should warn users if the
> host backend is not device-dax.
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Message-id: CAPcyv4hV2-ZW8SMCRtD0P_86KgR3DHOvNe+6T5SY2u7wXg3gEg@mail.gmai=
l.com
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  hw/mem/nvdimm.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index db896b0bb6..c7bb407f33 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "hw/mem/nvdimm.h"
> +#include "qemu/error-report.h"
> =20
>  static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *n=
ame,
>                                    void *opaque, Error **errp)
> @@ -78,12 +79,48 @@ static MemoryRegion *nvdimm_get_memory_region(PCDIMMD=
evice *dimm)
>      return &nvdimm->nvdimm_mr;
>  }
> =20
> +static void nvdimm_check_dax(HostMemoryBackend *hostmem)
> +{
> +    char *mem_path =3D
> +        object_property_get_str(OBJECT(hostmem), "mem-path", NULL);
> +    char *dev_name =3D NULL, *sysfs_path =3D NULL;
> +    bool is_dax =3D false;
> +
> +    if (!mem_path) {
> +        goto out;
> +    }
> +
> +    if (!g_str_has_prefix(mem_path, "/dev/dax")) {

Does not work with relative paths, symlinks, or device nodes in
non-standard locations.

A more accurate check is to fstat the file descriptor for the char
device major/minor number and verify that
/sys/dev/char/MAJ:MIN/device/devtype is "nd_dax".

> +        goto out;
> +    }
> +
> +    dev_name =3D mem_path + strlen("/dev/");
> +    sysfs_path =3D g_strdup_printf("/sys/class/dax/%s", dev_name);
> +    if (access(sysfs_path, F_OK)) {
> +        goto out;
> +    }
> +
> +    is_dax =3D true;

This check is Linux-specific, please use #ifdef __linux__.  It's okay to
always print an error on other operating systems.

> +
> + out:
> +    if (!is_dax) {
> +        error_report("warning: nvdimm backend %s is not DAX device, "

The check is not 100% accurate so:

s/is not/does not look like a/

> +                     "unable to guarantee persistence of guest writes",
> +                     mem_path ?: "RAM");
> +    }
> +
> +    g_free(sysfs_path);
> +    g_free(mem_path);
> +}
> +
>  static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
>  {
>      MemoryRegion *mr =3D host_memory_backend_get_memory(dimm->hostmem, e=
rrp);
>      NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
>      uint64_t align, pmem_size, size =3D memory_region_size(mr);
> =20
> +    nvdimm_check_dax(dimm->hostmem);
> +
>      align =3D memory_region_get_alignment(mr);
> =20
>      pmem_size =3D size - nvdimm->label_size;
> --=20
> 2.11.0
>=20

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLTgfAAoJEJykq7OBq3PIrZsIAKLWByw0Tpsefofi7dzqI3Dn
rcnTDUUUMSxM6PAVem9PEbnfhEQX5bZCqVA7eDRwW5bsCWewUhfHkMH0K/DRU8SF
/P0kN+4+sW/PFn+SOQ1bFpo1EZZwpJYZ/f2/8rIHQBXPY3s5wOO22R/OQEgbDGLe
WSY+Wb16wqu+D5wPog8LcL+A9b8W9WZAxKuCunW3j8tPm16GlKTLSFg1Bu7wwT1A
bcSrQqqQ6owGhRe/NoBAGB2nsDXTddKaabUi8Qk/nppdxItcJzCmGKeRJDTK0cuM
cd7LhHJyx8RWLdE7iKzY3BUKe83nevO0OKsc7YDlwmHCBWi51s0d+cjTeww3sM0=
=M4JA
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
