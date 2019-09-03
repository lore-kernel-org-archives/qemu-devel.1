Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF810207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BiizWxPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF810207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fbm-0000Uw-75
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZa-00072b-9f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZY-0008Qh-U2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZY-0008KX-FW
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KYAwX053836;
 Tue, 3 Sep 2019 20:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=BmCXB0MhPfbpv+lvsEbmzbJ4q1qBl65OEA69sFifD6k=;
 b=BiizWxPF22m2XtTInxooASMdRsUk7f2Gq9V5u1BKJ4nfxSeM5dBguoKkOIVUgpjc3kyH
 qldY1mvdS9XFSFY9nrl0LooOceUkiHxjMmCesvTKmStga0NG1p7R1CDe0vtNDTTFUN5k
 2LJwOsA1wcCjah5M3RcghSnWLIdLJoAiahd1rZ7vZvQmKjaiA7XQzM1yvfD8EUPIIR99
 jEq00rCb7ym9qnw2lpU/umyVKU22YlvnmbrzBCp42HFqe1CfYxfTayWkW6nRlUnFmrkG
 vS37PUcDS9XALnOs0wxS/wQPsqXY59jvLnYbQEMR4OYGtLcJcwsiySclsEhWoNYp9iik aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2usy6n01wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcAIN025408;
 Tue, 3 Sep 2019 20:38:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2us5ph9yk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:28 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KcQKU028537;
 Tue, 3 Sep 2019 20:38:27 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:26 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:28 -0400
Message-Id: <32b6764ce960a792b6f523d615ff160ef7d3d12e.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 02/45] multi-process: util: Add
 qemu_thread_cancel() to cancel running thread
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_thread_cancel() added to destroy a given running thread.
This will be needed in the following patches.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 include/qemu/thread.h    |  1 +
 util/qemu-thread-posix.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a9..78791be 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -156,6 +156,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
                         void *(*start_routine)(void *),
                         void *arg, int mode);
 void *qemu_thread_join(QemuThread *thread);
+void qemu_thread_cancel(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 void qemu_thread_exit(void *retval);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 1bf5e65..7c89071 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -573,3 +573,13 @@ void *qemu_thread_join(QemuThread *thread)
     }
     return ret;
 }
+
+void qemu_thread_cancel(QemuThread *thread)
+{
+    int err;
+
+    err = pthread_cancel(thread->thread);
+    if (err) {
+        error_exit(err, __func__);
+    }
+}
-- 
1.8.3.1


