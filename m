Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E766FC47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F50206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mepu29M2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F50206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODv7-0004X4-Cp
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1kOB16-0008OC-8V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 22:41:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1kOB13-0002xz-Tv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 22:41:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0922TeHJ104746;
 Fri, 2 Oct 2020 02:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=e+KpEZ/G2GVblFzq9cQMq+1bD63IjoSEf+so3ndf1k0=;
 b=mepu29M2kYMToqyCI5Bga+hybqbi8S/B9mvfksnoGdZLapwzlctG7XhYBWo9Sz7Ejaxk
 MTkvrR7IG6HHdACngcpW5ESgFY3ZRkqm43aBi3WS6tvBL2hkPcBr9UmWhMLWZO8JrSXK
 GsietFP4wvGYClxZ9lUSSRUZ3IghUvjO7Re2SKYgp/T1slhxy59s/OTo4SavZRYwbf7p
 oGXBBQlTAWnYmzxxXxKw3RPEBJnapu7pUdyJGlMRCVT8CuZ/VHmESpFWf0T6K3Fs5Af/
 gD3l8SjLmkVGYPfnxCrSTSqgVXSx8wFoj45CoHk5Sr7UL7w0FUoBw0OUGtqg1sGMzwat hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 33swkm93m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 02 Oct 2020 02:41:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0922V0om180923;
 Fri, 2 Oct 2020 02:41:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33uv2hs3yf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Oct 2020 02:41:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0922fenK007774;
 Fri, 2 Oct 2020 02:41:40 GMT
Received: from ban25x6uut148.us.oracle.com (/10.153.73.148)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 19:41:40 -0700
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] vl: Add -no-panicstop option
Date: Thu,  1 Oct 2020 22:41:34 -0400
Message-Id: <1601606494-1154-2-git-send-email-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
References: <1601606494-1154-1-git-send-email-alejandro.j.jimenez@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020016
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 22:41:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Oct 2020 01:46:45 -0400
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current default action of pausing a guest after a panic event
is received leaves the responsibility to resume guest execution to the
management layer. The reasons for this behavior are discussed here:
https://lore.kernel.org/qemu-devel/52148F88.5000509@redhat.com/

However, in instances like the case of older guests (Linux and
Windows) using a pvpanic device but missing support for the
PVPANIC_CRASHLOADED event, and Windows guests using the hv-crash
enlightenment, it is desirable to allow the guests to continue
running after sending a PVPANIC_PANICKED event. This allows such
guests to proceed to capture a crash dump and automatically reboot
without intervention of a management layer.

Add an option to avoid stopping a VM after a panic event is received.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
---
 qemu-options.hx | 11 +++++++++++
 softmmu/vl.c    | 17 ++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 3564c23..cbaf947 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3882,6 +3882,17 @@ SRST
     specified domain id (XEN only).
 ERST
 
+DEF("no-panicstop", 0, QEMU_OPTION_no_panicstop, \
+    "-no-panicstop	do not stop the VM on panic\n", QEMU_ARCH_ALL)
+SRST
+``-no-panicstop``
+    Don't stop the VM when a panic event is received. This allows older guests
+    using a pvpanic device but without support for the PVPANIC_CRASHLOADED
+    event, and Windows guests using the hv-crash enlightenment to continue
+    running and capture a crash dump or reboot without intervention of a
+    management layer.
+ERST
+
 DEF("no-reboot", 0, QEMU_OPTION_no_reboot, \
     "-no-reboot      exit instead of rebooting\n", QEMU_ARCH_ALL)
 SRST
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 22bc570..a939b18 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -147,6 +147,7 @@ int win2k_install_hack = 0;
 int singlestep = 0;
 int no_hpet = 0;
 int fd_bootchk = 1;
+static int no_panicstop;
 static int no_reboot;
 int no_shutdown = 0;
 int graphic_rotate = 0;
@@ -1431,9 +1432,16 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     if (current_cpu) {
         current_cpu->crash_occurred = true;
     }
-    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
-                                   !!info, info);
-    vm_stop(RUN_STATE_GUEST_PANICKED);
+
+    if (no_panicstop) {
+        qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_RUN,
+                                        !!info, info);
+    } else {
+        qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
+                                        !!info, info);
+        vm_stop(RUN_STATE_GUEST_PANICKED);
+    }
+
     if (!no_shutdown) {
         qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
                                        !!info, info);
@@ -3558,6 +3566,9 @@ void qemu_init(int argc, char **argv, char **envp)
             case QEMU_OPTION_no_hpet:
                 no_hpet = 1;
                 break;
+            case QEMU_OPTION_no_panicstop:
+                no_panicstop = 1;
+                break;
             case QEMU_OPTION_no_reboot:
                 no_reboot = 1;
                 break;
-- 
1.8.3.1


