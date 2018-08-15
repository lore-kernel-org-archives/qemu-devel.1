Received: from eggs.gnu.org ([2001:4830:134:3::10]:57269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQF-0001L6-FB
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQA-0006tW-86
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:52026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqQ9-0006r9-Ps
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqQ8-0006Ze-Tq
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BBA262E851D
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:34:56 -0000
From: Thomas Huth <1784900@bugs.launchpad.net>
Reply-To: Bug 1784900 <1784900@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153314156256.17371.7866837258800403867.malonedeb@soybean.canonical.com>
Message-Id: <153431849675.7864.146458114736830124.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1784900] Re: QEMU (frontend) crashes upon warm
 reboot with virtio-gpu device and vga=775 on Linux cmdline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been added here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D93f874fe9dbe0b997b5a94

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1784900

Title:
  QEMU (frontend) crashes upon warm reboot with virtio-gpu device and
  vga=3D775 on Linux cmdline

Status in QEMU:
  Fix Released

Bug description:
  With vga=3D775 on the Linux command line a first boot of the VM running
  Linux works fine. After a warm reboot it crashes during Linux boot.
  The VM was used remotely via virt-manager and VNC.

  Bisecting the code lead to the following patch that introduced the
  bug:

  commit 1fccd7c5a9a722a9cbf1bc91693f4618034f01ac (HEAD, refs/bisect/bad)
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Mon Jul 2 18:24:43 2018 +0200

      virtio-gpu: disable scanout when backing resource is destroyed

      Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
      Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
      Message-id: 20180702162443.16796-4-kraxel@redhat.com

  diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
  index 336dc59007..08cd567218 100644
  --- a/hw/display/virtio-gpu.c
  +++ b/hw/display/virtio-gpu.c
  @@ -430,6 +430,16 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g,=
 int scanout_id)
   static void virtio_gpu_resource_destroy(VirtIOGPU *g,
                                           struct virtio_gpu_simple_resourc=
e *res)
   {
  +    int i;
  +
  +    if (res->scanout_bitmask) {
  +        for (i =3D 0; i < g->conf.max_outputs; i++) {
  +            if (res->scanout_bitmask & (1 << i)) {
  +                virtio_gpu_disable_scanout(g, i);
  +            }
  +        }
  +    }
  +
       pixman_image_unref(res->image);
       virtio_gpu_cleanup_mapping(res);
       QTAILQ_REMOVE(&g->reslist, res, next);

  =

  Reported backtraces can be found here:  https://paste.fedoraproject.org/p=
aste/OUDEfCk1IY7xiy0I0PDlkw

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1784900/+subscriptions
