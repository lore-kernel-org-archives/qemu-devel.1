Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3BBC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0841A206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ddhA0ToL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0841A206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57387 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLONC-0005EJ-5g
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGi-0001w3-Fh
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGh-0002Fb-9O
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGg-0002El-W7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dA07025336;
 Mon, 6 Apr 2020 09:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ovXmJb751tMmY62g+3cNjputDMZHGQwW/4lf2VA6e2I=;
 b=ddhA0ToLKA9UXp3zMlgmntRIpO4LccokP4JXYSwTs2XbOP8YLu+Iv8zZxi5orCuNlfMl
 CRnNgK+SgDmR4abqlD9xNkjkRCSuMDyjpaX45Fjycsiw55+8Falqg/dS7pQ/+bCe0WSe
 X+pxoqh+pXEesWQsz59pEVCqCeFhfne60dkuvGnEr1sX7wqf+u7p7PmN7cCEaYJ1eMDX
 OnDW2U6ucyuNmQp3L8Z5gFVcws+607fWPgGq6uamHfQGOBJMo5816rREbnJGvARnBxtl
 ZDKghnt8vBdiM95tGGs11yOflDbpE5DexGzjxCdm4qb39HcEKKuZjEKefZjDiGQF1DUU rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 306jvmwr4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cUFY006236;
 Mon, 6 Apr 2020 09:42:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 3073xvtug9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369fwaK013611;
 Mon, 6 Apr 2020 09:41:59 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:58 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 16/36] multi-process: remote process initialization
Date: Mon,  6 Apr 2020 02:41:06 -0700
Message-Id: <73241ca8e613a00d89f86d214bf586cad658a616.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=3
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
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

From: Jagannathan Raman <jag.raman@oracle.com>

Adds the handler to process message from QEMU,
Initialize remote process main loop, handles SYNC_SYSMEM
message by updating its "system_memory" container using
shared file descriptors received from QEMU.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 remote/remote-main.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index ecf30e0cba..51595f3141 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -12,6 +12,7 @@
 #include "qemu-common.h"
 
 #include <stdio.h>
+#include <unistd.h>
 
 #include "qemu/module.h"
 #include "remote/pcihost.h"
@@ -19,12 +20,98 @@
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
+
+static void process_msg(GIOCondition cond, MPQemuLinkState *link,
+                        MPQemuChannel *chan)
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
+
+    mpqemu_link_set_callback(mpqemu_link, process_msg);
+
+    qdev_machine_creation_done();
+    qemu_mutex_lock_iothread();
+    qemu_run_machine_init_done_notifiers();
+    qemu_mutex_unlock_iothread();
+
+    mpqemu_start_coms(mpqemu_link, mpqemu_link->com);
+
     return 0;
 }
-- 
2.25.GIT


