Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90606206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QM4weoki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90606206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AuK-0006OL-S7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdY-0007eQ-Jp
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdV-0002CO-Tv
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXPlV152146;
 Thu, 30 Jul 2020 15:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=FPPMSivcUUtl0hRkdAFGBRzCLwr8+PkkoZfhLsJyqGs=;
 b=QM4weokiqiLhDvpSqxMTqdt9/TGQT+Ou7MoBsLCGSgokxwBFmQhmIqisJbHEBmQ7B+oA
 wrn7ouDQNMEgIf1lNz7s98J3ycDk68G3XDQAp0dy2gb++M4uHrM5ls/WAIPYO6ucNbi4
 +/TR+rPPjAIszj52BkxvW/cooNs5NIIcO7cTL9+YLpesp2so6ezMVha22wRXSewrrOjk
 e0sBy0YeViPbxKJvaYsZBppNsdd2dYHF1qRnN+zze1BibThoAlNRhG7i9QXpkUth4mDG
 eLyaZPtsRsjTJlQZHlLVdJ0V3/03rbqzRSaopYlKjFuZ7xPmClm2hlkkO6eVRIWZRw+u pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32hu1jve10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWZrB176081;
 Thu, 30 Jul 2020 15:38:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 32hu61a20m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFcGWZ007542;
 Thu, 30 Jul 2020 15:38:16 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:15 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 28/32] char: restore terminal on restart
Date: Thu, 30 Jul 2020 08:14:32 -0700
Message-Id: <1596122076-341293-29-git-send-email-steven.sistare@oracle.com>
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

If stdin is is a char backend device, then restore original stdin terminal
settings in before re-exec'ing.  Otherwise, the new qemu sees the modified
settings as initial settings, and does not restore the true initial settings
when it exits.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 chardev/char-stdio.c   | 7 +++++++
 include/chardev/char.h | 2 ++
 migration/savevm.c     | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 82eaebc..6481d08 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -119,6 +119,13 @@ static void qemu_chr_open_stdio(Chardev *chr,
 }
 #endif
 
+void qemu_term_exit(void)
+{
+#ifndef _WIN32
+    term_exit();
+#endif
+}
+
 static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend,
                                  Error **errp)
 {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index c18bda8..5fd3ecc 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -296,4 +296,6 @@ void save_char_socket_fd(Chardev *);
 void load_char_socket_fd(Chardev *);
 void save_char_pty_fd(Chardev *);
 
+void qemu_term_exit(void);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 732dfb5..881dc13 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -32,6 +32,7 @@
 #include "migration.h"
 #include "migration/snapshot.h"
 #include "migration/vmstate.h"
+#include "chardev/char.h"
 #include "migration/misc.h"
 #include "migration/register.h"
 #include "migration/global_state.h"
@@ -2772,6 +2773,7 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
         walkenv(FD_PREFIX, preserve_fd, 0);
         reset_vhost_devices();
         save_qmp_negotiation_status();
+        qemu_term_exit();
         qemu_system_exec_request();
         putenv((char *)"QEMU_START_FREEZE=");
     }
-- 
1.8.3.1


