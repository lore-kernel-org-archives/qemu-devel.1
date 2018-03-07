Received: from eggs.gnu.org ([2001:4830:134:3::10]:54440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYH-0003Xr-DD
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYD-0008HV-FS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59004
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1etYYD-0008GW-8s
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:09 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27Cq7qo107946
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 07:52:08 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjdw8ppdb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 07:52:08 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:52:07 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  7 Mar 2018 07:51:55 -0500
In-Reply-To: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1520427119-6236-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/5] tpm: convert tpm_crb.c to use
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.objs       |  1 +
 hw/tpm/tpm_crb.c    | 17 +++++------------
 hw/tpm/trace-events |  5 +++++
 3 files changed, 11 insertions(+), 12 deletions(-)
 create mode 100644 hw/tpm/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 5dc1348..72c3d8c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -162,6 +162,7 @@ trace-events-subdirs +=3D hw/alpha
 trace-events-subdirs +=3D hw/hppa
 trace-events-subdirs +=3D hw/xen
 trace-events-subdirs +=3D hw/ide
+trace-events-subdirs +=3D hw/tpm
 trace-events-subdirs +=3D ui
 trace-events-subdirs +=3D audio
 trace-events-subdirs +=3D net
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index b5b8256..d8917cb 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
+#include "trace.h"
=20
 typedef struct CRBState {
     DeviceState parent_obj;
@@ -44,14 +45,6 @@ typedef struct CRBState {
=20
 #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
=20
-#define DEBUG_CRB 0
-
-#define DPRINTF(fmt, ...) do {                  \
-        if (DEBUG_CRB) {                        \
-            printf(fmt, ## __VA_ARGS__);        \
-        }                                       \
-    } while (0)
-
 #define CRB_INTF_TYPE_CRB_ACTIVE 0b1
 #define CRB_INTF_VERSION_CRB 0b1
 #define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
@@ -91,8 +84,8 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr =
addr,
     unsigned offset =3D addr & 3;
     uint32_t val =3D *(uint32_t *)regs >> (8 * offset);
=20
-    DPRINTF("CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32 "\n",
-            addr, size, val);
+    trace_tpm_crb_mmio_read(addr, size, val);
+
     return val;
 }
=20
@@ -100,8 +93,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr ad=
dr,
                                uint64_t val, unsigned size)
 {
     CRBState *s =3D CRB(opaque);
-    DPRINTF("CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx64 "\n"=
,
-            addr, size, val);
+
+    trace_tpm_crb_mmio_write(addr, size, val);
=20
     switch (addr) {
     case A_CRB_CTRL_REQ:
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
new file mode 100644
index 0000000..336b06d
--- /dev/null
+++ b/hw/tpm/trace-events
@@ -0,0 +1,5 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/tpm/tpm_crb.c
+tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read =
0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB writ=
e 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
--=20
2.5.5
