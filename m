Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1equRw-00044y-Qg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1equRt-00044y-MZ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:38:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1equRt-00044P-Gw
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 00:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2808EAEA6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:38:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 28 Feb 2018 06:38:23 +0100
Message-Id: <1519796303-13257-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] balloon: Fix documentation of the --balloon
 parameter and deprecate it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Michael S Tsirkin <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

There are two issues with the documentation of the --balloon parameter:
First, "--balloon none" is simply doing nothing. Even if a machine had a
balloon device by default, this option is not disabling anything, it is
simply ignored. Thus let's simply drop this option from the documentation
to avoid to confuse the users (but keep the code in vl.c for backward
compatibility).
Second, the documentation claims that "--balloon virtio" is the default
mode, but this is not true anymore since commit 382f074371f7dc32a34.
Since that commit, the option also has no real use case anymore, since
you can simply use "--device virtio-balloon" nowadays instead. Thus to
simplify our complex parameter zoo a little bit, let's deprecate the
the parameter now and tell the user to use "--device virtio-balloon"
instead.

Fixes: 382f074371f7dc32a34c944c845b1698e83d8c36
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi   |  5 +++++
 qemu-options.hx | 11 ++++-------
 vl.c            |  3 +++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 8e35569..29c888d 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2725,6 +2725,11 @@ enabled via the ``-machine usb=on'' argument.
 
 The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
 
+@subsection -balloon (since 2.12.0)
+
+The @option{--balloon virtio} argument has been superseded by
+@option{--device virtio-balloon}.
+
 @subsection -machine s390-squash-mcss=on|off (since 2.12.0)
 
 The ``s390-squash-mcss=on`` property has been obsoleted by allowing the
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ccd5dc..075eb0a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -462,16 +462,13 @@ modprobe i810_audio clocking=48000
 ETEXI
 
 DEF("balloon", HAS_ARG, QEMU_OPTION_balloon,
-    "-balloon none   disable balloon device\n"
     "-balloon virtio[,addr=str]\n"
-    "                enable virtio balloon device (default)\n", QEMU_ARCH_ALL)
+    "                enable virtio balloon device (deprecated)\n", QEMU_ARCH_ALL)
 STEXI
-@item -balloon none
-@findex -balloon
-Disable balloon device.
 @item -balloon virtio[,addr=@var{addr}]
-Enable virtio balloon device (default), optionally with PCI address
-@var{addr}.
+@findex -balloon
+Enable virtio balloon device, optionally with PCI address @var{addr}. This
+option is deprecated, use @option{--device virtio-balloon} instead.
 ETEXI
 
 DEF("device", HAS_ARG, QEMU_OPTION_device,
diff --git a/vl.c b/vl.c
index 9e7235d..2729476 100644
--- a/vl.c
+++ b/vl.c
@@ -2221,6 +2221,9 @@ static int balloon_parse(const char *arg)
 {
     QemuOpts *opts;
 
+    warn_report("This option is deprecated. "
+                "Use '--device virtio-balloon' to enable the balloon device.");
+
     if (strcmp(arg, "none") == 0) {
         return 0;
     }
-- 
1.8.3.1
