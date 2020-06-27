Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB2320775
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 17:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zb9Dzq9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB2320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpESG-0003Ak-AC
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 13:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpENA-0002RN-Pd
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jpEN8-0007Rv-Rn
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 13:12:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RHC01n193134;
 Sat, 27 Jun 2020 17:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=G/fseAFPQfbAIJooU997W+O6g6K8cG3OMnwqRRi1KUQ=;
 b=zb9Dzq9+iJdWiDLjza4dD9S+ZOGhS2AO3DPZ8N7ZU6ZiQfZL0SNB/GTMK/XsFLZ6ahph
 sXi+IREBprNDNm2J1ZBk2BiWHe6icxxM1OXsx7V0vBCRQuAsk9A8fwXy4cMHUVXiRkCm
 63EKs1xYxa54IDOfnnnxbn8F2TrabTX7tLztIzbTTkchCxzeCsAx9usI9kfCg+9qKG2K
 5HVJztAyC72pQyl0LXg/e0dixUcKNGreRPPhtQ31kY9HySyBsEiHjMeoB4DUN5UGqepP
 wQMAMErBI4PtT08NW4+O3x9P2x8q1mlMrZhzfIdf60rTDlSdo9EH/WVUH6dsvy819OOd pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 31wxrms9ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 27 Jun 2020 17:12:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05RH8RwI102275;
 Sat, 27 Jun 2020 17:09:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 31wwx17sce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Jun 2020 17:09:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05RH9uPo030517;
 Sat, 27 Jun 2020 17:09:56 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sat, 27 Jun 2020 10:09:55 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/21] multi-process: add qio channel function to transmit
Date: Sat, 27 Jun 2020 10:09:27 -0700
Message-Id: <cb545beadb8584feabcb5c8a0eabcda4ef4becd9.1593273671.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1593273671.git.elena.ufimtseva@oracle.com>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=3
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006270124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9665
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=3 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006270124
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 13:10:10
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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

The entire array of the memory regions and file handlers.
Will be used in the next patch.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 include/io/channel.h | 24 +++++++++++++++++++++++
 io/channel.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index d4557f0930..c2e3eaeafc 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -779,5 +779,29 @@ void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
                                     IOHandler *io_read,
                                     IOHandler *io_write,
                                     void *opaque);
+/**
+ * qio_channel_writev_full_all:
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @fds: an array of file handles to send
+ * @nfds: number of file handles in @fds
+ * @errp: pointer to a NULL-initialized error object
+ *
+ *
+ * Behaves like qio_channel_writev_full but will attempt
+ * to send all data passed (file handles and memory regions).
+ * The function will wait for all requested data
+ * to be written, yielding from the current coroutine
+ * if required.
+ *
+ * Returns: 0 if all bytes were written, or -1 on error
+ */
+
+int qio_channel_writev_full_all(QIOChannel *ioc,
+                           const struct iovec *iov,
+                           size_t niov,
+                           int *fds, size_t nfds,
+                           Error **errp);
 
 #endif /* QIO_CHANNEL_H */
diff --git a/io/channel.c b/io/channel.c
index e4376eb0bc..22c10c5ccc 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -190,6 +190,51 @@ int qio_channel_writev_all(QIOChannel *ioc,
     return ret;
 }
 
+int qio_channel_writev_full_all(QIOChannel *ioc,
+                                const struct iovec *iov,
+                                size_t niov,
+                                int *fds, size_t nfds,
+                                Error **errp)
+{
+    int ret = -1;
+    struct iovec *local_iov = g_new(struct iovec, niov);
+    struct iovec *local_iov_head = local_iov;
+    unsigned int nlocal_iov = niov;
+
+    nlocal_iov = iov_copy(local_iov, nlocal_iov,
+                          iov, niov,
+                          0, iov_size(iov, niov));
+
+    while (nlocal_iov > 0) {
+        ssize_t len;
+        len = qio_channel_writev_full(ioc, local_iov, nlocal_iov, fds,
+                                      nfds, errp);
+        if (len == QIO_CHANNEL_ERR_BLOCK) {
+            if (qemu_in_coroutine()) {
+                qio_channel_yield(ioc, G_IO_OUT);
+            } else {
+                qio_channel_wait(ioc, G_IO_OUT);
+            }
+            continue;
+        }
+        if (len < 0) {
+            goto cleanup;
+        }
+
+        iov_discard_front(&local_iov, &nlocal_iov, len);
+
+        if (len > 0) {
+            fds = NULL;
+            nfds = 0;
+        }
+    }
+
+    ret = 0;
+ cleanup:
+    g_free(local_iov_head);
+    return ret;
+}
+
 ssize_t qio_channel_readv(QIOChannel *ioc,
                           const struct iovec *iov,
                           size_t niov,
-- 
2.25.GIT


