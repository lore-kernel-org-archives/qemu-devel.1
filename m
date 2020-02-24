Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE50C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965E120CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FxH2bkU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965E120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kw5-00063h-O1
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km9-0006Gi-TS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km8-00034e-JV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km8-00032j-Ad
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKral2164128;
 Mon, 24 Feb 2020 20:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=MxpNHjTs+jU27aG3D0nYtJNgO++of0qV7/YWLWpKgxs=;
 b=FxH2bkU2MVdwh+uuDWXPhMwsZ/h7KWcCMIVK6/E2pnkjyeloCS7AJp/MR6G8aHePQooS
 DIzjA9bBbB1I3CnSWXod4o5YIT7afRzMivYViYqLmO+ySyzni8cL85ehv8d2mic+hxIt
 I9EDBxxLK/aZhFBwd4vf+2yGaQBuiheeaJNTs9LWO9F5aXZREMEI3TVdyPAQF1aBdpvq
 RheKdqbnuRHVdR1FRvQa3TuDGgAggsq3z9Nh3A6fJ/N9DxXQN7T5uCDeNnJVJ5xd40vF
 eEJeJOIbeHnU8Sx7ezGPYGba37+p/DxAWQYJjBrRMg3LQXxPgEIDNY9lDFF0ZQPNI5Ye XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p93r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqjfe017311;
 Mon, 24 Feb 2020 20:56:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ybduv6cuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuFN0028280;
 Mon, 24 Feb 2020 20:56:15 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:14 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/50] multi-process: remote process initialization
Date: Mon, 24 Feb 2020 15:55:03 -0500
Message-Id: <264de034fcdc1000bada4a93ac7e0856fef591f2.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=3
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=3 phishscore=0
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

Adds the handler to process message from QEMU,
Initialize remote process main loop, handles SYNC_SYSMEM
message by updating its "system_memory" container using
shared file descriptors received from QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 v4 -> v5:
  - We checked if we could use functions already defined in
    util/main-loop.c instead of using g_main_loop_run. However,
    we couldn't find a suitable function that's generic enough
    to do this. All of them have emulator code embedded in them
    which is not used by the remote process. We are therefore
    not making any change to this patch

 remote/remote-main.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index ecf30e0..56315cd 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -12,6 +12,7 @@
 #include "qemu-common.h"
 
 #include <stdio.h>
+#include <unistd.h>
 
 #include "qemu/module.h"
 #include "remote/pcihost.h"
@@ -19,12 +20,96 @@
 #include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "qemu/main-loop.h"
+#include "remote/memory.h"
+#include "io/mpqemu-link.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu-common.h"
+#include "hw/pci/pci.h"
+#include "qemu/thread.h"
+#include "qemu/main-loop.h"
+#include "qemu/config-file.h"
+#include "sysemu/sysemu.h"
+#include "block/block.h"
+#include "exec/ramlist.h"
+
+static MPQemuLinkState *mpqemu_link;
+PCIDevice *remote_pci_dev;
+
+static void process_msg(GIOCondition cond, MPQemuChannel *chan)
+{
+    MPQemuMsg *msg = NULL;
+    Error *err = NULL;
+
+    if ((cond & G_IO_HUP) || (cond & G_IO_ERR)) {
+        goto finalize_loop;
+    }
+
+    msg = g_malloc0(sizeof(MPQemuMsg));
+
+    if (mpqemu_msg_recv(msg, chan) < 0) {
+        error_setg(&err, "Failed to receive message");
+        goto finalize_loop;
+    }
+
+    switch (msg->cmd) {
+    case INIT:
+        break;
+    case PCI_CONFIG_WRITE:
+        break;
+    case PCI_CONFIG_READ:
+        break;
+    default:
+        error_setg(&err, "Unknown command");
+        goto finalize_loop;
+    }
+
+    g_free(msg->data2);
+    g_free(msg);
+
+    return;
+
+finalize_loop:
+    if (err) {
+        error_report_err(err);
+    }
+    g_free(msg);
+    mpqemu_link_finalize(mpqemu_link);
+    mpqemu_link = NULL;
+}
 
 int main(int argc, char *argv[])
 {
+    Error *err = NULL;
+
     module_call_init(MODULE_INIT_QOM);
 
+    bdrv_init_with_whitelist();
+
+    if (qemu_init_main_loop(&err)) {
+        error_report_err(err);
+        return -EBUSY;
+    }
+
+    qemu_init_cpu_loop();
+
+    page_size_init();
+
+    qemu_mutex_init(&ram_list.mutex);
+
     current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
 
+    mpqemu_link = mpqemu_link_create();
+    if (!mpqemu_link) {
+        printf("Could not create MPQemu link\n");
+        return -1;
+    }
+
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, STDIN_FILENO);
+    mpqemu_link_set_callback(mpqemu_link, process_msg);
+
+    mpqemu_start_coms(mpqemu_link);
+
     return 0;
 }
-- 
1.8.3.1


