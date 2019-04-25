Received: from eggs.gnu.org ([209.51.188.92]:58398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJy-0003GD-Fv
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJx-0003f4-AU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:21 +0200
Message-Id: <20190425132134.2839-7-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/19] s390-bios: Map low core memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Create a new header for basic architecture specific definitions and add a
mapping of low core memory. This mapping will be used by the real dasd boot
process.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-7-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c      |  2 +
 pc-bios/s390-ccw/s390-arch.h | 90 ++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 pc-bios/s390-ccw/s390-arch.h

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 10f04c69068f..e403b5f733e4 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -9,6 +9,7 @@
  */
 
 #include "libc.h"
+#include "s390-arch.h"
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
@@ -19,6 +20,7 @@ static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
+LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
 
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
new file mode 100644
index 000000000000..5e92c7a27d53
--- /dev/null
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -0,0 +1,90 @@
+/*
+ * S390 Basic Architecture
+ *
+ * Copyright (c) 2019 Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390_ARCH_H
+#define S390_ARCH_H
+
+typedef struct PSW {
+    uint64_t mask;
+    uint64_t addr;
+} __attribute__ ((aligned(8))) PSW;
+_Static_assert(sizeof(struct PSW) == 16, "PSW size incorrect");
+
+/* Older PSW format used by LPSW instruction */
+typedef struct PSWLegacy {
+    uint32_t mask;
+    uint32_t addr;
+} __attribute__ ((aligned(8))) PSWLegacy;
+_Static_assert(sizeof(struct PSWLegacy) == 8, "PSWLegacy size incorrect");
+
+/* s390 psw bit masks */
+#define PSW_MASK_IOINT      0x0200000000000000ULL
+#define PSW_MASK_WAIT       0x0002000000000000ULL
+#define PSW_MASK_EAMODE     0x0000000100000000ULL
+#define PSW_MASK_BAMODE     0x0000000080000000ULL
+#define PSW_MASK_ZMODE      (PSW_MASK_EAMODE | PSW_MASK_BAMODE)
+
+/* Low core mapping */
+typedef struct LowCore {
+    /* prefix area: defined by architecture */
+    PSWLegacy       ipl_psw;                  /* 0x000 */
+    uint32_t        ccw1[2];                  /* 0x008 */
+    uint32_t        ccw2[2];                  /* 0x010 */
+    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
+    uint32_t        ext_params;               /* 0x080 */
+    uint16_t        cpu_addr;                 /* 0x084 */
+    uint16_t        ext_int_code;             /* 0x086 */
+    uint16_t        svc_ilen;                 /* 0x088 */
+    uint16_t        svc_code;                 /* 0x08a */
+    uint16_t        pgm_ilen;                 /* 0x08c */
+    uint16_t        pgm_code;                 /* 0x08e */
+    uint32_t        data_exc_code;            /* 0x090 */
+    uint16_t        mon_class_num;            /* 0x094 */
+    uint16_t        per_perc_atmid;           /* 0x096 */
+    uint64_t        per_address;              /* 0x098 */
+    uint8_t         exc_access_id;            /* 0x0a0 */
+    uint8_t         per_access_id;            /* 0x0a1 */
+    uint8_t         op_access_id;             /* 0x0a2 */
+    uint8_t         ar_access_id;             /* 0x0a3 */
+    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
+    uint64_t        trans_exc_code;           /* 0x0a8 */
+    uint64_t        monitor_code;             /* 0x0b0 */
+    uint16_t        subchannel_id;            /* 0x0b8 */
+    uint16_t        subchannel_nr;            /* 0x0ba */
+    uint32_t        io_int_parm;              /* 0x0bc */
+    uint32_t        io_int_word;              /* 0x0c0 */
+    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
+    uint32_t        stfl_fac_list;            /* 0x0c8 */
+    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
+    uint64_t        mcic;                     /* 0x0e8 */
+    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
+    uint32_t        external_damage_code;     /* 0x0f4 */
+    uint64_t        failing_storage_address;  /* 0x0f8 */
+    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
+    uint64_t        per_breaking_event_addr;  /* 0x110 */
+    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
+    PSW             restart_old_psw;          /* 0x120 */
+    PSW             external_old_psw;         /* 0x130 */
+    PSW             svc_old_psw;              /* 0x140 */
+    PSW             program_old_psw;          /* 0x150 */
+    PSW             mcck_old_psw;             /* 0x160 */
+    PSW             io_old_psw;               /* 0x170 */
+    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
+    PSW             restart_new_psw;          /* 0x1a0 */
+    PSW             external_new_psw;         /* 0x1b0 */
+    PSW             svc_new_psw;              /* 0x1c0 */
+    PSW             program_new_psw;          /* 0x1d0 */
+    PSW             mcck_new_psw;             /* 0x1e0 */
+    PSW             io_new_psw;               /* 0x1f0 */
+} __attribute__((packed, aligned(8192))) LowCore;
+
+extern LowCore const *lowcore;
+
+#endif
-- 
2.17.2
