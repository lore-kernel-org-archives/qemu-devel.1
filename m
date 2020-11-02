Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95126C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214A922400
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IvntMnNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214A922400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcTz-0004Eq-6V
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kZcSy-0003Ky-Sy
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:14:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kZcSv-0006oA-0A
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:13:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2G9Yv4065555;
 Mon, 2 Nov 2020 16:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=jjIfD9cfNTOR+XSGV2lKLHHzQPpiWMLV2itqoevKKm0=;
 b=IvntMnNs4Br0ooqXXjAZHua0jstH7UxvKxcaRDLfm8RtJ2CeAZlkM5C8Bet3ZA6BjnIn
 B+hWplHBlREMLUWT0Lp8GOqa9xX5ovC0L1zj+fMp+uil7dVpRbXNij+qQ6GfSdJi6JLH
 7ORSTQUmMViDqrkhYGB4wZhrg88qfHzd13NltPsoWbqlkZHsfN8/1dyM19P3jRjYv5So
 obHtEpv/S1dcnBmxnh69IvZMyI2K9yMixjnXOUW7ocObWgBEhtR4RlEIvpv3FdEgJs4p
 dzIcHsuSHCLymo8wAqETiOMXCh+KNIDYPPC3tzZZhjWNBO5jKnARS2uP62MZzyUUH/17 8A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 34hhvc4rmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 02 Nov 2020 16:13:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2GAwWt057860;
 Mon, 2 Nov 2020 16:13:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 34jf46qwte-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Nov 2020 16:13:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A2GDjYg015953;
 Mon, 2 Nov 2020 16:13:45 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Nov 2020 08:13:45 -0800
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2] vl: pause option
Date: Mon,  2 Nov 2020 07:50:03 -0800
Message-Id: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=954 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=1
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=971
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020125
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 11:13:48
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide the -pause command-line parameter and the QEMU_PAUSE environment
variable to pause QEMU during process startup using SIGSTOP and allow a
developer to attach a debugger, or observe the process using tools such as
strace.  Useful when the QEMU has been launched with some other entity, such
as libvirt.  QEMU_PAUSE is checked in a constructor at the highest priority,
and can be used to debug other constructors.  The -pause option is checked
later, during argument processing in main, but is useful if passing an
environment variable from a launcher to qemu is awkard.

Usage: qemu -pause, or QEMU_PAUSE=1
After attaching a debugger, send SIGCONT to the qemu process to continue.

Example:

$ QEMU_PAUSE=1 qemu-system-x86_64 ...
QEMU pid 18371 is stopped.
[1]+  Stopped
                                 $ gdb -p 18371
                                 (gdb)
$ kill -cont 18371
                                 (gdb) break rcu_init
                                 (gdb) continue
                                 Program received signal SIGCONT, Continued.
                                 (gdb) continue
                                 Breakpoint 1, rcu_init () at util/rcu.c:380

Thanks to Daniel P. Berrange <berrange@redhat.com> for suggesting SIGSTOP.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qemu-options.hx | 14 ++++++++++++++
 softmmu/vl.c    | 23 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 708583b..42edd70 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3668,6 +3668,20 @@ SRST
     option is experimental.
 ERST
 
+DEF("pause", 0, QEMU_OPTION_pause, \
+    "-pause          pause the qemu process in main using SIGSTOP.\n"
+    "                to pause earlier, before constructors are run, set the\n"
+    "                environment variable QEMU_PAUSE=1 before starting qemu.\n",
+    QEMU_ARCH_ALL)
+
+SRST
+``-pause``
+    Pause the qemu process in main using SIGSTOP.  This is useful for attaching
+    a debugger after QEMU has been launched by some other entity.  After
+    attaching, send SIGCONT to continue.  To pause earlier, before constructors
+    are run, set the environment variable QEMU_PAUSE=1 before starting qemu.
+ERST
+
 DEF("S", 0, QEMU_OPTION_S, \
     "-S              freeze CPU at startup (use 'c' to start execution)\n",
     QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4eb9d1f..aee1a96 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2829,6 +2829,24 @@ static void create_default_memdev(MachineState *ms, const char *path)
                             &error_fatal);
 }
 
+static __attribute__((constructor(101))) void maybe_pause(void)
+{
+    const char *pause = getenv("QEMU_PAUSE");
+
+    if (pause) {
+        if (!pause[0] || !strcmp(pause, "1")) {
+            printf("QEMU pid %d is stopped.  Send SIGCONT to continue.\n",
+                   getpid());
+            kill(getpid(), SIGSTOP);
+        } else if (strcmp(pause, "0")) {
+            fprintf(stderr, "error: QEMU_PAUSE bad value %s. Must be 1 or "
+                            "empty to enable, 0 or unset to disable.\n",
+                            pause);
+            exit(1);
+        }
+    }
+}
+
 void qemu_init(int argc, char **argv, char **envp)
 {
     int i;
@@ -3191,6 +3209,11 @@ void qemu_init(int argc, char **argv, char **envp)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+            case QEMU_OPTION_pause:
+                printf("QEMU pid %d is stopped.  Send SIGCONT to continue.\n",
+                       getpid());
+                kill(getpid(), SIGSTOP);
+                break;
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
-- 
1.8.3.1


