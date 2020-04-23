Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DEC55185
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 02:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940102075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 02:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NjtxdxF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940102075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRRvl-0000lW-Is
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 22:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jRRu0-0008Ic-MY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 22:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jRRty-0000dC-SM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 22:47:47 -0400
Received: from m12-16.163.com ([220.181.12.16]:60045)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jRRtw-0000M2-8t
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 22:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=zU48EntpaAnTs1XJQf
 aDHNhT4JTrL5bb5mDEGKr061A=; b=NjtxdxF8T1uY0r5efEoUSQG+0zLoBmgWam
 zkHgzhd2rQn3NgE9VB9/7Xn+1SSEp0rIrxVNwoNxcdbFX5FuLMozDPvTzC0FTvz9
 sszu7sIdJMFuFysPEANzj/pqVIbhzOwRB5DM63K8zj3oZ/kcx2AaSDkAqo+1rHTV
 uPhCdI5BA=
Received: from localhost.localdomain (unknown [39.155.168.46])
 by smtp12 (Coremail) with SMTP id EMCowAC3zi4v_qBe8sKqBA--.44860S2;
 Thu, 23 Apr 2020 10:32:17 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-sockets: add abstract UNIX domain socket support
Date: Thu, 23 Apr 2020 10:32:12 +0800
Message-Id: <20200423023212.20968-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowAC3zi4v_qBe8sKqBA--.44860S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryrXFyDGw4UGF17Xr45Awb_yoW8GF1kpF
 W5K393GrW5Ar4rurs5JayUCr1aya1kG34UW34kJw1S9an8WF18ZFWvkr1UKryUXrWrWrW7
 Crn0gFsIyFZ8tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRS1vhUUUUU=
X-Originating-IP: [39.155.168.46]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbB0hEPxlUMVnudTAAAsv
Received-SPF: pass client-ip=220.181.12.16; envelope-from=zxq_yx_007@163.com;
 helo=m12-16.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 22:32:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 220.181.12.16
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
Cc: xiaoqiang zhao <zxq_yx_007@163.com>, berrange@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

unix_connect_saddr now support abstract address type

By default qemu does not support abstract UNIX domain
socket address. Add this ability to make qemu handy
when abstract address is needed.
Abstract address is marked by prefixing the address name with a '@'.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 util/qemu-sockets.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index bcc06d0e01..d4f02a6b1a 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -939,6 +939,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     struct sockaddr_un un;
     int sock, rc;
     size_t pathlen;
+    socklen_t serverlen;
 
     if (saddr->path == NULL) {
         error_setg(errp, "unix connect: no path specified");
@@ -963,10 +964,18 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     un.sun_family = AF_UNIX;
     memcpy(un.sun_path, saddr->path, pathlen);
 
+    if (saddr->path[0] == '@') {
+        un.sun_path[0] = '\0';
+        serverlen = strlen(saddr->path) + offsetof(struct sockaddr_un, sun_path);
+    }
+    else {
+        serverlen = sizeof(un);
+    }
+
     /* connect to peer */
     do {
         rc = 0;
-        if (connect(sock, (struct sockaddr *) &un, sizeof(un)) < 0) {
+        if (connect(sock, (struct sockaddr *) &un, serverlen) < 0) {
             rc = -errno;
         }
     } while (rc == -EINTR);
-- 
2.17.1



