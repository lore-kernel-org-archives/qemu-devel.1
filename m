Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF21C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0561C21556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z/Ch88wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0561C21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L53-0006RV-4z
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmV-00075i-93
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmU-0003Zb-2V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmT-0003XD-Pm
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKraCW164147;
 Mon, 24 Feb 2020 20:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=J8Xaz+gGxdaFRzPsqSOpPdy1ej1AcSmDgOKijRk3X8A=;
 b=Z/Ch88wTpt7hsotSbrTcWr1BnXETGUk2xpAgRC0DJbzk9hpfFGOkBarZphL426zkNN6p
 fyaVB1TdLgixuasWLupPgimSQ8K0YbltABMbYe4m4q5QlN7wLLRcU00XnwoLc/QZ24Ak
 7JEEMerzqBrGZ/YZVWEH2ytN3h9IGYrCgmLAylsfHzggMs4Z/GRgSdVhK3qnH1TkU4QH
 t3BjRCGnsXRzE3fqMA4tkCFPYgtB74D8n/lptAqSy2UsFWflofe5LcD7kswgLQLFUgy0
 KKwJFdVo0Vni0osRaotaOwkttiFIvlZxU5nIdmyQ+qP9XtQBpsO4iXcI+sJT4x1nK7P5 /Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p96g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKud0W073024;
 Mon, 24 Feb 2020 20:56:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2ybduv6d8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuX0j009417;
 Mon, 24 Feb 2020 20:56:33 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:33 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 24/50] multi-process: add processing of remote device
 command line
Date: Mon, 24 Feb 2020 15:55:15 -0500
Message-Id: <48965605c3f49f453b4b4f107bb8c7171eec2af9.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
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

Add processing of command line options for devices emulated
in the remote process.
After remote devices are created along with their proxies,
signal the proxies to finish the configuration steps.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 softmmu/vl.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 94a7b93..79a286c 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -35,6 +35,11 @@
 #include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "qapi/qmp/qdict.h"
+#include "block/qdict.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -2065,10 +2070,35 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
     return qdev_device_help(opts);
 }
 
+#if defined(CONFIG_MPQEMU)
+static int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    DeviceState *dev;
+
+    dev = qdev_remote_add(opts, errp);
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
     if (!dev && *errp) {
         error_report_err(*errp);
@@ -4307,6 +4337,9 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
 
+#if defined(CONFIG_MPQEMU)
+    qdev_proxy_fire();
+#endif
     if (rom_check_and_register_reset() != 0) {
         error_report("rom check and register reset failed");
         exit(1);
-- 
1.8.3.1


