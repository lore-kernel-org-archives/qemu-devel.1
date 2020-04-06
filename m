Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D35CC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DAA206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IoW6sL5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DAA206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOUC-0001p4-86
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGu-0002Te-Cu
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGs-0002On-S0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGs-0002O1-IY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369eShA070136;
 Mon, 6 Apr 2020 09:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9VdQsRUWq0Hfr/+CgqCStzC0T+lowcu05EYYWMkJqP8=;
 b=IoW6sL5pbl8IYWar/gf5+TUaWxhUldFbkxnI20I9ixbeIHUPsx5/Oz0dAXWKoUS7TDXV
 1Y5qAzR2KRipvZZFUuIlV9XMiDbDUp8cnyShv28aSoneCW2b9DFW6J/ELqmHru03Hvbt
 IFzIPqMMN/WHsxFEUq+9m7AAA6hR2iYzWu9LRm84p9O0pmEPvfxcJvxEQmFhK3cyIM7b
 65CoNRVtwcMRixyD3RAkxMyrAm1FzX/Q3Gc4rCDD3YFuTb9uz6D5LHpAuP3N+ubKZXt9
 ADtsJ4iDmeTQJnB2ymOxflkHp77Rp2c1NOzLoHUeD1gu+EwYCCRWitrqHr1ACYbyvCdV Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 306j6m5tc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369ch94092251;
 Mon, 6 Apr 2020 09:42:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073spk6gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369gFqj032026;
 Mon, 6 Apr 2020 09:42:15 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:15 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 26/36] multi-process: add parse_cmdline in remote process
Date: Mon,  6 Apr 2020 02:41:16 -0700
Message-Id: <620dba4d6247004dadb2202a58d0d6e2765e417e.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 0369eShA070136
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 MAINTAINERS          |  2 ++
 remote/Makefile.objs |  1 +
 remote/remote-main.c | 20 +++++++++++-
 remote/remote-opts.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 remote/remote-opts.h | 15 +++++++++
 5 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 21fbf9a0f0..2a0fd65f7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2832,6 +2832,8 @@ F: include/hw/proxy/memory-sync.h
 F: hw/proxy/memory-sync.c
 F: include/remote/iohub.h
 F: remote/iohub.c
+F: remote/remote-opts.h
+F: remote/remote-opts.c
=20
 Build and test automation
 -------------------------
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index cbb3065b69..f8d58d09e6 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,4 +1,5 @@
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-opts.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D iohub.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
index d249eba9e8..a0892c05b6 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -24,6 +24,7 @@
 #include "io/mpqemu-link.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
+#include "qemu/cutils.h"
 #include "sysemu/cpus.h"
 #include "qemu-common.h"
 #include "hw/pci/pci.h"
@@ -36,6 +37,7 @@
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
 #include "remote/iohub.h"
+#include "remote-opts.h"
=20
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -262,6 +264,7 @@ finalize_loop:
 int main(int argc, char *argv[])
 {
     Error *err =3D NULL;
+    int fd =3D -1;
=20
     module_call_init(MODULE_INIT_QOM);
=20
@@ -280,13 +283,28 @@ int main(int argc, char *argv[])
=20
     current_machine =3D MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MA=
CHINE)));
=20
+    qemu_add_opts(&qemu_device_opts);
+    qemu_add_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&qemu_legacy_drive_opts);
+    qemu_add_drive_opts(&qemu_common_drive_opts);
+    qemu_add_drive_opts(&qemu_drive_opts);
+    qemu_add_drive_opts(&bdrv_runtime_opts);
+
     mpqemu_link =3D mpqemu_link_create();
     if (!mpqemu_link) {
         printf("Could not create MPQemu link\n");
         return -1;
     }
=20
-    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
+    fd =3D qemu_parse_fd(argv[1]);
+    if (fd =3D=3D -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+
+    parse_cmdline(argc - 2, argv + 2, NULL);
+
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
=20
     mpqemu_link_set_callback(mpqemu_link, process_msg);
=20
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
new file mode 100644
index 0000000000..cb7837bf13
--- /dev/null
+++ b/remote/remote-opts.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/boards.h"
+#include "sysemu/blockdev.h"
+#include "qapi/error.h"
+#include "qemu-options.h"
+#include "qemu-parse.h"
+#include "remote-opts.h"
+
+/*
+ * In remote process, we parse only subset of options. The code
+ * taken from vl.c to re-use in remote command line parser.
+ */
+void parse_cmdline(int argc, char **argv, char **envp)
+{
+    int optind;
+    const char *optarg;
+    MachineClass *mc;
+
+    /* from vl.c */
+    optind =3D 0;
+
+    /* second pass of option parsing */
+
+    for (;;) {
+        if (optind >=3D argc) {
+            break;
+        }
+        if (argv[optind][0] !=3D '-') {
+            loc_set_cmdline(argv, optind, 1);
+            drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
+        } else {
+            const QEMUOption *popt;
+
+            popt =3D lookup_opt(argc, argv, &optarg, &optind);
+            #ifndef REMOTE_PROCESS
+            if (!(popt->arch_mask & arch_type)) {
+                error_report("Option not supported for this target,"
+                             " %x arch_mask, %x arch_type",
+                             popt->arch_mask, arch_type);
+                exit(1);
+            }
+            #endif
+            switch (popt->index) {
+            case QEMU_OPTION_drive:
+                if (drive_def(optarg) =3D=3D NULL) {
+                    fprintf(stderr, "Could not init drive\n");
+                    exit(1);
+                }
+                break;
+            default:
+                break;
+            }
+        }
+    }
+    mc =3D MACHINE_GET_CLASS(current_machine);
+
+    mc->block_default_type =3D IF_IDE;
+    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                          &mc->block_default_type, &error_fatal)) {
+        /* We printed help */
+        exit(0);
+    }
+
+    return;
+}
diff --git a/remote/remote-opts.h b/remote/remote-opts.h
new file mode 100644
index 0000000000..263d428060
--- /dev/null
+++ b/remote/remote-opts.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_OPTS_H
+#define REMOTE_OPTS_H
+
+void parse_cmdline(int argc, char **argv, char **envp);
+
+#endif
+
--=20
2.25.GIT


