Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B8C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C84D2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JOH+7g3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C84D2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1vW-0000SU-Jf
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <darren.kenny@oracle.com>) id 1iS1u1-0007pw-1d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <darren.kenny@oracle.com>) id 1iS1ty-0008MP-Jf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:41:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
 id 1iS1tx-0008Kn-PH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:41:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5GdceV107701;
 Tue, 5 Nov 2019 16:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=PCQG3BHwAXytZr5TcgenZoiR/SrvnwEylj5nNHUg+i0=;
 b=JOH+7g3MnoemTnIlXA97aGrHR7k3oyT4WaMj26liyfY8nL45mGjRCOuW3NnJ1Tm/nlf9
 uLq0MzibCRx4a/F6Z69H7WpKwX7xGYveLKxsjw4WUk2LwnI9bF8PH9Pr2tODTstZKZhV
 2A9LW9hL+wPsQpoUzhd7ZOPsZMoz8OjWGT27GWD1/mGX6aKeMUo18sWmwNgYQEIgMeKs
 7b3hFINoFfQREmgsQ6a+J4Y2kEPkMXy0rnzRwEFkiOMzth8723hgjNoTPJMekf4Hhjih
 xrRRXLiQB07JPYhEWkAdX5DRq5+0pMQ7b63/ZBHmqud3tYVGWWKOD26nizOAMChWWfD4 1g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2w11rpyujw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Nov 2019 16:41:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5GeSpw134751;
 Tue, 5 Nov 2019 16:41:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2w333vh6tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Nov 2019 16:41:49 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA5GfmXK028836;
 Tue, 5 Nov 2019 16:41:48 GMT
Received: from starbug-mbp.localdomain (/10.175.184.49)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 05 Nov 2019 08:41:48 -0800
Received: from starbug-mbp (localhost [127.0.0.1])
 by starbug-mbp.localdomain (Postfix) with SMTP id 9E8954AA6545;
 Tue,  5 Nov 2019 16:41:41 +0000 (GMT)
Date: Tue, 5 Nov 2019 16:41:41 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 01/20] softmmu: split off vl.c:main() into main.c
Message-ID: <20191105164140.gts3ratgxwa4z2jg@starbug-mbp>
Mail-Followup-To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-2-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-2-alxndr@bu.edu>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 02:49:48PM +0000, Oleinik, Alexander wrote:
>From: Alexander Oleinik <alxndr@bu.edu>
>
>A program might rely on functions implemented in vl.c, but implement its
>own main(). By placing main into a separate source file, there are no
>complaints about duplicate main()s when linking against vl.o. For
>example, the virtual-device fuzzer uses a main() provided by libfuzzer,
>and needs to perform some initialization before running the softmmu
>initialization. Now, main simply calls three vl.c functions which
>handle the guest initialization, main loop and cleanup.
>
>Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>---
> Makefile                |  1 +
> Makefile.objs           |  2 ++
> include/sysemu/sysemu.h |  4 ++++
> main.c                  | 52 +++++++++++++++++++++++++++++++++++++++++
> vl.c                    | 36 +++++++---------------------
> 5 files changed, 68 insertions(+), 27 deletions(-)
> create mode 100644 main.c
>
>diff --git a/Makefile b/Makefile
>index 0e994a275d..d2b2ecd3c4 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -474,6 +474,7 @@ $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
> $(SOFTMMU_ALL_RULES): $(io-obj-y)
> $(SOFTMMU_ALL_RULES): config-all-devices.mak
> $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
>+$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
>
> .PHONY: $(TARGET_DIRS_RULES)
> # The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
>diff --git a/Makefile.objs b/Makefile.objs
>index 11ba1a36bd..9ff9b0c6f9 100644
>--- a/Makefile.objs
>+++ b/Makefile.objs
>@@ -86,6 +86,8 @@ common-obj-$(CONFIG_FDT) += device_tree.o
> # qapi
>
> common-obj-y += qapi/
>+
>+softmmu-main-y = main.o
> endif
>
> #######################################################################
>diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>index 44f18eb739..03f9838b81 100644
>--- a/include/sysemu/sysemu.h
>+++ b/include/sysemu/sysemu.h
>@@ -114,6 +114,10 @@ QemuOpts *qemu_get_machine_opts(void);
>
> bool defaults_enabled(void);
>
>+void main_loop(void);
>+void qemu_init(int argc, char **argv, char **envp);
>+void qemu_cleanup(void);
>+
> extern QemuOptsList qemu_legacy_drive_opts;
> extern QemuOptsList qemu_common_drive_opts;
> extern QemuOptsList qemu_drive_opts;
>diff --git a/main.c b/main.c
>new file mode 100644
>index 0000000000..ecd6389424
>--- /dev/null
>+++ b/main.c
>@@ -0,0 +1,52 @@
>+/*
>+ * QEMU System Emulator
>+ *
>+ * Copyright (c) 2003-2008 Fabrice Bellard
>+ *
>+ * Permission is hereby granted, free of charge, to any person obtaining a copy
>+ * of this software and associated documentation files (the "Software"), to deal
>+ * in the Software without restriction, including without limitation the rights
>+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>+ * copies of the Software, and to permit persons to whom the Software is
>+ * furnished to do so, subject to the following conditions:
>+ *
>+ * The above copyright notice and this permission notice shall be included in
>+ * all copies or substantial portions of the Software.
>+ *
>+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>+ * THE SOFTWARE.
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "sysemu/sysemu.h"
>+
>+#ifdef CONFIG_SDL
>+#if defined(__APPLE__) || defined(main)
>+#include <SDL.h>
>+int main(int argc, char **argv)
>+{
>+    return qemu_main(argc, argv, NULL);
>+}
>+#undef main
>+#define main qemu_main

This /looks/ wrong, you're defining a function main(), and then
immediately #undef and #define main again.

Maybe this could be written differently, or add a comment here as to
why you need to do this.

>+#endif
>+#endif /* CONFIG_SDL */
>+
>+#ifdef CONFIG_COCOA
>+#undef main
>+#define main qemu_main
>+#endif /* CONFIG_COCOA */

