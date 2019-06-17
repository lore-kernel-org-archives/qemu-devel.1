Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C720BC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F41208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RF8axvmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F41208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwiF-0002Sk-QJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBd-0005lk-9d
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBb-0002CV-6b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBa-0002AR-Qv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8kdq065855;
 Mon, 17 Jun 2019 18:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=jmY+mxEc9E6wa+00MVvwZiziNDZ83zIQadXW1VBFKCk=;
 b=RF8axvmM+vYVFzZnx2HmFBGsNnaObm4j2j5iBTWw0wwF+n812Jr0eHso3lO2l10b0FET
 MypPsVKc3XcYkj0GgPj/HsihBsf6SZjstJm8TYt/J8czoJnUOYnyEQKPJVDZr66ebk8Q
 RWAFYtJDk7a7rXSKGn+pXIZuMS4LsyP4cQYsZMmVGBNSe03L/jP9bSDcxGl1LAAujEoa
 HA400+rhHmKyqvKaRWjMzKyci4V+waon3bqTrzrVyUGCU5CJx/O5ALyQWQmBWshsaB9m
 7KgZVgmGdSjRUBRKExLPWpVsKp4U30F8UaXeOlQGDtqPDNBF4ojLGn/ZYA4FOPy9MqZm 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIGR6f181417;
 Mon, 17 Jun 2019 18:16:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t5mgbgb8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIGoEY032468;
 Mon, 17 Jun 2019 18:16:50 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:50 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:48 -0700
Message-Id: <20190617181648.30416-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 28/35] multi-process: add processing of
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, kanth.ghatraju@oracle.com
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
 Changes in v2:
 - change command line option for remote process drive/device to
 use existing -drive/-device options.
 - process drive and device options only after non-remote devices
 and drives are added.
---
 vl.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index ff5dfb6fbc..de16dbcbc9 100644
--- a/vl.c
+++ b/vl.c
@@ -30,6 +30,11 @@
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
 #include "sysemu/seccomp.h"
+#include "qapi/qmp/qdict.h"
+#include "block/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
@@ -1156,11 +1161,38 @@ static int cleanup_add_fd(void *opaque, QemuOpts *opts, Error **errp)
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
+    const char *remote;
 
-    return drive_new(opts, *block_default_type, errp) == NULL;
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
 }
 
 static int drive_enable_snapshot(void *opaque, QemuOpts *opts, Error **errp)
@@ -2333,9 +2365,31 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
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
+    const char *remote;
+
+    remote = qemu_opt_get(opts, "remote");
+    if (remote) {
+        /* This will be a remote process */
+        return rdevice_init_func(opaque, opts, errp);
+    }
 
     dev = qdev_device_add(opts, errp);
     if (!dev) {
@@ -4498,6 +4552,15 @@ int main(int argc, char **argv, char **envp)
     /* Check if IGD GFX passthrough. */
     igd_gfx_passthru();
 
+    pass = 1;
+    /*
+     * Parse the list for remote drives here as we launch PCIProxyDev here and
+     * need PCI host initialized. As a TODO: could defer init of PCIProxyDev instead.
+     */
+    if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
+                          &machine_class->block_default_type, &error_fatal)) {
+        exit(0);
+    }
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
@@ -4555,10 +4618,13 @@ int main(int argc, char **argv, char **envp)
     qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
 
+#if defined(CONFIG_MPQEMU)
+    qdev_proxy_fire();
     if (rom_check_and_register_reset() != 0) {
         error_report("rom check and register reset failed");
         exit(1);
     }
+#endif
 
     replay_start();
 
-- 
2.17.1


