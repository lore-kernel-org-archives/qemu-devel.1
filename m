Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACDC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4539020732
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYcAsqq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4539020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LAi-0006rP-AA
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kma-0007Ha-7K
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmY-0003fE-Qz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmY-0003eT-Hz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrT3S032113;
 Mon, 24 Feb 2020 20:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=ZAut839gnnTM2391uTPPAt9hp4FxiFqDIO14yAEQRKI=;
 b=GYcAsqq9Hal8X4/PFytk955Co0882VnunpCDzc4G1wQwJtSBvep7etlMvW3GBrAHNkd6
 5poH3rBmmMZtcyis1xbbSwmmUvH7M8tKbpjDxzOVDql9Jyogbkb33w+acBcPXCmqD0MQ
 FHJBkCZ0MdYzJWOb/ui4xRKRYHU4zFW85GjXrjKtxtCQ+N8LloLcMLiUretUcfskHomv
 GcZqCj1tpZsEHg1Xp2gtAzUmiALXD+gpO/L4bSKjKZEAFqqkF0Ofkw1HwyVz8xtEJS2r
 mKCx1dIJDH0yizJYdUGLHt9OYEVmPqYsvpHUDOrXRH/vN2IyB658WniJySqCxQJDwVND Rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2yauqua0nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq8LT089105;
 Mon, 24 Feb 2020 20:56:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yby5dmchq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKufMJ028696;
 Mon, 24 Feb 2020 20:56:41 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:41 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 29/50] multi-process: add parse_cmdline in remote process
Date: Mon, 24 Feb 2020 15:55:20 -0500
Message-Id: <713dcf76224660af4a5766d6ebdd5b478cd4fec7.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 01OKrT3S032113
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
 remote/Makefile.objs |  1 +
 remote/remote-main.c | 11 ++++++
 remote/remote-opts.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 remote/remote-opts.h | 15 ++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 remote/remote-opts.c
 create mode 100644 remote/remote-opts.h

diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index c1349ad..a677fce 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,4 +1,5 @@
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-opts.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D iohub.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
index ec1ce2c..872ff7e 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -52,6 +52,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qemu/log.h"
 #include "qemu/cutils.h"
+#include "remote-opts.h"
=20
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -429,6 +430,13 @@ int main(int argc, char *argv[])
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
@@ -442,6 +450,9 @@ int main(int argc, char *argv[])
     }
=20
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
+
+    parse_cmdline(argc - 2, argv + 2, NULL);
+
     mpqemu_link_set_callback(mpqemu_link, process_msg);
=20
     mpqemu_start_coms(mpqemu_link);
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
new file mode 100644
index 0000000..7e12700
--- /dev/null
+++ b/remote/remote-opts.c
@@ -0,0 +1,99 @@
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
+#include <stdio.h>
+#include <unistd.h>
+
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu-common.h"
+
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "hw/boards.h"
+#include "hw/qdev-core.h"
+#include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/mpqemu-link.h"
+#include "qapi/error.h"
+#include "qemu-options.h"
+#include "sysemu/arch_init.h"
+
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qobject.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
+#include "block/block.h"
+#include "remote/remote-opts.h"
+#include "include/qemu-common.h"
+
+#include "vl.h"
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
+                error_report("Option not supported for this target, %x a=
rch_mask, %x arch_type",
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
index 0000000..263d428
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
1.8.3.1


