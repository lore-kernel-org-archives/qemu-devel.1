Received: from eggs.gnu.org ([2001:4830:134:3::10]:55581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g04Oe-0005YJ-Pv
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1g04Ob-000798-J8
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1g04Ob-00077b-AJ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:37:25 -0400
Date: Wed, 12 Sep 2018 08:37:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180912082250-mutt-send-email-mst@kernel.org>
References: <905c68e0-531a-d915-4033-474bda42a643@gliwa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905c68e0-531a-d915-4033-474bda42a643@gliwa.com>
Subject: Re: [Qemu-devel] virtio-net sporadic error with QNX 7.0 guest:
 virtio-net ctrl missing headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio <claudio.fontana@gliwa.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Wed, Sep 12, 2018 at 10:01:34AM +0200, Claudio wrote:
> Hello Michael, Jason and all,
> 
> I am currently using latest mainline QEMU on x86_64 to run a QNX 7 guest.
> 
> QNX 7 is not free software anymore unfortunately, with the
> the last open source versions in the 6.x range.
> 
> I am using the official virtio-net guest driver from QNX 7.
> 
> During initialization I sporadically get this error message:
> 
> $ qemu-system-x86_64 -machine pc,accel=kvm,kernel_irqchip=on -smp 2 -m 2048 -display none -nodefconfig -nodefaults -chardev stdio,mux=on,id=char0 -serial chardev:char0 -monitor none -mon chardev=char0,mode=readline -netdev user,id=user0,hostfwd=udp::9004-:9004 -device virtio-net,netdev=user0 qnx.img
> 
> virtio-net ctrl missing headers

This means a control buffer is sent either without the input element
or without an output element, or with a single byte output element.

> and following that my host->guest UDP port forwarding does not work, that is,
> the qemu process shows up as listening on the interface, but no packets appear in the guest.
> 
> This error during initialization does not appear every time I launch QEMU.
> It appears to be more or less random.
> 
> Whenever the error does not appear, the interface works as expected, and port forwarding works.
> 
> Latest commit is 
> 
> 19b599f7664b ("Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2'")
> 
> Thanks a lot for any advice!
> 
> Ciao,
> 
> Claudio

If it's easy to reproduce, you can try printing out all commands.
E.g.:

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f154756e85..34251273a9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -987,6 +987,10 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         if (!elem) {
             break;
         }
+        fprintf(stderr, "%s: in %d/%d, out %d/%d\n",
+                elem->in_num, iov_size(elem->in_sg, elem->in_num),
+                elem->out_num, iov_size(elem->out_sg, elem->out_num));
+
         if (iov_size(elem->in_sg, elem->in_num) < sizeof(status) ||
             iov_size(elem->out_sg, elem->out_num) < sizeof(ctrl)) {
             virtio_error(vdev, "virtio-net ctrl missing headers");
@@ -1014,6 +1018,9 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
             status = virtio_net_handle_offloads(n, ctrl.cmd, iov, iov_cnt);
         }
+        fprintf(stderr, "%s: class 0x%x cmd 0x%x cnt %d status 0x%x\n",
+                ctrl.class, ctrl.cmd, iov_cnt, status);
+
 
         s = iov_from_buf(elem->in_sg, elem->in_num, 0, &status, sizeof(status));
         assert(s == sizeof(status));


You can also try replacing virtio_error with fprintf - that will
avoid wedging the device on an error and let you proceed
with debugging.

-- 
MST
