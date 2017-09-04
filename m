Received: from eggs.gnu.org ([2001:4830:134:3::10]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dosuU-0004WL-4q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dossp-0002aW-9s
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:03:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:47562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dossp-0002ZP-4Z
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:01:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dossm-0002IV-Qb
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 15:01:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 880122E81BE
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 15:01:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Sep 2017 14:53:24 -0000
From: ilovezfs <1714750@bugs.launchpad.net>
Reply-To: Bug 1714750 <1714750@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150442540217.17409.6458222878014636993.malonedeb@gac.canonical.com>
Message-Id: <150453680466.10750.3497504310042559272.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1714750] Re: 2.10.0 cannot be installed on
 case-insensitive file system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I mean in that every user is going to have to figure this out
individually until it's fixed.

In any case it will not be a problem for our Homebrew users, as I will do t=
his:
```
diff --git a/Formula/qemu.rb b/Formula/qemu.rb
index 16a54af167..db0e68d103 100644
--- a/Formula/qemu.rb
+++ b/Formula/qemu.rb
@@ -1,10 +1,20 @@
+# Fix extraction on case-insentive file systems.
+# Reported 4 Sep 2017 https://bugs.launchpad.net/qemu/+bug/1714750
+# This is actually an issue with u-boot and may take some time to sort out.
+class QemuDownloadStrategy < CurlDownloadStrategy
+  def stage
+    exclude =3D "#{name}-#{version}/roms/u-boot/scripts/Kconfig"
+    safe_system "tar", "xjf", cached_location, "--exclude", exclude
+    chdir
+  end
+end
+
 class Qemu < Formula
   desc "x86 and PowerPC Emulator"
   homepage "https://www.qemu.org/"
-  url "https://download.qemu.org/qemu-2.9.0.tar.bz2"
-  sha256 "00bfb217b1bb03c7a6c3261b819cfccbfb5a58e3e2ceff546327d271773c6c14"
-  revision 2
-
+  url "https://download.qemu.org/qemu-2.10.0.tar.bz2",
+      :using =3D> QemuDownloadStrategy
+  sha256 "7e9f39e1306e6dcc595494e91c1464d4b03f55ddd2053183e0e1b69f7f776d48"
   head "https://git.qemu.org/git/qemu.git"
 =

   bottle do
```
https://github.com/Homebrew/homebrew-core/pull/17467

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1714750

Title:
  2.10.0 cannot be installed on case-insensitive file system

Status in QEMU:
  New

Bug description:
  The https://download.qemu.org/qemu-2.10.0.tar.bz2 tarball cannot be
  unpacked on a case-insensitive file system because it has a file
  qemu-2.10.0/roms/u-boot/scripts/Kconfig and a directory
  qemu-2.10.0/roms/u-boot/scripts/kconfig. This prevents installation on
  most macOS systems since by default the file system is case
  insensitive. The 2.10.0 upgrade is blocked in Homebrew due to this
  issue. See https://github.com/Homebrew/homebrew-core/pull/17467. This
  is a regression from 2.9.0, which didn't have this problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1714750/+subscriptions
