Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA67C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D2E206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HATlcllz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D2E206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Axi-00033n-7p
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfQ-0001U9-6N
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfD-0002Uz-Dm
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSrw007533;
 Thu, 30 Jul 2020 15:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=J39U91hwUcfjz6AYWlnaWvznYzeNFQTfjjlfc4yEwTc=;
 b=HATlcllz2geWSo0JhUch8jXfS1fmtj7O9TyiHsJYjFPaRVDZCeD9Tz5HgwVNuurK+n6o
 cXnAY0V139k71HxrTw9/UJoRxGXpspBaYq2SzfP2oeHxSnZDDjqh6jP+tr1EpiVJ/VDI
 pgg6nhMLZ9VaJY/y2A+qnoFYI8yLnxqtd1AiHCYLddNqnbufpztgHOc2QsngkAKx6fiY
 0zPtXwz106C/Af2PXxoPgz2GpouL6XZHkRpNAN3qBs5fvTOJwkLYMcww5QK4M5rcQ7Z1
 VTm2ybj3k2PWjTx8v0Mi3zjCEsyHCV56QouTqUqVaQvOq9DOjB8KZgfYFw6yhprbmfrA yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jmfu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:40:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWZQ9176243;
 Thu, 30 Jul 2020 15:38:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 32hu61a1dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:04 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFc3LM007477;
 Thu, 30 Jul 2020 15:38:03 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:02 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 13/32] gdbstub: gdb support for suspended state
Date: Thu, 30 Jul 2020 08:14:17 -0700
Message-Id: <1596122076-341293-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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

Modify the gdb server so a continue command appears to resume execution
when in RUN_STATE_SUSPENDED.  Do not print the next gdb prompt, but do not
actually resume instruction fetch.  While in this "fake" running mode, a
ctrl-C returns the user to the gdb prompt.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 gdbstub.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index f3a318c..2f0d9ff 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -461,7 +461,9 @@ static inline void gdb_continue(void)
 #else
     if (!runstate_needs_reset()) {
         trace_gdbstub_op_continue();
-        vm_start();
+        if (!runstate_check(RUN_STATE_SUSPENDED)) {
+            vm_start();
+        }
     }
 #endif
 }
@@ -490,7 +492,7 @@ static int gdb_continue_partial(char *newstates)
     int flag = 0;
 
     if (!runstate_needs_reset()) {
-        if (vm_prepare_start()) {
+        if (!runstate_check(RUN_STATE_SUSPENDED) && vm_prepare_start()) {
             return 0;
         }
 
@@ -2835,6 +2837,9 @@ static void gdb_read_byte(uint8_t ch)
         /* when the CPU is running, we cannot do anything except stop
            it when receiving a char */
         vm_stop(RUN_STATE_PAUSED);
+    } else if (runstate_check(RUN_STATE_SUSPENDED) && ch == 3) {
+        /* Received ctrl-c from gdb */
+        gdb_vm_state_change(0, 0, RUN_STATE_PAUSED);
     } else
 #endif
     {
@@ -3282,6 +3287,8 @@ static void gdb_sigterm_handler(int signal)
 {
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_PAUSED);
+    } else if (runstate_check(RUN_STATE_SUSPENDED)) {
+        gdb_vm_state_change(0, 0, RUN_STATE_PAUSED);
     }
 }
 #endif
-- 
1.8.3.1


