Received: from eggs.gnu.org ([2001:4830:134:3::10]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elEaO-0003QH-Go
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elEaM-0007xj-NC
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:56:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1elEaM-0007wP-G0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:55:58 -0500
Date: Mon, 12 Feb 2018 13:55:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180212135540.GE4913@stefanha-x1.localdomain>
References: <20180207073331.14158-1-haozhong.zhang@intel.com>
	<20180207073331.14158-5-haozhong.zhang@intel.com>
	<20180209142740.GA3390@stefanha-x1.localdomain>
	<20180209145726.55ushghorccxne47@hz-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <20180209145726.55ushghorccxne47@hz-desktop>
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
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Dan Williams <dan.j.williams@intel.com>


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 10:57:26PM +0800, Haozhong Zhang wrote:
> On 02/09/18 14:27 +0000, Stefan Hajnoczi wrote:
> > On Wed, Feb 07, 2018 at 03:33:27PM +0800, Haozhong Zhang wrote:
> > > @@ -156,11 +157,17 @@ static void nvdimm_write_label_data(NVDIMMDevic=
e *nvdimm, const void *buf,
> > >  {
> > >      MemoryRegion *mr;
> > >      PCDIMMDevice *dimm =3D PC_DIMM(nvdimm);
> > > +    bool is_pmem =3D object_property_get_bool(OBJECT(dimm->hostmem),
> > > +                                            "pmem", NULL);
> > >      uint64_t backend_offset;
> > > =20
> > >      nvdimm_validate_rw_label_data(nvdimm, size, offset);
> > > =20
> > > -    memcpy(nvdimm->label_data + offset, buf, size);
> > > +    if (!is_pmem) {
> > > +        memcpy(nvdimm->label_data + offset, buf, size);
> > > +    } else {
> > > +        pmem_memcpy_persist(nvdimm->label_data + offset, buf, size);
> > > +    }
> >=20
> > Is this enough to prevent label corruption in case of power failure?
> >=20
> > pmem_memcpy_persist() is not atomic.  Power failure can result in a mix
> > of the old and new label data.
> >=20
> > If we want this operation to be 100% safe there needs to be some kind of
> > update protocol that makes the change atomic, like a Label A and Label B
> > area with a single Label Index field that can be updated atomically to
> > point to the active Label A/B area.
>=20
> All this patch series is to guarantee: if the guest is still alive and
> running, all its previous writes to pmem, which were performed by
> QEMU, will be still persistent on pmem.
>=20
> If a power failure happens before QEMU returns to the guest, e.g., in
> the middle of above pmem_memcpy_persist(), yes, the guest label data
> may be in an inconsistent state, but the guest also has no chance to
> progress.  And, that is what could happen in the non-virtualization
> environment as well, and it's the responsibility of the (guest) SW to
> defend such failures, e.g., by the protocol you mentioned.

Thanks for explaining!  I thought the atomic update is done by the ACPI
_LSW DSM method but it turns out the driver must do it.

For anyone else who is interested, a detailed description of the Label
Storage Area is on page 652 of the UEFI Specification version 2.7 and
the Linux driver implements the atomic update algorithm in
drivers/nvdimm/label.c:__pmem_label_update().

Stefan

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJagZzcAAoJEJykq7OBq3PINO8IAMJBzfE2W5r02M12e9yzDYnj
0C2Kw9FCQcbXBbXZnSHncZCY7ExiEwcN7YQDE8LbNo10yAd6McgFedcM85wyQfmX
x58EG21ttkvNisTQHcame4pWdSYJ3nQSQ5OBOG4HHiEVtfGkCkSZ02v0Lg78LhsB
bL/JH2jcWEQSNqLgW+hLbi6WSeFiUQx+NCOR7x4Il8KCpgL9W4b72tyZKK0Zh9iZ
beRsDvdPfVSeru2+18JIstpqpuCWaJfiE3fWyOPRkspJVICG/kC5kLy2OcyR4tIZ
2GBGyRtVmTWjGC8LJU8tbb7pGu+/8ZRGulYpqoo6tZOGsNjvqhVYY+YjCgVS1xg=
=E4uc
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--
