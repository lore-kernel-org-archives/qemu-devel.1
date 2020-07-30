Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E92C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700902082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IfjgW050"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700902082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ajl-0007qU-N7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdB-000764-78
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad8-000263-VP
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXP0g155719;
 Thu, 30 Jul 2020 15:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=h6VW8WSg+pOehoYaPNZ8J01kel1i2awnl/tUOVeNh6I=;
 b=IfjgW050F/XW/3Xml1jZsZnb0W1dQSCQF/9DB/nrLUJh6W5Dk0tHnwRJdgswj0Ngz10E
 +/LhlgfAITCh+4WcKCEe1srXgD9j60PZG5dqevaDfAfb0ug4TXIR7H4JSegXr4ScXMEu
 s/rwWaKwBa/Ejisj0kl9U/W82sk7cp/wsVlQgD7akIOEZ+Dcrd/nwwyKmykwC9tSujgD
 k1vHwI1Hq3rqHsfmo4RAGWIaoik/TEiiJDc5Rraz/QB99mtpW0OYmJQXm6LQPNEpysQc
 DPqFOGF3ln0BUBo2mKmuOL/IDdTe0WO7sbAHf4UL96+qtCXuxTHdZJ4NJzi6Xw0Gl8ju VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 32hu1jmecc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSWD130724;
 Thu, 30 Jul 2020 15:37:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 32hu5wwgph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06UFbwP1014433;
 Thu, 30 Jul 2020 15:37:58 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:58 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 07/32] savevm: QMP command for cprinfo
Date: Thu, 30 Jul 2020 08:14:11 -0700
Message-Id: <1596122076-341293-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=steven.sistare@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:57
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

Provide the cprinfo QMP command.  This returns a string with a space-
separated list of modes supported by cprsave, and can be used by clients
as a feature test to check if the running QEMU instance supports cprsave.

Syntax:
  {'command':'cprinfo', 'returns':'str'}

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 monitor/qmp-cmds.c  | 5 +++++
 qapi/migration.json | 9 +++++++++
 qapi/pragma.json    | 1 +
 3 files changed, 15 insertions(+)

diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 81e6feb..8c400e6 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -162,6 +162,11 @@ void qmp_cont(Error **errp)
     }
 }
 
+char *qmp_cprinfo(Error **errp)
+{
+    return g_strdup("reboot");
+}
+
 void qmp_cprsave(const char *file, const char *mode, Error **errp)
 {
     save_cpr_snapshot(file, mode, errp);
diff --git a/qapi/migration.json b/qapi/migration.json
index ce4d32b..8190b16 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1623,6 +1623,15 @@
   'data': { 'device-id': 'str' } }
 
 ##
+# @cprinfo:
+#
+# Return a space-delimited list of modes supported by the cprsave command
+#
+# Since 5.0
+##
+{ 'command': 'cprinfo', 'returns': 'str' }
+
+##
 # @cprsave:
 #
 # Create a checkpoint of the virtual machine device state in @file.
diff --git a/qapi/pragma.json b/qapi/pragma.json
index cffae27..43bdb39 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -5,6 +5,7 @@
 { 'pragma': {
     # Commands allowed to return a non-dictionary:
     'returns-whitelist': [
+        'cprinfo',
         'human-monitor-command',
         'qom-get',
         'query-migrate-cache-size',
-- 
1.8.3.1


