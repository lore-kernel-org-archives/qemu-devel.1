Received: from eggs.gnu.org ([2001:4830:134:3::10]:50264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gMyJk-0008HR-QF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gMyJf-0007hk-N0
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:47:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gMyJf-0006NO-EJ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:46:59 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAEGjrPi005479
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 11:46:09 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nrpnnjr2d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 11:46:02 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Nov 2018 16:44:55 -0000
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Nov 2018 10:44:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181114164438.6412-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.1 v2] build: qga: add macro to force use
 of native mingw32 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

When building qemu-ga for w32 with VSS support, some parts of qemu-ga
are not linked against glib, specifically the C++ bits used to
create the VSS provider DLL. With 3ebee3b191e, we now define assert()
as g_assert() for all mingw32 builds via osdep.h, which results in the
following build breakage:

  x86_64-w64-mingw32-g++ -o qga/vss-win32/qga-vss.dll qga/vss-win32/reque=
ster.o qga/vss-win32/provider.o qga/vss-win32/install.o /home/mdroth/w/qe=
mu4.git/qga/vss-win32/qga-vss.def  -shared -Wl,--add-stdcall-alias,--enab=
le-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
  qga/vss-win32/requester.o: In function `requester_freeze':
  /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:284: undefined ref=
erence to `g_assertion_message_expr'
  qga/vss-win32/requester.o: In function `requester_thaw':
  /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:508: undefined ref=
erence to `g_assertion_message_expr'
  /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:509: undefined ref=
erence to `g_assertion_message_expr'
  collect2: error: ld returned 1 exit status
  make: *** [/home/mdroth/w/qemu4.git/qga/vss-win32/Makefile.objs:10: qga=
/vss-win32/qga-vss.dll] Error 1
  make: *** Waiting for unfinished jobs....

Fix this by introducing a USE_NATIVE_MINGW32_ASSERT macro that can
be defined prior to inclusion of osdep.h for build targets that
don't link against glib.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
v2:
 * define USE_NATIVE_MINGW32_ASSERT via build recipe and avoid moving
   #include's before osdep.h (Philippe)
---
 include/qemu/osdep.h        | 2 +-
 qga/vss-win32/Makefile.objs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bcdec..59364bfeb0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -129,7 +129,7 @@ extern int daemon(int, int);
  * code that is unreachable when features are disabled.
  * All supported versions of Glib's g_assert() satisfy this requirement.
  */
-#ifdef __MINGW32__
+#if defined(__MINGW32__) && !defined(USE_NATIVE_MINGW32_ASSERT)
 #undef assert
 #define assert(x)  g_assert(x)
 #endif
diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
index 23d08da225..5773bfd868 100644
--- a/qga/vss-win32/Makefile.objs
+++ b/qga/vss-win32/Makefile.objs
@@ -3,7 +3,7 @@
 qga-vss-dll-obj-y +=3D requester.o provider.o install.o
=20
 obj-qga-vss-dll-obj-y =3D $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
-$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-protot=
ypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-=
style-definition -Wredundant-decls -fstack-protector-all -fstack-protecto=
r-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dt=
or
+$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-protot=
ypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-=
style-definition -Wredundant-decls -fstack-protector-all -fstack-protecto=
r-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dt=
or -DUSE_NATIVE_MINGW32_ASSERT
=20
 $(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enable=
-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
 $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.=
def
--=20
2.17.1
