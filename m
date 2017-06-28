Received: from eggs.gnu.org ([2001:4830:134:3::10]:58638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQA77-00072Y-72
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQA76-0008J3-Eu
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:22:25 -0400
Date: Wed, 28 Jun 2017 12:22:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628102213.GB5378@noname.redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
	<1498234919-27316-12-git-send-email-kwolf@redhat.com>
	<4c7f09a2-04b4-25b0-b9c7-cbdb5dc3c795@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c7f09a2-04b4-25b0-b9c7-cbdb5dc3c795@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 11/61] virtio-pci: use
 ioeventfd even when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

Am 28.06.2017 um 12:11 hat QingFeng Hao geschrieben:
> =E5=9C=A8 2017/6/24 0:21, Kevin Wolf =E5=86=99=E9=81=93:
> >From: Stefan Hajnoczi <stefanha@redhat.com>
> >
> >Old kvm.ko versions only supported a tiny number of ioeventfds so
> >virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> >
> >Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> >always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a=
6f
> >("memory: emulate ioeventfd") it has been possible to use ioeventfds i=
n
> >qtest or TCG mode.
> >
> >This patch makes -device virtio-blk-pci,iothread=3Diothread0 work even
> >when KVM is disabled.
> >
> >I have tested that virtio-blk-pci works under TCG both with and withou=
t
> >iothread.
> >
> >Cc: Michael S. Tsirkin <mst@redhat.com>
> >Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >---
> >  hw/virtio/virtio-pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >index 20d6a08..301920e 100644
> >--- a/hw/virtio/virtio-pci.c
> >+++ b/hw/virtio/virtio-pci.c
> >@@ -1740,7 +1740,7 @@ static void virtio_pci_realize(PCIDevice *pci_de=
v, Error **errp)
> >      bool pcie_port =3D pci_bus_is_express(pci_dev->bus) &&
> >                       !pci_bus_is_root(pci_dev->bus);
> >
> >-    if (!kvm_has_many_ioeventfds()) {
> >+    if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
> >          proxy->flags &=3D ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
> >      }
> This response is actually for mail thread "Re: [Qemu-devel] [PATCH
> 1/5] virtio-pci: use ioeventfd even when KVM is disabled"
> which I didn't receive, sorry.
> I also saw the failed case of 068 as Fam due to the same cause on
> s390x and x86.
> With this patch applied, no failure found. Further investigation
> shows that the error is in
> virtio_scsi_dataplane_setup:
>  if (!virtio_device_ioeventfd_enabled(vdev)) {
>             error_setg(errp, "ioeventfd is required for iothread");
>             return;
>  }
> call flow is:
> virtio_device_ioeventfd_enabled-->virtio_bus_ioeventfd_enabled
> -->k->ioeventfd_enabled-->virtio_pci_ioeventfd_enabled
> virtio_pci_ioeventfd_enabled checks flag
> VIRTIO_PCI_FLAG_USE_IOEVENTFD which was
> cleared in virtio_pci_realize if this patch isn't applied.

Yes, we know all of this. However, this patch is not correct and causes
'make check' failures on some platforms. The open question is where that
failure comes from. Before this is solved, the patch can't be applied.

Kevin
