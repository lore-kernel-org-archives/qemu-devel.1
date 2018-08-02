Received: from eggs.gnu.org ([2001:4830:134:3::10]:37850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fl1Ca-0005DH-Jx
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 20:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fl1CX-0006oU-EG
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 20:10:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:58586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fl1CX-0006nF-6P
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 20:10:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fl1CV-00005i-Uu
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 00:10:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E5E582E8042
	for <qemu-devel@nongnu.org>; Thu,  2 Aug 2018 00:10:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Aug 2018 00:03:04 -0000
From: Stefan Berger <1784900@bugs.launchpad.net>
Reply-To: Bug 1784900 <1784900@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153314156256.17371.7866837258800403867.malonedeb@soybean.canonical.com>
Message-Id: <153316818472.18210.7680271968873338296.malone@soybean.canonical.com>
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

The reason for this bug is memory corruption in glibc's memory chunk
header that is in front of some bitmap pixman is allocating and
maintaining as image->bits.free_me. I set a memory watchpoint to this
memory location and this code here triggered it and corrupted what seems
to be a memory chunk size indicator, which upon free() causes print of
'invalid pointer' by glibc:

Thread 1 "qemu-system-x86" hit Hardware watchpoint 2: *0x7f6160361d88

Old value =3D 3145749
New value =3D 0
vga_draw_line8 (vga=3Dvga@entry=3D0x556d68549b30, d=3D0x7f6160361d80 "", d@=
entry=3D0x7f61603615e0 "", addr=3D983528, width=3D<optimized out>)
    at /home/stefanb/tmp/qemu-tip/hw/display/vga-helpers.h:297
297	        ((uint32_t *)d)[3] =3D palette[vga_read_byte(vga, addr + 3)];


(gdb) bt
#0  vga_draw_line8 (vga=3Dvga@entry=3D0x556d68549b30, d=3D0x7f6160361d80 ""=
, d@entry=3D0x7f61603615e0 "", addr=3D983528, width=3D<optimized out>)
    at /home/stefanb/tmp/qemu-tip/hw/display/vga-helpers.h:297
#1  0x0000556d659918ee in vga_draw_graphic (full_update=3D0, s=3D0x556d6854=
9b30) at /home/stefanb/tmp/qemu-tip/hw/display/vga.c:1695
#2  vga_update_display (opaque=3D0x556d68549b30) at /home/stefanb/tmp/qemu-=
tip/hw/display/vga.c:1782
#3  0x0000556d65c0cd92 in vnc_refresh (dcl=3D0x556d683055a8) at ui/vnc.c:30=
46
#4  0x0000556d65bff702 in dpy_refresh (s=3D0x556d686be540) at ui/console.c:=
1658
#5  gui_update (opaque=3D0x556d686be540) at ui/console.c:205
#6  0x0000556d65d0deac in timerlist_run_timers (timer_list=3D0x556d66de0e00=
) at util/qemu-timer.c:536
#7  0x0000556d65d0e0f7 in qemu_clock_run_timers (type=3DQEMU_CLOCK_REALTIME=
) at util/qemu-timer.c:547
#8  qemu_clock_run_all_timers () at util/qemu-timer.c:674
#9  0x0000556d65d0e5d1 in main_loop_wait (nonblocking=3D<optimized out>) at=
 util/main-loop.c:503
#10 0x0000556d65a5f2ee in main_loop () at vl.c:1865
#11 0x0000556d658ff166 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:4643

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1784900

Title:
  QEMU (frontend) crashes upon warm reboot with virtio-gpu device and
  vga=3D775 on Linux cmdline

Status in QEMU:
  New

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
