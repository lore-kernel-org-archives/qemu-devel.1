Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C27C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9382075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rgMEA0ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9382075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTHC-00017g-2N
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTFy-0007lK-Gl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTFx-0006D2-S5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTFx-00066Y-BU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:14:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CTwN131569;
 Thu, 23 Apr 2020 04:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=nejQGl7VLDebQVpqXGMyWrYDcxZVwsmS5OWDBlOa5NY=;
 b=rgMEA0abf2EDRwtHOVl2PPs7iyeJDN40YR26HE4JNrEnuAeZ6SzvzPYxays8Rsc3DUXo
 TrU/bOEO1PE990MAjJ0ZGcpiKabgOxUBeRUU/Q4fAMAjX+PbV0wgprluUkEDl9B+aVkP
 JikECSoP60S0x9ISUqQ259aZYlzgAX968tGfs99o4pJD96raE0Gy5kGve4QAzJcMbOy/
 KvhPOhDP6XAUZuHsJ0p21RrFD5TTiw3ovvptedYwVSrH3FKSvzQ2BQvTsDZQ93VF/xBg
 bwwXny7aFzh1FofUskm4YGcEAGV+/Uw7bJgyJ6DM6pYqgTe+w0EICI9I4Eda0cB8pDBS Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 30jvq4s8y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CZsI156871;
 Thu, 23 Apr 2020 04:14:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 30gbbjtw22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:25 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4EOIj026393;
 Thu, 23 Apr 2020 04:14:24 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:24 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 04/36] multi-process: Refactor chardev functions out
 of vl.c
Date: Wed, 22 Apr 2020 21:13:39 -0700
Message-Id: <fe712ae6406af4bf52f33325db4aa8889fb99f7a.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=141.146.126.78;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:28
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

Some of the initialization helper functions w.r.t chardev
in vl.c are also used by the remote process. Therefore, these functions
are refactored into shared files that both QEMU & remote process
could use.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 chardev/char.c         | 14 ++++++++++++++
 include/chardev/char.h |  2 ++
 softmmu/vl.c           | 14 --------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..47dcf93da7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1196,3 +1196,17 @@ static void register_types(void)
 }
 
 type_init(register_types);
+
+int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
+{
+    Error *local_err = NULL;
+
+    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return -1;
+        }
+        exit(0);
+    }
+    return 0;
+}
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 00589a6025..0804e78f7a 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -290,4 +290,6 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
 /* console.c */
 void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp);
 
+int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp);
+
 #endif
diff --git a/softmmu/vl.c b/softmmu/vl.c
index d1b32a33a2..6e35f3787d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2038,20 +2038,6 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
     return qdev_device_help(opts);
 }
 
-static int chardev_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    Error *local_err = NULL;
-
-    if (!qemu_chr_new_from_opts(opts, NULL, &local_err)) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return -1;
-        }
-        exit(0);
-    }
-    return 0;
-}
-
 #ifdef CONFIG_VIRTFS
 static int fsdev_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-- 
2.25.GIT


