Received: from eggs.gnu.org ([209.51.188.92]:38857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gtfoV-0000qH-VW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gtfdI-00044e-5f
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gtfdI-000428-0e
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CLT6vP096421
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 16:30:20 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm3tc5fjy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 16:30:20 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 12 Feb 2019 21:30:19 -0000
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 12 Feb 2019 15:29:16 -0600
In-Reply-To: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
References: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190212212917.26977-2-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] qga-win: include glib when building VSS DLL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, qemu-stable@nongnu.org

Commit 3ebee3b191e defined assert() as g_assert(), but when we build
the VSS DLL component of QGA (to handle fsfreeze) we do not include
glib, which results in breakage when building with VSS support enabled.

Fix this by including glib. Since the VSS DLL is built statically,
this introduces an additional dependency on static glib and supporting
libs for the mingw environment (possibly why we didn't include glib
originally), but VSS support already has very specific prerequisites
so it shouldn't affect too many build environments.

Since the VSS DLL code does use qemu/osdep.h, this should also help
avoid future breakages and possibly allow for some clean ups in current
VSS code.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
index 23d08da225..dad9d1b0ba 100644
--- a/qga/vss-win32/Makefile.objs
+++ b/qga/vss-win32/Makefile.objs
@@ -5,7 +5,7 @@ qga-vss-dll-obj-y +=3D requester.o provider.o install.o
 obj-qga-vss-dll-obj-y =3D $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
 $(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-protot=
ypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-=
style-definition -Wredundant-decls -fstack-protector-all -fstack-protecto=
r-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dt=
or
=20
-$(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enable=
-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
+$(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enable=
-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws=
2_32 -static
 $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.=
def
 	$(call quiet-command,$(CXX) -o $@ $(qga-vss-dll-obj-y) $(SRC_PATH)/qga/=
vss-win32/qga-vss.def $(CXXFLAGS) $(LDFLAGS),"LINK","$(TARGET_DIR)$@")
=20
--=20
2.17.1
