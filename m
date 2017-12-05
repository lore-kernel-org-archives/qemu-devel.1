Received: from eggs.gnu.org ([2001:4830:134:3::10]:36096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMGIJ-0005zx-Vy
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMGIG-00037J-2I
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMGIF-00036r-P2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:42:03 -0500
Date: Tue, 5 Dec 2017 16:41:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205164154.GD6712@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
	<20171205145950.GF31150@stefanha-x1.localdomain>
	<20171205174833-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <20171205174833-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add
 vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 05:55:45PM +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 05, 2017 at 02:59:50PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
> > > Add the vhost-pci-net device emulation. The device uses bar 2 to expo=
se
> > > the remote VM's memory to the guest. The first 4KB of the the bar area
> > > stores the metadata which describes the remote memory and vring info.
> >=20
> > This device looks like the beginning of a new "vhost-pci" virtio device
> > type.  There are layering violations:
> >=20
> > 1. This has nothing to do with virtio-net or networking, it's purely
> >    vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?
> >=20
> > 2. VirtIODevice does not know about PCI.  It should work over virtio-ccw
> >    or virtio-mmio.  This patch talks about BARs inside a VirtIODevice so
> >    there is a problem here.
>=20
> I think the point is how memory is exposed to another guest.  This
> device exposes it as a pci bar. I don't think e.g. ccw can do this,
> it's all hypercall-based.

Yes, that's why the BAR issue needs to be discussed.

In terms of the patches, the clean way to do it is for the
vhost-pci device to have a memory region that is not called "BAR".  The
virtio-pci transport can expose it as a BAR but the device doesn't need
to know about it.  Other transports that support memory mapping could
then work with this device too.

The VIRTIO specification needs to capture this transport requirement
somehow too so it's clear that the vhost device can only run over
transports that support memory mapping.

That said, it's not clear to me why the vhost-pci device is a VIRTIO
device.  It doesn't use virtqueues or the configuration space.  It only
uses the vhost-user chardev and the mapped memory.  Isn't it better to
make it a PCI device?

Stefan

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsxRAAoJEJykq7OBq3PIIwEH/0iqAkapVKinvBtujwumJlD5
Ml9DOrjQC5RtLQjk3JdkQVGAzUpEPojsD2Om5wL4kvBlTjqFwxLpUpd+sjCt2C/u
VCOCe1//T+dBnCrz+SOXCRPrDgG2baCCrUFRjdMLVF4dlNglWVZMk7TIUozxcNeC
VUA9EjPpsV0NNXe9qpHuaUC5xYxStrwgCBa6tZETDeK1D8f3WxM672uKCo+Dulq2
E8sV0LkWG0llo+QrBlQ/LCDUt185P2quPfGOBpqk2boW9dd5WepkoRudnxcusGHT
M/cQL8m6WIBZ4MdB30xoAuQRY8UxjerNST67SmcwzKQcq19o0owlaAUt9XEVDw8=
=cizm
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
