Received: from eggs.gnu.org ([2001:4830:134:3::10]:53815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fs3Xm-0000u1-R1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fs3Xg-0002wU-ER
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:05:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60320 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fs3Xg-0002ug-6X
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD2CC804BCF4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:05:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 21 Aug 2018 12:05:30 +0200
Message-Id: <1534845930-14451-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Remove deprecated -balloon option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>

The "-balloon" option has been replaced by "-device virtio-balloon".
It's been marked as deprecated since two releases, and nobody
complained, so let's remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/virtio-balloon-stats.txt |  6 +++---
 qemu-deprecated.texi          |  5 -----
 qemu-options.hx               | 10 ----------
 vl.c                          | 36 ------------------------------------
 4 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/docs/virtio-balloon-stats.txt b/docs/virtio-balloon-stats.txt
index 9985e1d..1732cc8 100644
--- a/docs/virtio-balloon-stats.txt
+++ b/docs/virtio-balloon-stats.txt
@@ -61,9 +61,9 @@ It's also important to note the following:
    respond to the request the timer will never be re-armed, which has
    the same effect as disabling polling
 
-Here are a few examples. QEMU is started with '-balloon virtio', which
-generates '/machine/peripheral-anon/device[1]' as the QOM path for the
-balloon device.
+Here are a few examples. QEMU is started with '-device virtio-balloon',
+which generates '/machine/peripheral-anon/device[1]' as the QOM path for
+the balloon device.
 
 Enable polling with 2 seconds interval:
 
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 67b7211..0714017 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -106,11 +106,6 @@ enabled via the ``-machine usb=on'' argument.
 
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
 
-@subsection -balloon (since 2.12.0)
-
-The @option{--balloon virtio} argument has been superseded by
-@option{--device virtio-balloon}.
-
 @subsection -fsdev handle (since 2.12.0)
 
 The ``handle'' fsdev backend does not support symlinks and causes the 9p
diff --git a/qemu-options.hx b/qemu-options.hx
index 4efdedf..47c6b92 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -454,16 +454,6 @@ modprobe i810_audio clocking=48000
 @end example
 ETEXI
 
-DEF("balloon", HAS_ARG, QEMU_OPTION_balloon,
-    "-balloon virtio[,addr=str]\n"
-    "                enable virtio balloon device (deprecated)\n", QEMU_ARCH_ALL)
-STEXI
-@item -balloon virtio[,addr=@var{addr}]
-@findex -balloon
-Enable virtio balloon device, optionally with PCI address @var{addr}. This
-option is deprecated, use @option{-device virtio-balloon} instead.
-ETEXI
-
 DEF("device", HAS_ARG, QEMU_OPTION_device,
     "-device driver[,prop[=value][,...]]\n"
     "                add device (based on driver)\n"
diff --git a/vl.c b/vl.c
index 16b913f..f952f01 100644
--- a/vl.c
+++ b/vl.c
@@ -2127,36 +2127,6 @@ static void parse_display(const char *p)
     }
 }
 
-static int balloon_parse(const char *arg)
-{
-    QemuOpts *opts;
-
-    warn_report("This option is deprecated. "
-                "Use '--device virtio-balloon' to enable the balloon device.");
-
-    if (strcmp(arg, "none") == 0) {
-        return 0;
-    }
-
-    if (!strncmp(arg, "virtio", 6)) {
-        if (arg[6] == ',') {
-            /* have params -> parse them */
-            opts = qemu_opts_parse_noisily(qemu_find_opts("device"), arg + 7,
-                                           false);
-            if (!opts)
-                return  -1;
-        } else {
-            /* create empty opts */
-            opts = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
-                                    &error_abort);
-        }
-        qemu_opt_set(opts, "driver", "virtio-balloon", &error_abort);
-        return 0;
-    }
-
-    return -1;
-}
-
 char *qemu_find_file(int type, const char *name)
 {
     int i;
@@ -3659,12 +3629,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_no_hpet:
                 no_hpet = 1;
                 break;
-            case QEMU_OPTION_balloon:
-                if (balloon_parse(optarg) < 0) {
-                    error_report("unknown -balloon argument %s", optarg);
-                    exit(1);
-                }
-                break;
             case QEMU_OPTION_no_reboot:
                 no_reboot = 1;
                 break;
-- 
1.8.3.1
