Received: from eggs.gnu.org ([2001:4830:134:3::10]:46979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edwVY-0002ju-40
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edwVU-0004L3-3m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:12:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edwVT-0004Kb-Qs
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:12:48 -0500
Date: Tue, 23 Jan 2018 11:12:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180123111238.GC6565@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <5A65C652.6080307@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2018 at 07:09:06PM +0800, Wei Wang wrote:
> On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
> Thanks for the quick implementation. Not sure if the following issues could
> be solved with this approach:
>  - After we boot the slave VM, if we don't run the virtio-vhost-user driver
> (i.e. testpmd), then the master VM couldn't boot, because the booting of the
> virtio-net device relies on a negotiation with the virtio-vhost-user driver.

This is a limitation of QEMU's vhost-user master implementation which
also affects AF_UNIX.  It cannot be solved by this patch series since
this is the slave side.

Here is what I suggest.  Introduce a new VIRTIO feature bit:

  #define VIRTIO_F_DEVICE_READY 34

When the device supports this bit we extend the device initialization
procedure.  If the device is not yet ready, the FEATURES_OK status bit
is not accepted by the device.  Device initialization fails temporarily
but the device may raise the configuration change interrupt to indicate
that device initialization should be retried.

Using a feature bit guarantees that existing device and driver behavior
remains unchanged.

On the QEMU side the changes are:

1. Virtio hardware registers and configuration space are available even
   when vhost-user is disconnected.  This shouldn't be difficult to
   implement because QEMU always has a virtio device model for each
   vhost-user device.  We just need to put dummy values in the
   registers/configuration space until vhost-user has connected.

2. When vhost-user connects, raise the configuration change interrupt
   and allow vhost-user to process.

On the guest side the changes are:

1. virtio_pci.ko must set VIRTIO_F_DEVICE_READY and handle !FEATURES_OK
   by waiting for the configuration change interrupt and retrying.

This doesn't fully solve the problem because it assumes that a connected
slave always responds to VIRTIO hardware register accesses (e.g. get/set
features).  If the slave crashes but leaves the virtio-vhost-user PCI
adapter connected then vhost-user requests from the master go
unanswered and cause hangs...

>  - Suppose in the future there is also a kernel virtio-vhost-user driver as
> other PCI devices, can we unbind the kernel driver first, and then bind the
> device to the dpdk driver? A normal PCI device should be able to smoothly
> switch between the kernel driver and dpdk driver.

It depends what you mean by "smoothly switch".

If you mean whether it's possible to go from a kernel driver to
vfio-pci, then the answer is yes.

But if the kernel driver has an established vhost-user connection then
it will be closed.  This is the same as reconnecting with AF_UNIX
vhost-user.

Stefan

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZximAAoJEJykq7OBq3PIZ1gIAI0XuuDvGhIvdRLHwfhkDukT
gvsb0igp42I7GA4CeY+/iXRE0wqWeKW6HKlxFbShretZCuUL4JzcH6N88BxjSoon
P20ISJCAC1y2CmODTZodTBAM/pEEHpMaXKUt1KlMOOcra8PALNZzOSFKGm117OvJ
c43yMrZhokl2NXobR2i05eBWbBxjf5S+1K07vhPundsGf9YRy0c7AtWEJ8gYU/mq
SrJPKmh6XhOtsjKAyo25anHiJHUs1DBfU4cWffwGcpmvIgk9aV/wyPHzRYS4xUu/
7DQdp41Xt3fbzsXmFIqlzARijxAWIyjyAPVplTW3jEFu3wpla53pLNtvM6Dp4Qs=
=bhZM
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
