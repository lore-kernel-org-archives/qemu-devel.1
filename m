Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ABFC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81632082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvUw-0000eh-3s
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:41:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFf-0002G6-7I
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFd-0002RU-Cg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFb-0002QD-Fw; Fri, 12 Apr 2019 08:25:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1945C811D5;
	Fri, 12 Apr 2019 12:25:46 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1C415D9CC;
	Fri, 12 Apr 2019 12:25:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:12 +0200
Message-Id: <20190412122523.24111-7-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 12 Apr 2019 12:25:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 06/17] s390-bios: Map
 low core memory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122512.XhlsrAo-XvTO6Qb7r0TY0202FbDQb0LpYlqT-nJsK6U@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Create a new header for basic architecture specific definitions and add a
mapping of low core memory. This mapping will be used by the real dasd bo=
ot
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
index 10f04c6906..e403b5f733 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -9,6 +9,7 @@
  */
=20
 #include "libc.h"
+#include "s390-arch.h"
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
@@ -19,6 +20,7 @@ static char loadparm_str[LOADPARM_LEN + 1] =3D { 0, 0, =
0, 0, 0, 0, 0, 0, 0 };
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
+LowCore const *lowcore; /* Yes, this *is* a pointer to address 0 */
=20
 #define LOADPARM_PROMPT "PROMPT  "
 #define LOADPARM_EMPTY  "        "
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
new file mode 100644
index 0000000000..5e92c7a27d
--- /dev/null
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -0,0 +1,90 @@
+/*
+ * S390 Basic Architecture
+ *
+ * Copyright (c) 2019 Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
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
+_Static_assert(sizeof(struct PSW) =3D=3D 16, "PSW size incorrect");
+
+/* Older PSW format used by LPSW instruction */
+typedef struct PSWLegacy {
+    uint32_t mask;
+    uint32_t addr;
+} __attribute__ ((aligned(8))) PSWLegacy;
+_Static_assert(sizeof(struct PSWLegacy) =3D=3D 8, "PSWLegacy size incorr=
ect");
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
--=20
2.21.0


