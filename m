Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6DDC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1CC2087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK8Zti3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1CC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW6D-0003Jv-K3
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2v-0005Yi-CI
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW2u-0000N0-EO
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW2u-0000Md-9I; Tue, 30 Jul 2019 13:36:20 -0400
Received: by mail-pf1-x442.google.com with SMTP id t16so30174718pfe.11;
 Tue, 30 Jul 2019 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NXuVmvKVvaaCTBLbPMTd941jc9j4FEh2ipsZBGZH/Ck=;
 b=BK8Zti3K0yzBkniUOUGbVHiOjeuxOxWLKH2CU926tyFH7UUYCswvnyjVRjYIkmeGUh
 Qv3Yan/DpDIvggy9DtItC3tNf9Pei/ZTrkSr7rIUTQybc05sye1Ob8CjA6fkFWE5g/ng
 Ad73wwDje8MoKvBLw/n06Yd/M57GEY5GlKYw1ZUPbLGI1eWnzNRMCXbOWcdS2Q1huSCh
 ylGPOE8pqwbpRlA7B3vISm024tLTzeFizjO6RZ6Z9Kbk5a7UdIYfBS08xysozVvjKqm5
 C/jGQB8hXjDMJtulx/ZDpwu7zd1ttlFfoOoLHYao53L3gZVwWk0IdyeRFCftYoWNnzuy
 yJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NXuVmvKVvaaCTBLbPMTd941jc9j4FEh2ipsZBGZH/Ck=;
 b=JuI8l89YWQKuW2xR71vPCqmblnN1reuUePtSk5DDLKEKSWmenc5Kp6Y5YtlGcw7J78
 lAzlOExvlEvpIn9I6t6EuZqUuGSASsaVFYf8JUzPjJAm7buVqQlmA5ZtG1B+2p52lyEe
 xtq68oGEhcOxfRDGIWdQ12v02iPbwJl9V4msl/nO4V7PuBLjo3xgPg0sbqr/R/UsZ80S
 z2YmR6dhYnk7lrbIG1Ab2uAynP72PuRErhn/R9hdV5XDzO9v6cW51ohck3IWHBPPuqaj
 Cer3R5gWWI0tL/R9xpd5UHXRFzUZ42mqb6FiKc3wXCuA5KWwE5FL08IyFOsG5IfY8215
 ExfA==
X-Gm-Message-State: APjAAAVgsy0JZKWUVg9xCeFQ1UPAWb2KgC3ssd8v8TpTJzmIJta+EB73
 V0HDVLSkPMnzrGbNdWlHbc/zhZyVFUBlcg==
X-Google-Smtp-Source: APXvYqxsesaQAvRgWcFtxDQ8PhkYZt+CXNDx10IKa3OSN0UaLV+DN67OUlDWFxnB1ehrrh4DmQJHCg==
X-Received: by 2002:a17:90a:258b:: with SMTP id
 k11mr113181991pje.110.1564508178658; 
 Tue, 30 Jul 2019 10:36:18 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.36.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:36:18 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:35 +0530
Message-Id: <20190730173441.26486-11-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v8 10/16] block/io_uring: adds userspace
 completion polling
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index ba739ebe06..e2bef380e7 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -238,6 +238,21 @@ static void qemu_luring_completion_cb(void *opaque)
     luring_process_completions_and_submit(s);
 }
 
+static bool qemu_luring_poll_cb(void *opaque)
+{
+    LuringState *s = opaque;
+    struct io_uring_cqe *cqes;
+
+    if (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
+        if (cqes) {
+            luring_process_completions_and_submit(s);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void ioq_init(LuringQueue *io_q)
 {
     QSIMPLEQ_INIT(&io_q->submit_queue);
@@ -395,7 +410,7 @@ void luring_attach_aio_context(LuringState *s, AioContext *new_context)
     s->aio_context = new_context;
     s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
     aio_set_fd_handler(s->aio_context, s->ring.ring_fd, false,
-                       qemu_luring_completion_cb, NULL, NULL, s);
+                       qemu_luring_completion_cb, NULL, qemu_luring_poll_cb, s);
 }
 
 LuringState *luring_init(Error **errp)
-- 
2.21.0


