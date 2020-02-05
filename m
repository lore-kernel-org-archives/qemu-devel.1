Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B1C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075752072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jXIGV0p9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075752072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKjA-0006vQ-8e
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1izKhq-0005eQ-Aq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1izKho-00037w-Mf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:27:02 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1izKho-000316-DC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:27:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DO2uK105634;
 Wed, 5 Feb 2020 13:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=/LVZim7N6b/mrqTWUC/HKFj/D55qTPQuXQY7Zzfr8Ws=;
 b=jXIGV0p9xJCnhs4rnqX0eAiZRtpfFiHG8tpoicGmNl+zLq26cUteUleat6yp0ivh4mv4
 rgbyMxnz3ySg2Qtxq/9t9pepMH5N6T51F+JK/UHrJrxydnXtU5hwzPo/OVEJd8y/KZ31
 +H0GSZRs/2fXLsQjgMoDPCAeLbcgb+qkV+NDs+/ACIJUvIoXlYxtkyODy7gV6yqbDaU7
 ERv69nGj03rJaw+nSbrJ89wlECe8FdbuyRj6SdK3+iMA84uIlwnQt+i8SrCyGND1D+c3
 MM6hs+Af395chOw4tax9CnFKEnVnS7vnzIGxvidHkDg5HDwTzZfUIBGOBtpPmNY16/Dr 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2xykbp2y0v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:26:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015DICnn087769;
 Wed, 5 Feb 2020 13:26:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2xykc2v56p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2020 13:26:57 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015DQsIx011534;
 Wed, 5 Feb 2020 13:26:54 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 05 Feb 2020 05:26:54 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 2FC5557DBB03;
 Wed,  5 Feb 2020 13:26:51 +0000 (GMT)
Date: Wed, 5 Feb 2020 13:26:50 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 18/21] fuzz: add i440fx fuzz targets
Message-ID: <20200205132650.yajwli5c5a6b7aur@starbug-mbp>
Mail-Followup-To: "Bulekov, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-19-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129053357.27454-19-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050109
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 05:34:26AM +0000, Bulekov, Alexander wrote:
>These three targets should simply fuzz reads/writes to a couple ioports,
>but they mostly serve as examples of different ways to write targets.
>They demonstrate using qtest and qos for fuzzing, as well as using
>rebooting and forking to reset state, or not resetting it at all.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

A couple of nit below w.r.t. commenting on how the fuzzed data is
being processed.

