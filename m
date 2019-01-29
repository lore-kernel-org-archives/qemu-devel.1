Received: from eggs.gnu.org ([209.51.188.92]:60432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSn-0000Gi-34
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1goTSk-0000SX-Kb
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52038
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1goTSk-0000Hy-Eq
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:30:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDR9GX114446
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:52 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qapcgd5bf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:29:51 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Tue, 29 Jan 2019 13:29:51 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Tue, 29 Jan 2019 08:29:22 -0500
In-Reply-To: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1548768562-20007-16-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 15/15] s390-bios: Support booting from real
 dasd device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Allows guest to boot from a vfio configured real dasd device.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 docs/devel/s390-dasd-ipl.txt | 132 +++++++++++++++++++++++
 pc-bios/s390-ccw/Makefile    |   2 +-
 pc-bios/s390-ccw/dasd-ipl.c  | 249 +++++++++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 +++
 pc-bios/s390-ccw/main.c      |   4 +
 pc-bios/s390-ccw/s390-arch.h |  13 +++
 6 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h

diff --git a/docs/devel/s390-dasd-ipl.txt b/docs/devel/s390-dasd-ipl.txt
new file mode 100644
index 0000000..84ec7b8
--- /dev/null
+++ b/docs/devel/s390-dasd-ipl.txt
@@ -0,0 +1,132 @@
+*****************************
+***** s390 hardware IPL *****
+*****************************
+
+The s390 hardware IPL process consists of the following steps.
+
+1. A READ IPL ccw is constructed in memory location 0x0.
+    This ccw, by definition, reads the IPL1 record which is located on the disk
+    at cylinder 0 track 0 record 1. Note that the chain flag is on in this ccw
+    so when it is complete another ccw will be fetched and executed from memory
+    location 0x08.
+
+2. Execute the Read IPL ccw at 0x00, thereby reading IPL1 data into 0x00.
+    IPL1 data is 24 bytes in length and consists of the following pieces of
+    information: [psw][read ccw][tic ccw]. When the machine executes the Read
+    IPL ccw it read the 24-bytes of IPL1 to be read into memory starting at
+    location 0x0. Then the ccw program at 0x08 which consists of a read
+    ccw and a tic ccw is automatically executed because of the chain flag from
+    the original READ IPL ccw. The read ccw will read the IPL2 data into memory
+    and the TIC (Tranfer In Channel) will transfer control to the channel
+    program contained in the IPL2 data. The TIC channel command is the
+    equivalent of a branch/jump/goto instruction for channel programs.
+    NOTE: The ccws in IPL1 are defined by the architecture to be format 0.
+
+3. Execute IPL2.
+    The TIC ccw instruction at the end of the IPL1 channel program will begin
+    the execution of the IPL2 channel program. IPL2 is stage-2 of the boot
+    process and will contain a larger channel program than IPL1. The point of
+    IPL2 is to find and load either the operating system or a small program that
+    loads the operating system from disk. At the end of this step all or some of
+    the real operating system is loaded into memory and we are ready to hand
+    control over to the guest operating system. At this point the guest
+    operating system is entirely responsible for loading any more data it might
+    need to function. NOTE: The IPL2 channel program might read data into memory
+    location 0 thereby overwriting the IPL1 psw and channel program. This is ok
+    as long as the data placed in location 0 contains a psw whose instruction
+    address points to the guest operating system code to execute at the end of
+    the IPL/boot process.
+    NOTE: The ccws in IPL2 are defined by the architecture to be format 0.
+
+4. Start executing the guest operating system.
+    The psw that was loaded into memory location 0 as part of the ipl process
+    should contain the needed flags for the operating system we have loaded. The
+    psw's instruction address will point to the location in memory where we want
+    to start executing the operating system. This psw is loaded (via LPSW
+    instruction) causing control to be passed to the operating system code.
+
+In a non-virtualized environment this process, handled entirely by the hardware,
+is kicked off by the user initiating a "Load" procedure from the hardware
+management console. This "Load" procedure crafts a special "Read IPL" ccw in
+memory location 0x0 that reads IPL1. It then executes this ccw thereby kicking
+off the reading of IPL1 data. Since the channel program from IPL1 will be
+written immediately after the special "Read IPL" ccw, the IPL1 channel program
+will be executed immediately (the special read ccw has the chaining bit turned
+on). The TIC at the end of the IPL1 channel program will cause the IPL2 channel
+program to be executed automatically. After this sequence completes the "Load"
+procedure then loads the psw from 0x0.
+
+*****************************************
+***** How this all pertains to Qemu *****
+*****************************************
+
+In theory we should merely have to do the following to IPL/boot a guest
+operating system from a DASD device:
+
+1. Place a "Read IPL" ccw into memory location 0x0 with chaining bit on.
+2. Execute channel program at 0x0.
+3. LPSW 0x0.
+
+However, our emulation of the machine's channel program logic is missing one key
+feature that is required for this process to work: non-prefetch of ccw data.
+
+When we start a channel program we pass the channel subsystem parameters via an
+ORB (Operation Request Block). One of those parameters is a prefetch bit. If the
+bit is on then Qemu is allowed to read the entire channel program from guest
+memory before it starts executing it. This means that any channel commands that
+read additional channel commands will not work as expected because the newly
+read commands will only exist in guest memory and NOT within Qemu's channel
+subsystem memory. Qemu's channel subsystem's implementation currently requires
+this bit to be on for all channel programs. This is a problem because the IPL
+process consists of transferring control from the "Read IPL" ccw immediately to
+the IPL1 channel program that was read by "Read IPL".
+
+Not being able to turn off prefetch will also prevent the TIC at the end of the
+IPL1 channel program from transferring control to the IPL2 channel program.
+
+Lastly, in some cases (the zipl bootloader for example) the IPL2 program also
+tansfers control to another channel program segment immediately after reading it
+from the disk. So we need to be able to handle this case.
+
+**************************
+***** What Qemu does *****
+**************************
+
+Since we are forced to live with prefetch we cannot use the very simple IPL
+procedure we defined in the preceding section. So we compensate by doing the
+following.
+
+1. Place "Read IPL" ccw into memory location 0x0, but turn off chaining bit.
+2. Execute "Read IPL" at 0x0.
+
+   So now IPL1's psw is at 0x0 and IPL1's channel program is at 0x08.
+
+4. Write a custom channel program that will seek to the IPL2 record and then
+   execute the READ and TIC ccws from IPL1.  Normamly the seek is not required
+   because after reading the IPL1 record the disk is automatically positioned
+   to read the very next record which will be IPL2. But since we are not reading
+   both IPL1 and IPL2 as part of the same channel program we must manually set
+   the position.
+
+5. Grab the target address of the TIC instruction from the IPL1 channel program.
+   This address is where the IPL2 channel program starts.
+
+   Now IPL2 is loaded into memory somewhere, and we know the address.
+
+6. Execute the IPL2 channel program at the address obtained in step #5.
+
+   Because this channel program can be dynamic, we must use a special algorithm
+   that detects a READ immediately followed by a TIC and breaks the ccw chain
+   by turning off the chain bit in the READ ccw. When control is returned from
+   the kernel/hardware to the Qemu bios code we immediately issue another start
+   subchannel to execute the remaining TIC instruction. This causes the entire
+   channel program (starting from the TIC) and all needed data to be refetched
+   thereby stepping around the limitation that would otherwise prevent this
+   channel program from executing properly.
+
+   Now the operating system code is loaded somewhere in guest memory and the psw
+   in memory location 0x0 will point to entry code for the guest operating
+   system.
+
+7. LPSW 0x0.
+   LPSW transfers control to the guest operating system and we're done.
diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 12ad9c1..a048b6b 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -10,7 +10,7 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 .PHONY : all clean build-all
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o
+	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
 
 QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
 QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
