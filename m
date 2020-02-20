Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990CC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F882467B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e5IOS2bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F882467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jDM-0001KX-9T
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1j4jCI-0000Pu-R8
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1j4jCG-0001vZ-VV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:36:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1j4jCG-0001vF-D4
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:36:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KAWGfG037987;
 Thu, 20 Feb 2020 10:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UuZjHS/EpESdKqI8RIZI+1x0UUfkfaA+OypaiEIkfKE=;
 b=e5IOS2bNjUw7rTo5wBiY1YRUiz8lseGV2C978kasVff4VjkR6umbtJnx7mE/0V+qm3BI
 v+vGGIvKjB8BlH9t8VPd6n9HzsRRSipQ4QyPROkTAMVurXJa5R7PfAwI8O8wccPTRYIo
 Lbwqg+djfnLAND9qa8LUJYHdOyaySOe+Xl1+MLJxN+Xtx+GEpDlsFjzl5sC4/zW71F+M
 XByMSWbOAQrk9UDUcr+5L9vDj8tFNmuP4yR+bkLA2uWbtDvHDxsU1I2w0hw70U/adKTa
 Ww2+oN7twSR34gs8aj2uVWHRJLRjHLAHHb8OzzyB04Llk0BUYVuBU8BIe6Vt7xuC6AFV hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2y8ud18v8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 10:36:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KARo9E094517;
 Thu, 20 Feb 2020 10:34:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2y8ud3ecvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 10:34:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KAYefu031875;
 Thu, 20 Feb 2020 10:34:41 GMT
Received: from starbug-mbp.localdomain (/10.169.111.17)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Feb 2020 02:34:40 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 2400D59EB3ED;
 Thu, 20 Feb 2020 10:34:38 +0000 (GMT)