I don't really know the combinations that might exist, but it looks
like if CONFIG_SDL is not defined, then we're redefining main() to be
qemi_main() - so what main() function will actually be used here?

Thanks,

Darren.

>+
>+int main(int argc, char **argv, char **envp)
>+{
>+    qemu_init(argc, argv, envp);
>+    main_loop();
>+    qemu_cleanup();
>+
>+    return 0;
>+}
>diff --git a/vl.c b/vl.c
>index c389d24b2c..472f09e12a 100644
>--- a/vl.c
>+++ b/vl.c
>@@ -36,25 +36,6 @@
> #include "sysemu/seccomp.h"
> #include "sysemu/tcg.h"
>
>-#ifdef CONFIG_SDL
>-#if defined(__APPLE__) || defined(main)
>-#include <SDL.h>
>-int qemu_main(int argc, char **argv, char **envp);
>-int main(int argc, char **argv)
>-{
>-    return qemu_main(argc, argv, NULL);
>-}
>-#undef main
>-#define main qemu_main
>-#endif
>-#endif /* CONFIG_SDL */
>-
>-#ifdef CONFIG_COCOA
>-#undef main
>-#define main qemu_main
>-#endif /* CONFIG_COCOA */
>-
>-
> #include "qemu/error-report.h"
> #include "qemu/sockets.h"
> #include "sysemu/accel.h"
>@@ -1797,7 +1778,7 @@ static bool main_loop_should_exit(void)
>     return false;
> }
>
>-static void main_loop(void)
>+void main_loop(void)
> {
> #ifdef CONFIG_PROFILER
>     int64_t ti;
>@@ -2824,7 +2805,7 @@ static void user_register_global_props(void)
>                       global_init_func, NULL, NULL);
> }
>
>-int main(int argc, char **argv, char **envp)
>+void qemu_init(int argc, char **argv, char **envp)
> {
>     int i;
>     int snapshot, linux_boot;
>@@ -3404,7 +3385,7 @@ int main(int argc, char **argv, char **envp)
>             case QEMU_OPTION_watchdog:
>                 if (watchdog) {
>                     error_report("only one watchdog option may be given");
>-                    return 1;
>+                    exit(1);
>                 }
>                 watchdog = optarg;
>                 break;
>@@ -4440,7 +4421,7 @@ int main(int argc, char **argv, char **envp)
>     if (vmstate_dump_file) {
>         /* dump and exit */
>         dump_vmstate_json_to_file(vmstate_dump_file);
>-        return 0;
>+        exit(0);
>     }
>
>     if (incoming) {
>@@ -4457,8 +4438,11 @@ int main(int argc, char **argv, char **envp)
>     accel_setup_post(current_machine);
>     os_setup_post();
>
>-    main_loop();
>+    return;
>+}
>
>+void qemu_cleanup(void)
>+{
>     gdbserver_cleanup();
>
>     /*
>@@ -4495,6 +4479,4 @@ int main(int argc, char **argv, char **envp)
>     qemu_chr_cleanup();
>     user_creatable_cleanup();
>     /* TODO: unref root container, check all devices are ok */
>-
>-    return 0;
> }
>-- 
>2.23.0
>
>

