Received: from eggs.gnu.org ([2001:4830:134:3::10]:53916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgA0R-0002x9-CA
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgA0O-0005VM-9F
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:57:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgA0O-0005VC-37
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:57:20 -0500
Message-ID: <1487681835.2694.76.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 13:57:15 +0100
In-Reply-To: <1487361200-29966-13-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 12/23] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fr, 2017-02-17 at 21:54 +0200, Michael S. Tsirkin wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> The virtio-net change is necessary because it uses virtqueue_fill
> and virtqueue_flush instead of the more convenient virtqueue_push.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This change breaks ovmf for me, although it isn't obvious to me why.
Bisect landed here, and reverting indeed makes things going again.

Using q35 machine type, pcie virtio devices, with the rhel ovmf build
(OVMF-20160608b-1.git988715a.el7.noarch).

First thing I've tried is swapping virtio-net for another nic,
suspecting this change might trigger a bug in the ovmf virtio-net
driver, but that didn't change things.

Effect is that qemu just exits, without logging some error, looks like a
normal guest shutdown.  Firmware log doesn't give a clue either, it just
stops at some point, again without any error message.  Here are the last
lines of the log:

SataControllerStart START
SataControllerStart error return status =3D Already started
SetPciIntLine: [00:1C.0] PciRoot(0x0)/Pci(0x1C,0x0) -> 0x0A
SetPciIntLine: [01:00.0] PciRoot(0x0)/Pci(0x1C,0x0)/Pci(0x0,0x0) -> 0x0A
SetPciIntLine: [00:1C.1] PciRoot(0x0)/Pci(0x1C,0x1) -> 0x0A
SetPciIntLine: [02:00.0] PciRoot(0x0)/Pci(0x1C,0x1)/Pci(0x0,0x0) -> 0x0A
SetPciIntLine: [00:1C.2] PciRoot(0x0)/Pci(0x1C,0x2) -> 0x0A
SetPciIntLine: [00:1C.3] PciRoot(0x0)/Pci(0x1C,0x3) -> 0x0A
SetPciIntLine: [00:1C.4] PciRoot(0x0)/Pci(0x1C,0x4) -> 0x0A
SetPciIntLine: [05:00.0] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x0) -> 0x0A
SetPciIntLine: [05:00.1] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x1) -> 0x0A
SetPciIntLine: [05:00.2] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x2) -> 0x0A
SetPciIntLine: [00:1C.5] PciRoot(0x0)/Pci(0x1C,0x5) -> 0x0A
SetPciIntLine: [06:00.0] PciRoot(0x0)/Pci(0x1C,0x5)/Pci(0x0,0x0) -> 0x0A
SetPciIntLine: [00:1C.6] PciRoot(0x0)/Pci(0x1C,0x6) -> 0x0A
SetPciIntLine: [00:1C.7] PciRoot(0x0)/Pci(0x1C,0x7) -> 0x0A
SetPciIntLine: [00:1F.2] PciRoot(0x0)/Pci(0x1F,0x2) -> 0x0A
SetPciIntLine: [00:1F.3] PciRoot(0x0)/Pci(0x1F,0x3) -> 0x0A
Select Item: 0x8
Select Item: 0x17
qemu -kernel was not used.

cheers,
  Gerd
