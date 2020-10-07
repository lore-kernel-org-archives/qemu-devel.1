Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89CC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB5B20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 02:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="RRLQjlMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB5B20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPzaf-0005nm-0i
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 22:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kPzZv-0004um-8S
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 22:53:19 -0400
Received: from mr85p00im-zteg06021501.me.com ([17.58.23.183]:32936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kPzZp-0008R6-TV
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 22:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1602039189; bh=Otr2I2T+KLxTlS52QI/q1yQM8wc7NzEAqUDZTVJbvp8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=RRLQjlMSnIRYx0B/dPsR9ZUgPCYblK2+3XpmA4M9XjeSdFCR2RM47uMsPyK2une4G
 SaCDSYUG9bhG/+2nMUiiKb0bgDVbI7djE7N0tFXU+3E5WzyBdcaAcMOlKAK96MLm0W
 viNiwQlvelSEGea6qec7hrOt8JdjYXDDdxo+CYGjr0TLTydXGxlb4lZHNL9l7PfmLI
 jzguCztwkHIx6wy7JFfFUL1nNZlj5r780TeBUsa2ckLzab2rf2/x0+SycnHxXDUGdF
 8JvWxxabyb8m2hBnyKpsS4zCIgB1Bc1Dvw0fxWKdCdzzQy8x4t27yvEOPeerUj7aSb
 KCfP1B1tI4ZjQ==
Received: from localhost.localdomain (c-67-180-181-196.hsd1.ca.comcast.net
 [67.180.181.196])
 by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id A4EE33808A2;
 Wed,  7 Oct 2020 02:53:09 +0000 (UTC)
From: Jason Thorpe <thorpej@me.com>
To: qemu-devel@nongnu.org
Cc: Jason Thorpe <thorpej@me.com>
Subject: [PATCH] qemu-palcode: Changes to support booting NetBSD/alpha
Date: Tue,  6 Oct 2020 19:52:29 -0700
Message-Id: <20201007025229.7487-1-thorpej@me.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_03:2020-10-06,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010070018
Received-SPF: pass client-ip=17.58.23.183; envelope-from=thorpej@me.com;
 helo=mr85p00im-zteg06021501.me.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 22:53:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are additional changes in Qemu itself.  Those will be sent as
a follow-up.

- Change the $a2 value at VM start from "cpu count" to "config word".  Bits
  0-5 are cpu count, and bit 6 communicates the "-nographic" option from
  the VM.
- Provide a Console Terminal Block in the HWRPB.  Initialize this based on
  the location of the PCI VGA, or to the serial port if Qemu has been run
  with "-nographic".
- Initialize hwrpb.hwrpb.cpuid correctly; it's the WHAMI of the primary CPU,
  not the CPU type.
- Don't set the "PALcode memory valid" bit in the PCS flags field; those
  HWRPB fields are not, in fact, valid.
- Allow swppal() to specify the new $pv value.  Use this to pass the
  CPU_Restart_data to the cpu spinup entry point.
- Fix a bug in PCI address configuration that caused the CMD646 IDE registers
  to be mapped incorrectly.
- When configuring the PCI bus, program system-specific interrupt routing
  information into the PCI device "line" register (as SRM does).
- When building the PALcode, don't include outside header files; put everything
  that's needed in protos.h.

Signed-off-by: Jason Thorpe <thorpej@me.com>
---
 hwrpb.h       | 59 ++++++++++++++++++++++++++++++++++
 init.c        | 89 +++++++++++++++++++++++++++++++++++++++------------
 memcpy.c      |  2 +-
 memset.c      |  2 +-
 pal.S         | 16 ++++++---
 pci.c         | 33 ++++++++++++++-----
 pci.h         |  5 +++
 printf.c      | 11 +++++--
 protos.h      | 33 ++++++++++++++++---
 sys-clipper.h | 27 ++++++++++++++++
 vgaio.c       |  2 ++
 11 files changed, 236 insertions(+), 43 deletions(-)

diff --git a/hwrpb.h b/hwrpb.h
index 2166bad..1981d40 100644
--- a/hwrpb.h
+++ b/hwrpb.h
@@ -146,6 +146,65 @@ struct crb_struct {
 	struct vf_map_struct map[1];
 };
 
+struct ctb_struct {
+	unsigned long type;
+	unsigned long unit;
+	unsigned long res0;
+	unsigned long len;
+	unsigned long ipl;
+	unsigned long tintr_vec;
+	unsigned long rintr_vec;
+	unsigned long term_type;
+	unsigned long keybd_type;
+	unsigned long keybd_trans;
+	unsigned long keybd_map;
+	unsigned long keybd_state;
+	unsigned long keybd_last;
+	unsigned long font_us;
+	unsigned long font_mcs;
+	unsigned long font_width;
+	unsigned long font_height;
+	unsigned long mon_width;
+	unsigned long mon_height;
+	unsigned long dpi;
+	unsigned long planes;
+	unsigned long cur_width;
+	unsigned long cur_height;
+	unsigned long head_cnt;
+	unsigned long opwindow;
+	unsigned long head_offset;
+	unsigned long putchar;
+	unsigned long io_state;
+	unsigned long listen_state;
+	unsigned long xaddr;
+	unsigned long turboslot;
+	unsigned long server_off;
+	unsigned long line_off;
+	unsigned char csd;
+};
+
+#define	CTB_NONE	0x00
+#define	CTB_PRINTERPORT	0x02
+#define	CTB_GRAPHICS	0x03
+#define	CTB_TYPE4	0x04
+
+/*
+ * Format of the Console Terminal Block Type 4 `turboslot' field:
+ *
+ *  63                   40 39       32 31     24 23      16 15   8 7    0
+ *  |      reserved        |  channel  |  hose   | bus type |  bus | slot|
+ */
+#define	CTB_TURBOSLOT_CHANNEL(x)	(((x) >> 32) & 0xff)
+#define	CTB_TURBOSLOT_HOSE(x)		(((x) >> 24) & 0xff)
+#define	CTB_TURBOSLOT_TYPE(x)		(((x) >> 16) & 0xff)
+#define	CTB_TURBOSLOT_BUS(x)		(((x) >> 8) & 0xff)
+#define	CTB_TURBOSLOT_SLOT(x)		((x) & 0xff)
+
+#define	CTB_TURBOSLOT_TYPE_TC           0       /* TURBOchannel */
+#define	CTB_TURBOSLOT_TYPE_ISA          1       /* ISA */
+#define	CTB_TURBOSLOT_TYPE_EISA         2       /* EISA */
+#define	CTB_TURBOSLOT_TYPE_PCI          3       /* PCI */
+
 struct memclust_struct {
 	unsigned long start_pfn;
 	unsigned long numpages;
diff --git a/init.c b/init.c
index b53bab6..9cde986 100644
--- a/init.c
+++ b/init.c
@@ -18,8 +18,6 @@
    along with this program; see the file COPYING.  If not see
    <http://www.gnu.org/licenses/>.  */
 
-#include <string.h>
-#include <stddef.h>
 #include "hwrpb.h"
 #include "osf.h"
 #include "ioport.h"
@@ -38,11 +36,21 @@
 
 #define HZ	1024
 
+/*
+ * Register a2 contains configuration information from the VM:
+ *
+ * bits 0-5 -- ncpus
+ * bit  6   -- "nographics" option
+ */
+#define	CONFIG_NCPUS(x)		((x) & 63)
+#define	CONFIG_NOGRAPHICS(x)	((x) & (1ull << 6))
+
 struct hwrpb_combine {
   struct hwrpb_struct hwrpb;
   struct percpu_struct processor[4];
   struct memdesc_struct md;
   struct memclust_struct mc[2];
+  struct ctb_struct ctb;
   struct crb_struct crb;
   struct procdesc_struct proc_dispatch;
   struct procdesc_struct proc_fixup;
@@ -61,6 +69,8 @@ struct hwrpb_combine hwrpb __attribute__((aligned(PAGE_SIZE)));
 
 void *last_alloc;
 bool have_vga;
+unsigned int pci_vga_bus;
+unsigned int pci_vga_dev;
 
 static void *
 alloc (unsigned long size, unsigned long align)
@@ -138,11 +148,13 @@ init_page_table(void)
 }
 
 static void
-init_hwrpb (unsigned long memsize, unsigned long cpus)
+init_hwrpb (unsigned long memsize, unsigned long config)
 {
   unsigned long pal_pages;
   unsigned long amask;
   unsigned long i;
+  unsigned long proc_type = EV4_CPU;
+  unsigned long cpus = CONFIG_NCPUS(config);
   
   hwrpb.hwrpb.phys_addr = PA(&hwrpb);
 
@@ -164,12 +176,12 @@ init_hwrpb (unsigned long memsize, unsigned long cpus)
   switch (__builtin_alpha_implver())
     {
     case 0: /* EV4 */
-      hwrpb.hwrpb.cpuid = EV4_CPU;
+      proc_type = EV4_CPU;
       hwrpb.hwrpb.max_asn = 63;
       break;
 
     case 1: /* EV5 */
-      hwrpb.hwrpb.cpuid
+      proc_type
 	= ((amask & 0x101) == 0x101 ? PCA56_CPU		/* MAX+BWX */
 	   : amask & 1 ? EV56_CPU			/* BWX */
 	   : EV5_CPU);
@@ -177,11 +189,12 @@ init_hwrpb (unsigned long memsize, unsigned long cpus)
       break;
 
     case 2: /* EV6 */
-      hwrpb.hwrpb.cpuid = (amask & 4 ? EV67_CPU : EV6_CPU);  /* CIX */
+      proc_type = (amask & 4 ? EV67_CPU : EV6_CPU);  /* CIX */
       hwrpb.hwrpb.max_asn = 255;
       break;
     }
 
+  hwrpb.hwrpb.cpuid = 0;	/* CPU #0 is the primary */
   hwrpb.hwrpb.pagesize = PAGE_SIZE;
   hwrpb.hwrpb.pa_bits = 40;
   hwrpb.hwrpb.sys_type = SYS_TYPE;
@@ -189,9 +202,20 @@ init_hwrpb (unsigned long memsize, unsigned long cpus)
   hwrpb.hwrpb.sys_revision = SYS_REVISION;
   for (i = 0; i < cpus; ++i)
     {
-      /* ??? Look up these bits.  Snagging the value examined by the kernel. */
-      hwrpb.processor[i].flags = 0x1cc;
-      hwrpb.processor[i].type = hwrpb.hwrpb.cpuid;
+      /*
+       * original value was 0x1cc ==
+       *	PALcode loaded       (0x100)
+       *	PALcode memory valid (0x080)
+       *	PALcode valid        (0x040)
+       *	processor present    (0x008)
+       *	processor available  (0x004)
+       *
+       * Don't set PALcode memory valid -- we don't initialize those PCS
+       * fields!
+       */
+      hwrpb.processor[i].flags = 0x14c;
+      hwrpb.processor[i].type = proc_type;
+      /* XXX hwrpb.processor[i].pal_revision */
     }
 
   hwrpb.hwrpb.intr_freq = HZ * 4096;
@@ -213,6 +237,21 @@ init_hwrpb (unsigned long memsize, unsigned long cpus)
   hwrpb.mc[1].start_pfn = pal_pages;
   hwrpb.mc[1].numpages = (memsize >> PAGE_SHIFT) - pal_pages;
 
+  hwrpb.hwrpb.ctbt_offset = offsetof(struct hwrpb_combine, ctb);
+  hwrpb.hwrpb.ctb_size = sizeof(hwrpb.ctb);
+  if (have_vga && !CONFIG_NOGRAPHICS(config))
+    {
+      printf("CTB: GRAPHICS PCI BUS %d DEV %d\r\n", pci_vga_bus, pci_vga_dev);
+      hwrpb.ctb.term_type = CTB_GRAPHICS;
+      hwrpb.ctb.turboslot = (CTB_TURBOSLOT_TYPE_PCI << 16) |
+                            (pci_vga_bus << 8) | pci_vga_dev;
+    }
+  else
+    {
+      printf("CTB: PRINTERPORT\r\n");
+      hwrpb.ctb.term_type = CTB_PRINTERPORT;
+    }
+
   hwrpb.hwrpb.crb_offset = offsetof(struct hwrpb_combine, crb);
   hwrpb.crb.dispatch_va = &hwrpb.proc_dispatch;
   hwrpb.crb.dispatch_pa = PA(&hwrpb.proc_dispatch);
@@ -260,7 +299,7 @@ init_i8259 (void)
   outb(0x01, PORT_PIC1_DATA);	/* ICW4 */
 
   /* Initialize level triggers.  The CY82C693UB that's on real alpha
-     hardware doesn't have this; this is a PIIX extension.  However,
+     hardware controls these differently; we assume a PIIX here.  However,
      QEMU doesn't implement regular level triggers.  */
   outb(0xff, PORT_PIC2_ELCR);
   outb(0xff, PORT_PIC1_ELCR);
@@ -275,32 +314,37 @@ init_i8259 (void)
 }
 
 static void __attribute__((noreturn))
-swppal(void *entry, void *pcb)
+swppal(void *entry, void *pcb, unsigned long vptptr, unsigned long pv)
 {
   register int variant __asm__("$16") = 2;	/* OSF/1 PALcode */
   register void *pc __asm__("$17") = entry;
   register unsigned long pa_pcb __asm__("$18") = PA(pcb);
-  register unsigned long vptptr __asm__("$19") = VPTPTR;
+  register unsigned long newvptptr __asm__("$19") = vptptr;
+  register unsigned long newpv __asm__("$20") = pv;
 
-  asm("call_pal 0x0a" : : "r"(variant), "r"(pc), "r"(pa_pcb), "r"(vptptr));
+  asm("call_pal 0x0a" : :
+      "r"(variant), "r"(pc), "r"(pa_pcb), "r"(newvptptr), "r"(newpv));
   __builtin_unreachable ();
 }
 
 void
-do_start(unsigned long memsize, void (*kernel_entry)(void), unsigned long cpus)
+do_start(unsigned long memsize, void (*kernel_entry)(void),
+         unsigned long config)
 {
   last_alloc = _end;
 
   init_page_table();
-  init_hwrpb(memsize, cpus);
   init_pcb();
   init_i8259();
   uart_init();
   ps2port_setup();
   pci_setup();
   vgahw_init();
+  init_hwrpb(memsize, config);
 
-  swppal(kernel_entry ? kernel_entry : do_console, &pcb);
+  void *new_pc = kernel_entry ? kernel_entry : do_console;
+
+  swppal(new_pc, &pcb, VPTPTR, (unsigned long)new_pc);
 }
 
 void
@@ -315,14 +359,16 @@ do_start_wait(unsigned long cpuid)
 	{
 	  /* ??? The only message I know of is "START\r\n".
 	     I can't be bothered to verify more than 4 characters.  */
-	  /* ??? The Linux kernel fills in, but does not require,
-	     CPU_restart_data.  It just sets that to the same address
-	     as CPU_restart itself.  Our swppal *does* put the PC into
-	     $26 and $27, the latter of which the kernel does rely upon.  */
+
+	  /* Use use a private extension to SWPPAL to get the
+	     CPU_restart_data into $27.  Linux fills it in, but does
+	     not require it. Other operating system, however,s do use
+	     CPU_restart_data as part of secondary CPU start-up.  */
 
 	  unsigned int len = hwrpb.processor[cpuid].ipc_buffer[0];
 	  unsigned int msg = hwrpb.processor[cpuid].ipc_buffer[1];
 	  void *CPU_restart = hwrpb.hwrpb.CPU_restart;
+	  unsigned long CPU_restart_data = hwrpb.hwrpb.CPU_restart_data;
 	  __sync_synchronize();
 	  hwrpb.hwrpb.rxrdy = 0;
 
@@ -330,7 +376,8 @@ do_start_wait(unsigned long cpuid)
 	    {
 	      /* Set bootstrap in progress */
 	      hwrpb.processor[cpuid].flags |= 1;
-	      swppal(CPU_restart, hwrpb.processor[cpuid].hwpcb);
+	      swppal(CPU_restart, hwrpb.processor[cpuid].hwpcb,
+		     hwrpb.hwrpb.vptb, CPU_restart_data);
 	    }
 	}
     }
diff --git a/memcpy.c b/memcpy.c
index b6bbb74..9e1e913 100644
--- a/memcpy.c
+++ b/memcpy.c
@@ -8,7 +8,7 @@
  * This is a reasonably optimized memcpy() routine.
  */
 
-#include <string.h>
+#include "protos.h"
 
 /*
  * Note that the C code is written to be optimized into good assembly. However,
diff --git a/memset.c b/memset.c
index e8481dc..f9b0a6d 100644
--- a/memset.c
+++ b/memset.c
@@ -19,7 +19,7 @@
    <http://www.gnu.org/licenses/>.  */
 
 
-#include <string.h>
+#include "protos.h"
 
 void *memset(void *optr, int ival, unsigned long size)
 {
diff --git a/pal.S b/pal.S
index 64941a8..1e83b78 100644
--- a/pal.S
+++ b/pal.S
@@ -566,6 +566,8 @@ ENDFN	CallPal_Cserve_Cont
  *	r17 (a1) = New PC
  *	r18 (a2) = New PCB
  *	r19 (a3) = New VptPtr
+ *	r20 (a4) = New Procedure Value (to place into $27)
+ *	           (Non-standard; See note below.)
  * 
  * OUTPUT PARAMETERS:
  *
@@ -574,11 +576,15 @@ ENDFN	CallPal_Cserve_Cont
  *			1 - Unknown PALcode variant
  *			2 - Known PALcode variant, but PALcode not loaded
  *
- *	r26 (ra) = r27 (pv) = New PC
- *		Note that this is non-architected, but is relied on by
+ *	r26 (ra) = New PC
+ *	r27 (pv) = From $20
+ *		Note that this is non-architected, but is relied upon by
  *		the usage of SwpPal within our own console code in order
- *		to simplify its use within C code.
- *
+ *		to simplify its use within C code.  We can get away with
+ *		the extra non-standard argument (in $20) because as
+ *		architected, all registers except SP and R0 are
+ *		UNPREDICTABLE; therefore private internal usage is
+ *		fine.
  */
 	ORG_CALL_PAL_PRIV(0x0A)
 CallPal_SwpPal:
@@ -624,7 +630,7 @@ CallPal_SwpPal_Cont:
 	mtpr	$31, qemu_tbia		// Flush TLB for new PTBR
 
 	mov	a1, $26
-	mov	a1, $27
+	mov	a4, $27
 	hw_ret	(a1)
 ENDFN	CallPal_SwpPal_Cont
 	.previous
diff --git a/pci.c b/pci.c
index 87a101c..a521e2a 100644
--- a/pci.c
+++ b/pci.c
@@ -29,12 +29,9 @@
 #include "protos.h"
 #include "pci.h"
 #include "pci_regs.h"
+#include SYSTEM_H
 
 
-#define PCI_DEVFN(slot, func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
-#define PCI_BUS(devfn)		((devfn) >> 8)
-#define PCI_SLOT(devfn)		(((devfn) >> 3) & 0x1f)
-#define PCI_FUNC(devfn)		((devfn) & 0x07)
 #define PCI_SLOT_MAX		32
 #define PCI_FUNC_MAX		8
 #define PCI_REGION_ROM		6
@@ -88,7 +85,7 @@ pci_setup_device(int bdf, uint32_t *p_io_base, uint32_t *p_mem_base)
   device_id = pci_config_readw(bdf, PCI_DEVICE_ID);
   class_id = pci_config_readw(bdf, PCI_CLASS_DEVICE);
 
-  printf("PCI: %02x:%02x:%x class %04x id %04x:%04x\r\n",
+  printf("PCI: %d:%d:%d class %04x id %04x:%04x\r\n",
 	 PCI_BUS(bdf), PCI_SLOT(bdf), PCI_FUNC(bdf),
          class_id, vendor_id, device_id);
 
@@ -122,9 +119,11 @@ pci_setup_device(int bdf, uint32_t *p_io_base, uint32_t *p_mem_base)
 	  *p_base = addr + size;
 	  pci_config_writel(bdf, ofs, addr);
 
-	  printf("PCI:   region %d: %08x\r\n", region, addr);
+	  printf("PCI:   region %d (BAR %02x): %08x\r\n",
+	         region, ofs, addr);
 
-	  if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK)
+	  if ((old & PCI_BASE_ADDRESS_SPACE_IO) == 0 &&
+	      (old & PCI_BASE_ADDRESS_MEM_TYPE_MASK)
 	      == PCI_BASE_ADDRESS_MEM_TYPE_64)
 	    {
 	      pci_config_writel(bdf, ofs + 4, 0);
@@ -135,7 +134,25 @@ pci_setup_device(int bdf, uint32_t *p_io_base, uint32_t *p_mem_base)
 
   pci_config_maskw(bdf, PCI_COMMAND, 0, PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
 
-  /* Map the interrupt.  */
+  /* Map the interrupt and program the IRQ into the line register.
+     Some operating systems rely on the Console providing this information
+     in order to avoid having mapping tables for every possible system
+     variation.  */
+
+  const uint8_t pin = pci_config_readb(bdf, PCI_INTERRUPT_PIN);
+  const uint8_t slot = PCI_SLOT(bdf);
+  const int irq = MAP_PCI_INTERRUPT(slot, pin, class_id);
+
+  if (irq == -1)
+    {
+      /* No interrupt mapping.  */
+      pci_config_writeb(bdf, PCI_INTERRUPT_LINE, 0xff);
+    }
+  else
+    {
+      printf("PCI:   intr pin %d -> irq %d\r\n", pin, irq);
+      pci_config_writeb(bdf, PCI_INTERRUPT_LINE, irq);
+    }
 }
 
 void
diff --git a/pci.h b/pci.h
index b751c6f..b4a4f80 100644
--- a/pci.h
+++ b/pci.h
@@ -60,6 +60,11 @@ extern void pci_config_maskw(int bdf, int addr, uint16_t off, uint16_t on);
 
 extern int pci_next(int bdf, int *pmax);
 
+#define PCI_DEVFN(slot, func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
+#define PCI_BUS(devfn)		((devfn) >> 8)
+#define PCI_SLOT(devfn)		(((devfn) >> 3) & 0x1f)
+#define PCI_FUNC(devfn)		((devfn) & 0x07)
+
 #define foreachpci(BDF, MAX)				\
 	for (MAX = 0x0100, BDF = pci_next(0, &MAX);	\
 	     BDF >= 0;					\
diff --git a/printf.c b/printf.c
index 469b82c..bbc1caa 100644
--- a/printf.c
+++ b/printf.c
@@ -18,10 +18,8 @@
    along with this program; see the file COPYING.  If not see
    <http://www.gnu.org/licenses/>.  */
 
-#include <stdarg.h>
-#include <stdbool.h>
-#include <string.h>
 #include "console.h"
+#include "protos.h"
 
 static int print_buf_pad(char *buf, int buflen, char *p, int width, int pad)
 {
@@ -201,3 +199,10 @@ int printf(const char *fmt, ...)
   va_end(args);
   return r;
 }
+
+int puts(const char *s)
+{
+  int len = strlen(s);
+  crb_puts(0, s, len);
+  return len;
+}
diff --git a/protos.h b/protos.h
index 3ed1381..4c6f4bf 100644
--- a/protos.h
+++ b/protos.h
@@ -21,11 +21,33 @@
 #ifndef PROTOS_H
 #define PROTOS_H 1
 
-#include <stdint.h>
-#include <stdbool.h>
-#include <stddef.h>
-#include <string.h>
+/*
+ * Stand-alone definitions for various types, compatible with
+ * the Alpha Linux ABI and GCC.  This eliminates dependencies
+ * on external headers.
+ */
+typedef unsigned char  uint8_t;
+typedef unsigned short uint16_t;
+typedef unsigned int   uint32_t;
+typedef unsigned long  uint64_t;
+typedef unsigned long  size_t;
+
+#define	bool	_Bool
+#define	true	1
+#define	false	0
+
+#define	offsetof(type, member) __builtin_offsetof(type, member)
+
+typedef __builtin_va_list va_list;
+#define	va_start(ap, last)	__builtin_va_start((ap), (last))
+#define	va_arg			__builtin_va_arg
+#define	va_end(ap)		__builtin_va_end(ap)
+
+#define	NULL	((void *)0)
 
+extern void *memset(void *, int, size_t);
+extern void *memcpy(void *, const void *, size_t);
+extern size_t strlen(const char *);
 
 /*
  * Call_Pal functions.
@@ -202,6 +224,8 @@ extern unsigned long crb_fixup(unsigned long vptptr, unsigned long hwrpb);
  */
 
 extern bool have_vga;
+extern unsigned int pci_vga_bus;
+extern unsigned int pci_vga_dev;
 
 extern void do_console(void);
 extern void entInt(void);
@@ -211,6 +235,7 @@ extern void entInt(void);
  */
 
 extern int printf(const char *, ...);
+extern int puts(const char *);
 extern void ndelay(unsigned long nsec);
 
 static inline void udelay(unsigned long msec)
diff --git a/sys-clipper.h b/sys-clipper.h
index 31094ff..150fe49 100644
--- a/sys-clipper.h
+++ b/sys-clipper.h
@@ -27,4 +27,31 @@
 #define SYS_VARIATION	(5 << 10)
 #define SYS_REVISION	0
 
+#ifndef __ASSEMBLER__
+
+#define MAP_PCI_INTERRUPT(SLOT, PIN, CLASS_ID)				\
+({									\
+  int IRQ;								\
+    									\
+  if (CLASS_ID == 0x0601)						\
+    {									\
+      /* PCI-ISA bridge is hard-wired to IRQ 55 on real hardware,	\
+	 and comes in at a different SCB vector; force the line		\
+         register to -1.  */						\
+      IRQ = -1;								\
+    }									\
+  else if (PIN >= 1 && PIN <= 4)					\
+    {									\
+      /* See hw/alpha/dp264.c:clipper_pci_map_irq()  */			\
+      IRQ = (SLOT + 1) * 4 + (PIN - 1);					\
+    }									\
+  else									\
+    {									\
+      IRQ = -1;								\
+    }									\
+  IRQ;									\
+})
+
+#endif /* ! __ASSEMBLER__ */
+
 #endif
diff --git a/vgaio.c b/vgaio.c
index 2dd7eb7..1fb0d52 100644
--- a/vgaio.c
+++ b/vgaio.c
@@ -570,6 +570,8 @@ vgahw_init(void)
 
  found:
   have_vga = 1;
+  pci_vga_bus = PCI_BUS(bdf);
+  pci_vga_dev = PCI_SLOT(bdf);
 
   vmode_g = find_vga_entry(3);
 
-- 
2.28.0


