Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E39C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7D520652
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7D520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeUY-0003qs-Aa
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:32:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKN-0003dF-8J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKI-0003w4-EA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeKI-0003vV-36; Thu, 25 Apr 2019 09:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57DF8307CDD5;
	Thu, 25 Apr 2019 13:22:09 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B08505D9C5;
	Thu, 25 Apr 2019 13:22:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:30 +0200
Message-Id: <20190425132134.2839-16-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 25 Apr 2019 13:22:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 15/19] s390-bios: Support booting from real dasd
 device
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132130.n3LjoRWHlfBAChahM9amgYCGD4X68yhQZHLnsOJQPfk@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Allows guest to boot from a vfio configured real dasd device.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1554388475-18329-16-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                  |   1 +
 docs/devel/s390-dasd-ipl.txt | 133 ++++++++++++++++++++
 pc-bios/s390-ccw/Makefile    |   2 +-
 pc-bios/s390-ccw/dasd-ipl.c  | 235 +++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 +++
 pc-bios/s390-ccw/main.c      |   5 +
 pc-bios/s390-ccw/s390-arch.h |  13 ++
 7 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f7976aa43d0a..be53b7d3b703 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1181,6 +1181,7 @@ S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
+F: docs/devel/s390-dasd-ipl.txt
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
diff --git a/docs/devel/s390-dasd-ipl.txt b/docs/devel/s390-dasd-ipl.txt
new file mode 100644
index 000000000000..9107e048e4e6
--- /dev/null
+++ b/docs/devel/s390-dasd-ipl.txt
@@ -0,0 +1,133 @@
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
+    and the TIC (Transfer In Channel) will transfer control to the channel
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
+**********************************************************
+***** How this all pertains to QEMU (and the kernel) *****
+**********************************************************
+
+In theory we should merely have to do the following to IPL/boot a guest
+operating system from a DASD device:
+
+1. Place a "Read IPL" ccw into memory location 0x0 with chaining bit on.
+2. Execute channel program at 0x0.
+3. LPSW 0x0.
+
+However, our emulation of the machine's channel program logic within the kernel
+is missing one key feature that is required for this process to work:
+non-prefetch of ccw data.
+
+When we start a channel program we pass the channel subsystem parameters via an
+ORB (Operation Request Block). One of those parameters is a prefetch bit. If the
+bit is on then the vfio-ccw kernel driver is allowed to read the entire channel
+program from guest memory before it starts executing it. This means that any
+channel commands that read additional channel commands will not work as expected
+because the newly read commands will only exist in guest memory and NOT within
+the kernel's channel subsystem memory. The kernel vfio-ccw driver currently
+requires this bit to be on for all channel programs. This is a problem because
+the IPL process consists of transferring control from the "Read IPL" ccw
+immediately to the IPL1 channel program that was read by "Read IPL".
+
+Not being able to turn off prefetch will also prevent the TIC at the end of the
+IPL1 channel program from transferring control to the IPL2 channel program.
+
+Lastly, in some cases (the zipl bootloader for example) the IPL2 program also
+transfers control to another channel program segment immediately after reading
+it from the disk. So we need to be able to handle this case.
+
+**************************
+***** What QEMU does *****
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
+   execute the READ and TIC ccws from IPL1.  Normally the seek is not required
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
+   the kernel/hardware to the QEMU bios code we immediately issue another start
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
index 12ad9c1d5813..a048b6b077a9 100644
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
index 000000000000..0fc879bb8e8f
--- /dev/null
+++ b/pc-bios/s390-ccw/dasd-ipl.c
@@ -0,0 +1,235 @@
+/*
+ * S390 IPL (boot) from a real DASD device via vfio framework.
+ *
+ * Copyright (c) 2019 Jason J. Herne <jjherne@us.ibm.com>
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
+#include "helper.h"
+
+static char prefix_page[PAGE_SIZE * 2]
+            __attribute__((__aligned__(PAGE_SIZE * 2)));
+
+static void enable_prefixing(void)
+{
+    memcpy(&prefix_page, lowcore, 4096);
+    set_prefix(ptr2u32(&prefix_page));
+}
+
+static void disable_prefixing(void)
+{
+    set_prefix(0);
+    /* Copy io interrupt info back to low core */
+    memcpy((void *)&lowcore->subchannel_id, prefix_page + 0xB8, 12);
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
+static int run_dynamic_ccw_program(SubChannelId schid, uint16_t cutype,
+                                   uint32_t cpa)
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
+        rc = do_cio(schid, cutype, cpa, CCW_FMT0);
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
+static void run_readipl(SubChannelId schid, uint16_t cutype)
+{
+    if (do_cio(schid, cutype, 0x00, CCW_FMT0)) {
+        panic("dasd-ipl: Failed to run Read IPL channel program\n");
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
+    ccwSeek->count = sizeof(*seekData);
+    seekData->reserved = 0x00;
+    seekData->cyl = 0x00;
+    seekData->head = 0x00;
+
+    ccwSearchID->cmd_code = CCW_CMD_DASD_SEARCH_ID_EQ;
+    ccwSearchID->cda = ptr2u32(searchData);
+    ccwSearchID->chain = 1;
+    ccwSearchID->count = sizeof(*searchData);
+    searchData->cyl = 0;
+    searchData->head = 0;
+    searchData->record = 2;
+
+    /* Go back to Search CCW if correct record not yet found */
+    ccwSearchTic->cmd_code = CCW_CMD_TIC;
+    ccwSearchTic->cda = ptr2u32(ccwSearchID);
+}
+
+static void run_ipl1(SubChannelId schid, uint16_t cutype)
+ {
+    uint32_t startAddr = 0x08;
+
+    if (do_cio(schid, cutype, startAddr, CCW_FMT0)) {
+        panic("dasd-ipl: Failed to run IPL1 channel program\n");
+    }
+}
+
+static void run_ipl2(SubChannelId schid, uint16_t cutype, uint32_t addr)
+{
+    if (run_dynamic_ccw_program(schid, cutype, addr)) {
+        panic("dasd-ipl: Failed to run IPL2 channel program\n");
+    }
+}
+
+/*
+ * Limitations in vfio-ccw support complicate the IPL process. Details can
+ * be found in docs/devel/s390-dasd-ipl.txt
+ */
+void dasd_ipl(SubChannelId schid, uint16_t cutype)
+{
+    PSWLegacy *pswl = (PSWLegacy *) 0x00;
+    uint32_t ipl2_addr;
+
+    /* Construct Read IPL CCW and run it to read IPL1 from boot disk */
+    make_readipl();
+    run_readipl(schid, cutype);
+    ipl2_addr = read_ipl2_addr();
+    check_ipl1();
+
+    /*
+     * Fixup IPL1 channel program to account for vfio-ccw limitations, then run
+     * it to read IPL2 channel program from boot disk.
+     */
+    ipl1_fixup();
+    run_ipl1(schid, cutype);
+    check_ipl2(ipl2_addr);
+
+    /*
+     * Run IPL2 channel program to read operating system code from boot disk
+     */
+    run_ipl2(schid, cutype, ipl2_addr);
+
+    /* Transfer control to the guest operating system */
+    pswl->mask |= PSW_MASK_EAMODE;   /* Force z-mode */
+    pswl->addr |= PSW_MASK_BAMODE;   /* ...          */
+    jump_to_low_kernel();
+}
diff --git a/pc-bios/s390-ccw/dasd-ipl.h b/pc-bios/s390-ccw/dasd-ipl.h
new file mode 100644
index 000000000000..c3948289062c
--- /dev/null
+++ b/pc-bios/s390-ccw/dasd-ipl.h
@@ -0,0 +1,16 @@
+/*
+ * S390 IPL (boot) from a real DASD device via vfio framework.
+ *
+ * Copyright (c) 2019 Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef DASD_IPL_H
+#define DASD_IPL_H
+
+void dasd_ipl(SubChannelId schid, uint16_t cutype);
+
+#endif /* DASD_IPL_H */
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 57a10138c65d..3c449ad49688 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -13,6 +13,7 @@
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
+#include "dasd-ipl.h"
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
@@ -209,6 +210,10 @@ int main(void)
 
     cutype = cu_type(blk_schid);
     switch (cutype) {
+    case CU_TYPE_DASD_3990:
+    case CU_TYPE_DASD_2107:
+        dasd_ipl(blk_schid, cutype); /* no return */
+        break;
     case CU_TYPE_VIRTIO:
         virtio_setup();
         zipl_load(); /* no return */
diff --git a/pc-bios/s390-ccw/s390-arch.h b/pc-bios/s390-ccw/s390-arch.h
index 5e92c7a27d53..504fc7c2f098 100644
--- a/pc-bios/s390-ccw/s390-arch.h
+++ b/pc-bios/s390-ccw/s390-arch.h
@@ -87,4 +87,17 @@ typedef struct LowCore {
 
 extern LowCore const *lowcore;
 
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
2.17.2


