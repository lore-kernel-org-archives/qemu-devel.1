Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5CAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59ABF2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Idqb+eb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ABF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Alv-00036x-Hc
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdE-00079M-Ch
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdC-00026i-Fm
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXPfS007499;
 Thu, 30 Jul 2020 15:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=WIdUxn9OcuYCdzIU7jtF5oYpZlffe7b3B0nwEV0DcXQ=;
 b=Idqb+eb/kPVYcnaYIuBBMxCEsHywZyNZ5zR8eLlndIQT1SVl79keTdvaTz7EXyVJ1v8S
 4mIXyqo3ed0Pu6scMS1pnwYxrtgv0k92hQEG6QST0OIoXw/q3d/SZFFa2ACEHWPgw1i/
 zj0Ra5aO+7Hi+1ljZgw7dgllcUI4SEyj530lT4yvvJlp3Qttvf1VDgAHo5Btehjke1RE
 grDLuI6ajvkqQSkU5QmD8GZTC41h4IDBBcO7bk6E7k7cHq+6wglbn6aHI2uI3VIhKL22
 rrs5t8U4RJbs56DPrNmzRoYv5aJ8KmI/rwy0cKhzc/W1Z5c6rffdY7XSP3jaMuzIePqu dA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 32hu1jmfe9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSO7130733;
 Thu, 30 Jul 2020 15:38:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu5wwgrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFc1a2001856;
 Thu, 30 Jul 2020 15:38:01 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:01 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 11/32] cpu: disable ticks when suspended
Date: Thu, 30 Jul 2020 08:14:15 -0700
Message-Id: <1596122076-341293-12-git-send-email-steven.sistare@oracle.com>
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

After cprload, the guest console misbehaves.  You must type 8 characters
before any are echoed to the terminal.  Qemu was not sending interrupts
to the guest because the QEMU_CLOCK_VIRTUAL timers_state.cpu_clock_offset
was bad.  The offset is usually updated at cprsave time by the path

  save_cpr_snapshot()
    vm_stop()
      do_vm_stop()
        if (runstate_is_running())
          cpu_disable_ticks();
            timers_state.cpu_clock_offset = cpu_get_clock_locked();

However, if the guest is in RUN_STATE_SUSPENDED, then cpu_disable_ticks is
not called.  Further, the earlier transition to suspended in
qemu_system_suspend did not disable ticks.  To fix, call cpu_disable_ticks
from save_cpr_snapshot.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/savevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index f101039..00f493b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2729,6 +2729,11 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
         return;
     }
 
+    /* Update timers_state before saving.  Suspend did not so do. */
+    if (runstate_check(RUN_STATE_SUSPENDED)) {
+        cpu_disable_ticks();
+    }
+
     vm_stop(RUN_STATE_SAVE_VM);
 
     ret = qemu_savevm_state(f, op, errp);
-- 
1.8.3.1