Date: Thu, 20 Feb 2020 10:34:38 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v10 15/22] fuzz: support for fork-based fuzzing.
Message-ID: <20200220103438.3kjy7jchmnjvsop5@starbug-mbp>
Mail-Followup-To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 bsd@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20200220041118.23264-1-alxndr@bu.edu>
 <20200220041118.23264-16-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200220041118.23264-16-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=2 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 suspectscore=2 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200076
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 qemu-devel@nongnu.org, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 11:11:11PM -0500, Alexander Bulekov wrote:
>fork() is a simple way to ensure that state does not leak in between
>fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
>bitmaps which contain coverage information for each fuzzing run, and
>these bitmaps should be copied from the child to the parent(where the
>mutation occurs). These bitmaps are created through compile-time
>instrumentation and they are not shared with fork()-ed processes, by
>default. To address this, we create a shared memory region, adjust its
>size and map it _over_ the counter region. Furthermore, libfuzzer
>doesn't generally expose the globals that specify the location of the
>counters/coverage bitmap. As a workaround, we rely on a custom linker
>script which forces all of the bitmaps we care about to be placed in a
>contiguous region, which is easy to locate and mmap over.
>
>Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> tests/qtest/fuzz/Makefile.include |  5 +++
> tests/qtest/fuzz/fork_fuzz.c      | 55 +++++++++++++++++++++++++++++++
> tests/qtest/fuzz/fork_fuzz.h      | 23 +++++++++++++
> tests/qtest/fuzz/fork_fuzz.ld     | 37 +++++++++++++++++++++
> 4 files changed, 120 insertions(+)
> create mode 100644 tests/qtest/fuzz/fork_fuzz.c
> create mode 100644 tests/qtest/fuzz/fork_fuzz.h
> create mode 100644 tests/qtest/fuzz/fork_fuzz.ld
>
>diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
>index 8632bb89f4..a90915d56d 100644
>--- a/tests/qtest/fuzz/Makefile.include
>+++ b/tests/qtest/fuzz/Makefile.include
>@@ -2,5 +2,10 @@ QEMU_PROG_FUZZ=qemu-fuzz-$(TARGET_NAME)$(EXESUF)
>
> fuzz-obj-y += tests/qtest/libqtest.o
> fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
>+fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
>
> FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
>+
>+# Linker Script to force coverage-counters into known regions which we can mark
>+# shared
>+FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
>diff --git a/tests/qtest/fuzz/fork_fuzz.c b/tests/qtest/fuzz/fork_fuzz.c
>new file mode 100644
>index 0000000000..2bd0851903
>--- /dev/null
>+++ b/tests/qtest/fuzz/fork_fuzz.c
>@@ -0,0 +1,55 @@
>+/*
>+ * Fork-based fuzzing helpers
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ *
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "fork_fuzz.h"
>+
>+
>+void counter_shm_init(void)
>+{
>+    char *shm_path = g_strdup_printf("/qemu-fuzz-cntrs.%d", getpid());
>+    int fd = shm_open(shm_path, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
>+    g_free(shm_path);
>+
>+    if (fd == -1) {
>+        perror("Error: ");
>+        exit(1);
>+    }
>+    if (ftruncate(fd, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START) == -1) {
>+        perror("Error: ");
>+        exit(1);
>+    }
>+    /* Copy what's in the counter region to the shm.. */
>+    void *rptr = mmap(NULL ,
>+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
>+            PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>+    memcpy(rptr,
>+           &__FUZZ_COUNTERS_START,
>+           &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
>+
>+    munmap(rptr, &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START);
>+
>+    /* And map the shm over the counter region */
>+    rptr = mmap(&__FUZZ_COUNTERS_START,
>+            &__FUZZ_COUNTERS_END - &__FUZZ_COUNTERS_START,
>+            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, 0);
>+
>+    close(fd);
>+
>+    if (!rptr) {
>+        perror("Error: ");
>+        exit(1);
>+    }
>+}
>+
>+
>diff --git a/tests/qtest/fuzz/fork_fuzz.h b/tests/qtest/fuzz/fork_fuzz.h
>new file mode 100644
>index 0000000000..9ecb8b58ef
>--- /dev/null
>+++ b/tests/qtest/fuzz/fork_fuzz.h
>@@ -0,0 +1,23 @@
>+/*
>+ * Fork-based fuzzing helpers
>+ *
>+ * Copyright Red Hat Inc., 2019
>+ *
>+ * Authors:
>+ *  Alexander Bulekov   <alxndr@bu.edu>
>+ *
>+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
>+ * See the COPYING file in the top-level directory.
>+ *
>+ */
>+
>+#ifndef FORK_FUZZ_H
>+#define FORK_FUZZ_H
>+
>+extern uint8_t __FUZZ_COUNTERS_START;
>+extern uint8_t __FUZZ_COUNTERS_END;
>+
>+void counter_shm_init(void);
>+
>+#endif
>+
>diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
>new file mode 100644
>index 0000000000..b23a59f194
>--- /dev/null
>+++ b/tests/qtest/fuzz/fork_fuzz.ld
>@@ -0,0 +1,37 @@
>+/* We adjust linker script modification to place all of the stuff that needs to
>+ * persist across fuzzing runs into a contiguous seciton of memory. Then, it is
>+ * easy to re-map the counter-related memory as shared.
>+*/
>+
>+SECTIONS
>+{
>+  .data.fuzz_start : ALIGN(4K)
>+  {
>+      __FUZZ_COUNTERS_START = .;
>+      __start___sancov_cntrs = .;
>+      *(_*sancov_cntrs);
>+      __stop___sancov_cntrs = .;
>+
>+      /* Lowest stack counter */
>+      *(__sancov_lowest_stack);
>+  }
>+  .data.fuzz_ordered :
>+  {
>+      /* Coverage counters. They're not necessary for fuzzing, but are useful
>+       * for analyzing the fuzzing performance
>+       */
>+      __start___llvm_prf_cnts = .;
>+      *(*llvm_prf_cnts);
>+      __stop___llvm_prf_cnts = .;
>+
>+      /* Internal Libfuzzer TracePC object which contains the ValueProfileMap */
>+      FuzzerTracePC*(.bss*);
>+  }
>+  .data.fuzz_end : ALIGN(4K)
>+  {
>+      __FUZZ_COUNTERS_END = .;
>+  }
>+}
>+/* Dont overwrite the SECTIONS in the default linker script. Instead insert the
>+ * above into the default script */
>+INSERT AFTER .data;
>-- 
>2.25.0
>

