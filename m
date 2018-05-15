Received: from eggs.gnu.org ([2001:4830:134:3::10]:44353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fIZ6T-0008FA-Vf
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fIZ6Q-0003nP-OZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:30:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fIZ6Q-0003mW-GM
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:30:50 -0400
From: marcandre.lureau@redhat.com
Date: Tue, 15 May 2018 14:30:07 +0200
Message-Id: <20180515123007.10164-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180515123007.10164-1-marcandre.lureau@redhat.com>
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] ovmf: process TPM PPI request in
 AfterConsole()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Call Tcg2PhysicalPresenceLibProcessRequest() to process pending PPI
requests from PlatformBootManagerAfterConsole().

Laszlo understanding of edk2 is that the PPI operation processing was
meant to occur *entirely* before End-Of-Dxe, so that 3rd party UEFI
drivers couldn't interfere with PPI opcode processing *at all*.

He suggested that we should *not* call
Tcg2PhysicalPresenceLibProcessRequest() from BeforeConsole(). Because,
an "auth" console, i.e. one that does not depend on a 3rd party
driver, is *in general* impossible to guarantee. Instead we could opt
to trust 3rd party drivers, and use the "normal" console(s) in
AfterConsole(), in order to let the user confirm the PPI requests. It
will depend on the user to enable Secure Boot, so that the
trustworthiness of those 3rd party drivers is ensured. If an attacker
roots the guest OS from within, queues some TPM2 PPI requests, and
also modifies drivers on the EFI system partition and/or in GPU option
ROMs (?), then those drivers will not load after guest reboot, and
thus the dependent console(s) won't be used for confirming the PPI
requests.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c      | 8 ++++++++
 .../PlatformBootManagerLib/PlatformBootManagerLib.inf     | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c b/OvmfP=
kg/Library/PlatformBootManagerLib/BdsPlatform.c
index 004b753f4d26..8b1beaa3e207 100644
--- a/OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c
+++ b/OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c
@@ -16,6 +16,7 @@
 #include <Guid/XenInfo.h>
 #include <Guid/RootBridgesConnectedEventGroup.h>
 #include <Protocol/FirmwareVolume2.h>
+#include <Library/Tcg2PhysicalPresenceLib.h>
=20
=20
 //
@@ -1410,6 +1411,13 @@ PlatformBootManagerAfterConsole (
   //
   PciAcpiInitialization ();
=20
+
+  //
+  // Process TPM PPI request
+  //
+  Tcg2PhysicalPresenceLibProcessRequest (NULL);
+
+
   //
   // Process QEMU's -kernel command line option
   //
diff --git a/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLi=
b.inf b/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
index 27789b7377bc..4b72c44bcf0a 100644
--- a/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
+++ b/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
@@ -38,6 +38,7 @@ [Packages]
   IntelFrameworkModulePkg/IntelFrameworkModulePkg.dec
   SourceLevelDebugPkg/SourceLevelDebugPkg.dec
   OvmfPkg/OvmfPkg.dec
+  SecurityPkg/SecurityPkg.dec
=20
 [LibraryClasses]
   BaseLib
@@ -56,6 +57,7 @@ [LibraryClasses]
   LoadLinuxLib
   QemuBootOrderLib
   UefiLib
+  Tcg2PhysicalPresenceLib
=20
 [Pcd]
   gUefiOvmfPkgTokenSpaceGuid.PcdEmuVariableEvent
--=20
2.17.0.253.g3dd125b46d
