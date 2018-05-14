Received: from eggs.gnu.org ([2001:4830:134:3::10]:46400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fI6Ub-0008IQ-CY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fI3xX-0005Bl-IL
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:15:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:44774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fI3xX-0005AF-CI
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:15:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fI3xW-0007IQ-C0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:15:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 54FE02E8071
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 03:15:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 May 2018 03:00:44 -0000
From: eric hoffman <1771042@bugs.launchpad.net>
Reply-To: Bug 1771042 <1771042@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152625681679.27592.11833589256802380892.malonedeb@wampee.canonical.com>
Message-Id: <152626684503.26828.16869042301439556281.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1771042] Re: dataplane interrupt handler doesn't
 support msi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-bl=
k.c
index 101f32c..31d9eb8 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -73,7 +73,7 @@ static void notify_guest_bh(void *opaque)
             unsigned i =3D j + ctzl(bits);
             VirtQueue *vq =3D virtio_get_queue(s->vdev, i);

-            virtio_notify_irqfd(s->vdev, vq);
+            virtio_notify(s->vdev, vq);

             bits &=3D bits - 1; /* clear right-most bit */
         }

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1771042

Title:
  dataplane interrupt handler doesn't support msi

Status in QEMU:
  New

Bug description:
  hw/block/dataplane/virtio-blk.c commit
  1010cadf62332017648abee0d7a3dc7f2eef9632

  in the function notify_guest_bh, the function virtio_notify_irqfd is call=
ed
  to deliver the interrupt corresponding to the vq

  however, without the dataplane, hw/block/virtio_blk_req_complete calls
  virtio_notify to deliver the interrupt (immediately). this goes though
  a slightly more involved path that calls virtio_pci_notify which includes
  a case to handle msi interrupts.

  so, msi interrupts with block devices aren't serviced when using dataplane
  batching.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1771042/+subscriptions
