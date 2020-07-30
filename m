Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95FBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 949FB206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E14TlXm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949FB206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B2m-0002Ap-R7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfV-0001g1-6A
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AfP-0002W9-1T
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXP8L152158;
 Thu, 30 Jul 2020 15:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7DOqpXdM4b46H9Bprd54+k7iPJnt7p1rT/stHg9VDPI=;
 b=E14TlXm/Bn3ntVqhG5DOZ0bSJ5zXcJjpOBMNV6iqnotzOdMSJE3x/iI6qYJ1yJQGWyn7
 ra9n+wYDQU+sSl4vokAvjuEVxfeJOCzjtzBjgufQSGNCKKak2iVn/jxvod/fOWYjC9gA
 nbMm2e9MpTTUq7UagRZ37ZmsipF8e6tntmIeT7SGATsHZ8mMVFNojMOVRds/qYXHOvvs
 9+btehUn3NUcVWgo5e42xWlkTOxlryubPW+/OHDsASq2Dw7vTNyCrqsLoIXRFbOgIPUb
 Wp6kMfOWvr1X80UlfiA77aylwU58wWx0hO+GjpW/E8bSD2zXmWks1m1DSPcNgB1M2ztv Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 32hu1jvedd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:40:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSHV130739;
 Thu, 30 Jul 2020 15:38:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu5wwh3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFcFlT001927;
 Thu, 30 Jul 2020 15:38:15 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:15 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 27/32] vhost: reset vhost devices upon cprsave
Date: Thu, 30 Jul 2020 08:14:31 -0700
Message-Id: <1596122076-341293-28-git-send-email-steven.sistare@oracle.com>
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

From: Mark Kanda <mark.kanda@oracle.com>

A vhost device is implicitly preserved across re-exec because its fd is not
closed, and the value of the fd is specified on the command line for the
new qemu to find.  However, new qemu issues an VHOST_RESET_OWNER ioctl,
which fails because the device already has an owner.  To fix, reset the
owner prior to exec.

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/virtio/vhost.c       | 12 ++++++++++++
 include/sysemu/sysemu.h |  1 +
 migration/savevm.c      |  1 +
 3 files changed, 14 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e..d065b53 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -29,6 +29,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/tcg.h"
 #include "trace.h"
+#include "sysemu/sysemu.h"
 
 /* enabled until disconnected backend stabilizes */
 #define _VHOST_DEBUG 1
@@ -1773,3 +1774,14 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
 
     return -1;
 }
+
+void reset_vhost_devices(void)
+{
+    struct vhost_dev *dev;
+
+    QLIST_FOREACH(dev, &vhost_devices, entry) {
+        if (dev->vhost_ops->vhost_reset_device(dev) < 0) {
+            VHOST_OPS_DEBUG("vhost_reset_device failed");
+        }
+    }
+}
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index c5b2f24..e19c15b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -30,6 +30,7 @@ void load_cpr_snapshot(const char *file, Error **errp);
 void save_chardev_fds(void);
 void save_vnc_fds(void);
 void load_vnc_fds(void);
+void reset_vhost_devices(void);
 void save_qmp_negotiation_status(void);
 
 extern int autostart;
diff --git a/migration/savevm.c b/migration/savevm.c
index 225eaa6..732dfb5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2770,6 +2770,7 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
         save_chardev_fds();
         save_vnc_fds();
         walkenv(FD_PREFIX, preserve_fd, 0);
+        reset_vhost_devices();
         save_qmp_negotiation_status();
         qemu_system_exec_request();
         putenv((char *)"QEMU_START_FREEZE=");
-- 
1.8.3.1


