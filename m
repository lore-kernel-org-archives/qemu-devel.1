Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE03C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2288122CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MceREJfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2288122CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GCA-0000lC-Dl
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaF-0007tz-JB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaD-0000gP-PX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaD-0000fW-A0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KY2Jg066515;
 Tue, 3 Sep 2019 20:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=aFlL9hrp/8s5Ve2fji43eNKHS8OEeq+nWxFs4dHUn4g=;
 b=MceREJfpK1thjIEbF6NZjsy9TMj917/z9fHNUaJYSEOa03hhgkpwW2C3M4P3WrkMjCXN
 Wo54idlqX7GGxi3icJJT7efiZ44U84ofBAKzDbKFyvOXGUf9GwEdhFqHYzg1Thn2i6KU
 UO4ZEtJ8qyszXi1Znnokabq2dVrI3RD7Qh9oM94a1UGqT2WJhWN/iTR8cmFIaxH9VWBW
 PbETBtgh9K6PkGpMpAhP1LBANsrPvz/1QCkmaCwF9dIumLld5R/vjvzv8QG2MmnLA3BR
 3yBui67eMJMKD5OYah+uo13UehD4I1a5tBj5xfyjDgKEJoIoXowf/KRVoZ4D+qXa1dsc OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2usy4u832u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcY66178165;
 Tue, 3 Sep 2019 20:39:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2us4wegr3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:13 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KdCVg024635;
 Tue, 3 Sep 2019 20:39:12 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:12 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:57 -0400
Message-Id: <2bdaf006096778cd5330866ec4a6cc43f8ee958b.1567534653.git.jag.raman@oracle.com>
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
Subject: [Qemu-devel] [RFC v3 PATCH 31/45] multi-process: add remote options
 parser
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

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 vl.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/vl.c b/vl.c
index dc2558c..08e9c09 100644
--- a/vl.c
+++ b/vl.c
@@ -279,6 +279,28 @@ static QemuOptsList qemu_option_rom_opts = {
     },
 };
 
+static QemuOptsList qemu_remote_opts = {
+    .name = "remote",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_remote_opts.head),
+    .desc = {
+        {
+            .name = "rid",
+            .type = QEMU_OPT_NUMBER,
+            .help = "id of the remote process"
+        },{
+            .name = "socket",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Socket for remote",
+        },{
+            .name = "command",
+            .type = QEMU_OPT_STRING,
+            .help = "command to run",
+        },
+        { /* end of list */ }
+    },
+};
+
+
 static QemuOptsList qemu_machine_opts = {
     .name = "machine",
     .implied_opt_name = "type",
@@ -346,6 +368,87 @@ static QemuOptsList qemu_boot_opts = {
     },
 };
 
+#if defined(CONFIG_MPQEMU)
+static int device_remote_add(void *opaque, QemuOpts *opts, Error **errp)
+{
+    unsigned int rid = *(unsigned int *)opaque;
+    const char *opt_rid = NULL;
+    struct remote_process *p = NULL;;
+
+    opt_rid = qemu_opt_get(opts, "rid");
+    if (!opt_rid) {
+        return 0;
+    }
+
+    p = get_remote_process_rid(rid);
+    if (!p) {
+        return -EINVAL;
+    }
+
+    if (atoi(opt_rid) == rid) {
+        qemu_opt_set(opts, "command", p->command, errp);
+        rdevice_init_func(opaque, opts, errp);
+        qemu_opts_del(opts);
+    }
+    return 0;
+}
+
+static int parse_remote(void *opaque, QemuOpts *opts, Error **errp)
+{
+    int rid;
+    int socket;
+    char  *c_sock;
+    const char *command = NULL;
+    struct remote_process r_proc;
+
+    rid = atoi(qemu_opt_get(opts, "rid"));
+    if (rid < 0) {
+        error_setg(errp, "rid is required.");
+        return -1;
+    }
+    if (get_remote_process_rid(rid)) {
+        error_setg(errp, "There is already process with rid %d", rid);
+        goto cont_devices;
+    }
+
+    c_sock = (char *)qemu_opt_get(opts, "socket");
+    if (c_sock) {
+        socket = atoi(c_sock);
+    } else {
+        socket = -1;
+    }
+
+    command = qemu_opt_get(opts, "command");
+
+    if (socket <= STDERR_FILENO && socket != -1) {
+        socket = -1;
+    }
+
+    if (!command && socket < 0) {
+        error_setg(errp, "No correct  socket or command defined for remote.");
+        return -1;
+    }
+
+    if (rid < 0) {
+        error_setg(errp, "id option is required and must be non-negative");
+        return -1;
+    }
+    r_proc.rid = rid;
+    r_proc.socket = socket;
+    r_proc.command = g_strdup(command);
+    remote_process_register(&r_proc);
+
+ cont_devices:
+    if (qemu_opts_foreach(qemu_find_opts("device"), device_remote_add,
+                          &rid, NULL)) {
+        error_setg(errp, "Could not process some of the remote devices.");
+    }
+
+    return 0;
+}
+
+#endif
+
 static QemuOptsList qemu_add_fd_opts = {
     .name = "add-fd",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_add_fd_opts.head),
@@ -2861,6 +2964,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
+    qemu_add_opts(&qemu_remote_opts);
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
@@ -3697,6 +3801,14 @@ int main(int argc, char **argv, char **envp)
                 exit(1);
 #endif
                 break;
+            case QEMU_OPTION_remote:
+                opts = qemu_opts_parse_noisily(qemu_find_opts("remote"),
+                                               optarg, false);
+                if (!opts) {
+                    exit(1);
+                }
+                break;
+
             case QEMU_OPTION_object:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
                                                optarg, true);
@@ -4297,6 +4409,11 @@ int main(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
 
+#ifdef CONFIG_MPQEMU
+    qemu_opts_foreach(qemu_find_opts("remote"),
+                      parse_remote, NULL, &error_fatal);
+#endif
+
     cpu_synchronize_all_post_init();
 
     rom_reset_order_override();
-- 
1.8.3.1


