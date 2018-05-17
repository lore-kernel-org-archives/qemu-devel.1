Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fJKOn-0003o8-FX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fJKOh-0005iR-UM
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:00:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fJKOh-0005hy-Ps
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:00:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B43644201B08
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 15:00:50 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Thu, 17 May 2018 17:00:11 +0200
Message-Id: <cb05bb1909daa6ba62145c0194aafa05a14ed3d1.1526569138.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH] console: Avoid segfault in screendump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, kraxel@redhat.com

After f771c5440e04626f1 it is possible to select device and
head which to take screendump from. And even though we check if
provided head number falls within range, it may still happen that
the console has no surface yet leading to SIGSEGV:

  qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 \
    -qmp stdio \
    -device virtio-vga,id=video0,max_outputs=4

  {"execute":"qmp_capabilities"}
  {"execute":"screendump", "arguments":{"filename":"/tmp/screen.ppm", "device":"video0", "head":1}}
  Segmentation fault

 #0  0x00005628249dda88 in ppm_save (filename=0x56282826cbc0 "/tmp/screen.ppm", ds=0x0, errp=0x7fff52a6fae0) at ui/console.c:304
 #1  0x00005628249ddd9b in qmp_screendump (filename=0x56282826cbc0 "/tmp/screen.ppm", has_device=true, device=0x5628276902d0 "video0", has_head=true, head=1, errp=0x7fff52a6fae0) at ui/console.c:375
 #2  0x00005628247740df in qmp_marshal_screendump (args=0x562828265e00, ret=0x7fff52a6fb68, errp=0x7fff52a6fb60) at qapi/qapi-commands-ui.c:110

Here, @ds from frame #0 (or @surface from frame #1) is
dereferenced at the very beginning of ppm_save(). And because
it's NULL crash happens.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---

I'm not entirely sure if this is the right approach, but crasher is bad
for sure.

 ui/console.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 945f05d728..ef1247f872 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -372,6 +372,11 @@ void qmp_screendump(const char *filename, bool has_device, const char *device,
 
     graphic_hw_update(con);
     surface = qemu_console_surface(con);
+    if (!surface) {
+        error_setg(errp, "no surface");
+        return;
+    }
+
     ppm_save(filename, surface, errp);
 }
 
-- 
2.16.1
