Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B2BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FC22082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cGYDjR1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FC22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ajk-0007on-Hp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdF-0007AK-1v
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdD-00026o-1Q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSVG152193;
 Thu, 30 Jul 2020 15:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=pBOdcc2CBeYUKc86FdzgZ3jsx9sNsQgOjultivuhWfI=;
 b=cGYDjR1GRjZh/vQl/QWcM8tVySYpzykPsAVYJnYc2EuRyDUJYbwcJrMMvvMimy/k/ptf
 dmzMdCEaSVMy6dYZOZULIYSlgAlajX4Y7ZG2cjDpG9LTGXy99CFZaPYc2KoW60ogYzS9
 OUVVE8Uy7gb5nN7DuUXCXMS/lJ5tpuFPF6ZCZ5c+BttNM8PcVQGBH2d1Lj/YnLbIH5I2
 /KspMc+8CTs4yl8B9rts6rwtYYMoZSuOw4ssrFMFDK8FuxiQjDXeUr05EkXlIvumgZpY
 DkuiTpqb5uZapYBgP58IN4vyqhnDKg+vvmUr+nU/SAIIGXuNMyeaJtPACi9Q5cWmnq6B Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 32hu1jvdyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFYjDR172050;
 Thu, 30 Jul 2020 15:38:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 32hu5x0wat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFc2t8014453;
 Thu, 30 Jul 2020 15:38:02 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:02 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 12/32] vl: pause option
Date: Thu, 30 Jul 2020 08:14:16 -0700
Message-Id: <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=1 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:38:02
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide the -pause command-line parameter and the QEMU_PAUSE environment
variable to briefly pause QEMU in main and allow a developer to attach gdb.
Useful when the developer does not invoke QEMU directly, such as when using
libvirt.

Usage:
  qemu -pause <seconds>
  or
  export QEMU_PAUSE=<seconds>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qemu-options.hx |  9 +++++++++
 softmmu/vl.c    | 15 ++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 708583b..8505cf2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3668,6 +3668,15 @@ SRST
     option is experimental.
 ERST
 
+DEF("pause", HAS_ARG, QEMU_OPTION_pause, \
+    "-pause secs    Pause for secs seconds on entry to main.\n", QEMU_ARCH_ALL)
+
+SRST
+``--pause secs``
+    Pause for a number of seconds on entry to main.  Useful for attaching
+    a debugger after QEMU has been launched by some other entity.
+ERST
+
 DEF("S", 0, QEMU_OPTION_S, \
     "-S              freeze CPU at startup (use 'c' to start execution)\n",
     QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 8478778..951994f 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2844,7 +2844,7 @@ static void create_default_memdev(MachineState *ms, const char *path)
 
 void qemu_init(int argc, char **argv, char **envp)
 {
-    int i;
+    int i, seconds;
     int snapshot, linux_boot;
     const char *initrd_filename;
     const char *kernel_filename, *kernel_cmdline;
@@ -2882,6 +2882,13 @@ void qemu_init(int argc, char **argv, char **envp)
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
     int mem_prealloc = 0; /* force preallocation of physical target memory */
 
+    if (getenv("QEMU_PAUSE")) {
+        seconds = atoi(getenv("QEMU_PAUSE"));
+        printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
+               seconds, getpid());
+        sleep(seconds);
+    }
+
     os_set_line_buffering();
 
     error_init(argv[0]);
@@ -3204,6 +3211,12 @@ void qemu_init(int argc, char **argv, char **envp)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+            case QEMU_OPTION_pause:
+                seconds = atoi(optarg);
+                printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
+                            seconds, getpid());
+                sleep(seconds);
+                break;
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
-- 
1.8.3.1


