Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E4C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B1020786
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9qwzyeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B1020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdEZ-0003iP-Tg
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kZd9w-0008D0-Li
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:58:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1kZd9t-0004et-7D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:58:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2GinGp125491;
 Mon, 2 Nov 2020 16:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=J39U91hwUcfjz6AYWlnaWvznYzeNFQTfjjlfc4yEwTc=;
 b=X9qwzyeo/h6T7GguDT8K9Q8qYNUr1ifSnHUI4aYMaikNC6ZZ32REt5beJO1lWrqFpjC4
 Sd+FtULeTQc7IlSmI5nZ7e4qy9HAY/lQhq6ErjX0k0sdfy9o9RYybVfZmT8XJm5L8yhx
 TY56+3SCGNv49m+Mhp7ydfj8EPWa0gTA3kD6yEkCu+lYVqwz1A3gwdlvTu2IEMCTCvzq
 aXQXwMwspR2wFtCCI5OhJHvWLIkBPUjWXR25A//2aD9Vl5KnrSwz5XXAddnv5sZ/xZFz
 E+tcwF6J2u4l8gVxIrsAU9XNWdKapuyyowTjzfZp5/svoYVu11UaxkpQOywxh6zPIfL1 iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 34hhw2d2t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 02 Nov 2020 16:58:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2Gkd7W064310;
 Mon, 2 Nov 2020 16:56:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 34hw0bvkur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Nov 2020 16:56:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A2GuB5a018297;
 Mon, 2 Nov 2020 16:56:11 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Nov 2020 08:56:11 -0800
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH V1] gdbstub: gdb support for suspended state
Date: Mon,  2 Nov 2020 08:32:30 -0800
Message-Id: <1604334750-437914-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020129
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 10:41:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Steve Sistare <steven.sistare@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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