diff --git a/pc-bios/s390-ccw/dasd-ipl.c b/pc-bios/s390-ccw/dasd-ipl.c
new file mode 100644
index 0000000..b7ce6d9
--- /dev/null
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -0,0 +1,249 @@
+/*
+ * S390 IPL (boot) from a real DASD device via vfio framework.
+ *
+ * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "libc.h"
+#include "s390-ccw.h"
+#include "s390-arch.h"
+#include "dasd-ipl.h"
+
+static char prefix_page[PAGE_SIZE * 2]
+            __attribute__((__aligned__(PAGE_SIZE * 2)));
+
+static void enable_prefixing(void)
+{
+    memcpy(&prefix_page, (void *)0, 4096);
+    set_prefix(ptr2u32(&prefix_page));
+}
+
+static void disable_prefixing(void)
+{
+    set_prefix(0);
+    /* Copy io interrupt info back to low core */
+    memcpy((void *)0xB8, prefix_page + 0xB8, 12);
+}
+
+static bool is_read_tic_ccw_chain(Ccw0 *ccw)
+{
+    Ccw0 *next_ccw = ccw + 1;
+
+    return ((ccw->cmd_code == CCW_CMD_DASD_READ ||
+            ccw->cmd_code == CCW_CMD_DASD_READ_MT) &&
+            ccw->chain && next_ccw->cmd_code == CCW_CMD_TIC);
+}
+
+static bool dynamic_cp_fixup(uint32_t ccw_addr, uint32_t  *next_cpa)
+{
+    Ccw0 *cur_ccw = (Ccw0 *)(uint64_t)ccw_addr;
+    Ccw0 *tic_ccw;
+
+    while (true) {
+        /* Skip over inline TIC (it might not have the chain bit on)  */
+        if (cur_ccw->cmd_code == CCW_CMD_TIC &&
+            cur_ccw->cda == ptr2u32(cur_ccw) - 8) {
+            cur_ccw += 1;
+            continue;
+        }
+
+        if (!cur_ccw->chain) {
+            break;
+        }
+        if (is_read_tic_ccw_chain(cur_ccw)) {
+            /*
+             * Breaking a chain of CCWs may alter the semantics or even the
+             * validity of a channel program. The heuristic implemented below
+             * seems to work well in practice for the channel programs
+             * generated by zipl.
+             */
+            tic_ccw = cur_ccw + 1;
+            *next_cpa = tic_ccw->cda;
+            cur_ccw->chain = 0;
+            return true;
+        }
+        cur_ccw += 1;
+    }
+    return false;
+}
+
+static int run_dynamic_ccw_program(SubChannelId schid, uint32_t cpa)
+{
+    bool has_next;
+    uint32_t next_cpa = 0;
+    int rc;
+
+    do {
+        has_next = dynamic_cp_fixup(cpa, &next_cpa);
+
+        print_int("executing ccw chain at ", cpa);
+        enable_prefixing();
+        rc = do_cio(schid, cpa, CCW_FMT0);
+        disable_prefixing();
+
+        if (rc) {
+            break;
+        }
+        cpa = next_cpa;
+    } while (has_next);
+
+    return rc;
+}
+
+
+static void make_readipl(void)
+{
+    Ccw0 *ccwIplRead = (Ccw0 *)0x00;
+
+    /* Create Read IPL ccw at address 0 */
+    ccwIplRead->cmd_code = CCW_CMD_READ_IPL;
+    ccwIplRead->cda = 0x00; /* Read into address 0x00 in main memory */
+    ccwIplRead->chain = 0; /* Chain flag */
+    ccwIplRead->count = 0x18; /* Read 0x18 bytes of data */
+}
+
+static void run_readipl(SubChannelId schid)
+{
+    if (do_cio(schid, 0x00, CCW_FMT0)) {
+        panic("dasd-ipl: Failed to run Read IPL channel program");
+    }
+}
+
+/*
+ * The architecture states that IPL1 data should consist of a psw followed by
+ * format-0 READ and TIC CCWs. Let's sanity check.
+ */
+static void check_ipl1(void)
+{
+    Ccw0 *ccwread = (Ccw0 *)0x08;
+    Ccw0 *ccwtic = (Ccw0 *)0x10;
+
+    if (ccwread->cmd_code != CCW_CMD_DASD_READ ||
+        ccwtic->cmd_code != CCW_CMD_TIC) {
+        panic("dasd-ipl: IPL1 data invalid. Is this disk really bootable?\n");
+    }
+}
+
+static void check_ipl2(uint32_t ipl2_addr)
+{
+    Ccw0 *ccw = u32toptr(ipl2_addr);
+
+    if (ipl2_addr == 0x00) {
+        panic("IPL2 address invalid. Is this disk really bootable?\n");
+    }
+    if (ccw->cmd_code == 0x00) {
+        panic("IPL2 ccw data invalid. Is this disk really bootable?\n");
+    }
+}
+
+static uint32_t read_ipl2_addr(void)
+{
+    Ccw0 *ccwtic = (Ccw0 *)0x10;
+
+    return ccwtic->cda;
+}
+
+static void ipl1_fixup(void)
+{
+    Ccw0 *ccwSeek = (Ccw0 *) 0x08;
+    Ccw0 *ccwSearchID = (Ccw0 *) 0x10;
+    Ccw0 *ccwSearchTic = (Ccw0 *) 0x18;
+    Ccw0 *ccwRead = (Ccw0 *) 0x20;
+    CcwSeekData *seekData = (CcwSeekData *) 0x30;
+    CcwSearchIdData *searchData = (CcwSearchIdData *) 0x38;
+
+    /* move IPL1 CCWs to make room for CCWs needed to locate record 2 */
+    memcpy(ccwRead, (void *)0x08, 16);
+
+    /* Disable chaining so we don't TIC to IPL2 channel program */
+    ccwRead->chain = 0x00;
+
+    ccwSeek->cmd_code = CCW_CMD_DASD_SEEK;
+    ccwSeek->cda = ptr2u32(seekData);
+    ccwSeek->chain = 1;
+    ccwSeek->count = sizeof(seekData);
+    seekData->reserved = 0x00;
+    seekData->cyl = 0x00;
+    seekData->head = 0x00;
+
+    ccwSearchID->cmd_code = CCW_CMD_DASD_SEARCH_ID_EQ;
+    ccwSearchID->cda = ptr2u32(searchData);
+    ccwSearchID->chain = 1;
+    ccwSearchID->count = sizeof(searchData);
+    searchData->cyl = 0;
+    searchData->head = 0;
+    searchData->record = 2;
+
+    /* Go back to Search CCW if correct record not yet found */
+    ccwSearchTic->cmd_code = CCW_CMD_TIC;
+    ccwSearchTic->cda = ptr2u32(ccwSearchID);
+}
+
+static void run_ipl1(SubChannelId schid)
+ {
+    uint32_t startAddr = 0x08;
+
+    if (do_cio(schid, startAddr, CCW_FMT0)) {
+        panic("dasd-ipl: Failed to run IPL1 channel program");
+    }
+}
+
+static void run_ipl2(SubChannelId schid, uint32_t addr)
+{
+
+    if (run_dynamic_ccw_program(schid, addr)) {
+        panic("dasd-ipl: Failed to run IPL2 channel program");
+    }
+}
+
+static void lpsw(void *psw_addr)
+{
+    PSWLegacy *pswl = (PSWLegacy *) psw_addr;
+
+    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
+    pswl->addr |= PSW_MASK_BAMODE;
+    asm volatile("  llgtr 0,0\n llgtr 1,1\n"     /* Some OS's expect to be */
+                 "  llgtr 2,2\n llgtr 3,3\n"     /* in 32-bit mode. Clear  */
+                 "  llgtr 4,4\n llgtr 5,5\n"     /* high part of regs to   */
+                 "  llgtr 6,6\n llgtr 7,7\n"     /* avoid messing up       */
+                 "  llgtr 8,8\n llgtr 9,9\n"     /* instructions that work */
+                 "  llgtr 10,10\n llgtr 11,11\n" /* in both addressing     */
+                 "  llgtr 12,12\n llgtr 13,13\n" /* modes, like servc.     */
+                 "  llgtr 14,14\n llgtr 15,15\n"
+                 "  lpsw %0\n"
+                 : : "Q" (*pswl) : "cc");
+}
+
+/*
+ * Limitations in QEMU's CCW support complicate the IPL process. Details can
+ * be found in docs/devel/s390-dasd-ipl.txt
+ */
+void dasd_ipl(SubChannelId schid)
+{
+    uint32_t ipl2_addr;
+
+    /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
+    make_readipl();
+    run_readipl(schid);
+    ipl2_addr = read_ipl2_addr();
+    check_ipl1();
+
+    /*
+     * Fixup IPL1 channel program to account for QEMU limitations, then run it
+     * to read IPL2 channel program from boot disk.
+     */
+    ipl1_fixup();
+    run_ipl1(schid);
+    check_ipl2(ipl2_addr);
+
+    /*
+     * Run IPL2 channel program to read operating system code from boot disk
+     * then transfer control to the guest operating system
+     */
+    run_ipl2(schid, ipl2_addr);
+    lpsw(0);
+}
diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
new file mode 100644
index 0000000..56bba82
--- /dev/null
+++ b/pc-bios/s390-ccw/dasd-ipl.h
@@ -0,0 +1,16 @@
+/*
+ * S390 IPL (boot) from a real DASD device via vfio framework.
+ *
+ * Copyright (c) 2018 Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef DASD_IPL_H
+#define DASD_IPL_H
+
+void dasd_ipl(SubChannelId schid);
+
+#endif /* DASD_IPL_H */
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 5ee02c3..0a46339 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -13,6 +13,7 @@
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
+#include "dasd-ipl.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
@@ -210,6 +211,9 @@ int main(void)
 
     cutype = cu_type(blk_schid) ;
     switch (cutype) {
+    case CU_TYPE_DASD_3990:
+        dasd_ipl(blk_schid); /* no return */
+        break;
     case CU_TYPE_VIRTIO:
         virtio_setup();
         zipl_load(); /* no return */
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
index 47eaa04..0438d42 100644
--- a/pc-bios/s390-ccw/s390-arch.h
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -97,4 +97,17 @@ typedef struct LowCore {
 
 extern const LowCore *lowcore;
 
+static inline void set_prefix(uint32_t address)
+{
+    asm volatile("spx %0" : : "m" (address) : "memory");
+}
+
+static inline uint32_t store_prefix(void)
+{
+    uint32_t address;
+
+    asm volatile("stpx %0" : "=m" (address));
+    return address;
+}
+
 #endif
-- 
2.7.4
