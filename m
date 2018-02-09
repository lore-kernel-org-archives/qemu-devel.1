Received: from eggs.gnu.org ([2001:4830:134:3::10]:55554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ek9ej-0000bP-SW
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ek9ef-0000RO-VX
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:28:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ek9ef-0000Qy-Pa
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:27:57 -0500
Date: Fri, 9 Feb 2018 14:27:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180209142740.GA3390@stefanha-x1.localdomain>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-5-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20180207073331.14158-5-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] mem/nvdimm: ensure write
 persistence to PMEM in label emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Dan Williams <dan.j.williams@intel.com>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 03:33:27PM +0800, Haozhong Zhang wrote:
> @@ -156,11 +157,17 @@ static void nvdimm_write_label_data(NVDIMMDevice *n=
vdimm, const void *buf,
>  {
>      MemoryRegion *mr;
>      PCDIMMDevice *dimm =3D PC_DIMM(nvdimm);
> +    bool is_pmem =3D object_property_get_bool(OBJECT(dimm->hostmem),
> +                                            "pmem", NULL);
>      uint64_t backend_offset;
> =20
>      nvdimm_validate_rw_label_data(nvdimm, size, offset);
> =20
> -    memcpy(nvdimm->label_data + offset, buf, size);
> +    if (!is_pmem) {
> +        memcpy(nvdimm->label_data + offset, buf, size);
> +    } else {
> +        pmem_memcpy_persist(nvdimm->label_data + offset, buf, size);
> +    }

Is this enough to prevent label corruption in case of power failure?

pmem_memcpy_persist() is not atomic.  Power failure can result in a mix
of the old and new label data.

If we want this operation to be 100% safe there needs to be some kind of
update protocol that makes the change atomic, like a Label A and Label B
area with a single Label Index field that can be updated atomically to
point to the active Label A/B area.

Stefan

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJafa/cAAoJEJykq7OBq3PIBa4IAJzWdlv7xgxBYTlBMG5nf4eQ
ude2SdXwj6hjeW3QkAjVTyvR+sjPAfJds72R5CZg0lAvVijQDuFWU2QMMkcWwBOA
ACG5WmrEpVE1yIll1T6JM603BeSM4WV8r3t7Dd+gHBO465IgkGhgomrJoXB69k45
fAu5wyHjIaq4IlftvfW9pRjFzg9dQcc3p4HEiDrsS4S+mvy2UG0oohrBWTmFdTsN
MDhzQMQ0I8fZ3Ny4h7HHTUcnYjS887CkujSDadnvJ4oyvESxKc0TNFePOfeA5qZT
T0QAPFSyDvjcdIBqjOTyFOizF1ECLNa2o3ML91sI2Fus065kXJZAZhCr71hNVmU=
=8Tta
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
