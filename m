Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86551C11D34
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C9120714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4vmrqb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C9120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ErZ-0005EW-CM
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6Ekl-0001S6-VI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6Ekk-0001vq-Eh
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6Ekk-0001vX-BC
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582554633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPKIsCcQthcgEF3vGr1fM/jPzSM0CtjEd4BHQRSKfJ4=;
 b=F4vmrqb+Hhq1HFyDvfXbd87IieD5ZG4yCg7Qy4RdJNG1bIhOmBT/XfFgzmOmPTEoKPNYix
 5XjzoKrDTNuY8Bmvd4DFWYTGqu4NBl+4+8sY4pHb08V/EKveHG5q9EMNGi8Ecry/HE4ZC/
 /+M8ryi41VFD+BSh6kauxOYvG3kP7GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-RJwVTZe1OpCPKLC6K2xmQw-1; Mon, 24 Feb 2020 09:30:30 -0500
X-MC-Unique: RJwVTZe1OpCPKLC6K2xmQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4AE918AB2C2;
 Mon, 24 Feb 2020 14:30:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-134.ams2.redhat.com
 [10.36.117.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1259191835;
 Mon, 24 Feb 2020 14:30:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/20] qemu-storage-daemon: Add barebone tool
Date: Mon, 24 Feb 2020 15:29:49 +0100
Message-Id: <20200224143008.13362-2-kwolf@redhat.com>
In-Reply-To: <20200224143008.13362-1-kwolf@redhat.com>
References: <20200224143008.13362-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 coiby.xu@gmail.com, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a new binary qemu-storage-daemon that doesn't yet do more than
some typical initialisation for tools and parsing the basic command
options --version, --help and --trace.

Even though this doesn't add any options yet that create things (like
--object or --blockdev), already document that we're planning to process
them in the order they are given on the command line rather than trying
(and failing, like vl.c) to resolve dependencies between options
automatically.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 configure             |   2 +-
 qemu-storage-daemon.c | 127 ++++++++++++++++++++++++++++++++++++++++++
 Makefile              |   1 +
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 qemu-storage-daemon.c

diff --git a/configure b/configure
index d57261e3ad..c9ea8cc8fb 100755
--- a/configure
+++ b/configure
@@ -6257,7 +6257,7 @@ tools=3D""
 if test "$want_tools" =3D "yes" ; then
   tools=3D"qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-edid\$(EXESUF) $tools=
"
   if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" ] ; =
then
-    tools=3D"qemu-nbd\$(EXESUF) $tools"
+    tools=3D"qemu-nbd\$(EXESUF) qemu-storage-daemon\$(EXESUF) $tools"
   fi
   if [ "$ivshmem" =3D "yes" ]; then
     tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
new file mode 100644
index 0000000000..fc4aef572b
--- /dev/null
+++ b/qemu-storage-daemon.c
@@ -0,0 +1,127 @@
+/*
+ * QEMU storage daemon
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2019 Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+
+#include <getopt.h>
+
+#include "block/block.h"
+#include "crypto/init.h"
+
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "qemu-version.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+
+#include "trace/control.h"
+
+static void help(void)
+{
+    printf(
+"Usage: %s [options]\n"
+"QEMU storage daemon\n"
+"\n"
+"  -h, --help             display this help and exit\n"
+"  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\n"
+"                         specify tracing options\n"
+"  -V, --version          output version information and exit\n"
+"\n"
+QEMU_HELP_BOTTOM "\n",
+    error_get_progname());
+}
+
+static void process_options(int argc, char *argv[])
+{
+    int c;
+
+    static const struct option long_options[] =3D {
+        {"help", no_argument, NULL, 'h'},
+        {"trace", required_argument, NULL, 'T'},
+        {"version", no_argument, NULL, 'V'},
+        {0, 0, 0, 0}
+    };
+
+    /*
+     * In contrast to the system emulator, options are processed in the or=
der
+     * they are given on the command lines. This means that things must be
+     * defined first before they can be referenced in another option.
+     */
+    while ((c =3D getopt_long(argc, argv, "hT:V", long_options, NULL)) !=
=3D -1) {
+        switch (c) {
+        case '?':
+            exit(EXIT_FAILURE);
+        case 'h':
+            help();
+            exit(EXIT_SUCCESS);
+        case 'T':
+            {
+                char *trace_file =3D trace_opt_parse(optarg);
+                trace_init_file(trace_file);
+                g_free(trace_file);
+                break;
+            }
+        case 'V':
+            printf("qemu-storage-daemon version "
+                   QEMU_FULL_VERSION "\n" QEMU_COPYRIGHT "\n");
+            exit(EXIT_SUCCESS);
+        default:
+            g_assert_not_reached();
+        }
+    }
+    if (optind !=3D argc) {
+        error_report("Unexpected argument: %s", argv[optind]);
+        exit(EXIT_FAILURE);
+    }
+}
+
+int main(int argc, char *argv[])
+{
+#ifdef CONFIG_POSIX
+    signal(SIGPIPE, SIG_IGN);
+#endif
+
+    error_init(argv[0]);
+    qemu_init_exec_dir(argv[0]);
+
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_TRACE);
+    qemu_add_opts(&qemu_trace_opts);
+    qcrypto_init(&error_fatal);
+    bdrv_init();
+
+    if (!trace_init_backends()) {
+        return EXIT_FAILURE;
+    }
+    qemu_set_log(LOG_TRACE);
+
+    qemu_init_main_loop(&error_fatal);
+    process_options(argc, argv);
+
+    return EXIT_SUCCESS;
+}
diff --git a/Makefile b/Makefile
index 146a91bc3e..44b3c8a342 100644
--- a/Makefile
+++ b/Makefile
@@ -573,6 +573,7 @@ qemu-img.o: qemu-img-cmds.h
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) =
$(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-storage-daemon$(EXESUF): qemu-storage-daemon.o $(authz-obj-y) $(block=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
=20
--=20
2.20.1


