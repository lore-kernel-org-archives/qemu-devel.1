Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01ECC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD06208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD06208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrgd-0003IZ-V8
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgqez-0003KX-UK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgqey-00019O-30
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgqex-00018s-Pk
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5776730832D8;
 Fri, 28 Jun 2019 11:54:13 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D621A1A92D;
 Fri, 28 Jun 2019 11:54:10 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com
Date: Fri, 28 Jun 2019 13:53:48 +0200
Message-Id: <20190628115349.60293-4-slp@redhat.com>
In-Reply-To: <20190628115349.60293-1-slp@redhat.com>
References: <20190628115349.60293-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 28 Jun 2019 11:54:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] hw/i386: Add an Intel MPTable generator
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a helper function (mptable_generate) for generating an Intel
MPTable according to version 1.4 of the specification.

This is needed for the microvm machine type implementation.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/mptable.c                           | 157 +++++++++++++++++
 include/hw/i386/mptable.h                   |  37 ++++
 include/standard-headers/linux/mpspec_def.h | 182 ++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 hw/i386/mptable.c
 create mode 100644 include/hw/i386/mptable.h
 create mode 100644 include/standard-headers/linux/mpspec_def.h

diff --git a/hw/i386/mptable.c b/hw/i386/mptable.c
new file mode 100644
index 0000000000..c5cb57dd18
--- /dev/null
+++ b/hw/i386/mptable.c
@@ -0,0 +1,157 @@
+/*
+ * Intel MPTable generator
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * Authors:
+ *   Sergio Lopez <slp@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i386/mptable.h"
+#include "standard-headers/linux/mpspec_def.h"
+
+static int mptable_checksum(char *buf, int size)
+{
+    int i;
+    int checksum =3D 0;
+
+    for (i =3D 0; i < size; i++) {
+        checksum +=3D buf[i];
+    }
+
+    return checksum;
+}
+
+/*
+ * Generate an MPTable for "ncpus". "apic_id" must be the next available
+ * APIC ID (last CPU apic_id + 1). "table_base" is the physical location
+ * in the Guest where the caller intends to write the table, needed to
+ * fill the "physptr" field from the "mpf_intel" structure.
+ *
+ * On success, return a newly allocated buffer, that must be freed by th=
e
+ * caller using "g_free" when it's no longer needed, and update
+ * "mptable_size" with the size of the buffer.
+ */
+char *mptable_generate(int ncpus, int apic_id,
+                        int table_base, int *mptable_size)
+{
+    struct mpf_intel *mpf;
+    struct mpc_table *table;
+    struct mpc_cpu *cpu;
+    struct mpc_bus *bus;
+    struct mpc_ioapic *ioapic;
+    struct mpc_intsrc *intsrc;
+    struct mpc_lintsrc *lintsrc;
+    const char mpc_signature[] =3D MPC_SIGNATURE;
+    const char smp_magic_ident[] =3D "_MP_";
+    char *mptable;
+    int checksum =3D 0;
+    int offset =3D 0;
+    int ssize;
+    int i;
+
+    ssize =3D sizeof(struct mpf_intel);
+    mptable =3D g_malloc0(ssize);
+
+    mpf =3D (struct mpf_intel *) mptable;
+    memcpy(mpf->signature, smp_magic_ident, sizeof(smp_magic_ident) - 1)=
;
+    mpf->length =3D 1;
+    mpf->specification =3D 4;
+    mpf->physptr =3D table_base + ssize;
+    mpf->checksum -=3D mptable_checksum((char *) mpf, ssize);
+    offset =3D ssize + sizeof(struct mpc_table);
+
+    ssize =3D sizeof(struct mpc_cpu);
+    for (i =3D 0; i < ncpus; i++) {
+        mptable =3D g_realloc(mptable, offset + ssize);
+        cpu =3D (struct mpc_cpu *) (mptable + offset);
+        cpu->type =3D MP_PROCESSOR;
+        cpu->apicid =3D i;
+        cpu->apicver =3D APIC_VERSION;
+        cpu->cpuflag =3D CPU_ENABLED;
+        if (i =3D=3D 0) {
+            cpu->cpuflag |=3D CPU_BOOTPROCESSOR;
+        }
+        cpu->cpufeature =3D CPU_STEPPING;
+        cpu->featureflag =3D CPU_FEATURE_APIC | CPU_FEATURE_FPU;
+        checksum +=3D mptable_checksum((char *) cpu, ssize);
+        offset +=3D ssize;
+    }
+
+    ssize =3D sizeof(struct mpc_bus);
+    mptable =3D g_realloc(mptable, offset + ssize);
+    bus =3D (struct mpc_bus *) (mptable + offset);
+    bus->type =3D MP_BUS;
+    bus->busid =3D 0;
+    memcpy(bus->bustype, BUS_TYPE_ISA, sizeof(BUS_TYPE_ISA) - 1);
+    checksum +=3D mptable_checksum((char *) bus, ssize);
+    offset +=3D ssize;
+
+    ssize =3D sizeof(struct mpc_ioapic);
+    mptable =3D g_realloc(mptable, offset + ssize);
+    ioapic =3D (struct mpc_ioapic *) (mptable + offset);
+    ioapic->type =3D MP_IOAPIC;
+    ioapic->apicid =3D ncpus + 1;
+    ioapic->apicver =3D APIC_VERSION;
+    ioapic->flags =3D MPC_APIC_USABLE;
+    ioapic->apicaddr =3D IO_APIC_DEFAULT_PHYS_BASE;
+    checksum +=3D mptable_checksum((char *) ioapic, ssize);
+    offset +=3D ssize;
+
+    ssize =3D sizeof(struct mpc_intsrc);
+    for (i =3D 0; i < 16; i++) {
+        mptable =3D g_realloc(mptable, offset + ssize);
+        intsrc =3D (struct mpc_intsrc *) (mptable + offset);
+        intsrc->type =3D MP_INTSRC;
+        intsrc->irqtype =3D mp_INT;
+        intsrc->irqflag =3D MP_IRQDIR_DEFAULT;
+        intsrc->srcbus =3D 0;
+        intsrc->srcbusirq =3D i;
+        intsrc->dstapic =3D ncpus + 1;
+        intsrc->dstirq =3D i;
+        checksum +=3D mptable_checksum((char *) intsrc, ssize);
+        offset +=3D ssize;
+    }
+
+    ssize =3D sizeof(struct mpc_lintsrc);
+    mptable =3D g_realloc(mptable, offset + (ssize * 2));
+    lintsrc =3D (struct mpc_lintsrc *) (mptable + offset);
+    lintsrc->type =3D MP_LINTSRC;
+    lintsrc->irqtype =3D mp_ExtINT;
+    lintsrc->irqflag =3D MP_IRQDIR_DEFAULT;
+    lintsrc->srcbusid =3D 0;
+    lintsrc->srcbusirq =3D 0;
+    lintsrc->destapic =3D 0;
+    lintsrc->destapiclint =3D 0;
+    checksum +=3D mptable_checksum((char *) lintsrc, ssize);
+    offset +=3D ssize;
+
+    lintsrc =3D (struct mpc_lintsrc *) (mptable + offset);
+    lintsrc->type =3D MP_LINTSRC;
+    lintsrc->irqtype =3D mp_NMI;
+    lintsrc->irqflag =3D MP_IRQDIR_DEFAULT;
+    lintsrc->srcbusid =3D 0;
+    lintsrc->srcbusirq =3D 0;
+    lintsrc->destapic =3D 0xFF;
+    lintsrc->destapiclint =3D 1;
+    checksum +=3D mptable_checksum((char *) lintsrc, ssize);
+    offset +=3D ssize;
+
+    ssize =3D sizeof(struct mpc_table);
+    table =3D (struct mpc_table *) (mptable + sizeof(struct mpf_intel));
+    memcpy(table->signature, mpc_signature, sizeof(mpc_signature) - 1);
+    table->length =3D offset - sizeof(struct mpf_intel);
+    table->spec =3D MPC_SPEC;
+    memcpy(table->oem, MPC_OEM, sizeof(MPC_OEM) - 1);
+    memcpy(table->productid, MPC_PRODUCT_ID, sizeof(MPC_PRODUCT_ID) - 1)=
;
+    table->lapic =3D APIC_DEFAULT_PHYS_BASE;
+    checksum +=3D mptable_checksum((char *) table, ssize);
+    table->checksum -=3D checksum;
+
+    *mptable_size =3D offset;
+    return mptable;
+}
diff --git a/include/hw/i386/mptable.h b/include/hw/i386/mptable.h
new file mode 100644
index 0000000000..9f9eb82618
--- /dev/null
+++ b/include/hw/i386/mptable.h
@@ -0,0 +1,37 @@
+/*
+ * Intel MPTable generator
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ *
+ * Authors:
+ *   Sergio Lopez <slp@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_I386_MPTABLE_H
+#define HW_I386_MPTABLE_H
+
+#define APIC_VERSION     0x14
+#define CPU_STEPPING     0x600
+#define CPU_FEATURE_APIC 0x200
+#define CPU_FEATURE_FPU  0x001
+#define MPC_SPEC         0x4
+
+#define MP_IRQDIR_DEFAULT 0
+#define MP_IRQDIR_HIGH    1
+#define MP_IRQDIR_LOW     3
+
+static const char MPC_OEM[]        =3D "QEMU    ";
+static const char MPC_PRODUCT_ID[] =3D "000000000000";
+static const char BUS_TYPE_ISA[]   =3D "ISA   ";
+
+#define IO_APIC_DEFAULT_PHYS_BASE 0xfec00000
+#define APIC_DEFAULT_PHYS_BASE    0xfee00000
+#define APIC_VERSION              0x14
+
+char *mptable_generate(int ncpus, int apic_id,
+                       int table_base, int *mptable_size);
+
+#endif
diff --git a/include/standard-headers/linux/mpspec_def.h b/include/standa=
rd-headers/linux/mpspec_def.h
new file mode 100644
index 0000000000..6fb923a343
--- /dev/null
+++ b/include/standard-headers/linux/mpspec_def.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_MPSPEC_DEF_H
+#define _ASM_X86_MPSPEC_DEF_H
+
+/*
+ * Structure definitions for SMP machines following the
+ * Intel Multiprocessing Specification 1.1 and 1.4.
+ */
+
+/*
+ * This tag identifies where the SMP configuration
+ * information is.
+ */
+
+#define SMP_MAGIC_IDENT	(('_'<<24) | ('P'<<16) | ('M'<<8) | '_')
+
+#ifdef CONFIG_X86_32
+# define MAX_MPC_ENTRY 1024
+#endif
+
+/* Intel MP Floating Pointer Structure */
+struct mpf_intel {
+	char signature[4];		/* "_MP_"			*/
+	unsigned int physptr;		/* Configuration table address	*/
+	unsigned char length;		/* Our length (paragraphs)	*/
+	unsigned char specification;	/* Specification version	*/
+	unsigned char checksum;		/* Checksum (makes sum 0)	*/
+	unsigned char feature1;		/* Standard or configuration ?	*/
+	unsigned char feature2;		/* Bit7 set for IMCR|PIC	*/
+	unsigned char feature3;		/* Unused (0)			*/
+	unsigned char feature4;		/* Unused (0)			*/
+	unsigned char feature5;		/* Unused (0)			*/
+};
+
+#define MPC_SIGNATURE "PCMP"
+
+struct mpc_table {
+	char signature[4];
+	unsigned short length;		/* Size of table */
+	char spec;			/* 0x01 */
+	char checksum;
+	char oem[8];
+	char productid[12];
+	unsigned int oemptr;		/* 0 if not present */
+	unsigned short oemsize;		/* 0 if not present */
+	unsigned short oemcount;
+	unsigned int lapic;		/* APIC address */
+	unsigned int reserved;
+};
+
+/* Followed by entries */
+
+#define	MP_PROCESSOR		0
+#define	MP_BUS			1
+#define	MP_IOAPIC		2
+#define	MP_INTSRC		3
+#define	MP_LINTSRC		4
+/* Used by IBM NUMA-Q to describe node locality */
+#define	MP_TRANSLATION		192
+
+#define CPU_ENABLED		1	/* Processor is available */
+#define CPU_BOOTPROCESSOR	2	/* Processor is the boot CPU */
+
+#define CPU_STEPPING_MASK	0x000F
+#define CPU_MODEL_MASK		0x00F0
+#define CPU_FAMILY_MASK		0x0F00
+
+struct mpc_cpu {
+	unsigned char type;
+	unsigned char apicid;		/* Local APIC number */
+	unsigned char apicver;		/* Its versions */
+	unsigned char cpuflag;
+	unsigned int cpufeature;
+	unsigned int featureflag;	/* CPUID feature value */
+	unsigned int reserved[2];
+};
+
+struct mpc_bus {
+	unsigned char type;
+	unsigned char busid;
+	unsigned char bustype[6];
+};
+
+/* List of Bus Type string values, Intel MP Spec. */
+#define BUSTYPE_EISA	"EISA"
+#define BUSTYPE_ISA	"ISA"
+#define BUSTYPE_INTERN	"INTERN"	/* Internal BUS */
+#define BUSTYPE_MCA	"MCA"		/* Obsolete */
+#define BUSTYPE_VL	"VL"		/* Local bus */
+#define BUSTYPE_PCI	"PCI"
+#define BUSTYPE_PCMCIA	"PCMCIA"
+#define BUSTYPE_CBUS	"CBUS"
+#define BUSTYPE_CBUSII	"CBUSII"
+#define BUSTYPE_FUTURE	"FUTURE"
+#define BUSTYPE_MBI	"MBI"
+#define BUSTYPE_MBII	"MBII"
+#define BUSTYPE_MPI	"MPI"
+#define BUSTYPE_MPSA	"MPSA"
+#define BUSTYPE_NUBUS	"NUBUS"
+#define BUSTYPE_TC	"TC"
+#define BUSTYPE_VME	"VME"
+#define BUSTYPE_XPRESS	"XPRESS"
+
+#define MPC_APIC_USABLE		0x01
+
+struct mpc_ioapic {
+	unsigned char type;
+	unsigned char apicid;
+	unsigned char apicver;
+	unsigned char flags;
+	unsigned int apicaddr;
+};
+
+struct mpc_intsrc {
+	unsigned char type;
+	unsigned char irqtype;
+	unsigned short irqflag;
+	unsigned char srcbus;
+	unsigned char srcbusirq;
+	unsigned char dstapic;
+	unsigned char dstirq;
+};
+
+enum mp_irq_source_types {
+	mp_INT =3D 0,
+	mp_NMI =3D 1,
+	mp_SMI =3D 2,
+	mp_ExtINT =3D 3
+};
+
+#define MP_IRQPOL_DEFAULT	0x0
+#define MP_IRQPOL_ACTIVE_HIGH	0x1
+#define MP_IRQPOL_RESERVED	0x2
+#define MP_IRQPOL_ACTIVE_LOW	0x3
+#define MP_IRQPOL_MASK		0x3
+
+#define MP_IRQTRIG_DEFAULT	0x0
+#define MP_IRQTRIG_EDGE		0x4
+#define MP_IRQTRIG_RESERVED	0x8
+#define MP_IRQTRIG_LEVEL	0xc
+#define MP_IRQTRIG_MASK		0xc
+
+#define MP_APIC_ALL	0xFF
+
+struct mpc_lintsrc {
+	unsigned char type;
+	unsigned char irqtype;
+	unsigned short irqflag;
+	unsigned char srcbusid;
+	unsigned char srcbusirq;
+	unsigned char destapic;
+	unsigned char destapiclint;
+};
+
+#define MPC_OEM_SIGNATURE "_OEM"
+
+struct mpc_oemtable {
+	char signature[4];
+	unsigned short length;		/* Size of table */
+	char  rev;			/* 0x01 */
+	char  checksum;
+	char  mpc[8];
+};
+
+/*
+ *	Default configurations
+ *
+ *	1	2 CPU ISA 82489DX
+ *	2	2 CPU EISA 82489DX neither IRQ 0 timer nor IRQ 13 DMA chaining
+ *	3	2 CPU EISA 82489DX
+ *	4	2 CPU MCA 82489DX
+ *	5	2 CPU ISA+PCI
+ *	6	2 CPU EISA+PCI
+ *	7	2 CPU MCA+PCI
+ */
+
+enum mp_bustype {
+	MP_BUS_ISA =3D 1,
+	MP_BUS_EISA,
+	MP_BUS_PCI,
+};
+#endif /* _ASM_X86_MPSPEC_DEF_H */
--=20
2.21.0


