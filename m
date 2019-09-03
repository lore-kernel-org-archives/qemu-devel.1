Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBECAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CF121883
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xy/Vt7gN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CF121883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fr0-0007Z7-At
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa6-0007iJ-5y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fa4-0000Yy-Qo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5Fa4-0000YD-Ik
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXiFf066125;
 Tue, 3 Sep 2019 20:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=gvJSWIvciRUxRYvEzAMzohW12BYBfaOdbJ+gua1g6+4=;
 b=Xy/Vt7gNmbdwpqYboX89tJTi3zdK809NlRq2cx34i1pmQURS0z2vHLktfY5rswSjf95b
 4yZ2RUb+n7OIqoTxiCWkMsM88tfMkC+A9+5GwSvKTC6Gl3nGXHBhGhZTzglW6azX77SI
 k2YmLycElFOi+Af4CJUcTG22cz9ML0NnpfrFJ/tH10S/IXvzd2w1+NTX9dnqoj/ebz71
 2s5X/YpLGwAQphEcqda+iazL3lWMHvmeUZcvzR5JJBg3g7ZLCVLKh2SGWOM9dkA4Ys0E
 YxUtbEX59IFpWVUO1qNXF2Kxh+8TOY+zC/D0U1xh6uzcF09Y9BX1jpiAW+7xnOSTHu08 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2usy4u832a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kc97C025274;
 Tue, 3 Sep 2019 20:39:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2us5pha0gx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:06 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83Kd6EQ023193;
 Tue, 3 Sep 2019 20:39:06 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:05 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:53 -0400
Message-Id: <e99bbf1ad97f1b1c3028d5beda3cd7badbae96b1.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 27/45] multi-process: add processing of
 remote drive and device command line
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add processing of command line options drive and device.
After remote devices are created along with their proxies,
signal the proxies to finish the configuration steps.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v1 -> v2:
   - change command line option for remote process drive/device to
     use existing -drive/-device options
   - process drive and device options only after non-remote devices
     and drives are added

 vl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/vl.c b/vl.c
index b426b32..f7dae56 100644
--- a/vl.c
+++ b/vl.c
@@ -32,6 +32,11 @@
 #include "qemu/uuid.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "qapi/qmp/qdict.h"
+#include "block/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
@@ -1135,11 +1140,43 @@ static int cleanup_add_fd(void *opaque, QemuOpts *opts, Error **errp)
 #define MTD_OPTS ""
 #define SD_OPTS ""
 
+#if defined(CONFIG_MPQEMU)
+static int rdrive_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev = qdev_remote_add(opts, false /* this is drive */, errp);
+    if (!dev) {
+        error_setg(errp, "qdev_remote_add failed for drive.");
+        return -1;
+    }
+    object_unref(OBJECT(dev));
+    return 0;
+}
+#endif
+
+static int pass;
+
 static int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     BlockInterfaceType *block_default_type = opaque;
 
+#if defined(CONFIG_MPQEMU)
+    const char *remote;
+
+    remote = qemu_opt_get(opts, "remote");
+    if (pass && remote) {
+        return rdrive_init_func(opaque, opts, errp);
+    } else {
+        if (!remote && !pass) {
+            drive_new(opts, *block_default_type, errp);
+        }
+    }
+
+    return 0;
+#else
     return drive_new(opts, *block_default_type, errp) == NULL;
+#endif
 }
 
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **errp)
@@ -2184,10 +2221,35 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
     return qdev_device_help(opts);
 }
 
+#if defined(CONFIG_MPQEMU)
+static int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev = qdev_remote_add(opts, true /* this is device */, errp);
+    if (!dev) {
+        error_setg(errp, "qdev_remote_add failed for device.");
+        return -1;
+    }
+    object_unref(OBJECT(dev));
+    return 0;
+}
+#endif
+
 static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     DeviceState *dev;
 
+#if defined(CONFIG_MPQEMU)
+    const char *remote;
+
+    remote = qemu_opt_get(opts, "remote");
+    if (remote) {
+        /* This will be a remote process */
+        return rdevice_init_func(opaque, opts, errp);
+    }
+#endif
+
     dev = qdev_device_add(opts, errp);
     if (!dev) {
         return -1;
@@ -4367,6 +4429,17 @@ int main(int argc, char **argv, char **envp)
     /* Check if IGD GFX passthrough. */
     igd_gfx_passthru();
 
+#if defined(CONFIG_MPQEMU)
+    /*
+     * Parse the list for remote drives here as we launch PCIProxyDev here and
+     * need PCI host initialized. As a TODO: could defer init of PCIProxyDev instead.
+     */
+    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                          &machine_class->block_default_type, &error_fatal)) {
+        exit(0);
+    }
+#endif
+
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
@@ -4424,6 +4497,9 @@ int main(int argc, char **argv, char **envp)
     qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
 
+#if defined(CONFIG_MPQEMU)
+    qdev_proxy_fire();
+#endif
     if (rom_check_and_register_reset() != 0) {
         error_report("rom check and register reset failed");
         exit(1);
-- 
1.8.3.1


