Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMDwD-0002mb-60
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMDw7-0001Lp-7p
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMDw6-0001Cc-Fy
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:15:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36778307EA97
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 15:15:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Nov 2018 16:15:13 +0100
Message-Id: <20181112151516.10012-2-kraxel@redhat.com>
In-Reply-To: <20181112151516.10012-1-kraxel@redhat.com>
References: <20181112151516.10012-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] bt: Mark the bluetooth subsystem as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

It has been unmaintained since years, and there were only trivial or
tree-wide changes to the related files since many years, so the
code is likely very bitrotten and broken. For example the following
segfaults as soon as as you press a key:

 qemu-system-x86_64 -usb -device usb-bt-dongle -bt hci -bt device:keyboard

Since we are not aware of anybody using bluetooth with the current
version of QEMU, let's mark the subsystem as deprecated, with a special
request for the users to write to the qemu-devel mailing list in case
they still use it (so we could revert the deprecation status in that
case).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1542016830-19189-1-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c                 | 4 ++++
 qemu-deprecated.texi | 7 +++++++
 qemu-options.hx      | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/vl.c b/vl.c
index 55bab005b6..fa25d1ae2d 100644
--- a/vl.c
+++ b/vl.c
@@ -3269,6 +3269,10 @@ int main(int argc, char **argv, char **envp)
                 break;
 #endif
             case QEMU_OPTION_bt:
+                warn_report("The bluetooth subsystem is deprecated and will "
+                            "be removed soon. If the bluetooth subsystem is "
+                            "still useful for you, please send a mail to "
+                            "qemu-devel@nongnu.org with your usecase.");
                 add_device_config(DEV_BT, optarg);
                 break;
             case QEMU_OPTION_audio_help:
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 5d2d7a3588..cb4291f1e5 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -128,6 +128,13 @@ The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
+@subsection bluetooth (since 3.1)
+
+The bluetooth subsystem is unmaintained since many years and likely bitrotten
+quite a bit. It will be removed without replacement unless some users speaks
+up at the @email{qemu-devel@@nongnu.org} mailing list with information about
+their usecases.
+
 @section System emulator machines
 
 @subsection pc-0.10 and pc-0.11 (since 3.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 38c7a978c1..ee379b32e3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2772,6 +2772,10 @@ logic.  The Transport Layer is decided by the machine type.  Currently
 the machines @code{n800} and @code{n810} have one HCI and all other
 machines have none.
 
+Note: This option and the whole bluetooth subsystem is considered as deprecated.
+If you still use it, please send a mail to @email{qemu-devel@@nongnu.org} where
+you describe your usecase.
+
 @anchor{bt-hcis}
 The following three types are recognized:
 
-- 
2.9.3
