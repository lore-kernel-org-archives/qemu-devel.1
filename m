Received: from eggs.gnu.org ([209.51.188.92]:38481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gtfoV-0000MR-JZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gtfdK-00047J-UK
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gtfdI-00044I-U7
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:30:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1CLSjKV035660
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 16:30:23 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qm4aemgtk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 16:30:23 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 12 Feb 2019 21:30:21 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
	[9.57.199.108])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x1CLUIcl15466720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6F3B2065
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53809B2071
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:18 +0000 (GMT)
Received: from localhost (unknown [9.53.179.197])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 21:30:18 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 12 Feb 2019 15:29:17 -0600
In-Reply-To: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
References: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190212212917.26977-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] qga-win: fix VSS build breakage due to
 unintended gnu99 C++ flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 7be41675f7c set -std=gnu99 for C code via QEMU_CFLAGS. Currently
we generate a "custom" QEMU_CXXFLAGS for VSS DLL C++ build by
filtering out some options from QEMU_CFLAGS and adding some others.
Since we don't filter out -std=gnu99 currently this breaks builds when
VSS support is enabled.

We could keep the existing approach, filter out -std=gnu99 from
QEMU_CFLAGS, and add -std=gnu++98, like configure currently does for
QEMU_CXXFLAGS, but as it turns out our resulting QEMU_CXXFLAGS would
be exactly what configure already generates, just with these filtered
out:

  -fstack-protector-all -fstack-protector-strong

and these added:

  -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor

So fix the issue by re-using configure-generated QEMU_CXXFLAGS and
just handling these specific changes.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
index dad9d1b0ba..fd3ba1896b 100644
--- a/qga/vss-win32/Makefile.objs
+++ b/qga/vss-win32/Makefile.objs
@@ -3,7 +3,7 @@
 qga-vss-dll-obj-y += requester.o provider.o install.o
 
 obj-qga-vss-dll-obj-y = $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
-$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS = $(filter-out -Wstrict-prototypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls -fstack-protector-all -fstack-protector-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
+$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS := $(filter-out -fstack-protector-all -fstack-protector-strong, $(QEMU_CXXFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
 
 $(obj)/qga-vss.dll: LDFLAGS = -shared -Wl,--add-stdcall-alias,--enable-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -lws2_32 -static
 $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vss.def
-- 
2.17.1
