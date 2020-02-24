Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71513C38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3411720CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyJqx1TS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3411720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L8a-0003Dy-BF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmX-0007Ab-43
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmV-0003bi-Hn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmV-0003a2-80
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKral6164128;
 Mon, 24 Feb 2020 20:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=I0MCFzsj7Hs8gCp2U945/nTXJZSYe2xsHlKItOC4YrQ=;
 b=TyJqx1TSD3H5xoi1hVy1f1VqqLBUpeUl7nPcR36pSblhuqbvpMS3vNHSVQLiEOYZ8lNy
 22xoED6ylzORWpheXBlfDPWXvREW3Xg9p87UHXBm/XEm9RMEr954tsvIo7C66FdcpjfY
 QwE10UiTWXxnXnY/icV1YPC9T+/e3jQSpbEtUHeZO46uir9HI9Sg39bBxCt8ye/3H4xW
 1l+8NQEb/hmFJhze5SXvFcTE1uF2CtcrjBmkm+BSRFvX8jfilM156ARcFW73hlIpK/9M
 29NCCHrkpxi7VADEcPXVMB83jQ7d+NDVzGfV7aCCkqla8HF1RVY8ffLIap1PRA65h2Zm og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p96p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq8cm089110;
 Mon, 24 Feb 2020 20:56:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2yby5dmce7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:42 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKueaa029940;
 Mon, 24 Feb 2020 20:56:40 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:39 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 28/50] multi-process: add remote options parser
Date: Mon, 24 Feb 2020 15:55:19 -0500
Message-Id: <8ed88052f089814b70d32fcf17f0f963daa03c28.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
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

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 include/monitor/qdev.h |   1 +
 softmmu/vl.c           | 105 +++++++++++++++++++++++++++++++++++++++++++++++++
 vl-parse.c             |  31 +++++++++++++++
 vl.h                   |   1 +
 4 files changed, 138 insertions(+)

diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index d47a544..f3a56fa 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -23,6 +23,7 @@ struct remote_process {
     unsigned int type;
     int socket;
     char *command;
+    char *exec;
     QemuOpts *opts;
 
     QLIST_ENTRY(remote_process) next;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b277de3..a8a6f35 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -253,6 +253,32 @@ static QemuOptsList qemu_option_rom_opts = {
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
+        },{
+            .name = "exec",
+            .type = QEMU_OPT_STRING,
+            .help = "exec name",
+        },
+        { /* end of list */ }
+    },
+};
+
+
 static QemuOptsList qemu_machine_opts = {
     .name = "machine",
     .implied_opt_name = "type",
@@ -314,6 +340,71 @@ static QemuOptsList qemu_boot_opts = {
     },
 };
 
+#if defined(CONFIG_MPQEMU)
+static int parse_remote(void *opaque, QemuOpts *opts, Error **errp)
+{
+    int rid;
+    int socket;
+    char  *c_sock = NULL;
+    char *command = NULL;
+    char *exec = NULL;
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
+    if (socket <= STDERR_FILENO && socket != -1) {
+        socket = -1;
+    }
+
+    exec = (char *)qemu_opt_get(opts, "exec");
+
+    if (!exec && socket < 0) {
+        error_setg(errp, "No socket or exec defined for remote.");
+        return -1;
+    }
+    if (exec && (socket != -1)) {
+        error_setg(errp, "Both socket and exec are specified, " \
+                         "need only one of those.");
+        return -1;
+    }
+
+    command = (char *)qemu_opt_get(opts, "command");
+    if (!command && socket < 0) {
+        error_setg(errp, "Remote process command option is not specified.");
+        return -1;
+    }
+
+    r_proc.rid = rid;
+    r_proc.socket = socket;
+    r_proc.command = g_strdup(command);
+    r_proc.exec = g_strdup(exec);
+    remote_process_register(&r_proc);
+
+ cont_devices:
+    if (qemu_opts_foreach(qemu_find_opts("device"), device_remote_add,
+                          &rid, NULL)) {
+        error_setg(errp, "Could not process some of the remote devices.");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+#endif
+
 static QemuOptsList qemu_add_fd_opts = {
     .name = "add-fd",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_add_fd_opts.head),
@@ -2751,6 +2842,7 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_icount_opts);
     qemu_add_opts(&qemu_semihosting_config_opts);
     qemu_add_opts(&qemu_fw_cfg_opts);
+    qemu_add_opts(&qemu_remote_opts);
     module_call_init(MODULE_INIT_OPTS);
 
     runstate_init();
@@ -3575,6 +3667,14 @@ void qemu_init(int argc, char **argv, char **envp)
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
@@ -4170,6 +4270,11 @@ void qemu_init(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
 
+#ifdef CONFIG_MPQEMU
+    qemu_opts_foreach(qemu_find_opts("remote"),
+                      parse_remote, NULL, &error_fatal);
+#endif
+
     cpu_synchronize_all_post_init();
 
     rom_reset_order_override();
diff --git a/vl-parse.c b/vl-parse.c
index b76bc95..1f6a3f0 100644
--- a/vl-parse.c
+++ b/vl-parse.c
@@ -85,6 +85,37 @@ const QEMUOption *lookup_opt(int argc, char **argv,
     return popt;
 }
 
+#if defined(CONFIG_MPQEMU)
+int device_remote_add(void *opaque, QemuOpts *opts, Error **errp)
+{
+    unsigned int rid = 0;
+    const char *opt_rid = NULL;
+    struct remote_process *p = NULL;
+
+    if (opaque) {
+        rid = *(unsigned int *)opaque;
+    }
+    opt_rid = qemu_opt_get(opts, "rid");
+    if (!opt_rid) {
+        return 0;
+    }
+
+    p = get_remote_process_rid(rid);
+    if (!p) {
+        error_setg(errp, "No process for rid %d", rid);
+        return -EINVAL;
+    }
+
+    if (atoi(opt_rid) == rid) {
+        qemu_opt_set(opts, "command", p->command, errp);
+        qemu_opt_set(opts, "exec", p->exec, errp);
+        rdevice_init_func(opaque, opts, errp);
+        qemu_opts_del(opts);
+    }
+    return 0;
+}
+#endif
+
 int drive_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     BlockInterfaceType *block_default_type = opaque;
diff --git a/vl.h b/vl.h
index a171fab..d84bf63 100644
--- a/vl.h
+++ b/vl.h
@@ -36,6 +36,7 @@ int device_init_func(void *opaque, QemuOpts *opts, Error **errp);
 
 #if defined(CONFIG_MPQEMU)
 int rdevice_init_func(void *opaque, QemuOpts *opts, Error **errp);
+int device_remote_add(void *opaque, QemuOpts *opts, Error **errp);
 #endif
 
 #endif /* VL_H */
-- 
1.8.3.1