>---
> tests/qtest/fuzz/Makefile.include |   3 +
> tests/qtest/fuzz/i440fx_fuzz.c    | 178 ++++++++++++++++++++++++++++++
> 2 files changed, 181 insertions(+)
> create mode 100644 tests/qtest/fuzz/i440fx_fuzz.c
>
>diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
>index e3bdd33ff4..38b8cdd9f1 100644
>--- a/tests/qtest/fuzz/Makefile.include
>+++ b/tests/qtest/fuzz/Makefile.include
>@@ -6,6 +6,9 @@ fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
> fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
> fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
>
>+# Targets
>+fuzz-obj-y += tests/qtest/fuzz/i440fx_fuzz.o
>+
> FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>
> # Linker Script to force coverage-counters into known regions which we can mark
>diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
>new file mode 100644
>index 0000000000..c7791182b8
>--- /dev/null
>+++ b/tests/qtest/fuzz/i440fx_fuzz.c
>@@ -0,0 +1,178 @@
>+/*
>+ * I440FX Fuzzing Target
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "qemu/main-loop.h"
>+#include "tests/qtest/libqtest.h"
>+#include "tests/qtest/libqos/pci.h"
>+#include "tests/qtest/libqos/pci-pc.h"
>+#include "fuzz.h"
>+#include "fuzz/qos_fuzz.h"
>+#include "fuzz/fork_fuzz.h"
>+
>+
>+#define I440FX_PCI_HOST_BRIDGE_CFG 0xcf8
>+#define I440FX_PCI_HOST_BRIDGE_DATA 0xcfc
>+
>+enum action_id {
>+    WRITEB,
>+    WRITEW,
>+    WRITEL,
>+    READB,
>+    READW,
>+    READL,
>+    ACTION_MAX
>+};
>+

While it eventually becomes clear what is happening in these
functions, it does take several attempts at reading it to understand
what is going on.

For that reason, it might be worth a couple of comments for future
maintainers as to what is going on.

Thanks,

Darren.

>+static void i440fx_fuzz_qtest(QTestState *s,
>+        const unsigned char *Data, size_t Size) {
>+    typedef struct QTestFuzzAction {
>+        uint32_t value;
>+        uint8_t id;
>+        uint8_t addr;
>+    } QTestFuzzAction;
>+    QTestFuzzAction a;
>+
>+    while (Size >= sizeof(a)) {
>+        memcpy(&a, Data, sizeof(a));
>+        uint16_t addr = a.addr % 2 ? I440FX_PCI_HOST_BRIDGE_CFG :
>+                                      I440FX_PCI_HOST_BRIDGE_DATA;
>+        switch (a.id % ACTION_MAX) {
>+        case WRITEB:
>+            qtest_outb(s, addr, (uint8_t)a.value);
>+            break;
>+        case WRITEW:
>+            qtest_outw(s, addr, (uint16_t)a.value);
>+            break;
>+        case WRITEL:
>+            qtest_outl(s, addr, (uint32_t)a.value);
>+            break;
>+        case READB:
>+            qtest_inb(s, addr);
>+            break;
>+        case READW:
>+            qtest_inw(s, addr);
>+            break;
>+        case READL:
>+            qtest_inl(s, addr);
>+            break;
>+        }
>+        Size -= sizeof(a);
>+        Data += sizeof(a);
>+    }
>+    flush_events(s);
>+}
>+
>+static void i440fx_fuzz_qos(QTestState *s,
>+        const unsigned char *Data, size_t Size) {
>+
>+    typedef struct QOSFuzzAction {
>+        uint32_t value;
>+        int devfn;
>+        uint8_t offset;
>+        uint8_t id;
>+    } QOSFuzzAction;
>+
>+    static QPCIBus *bus;
>+    if (!bus) {
>+        bus = qpci_new_pc(s, fuzz_qos_alloc);
>+    }
>+
>+    QOSFuzzAction a;
>+    while (Size >= sizeof(a)) {
>+        memcpy(&a, Data, sizeof(a));
>+        switch (a.id % ACTION_MAX) {
>+        case WRITEB:
>+            bus->config_writeb(bus, a.devfn, a.offset, (uint8_t)a.value);
>+            break;
>+        case WRITEW:
>+            bus->config_writew(bus, a.devfn, a.offset, (uint16_t)a.value);
>+            break;
>+        case WRITEL:
>+            bus->config_writel(bus, a.devfn, a.offset, (uint32_t)a.value);
>+            break;
>+        case READB:
>+            bus->config_readb(bus, a.devfn, a.offset);
>+            break;
>+        case READW:
>+            bus->config_readw(bus, a.devfn, a.offset);
>+            break;
>+        case READL:
>+            bus->config_readl(bus, a.devfn, a.offset);
>+            break;
>+        }
>+        Size -= sizeof(a);
>+        Data += sizeof(a);
>+    }
>+    flush_events(s);
>+}
>+
>+static void i440fx_fuzz_qos_fork(QTestState *s,
>+        const unsigned char *Data, size_t Size) {
>+    if (fork() == 0) {
>+        i440fx_fuzz_qos(s, Data, Size);
>+        _Exit(0);
>+    } else {
>+        wait(NULL);
>+    }
>+}
>+
>+static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
>+                                       "-m 0 -display none";
>+static const char *i440fx_argv(FuzzTarget *t)
>+{
>+    return i440fx_qtest_argv;
>+}
>+
>+static void fork_init(void)
>+{
>+    counter_shm_init();
>+}
>+
>+static void register_pci_fuzz_targets(void)
>+{
>+    /* Uses simple qtest commands and reboots to reset state */
>+    fuzz_add_target(&(FuzzTarget){
>+                .name = "i440fx-qtest-reboot-fuzz",
>+                .description = "Fuzz the i440fx using raw qtest commands and"
>+                               "rebooting after each run",
>+                .get_init_cmdline = i440fx_argv,
>+                .fuzz = i440fx_fuzz_qtest});
>+
>+    /* Uses libqos and forks to prevent state leakage */
>+    fuzz_add_qos_target(&(FuzzTarget){
>+                .name = "i440fx-qos-fork-fuzz",
>+                .description = "Fuzz the i440fx using raw qtest commands and"
>+                               "rebooting after each run",
>+                .pre_vm_init = &fork_init,
>+                .fuzz = i440fx_fuzz_qos_fork,},
>+                "i440FX-pcihost",
>+                &(QOSGraphTestOptions){}
>+                );
>+
>+    /*
>+     * Uses libqos. Doesn't do anything to reset state. Note that if we were to
>+     * reboot after each run, we would also have to redo the qos-related
>+     * initialization (qos_init_path)
>+     */
>+    fuzz_add_qos_target(&(FuzzTarget){
>+                .name = "i440fx-qos-noreset-fuzz",
>+                .description = "Fuzz the i440fx using raw qtest commands and"
>+                               "rebooting after each run",
>+                .fuzz = i440fx_fuzz_qos,},
>+                "i440FX-pcihost",
>+                &(QOSGraphTestOptions){}
>+                );
>+}
>+
>+fuzz_target_init(register_pci_fuzz_targets);
>-- 
>2.23.0
>
>

