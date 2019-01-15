Received: from eggs.gnu.org ([209.51.188.92]:57793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjKff-0005OR-Uf
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjKfe-00010g-3A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:06:07 -0500
Received: from indium.canonical.com ([91.189.90.7]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjKfc-0000xv-A6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 04:06:05 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjKfZ-0006fu-Aj
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 09:06:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3A2662E80CC
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 09:06:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 08:56:20 -0000
From: Thomas Huth <1777252@bugs.launchpad.net>
Reply-To: Bug 1777252 <1777252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152916202234.7686.15264921741576357687.malonedeb@wampee.canonical.com>
Message-Id: <154754258028.32422.6669368576771224047.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777252] Re: tests/Makefile.include trying to add
 linking library '-lutil' that break the build on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Does something like this work for you?

diff --git a/tests/Makefile.include b/tests/Makefile.include
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -777,7 +777,7 @@ tests/migration/initrd-stress.img: tests/migration/stre=
ss$(EXESUF)
        rm $(INITRD_WORK_DIR)/init
        rmdir $(INITRD_WORK_DIR)
 =

-ifeq ($(CONFIG_POSIX),y)
+ifeq ($(CONFIG_POSIX)$(call lnot,$(CONFIG_SOLARIS)),yy)
 LIBS +=3D -lutil
 endif

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777252

Title:
  tests/Makefile.include trying to add linking library '-lutil' that
  break the build on Solaris

Status in QEMU:
  New

Bug description:
  Building script 'tests/Makefile.include' contains following code
  ```
  ifeq ($(CONFIG_POSIX),y)
  LIBS +=3D -lutil
  endif
  ```

  library -lutil is not available on Solaris, so the building will failed, =
like
  ```
  ld: fatal: library -lutil: not found
  make: *** [SOMEWHERE/src/qemu-2.12.0/rules.mak:121: qemu-nbd] Error 1
  ```

  Commenting those code out fixed the error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777252/+subscriptions
