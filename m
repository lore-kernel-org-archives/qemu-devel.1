Received: from eggs.gnu.org ([2001:4830:134:3::10]:47423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVXGW-0000a9-1W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVXGQ-0002nG-V9
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:10:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:50872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fVXGQ-0002mz-Oe
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:10:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fVXGP-0007U6-TB
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:10:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D319F2E8033
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:10:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Jun 2018 07:05:22 -0000
From: Qiang Wang <1777786@bugs.launchpad.net>
Reply-To: Bug 1777786 <1777786@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152947832268.7374.8550233006013647387.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777786] [NEW] virtio-gpu-3d.c: change
 virtio_gpu_fence_poll timer scale
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

We use virtio-gpu to accelerate Unigine Heaven Benchmark in VM. But we get =
only 5 FPS when we use AMD RX460 in our host.
We found that guest os spent a lot of time in waiting for the return of glM=
apBufferRange/glUnmapBuffer commad. We suspected the host GPU was waiting f=
or fence. So we finally change the timer of fence_poll. Afer change timer f=
rom
 ms to us=EF=BC=8C Benchmark result raise up to 22 FPS.

>From a4003af5c4fe92d55353f42767d0c45de95bb78f Mon Sep 17 00:00:00 2001
From: chen wei <chenwei1@ruijie.com.cn>
Date: Fri, 8 Jun 2018 17:34:45 +0800
Subject: [PATCH] virtio-gpu:improve 3d performance greatly

  opengl function need fence support.when CPU execute opengl function, it n=
eed wait fence for synchronize GPU.
so qemu must deal with fence timely as possible. but now the expire time of=
 the timer to deal with fence is 10 ms.
I think it is too long for opengl. So i will change it to 20 ns.
  Before change, when i play Unigine_Heaven 3d game with virglrenderer, the=
 fps is 3.  atfer change the fps up to 23.

Signed-off-by: chen wei   <chenwei1@ruijie.com.cn>
Signed-off-by: wang qiang <qiang_w@ruijie.com.cn>
---
 hw/display/virtio-gpu-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 3558f38..c0a5d21 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -582,7 +582,7 @@ static void virtio_gpu_fence_poll(void *opaque)
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
-        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1=
0);
+        timer_mod(g->fence_poll, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + 2=
0);
     }
 }
 =

@@ -629,7 +629,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         return ret;
     }
 =

-    g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
+    g->fence_poll =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
                                  virtio_gpu_fence_poll, g);
 =

     if (virtio_gpu_stats_enabled(g->conf)) {
-- =

2.7.4

** Affects: qemu
     Importance: Undecided
         Status: New

** Patch added: "virtio-gpu-improve-3d-performance-greatly.patch"
   https://bugs.launchpad.net/bugs/1777786/+attachment/5154498/+files/virti=
o-gpu-improve-3d-performance-greatly.patch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777786

Title:
  virtio-gpu-3d.c: change virtio_gpu_fence_poll timer scale

Status in QEMU:
  New

Bug description:
  We use virtio-gpu to accelerate Unigine Heaven Benchmark in VM. But we ge=
t only 5 FPS when we use AMD RX460 in our host.
  We found that guest os spent a lot of time in waiting for the return of g=
lMapBufferRange/glUnmapBuffer commad. We suspected the host GPU was waiting=
 for fence. So we finally change the timer of fence_poll. Afer change timer=
 from
   ms to us=EF=BC=8C Benchmark result raise up to 22 FPS.

  From a4003af5c4fe92d55353f42767d0c45de95bb78f Mon Sep 17 00:00:00 2001
  From: chen wei <chenwei1@ruijie.com.cn>
  Date: Fri, 8 Jun 2018 17:34:45 +0800
  Subject: [PATCH] virtio-gpu:improve 3d performance greatly

    opengl function need fence support.when CPU execute opengl function, it=
 need wait fence for synchronize GPU.
  so qemu must deal with fence timely as possible. but now the expire time =
of the timer to deal with fence is 10 ms.
  I think it is too long for opengl. So i will change it to 20 ns.
    Before change, when i play Unigine_Heaven 3d game with virglrenderer, t=
he fps is 3.  atfer change the fps up to 23.

  Signed-off-by: chen wei   <chenwei1@ruijie.com.cn>
  Signed-off-by: wang qiang <qiang_w@ruijie.com.cn>
  ---
   hw/display/virtio-gpu-3d.c | 4 ++--
   1 file changed, 2 insertions(+), 2 deletions(-)

  diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
  index 3558f38..c0a5d21 100644
  --- a/hw/display/virtio-gpu-3d.c
  +++ b/hw/display/virtio-gpu-3d.c
  @@ -582,7 +582,7 @@ static void virtio_gpu_fence_poll(void *opaque)
       virgl_renderer_poll();
       virtio_gpu_process_cmdq(g);
       if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
  -        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +=
 10);
  +        timer_mod(g->fence_poll, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) +=
 20);
       }
   }
   =

  @@ -629,7 +629,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
           return ret;
       }
   =

  -    g->fence_poll =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
  +    g->fence_poll =3D timer_new_us(QEMU_CLOCK_VIRTUAL,
                                    virtio_gpu_fence_poll, g);
   =

       if (virtio_gpu_stats_enabled(g->conf)) {
  -- =

  2.7.4

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777786/+subscriptions
