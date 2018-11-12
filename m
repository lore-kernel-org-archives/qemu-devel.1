Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gM91a-0001iP-SE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gM91V-0000Vp-Q4
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:00:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gM91S-0000RT-QH
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:00:49 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 12 Nov 2018 11:00:30 +0100
Message-Id: <1542016830-19189-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] bt: Mark the bluetooth subsystem as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Andrzej Zaborowski <andrew.zaborowski@intel.com>

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
---
 qemu-deprecated.texi | 7 +++++++
 qemu-options.hx      | 4 ++++
 vl.c                 | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 5d2d7a3..cb4291f 100644
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
index 38c7a97..ee379b3 100644
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
 
diff --git a/vl.c b/vl.c
index 55bab00..fa25d1a 100644
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
-- 
1.8.3.1
