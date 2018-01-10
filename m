Received: from eggs.gnu.org ([2001:4830:134:3::10]:47967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZJ1c-0005Zq-L5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZJ1X-00034Q-GM
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:14:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZJ1X-00031q-8i
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:14:43 -0500
Date: Wed, 10 Jan 2018 16:14:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110161438.GA28096@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Subject: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com
Cc: qemu-devel@nongnu.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wei,
I wanted to summarize the differences between the vhost-pci and
virtio-vhost-user approaches because previous discussions may have been
confusing.

vhost-pci defines a new virtio device type for each vhost device type
(net, scsi, blk).  It therefore requires a virtio device driver for each
device type inside the slave VM.

Adding a new device type requires:
1. Defining a new virtio device type in the VIRTIO specification.
3. Implementing a new QEMU device model.
2. Implementing a new virtio driver.

virtio-vhost-user is a single virtio device that acts as a vhost-user
protocol transport for any vhost device type.  It requires one virtio
driver inside the slave VM and device types are implemented using
existing vhost-user slave libraries (librte_vhost in DPDK and
libvhost-user in QEMU).

Adding a new device type to virtio-vhost-user involves:
1. Adding any new vhost-user protocol messages to the QEMU
   virtio-vhost-user device model.
2. Adding any new vhost-user protocol messages to the vhost-user slave
   library.
3. Implementing the new device slave.

The simplest case is when no new vhost-user protocol messages are
required for the new device.  Then all that's needed for
virtio-vhost-user is a device slave implementation (#3).  That slave
implementation will also work with AF_UNIX because the vhost-user slave
library hides the transport (AF_UNIX vs virtio-vhost-user).  Even
better, if another person has already implemented that device slave to
use with AF_UNIX then no new code is needed for virtio-vhost-user
support at all!

If you compare this to vhost-pci, it would be necessary to design a new
virtio device, implement it in QEMU, and implement the virtio driver.
Much of virtio driver is more or less the same thing as the vhost-user
device slave but it cannot be reused because the vhost-user protocol
isn't being used by the virtio device.  The result is a lot of
duplication in DPDK and other codebases that implement vhost-user
slaves.

The way that vhost-pci is designed means that anyone wishing to support
a new device type has to become a virtio device designer.  They need to
map vhost-user protocol concepts to a new virtio device type.  This will
be time-consuming for everyone involved (e.g. the developer, the VIRTIO
community, etc).

The virtio-vhost-user approach stays at the vhost-user protocol level as
much as possible.  This way there are fewer concepts that need to be
mapped by people adding new device types.  As a result, it will allow
virtio-vhost-user to keep up with AF_UNIX vhost-user and grow because
it's easier to work with.

What do you think?

Stefan

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVjvuAAoJEJykq7OBq3PI4QoIAId5xdT5YLAtdFG8FPO34l/v
fODiM9GWt9Vygx7PV099WMoFE4GICMeJBPTz88iBdtvtNdFJJbRy27JMBAdMOvEE
H1lqZAXZW/+v50AV45jY5FlZhYeUQA5+PNPWk5GGTbhYB6gkY3961mmbly0A/zb4
gKy5IZN61+RKQSs/uQ9nXcby/VBS34sAbCB3X91Lb4lQWU5QPUzgVZT563hc2Xln
bRsSp92kiYEQ6qTAiKYfM7KT7UlyVs90V41BVAicj3BcQT27zSdZuw4gh08cxOX9
Jah+uAhjWFMe6wkSxM4egqD2L+bUOeP6piKdKxnJaF6gH7caGAU9Kgk6q+D0oNs=
=QGca
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
