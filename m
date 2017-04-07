Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwcKE-0002qV-RU
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cwcKC-00069G-6c
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:57458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cwcKB-00068x-Ri
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 18:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cwcKA-0007dk-2j
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 22:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 70E312E80C1
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 22:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Apr 2017 22:17:41 -0000
From: Gerd Hoffmann <1635339@bugs.launchpad.net>
Reply-To: Bug 1635339 <1635339@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161020160532.23339.63373.malonedeb@soybean.canonical.com>
Message-Id: <20170407221741.12230.11302.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1635339] Re: qxl_pre_save assertion failure on vm
 "save"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not sure we want a failure mode for pre_save().

If we go for option (a) (from comment 9), I'd add a check when reading
the commands from the ring, not at migration time, so we don't run enter
a state where pre_save() can fail in the first place.  Because that will
break the windows drivers we might add a warning only for 2.9, then for
2.10 raise an error irq.  Something like this:

--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -639,6 +639,24 @@ static int interface_get_command(QXLInstance *sin, str=
uct QXLCommandExt *ext)
         qxl->guest_primary.commands++;
         qxl_track_command(qxl, ext);
         qxl_log_command(qxl, "cmd", ext);
+        {
+            void *msg =3D qxl_phys2virt(qxl, ext->cmd.data, ext->group_id);
+            if (msg < (void *)qxl->vga.vram_ptr ||
+                msg > ((void *)qxl->vga.vram_ptr + qxl->vga.vram_size)) {
+#if 1
+                /* temporary, for 2.9 */
+                static int once;
+                if (!once) {
+                    fprintf(stderr, "qxl: guest bug: command not in ram ba=
r, "
+                            "guest not migratable\n");
+                    once =3D true;
+                }
+#else
+                qxl_set_guest_bug(qxl, "command not in ram bar");
+                return false;
+#endif
+            }
+        }
         trace_qxl_ring_command_get(qxl->id, qxl_mode_to_string(qxl->mode));
         return true;
     default:

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1635339

Title:
  qxl_pre_save assertion failure on vm "save"

Status in QEMU:
  Confirmed

Bug description:
  When I try and save my Windows 10 VM, I see an assertion failure, and
  the machine is shut down.

  I see the following in the log:

  main_channel_handle_parsed: agent start
  qemu-system-x86_64: /build/qemu-Zwynhi/qemu-2.5+dfsg/hw/display/qxl.c:210=
1: qxl_pre_save: Assertion `d->last_release_offset < d->vga.vram_size' fail=
ed.
  2016-10-20 11:52:42.713+0000: shutting down

  Please let me know what other information would be relevant!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1635339/+subscriptions
