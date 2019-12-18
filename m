Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E0C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8484D2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfRJFl5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8484D2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYTm-0001lx-7P
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3A-0006MZ-Q8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY39-0000hv-Ju
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:32 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY39-0000eD-9l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:31 -0500
Received: by mail-wm1-x332.google.com with SMTP id f129so1611039wmf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M7st8zYRftA//6nYaWbb7lkO5v3FUGpG+F+usf39Ve4=;
 b=YfRJFl5VtYNlKCyjkld3TPF8k1UR3owE4ZgFqyH+mbdGd2b1eRM0XOaJQtgvyMH/lH
 mxPTB+J9CQ2c/4RORI8w3+TdZ6TgF8t9nV6PwCgyK59J0HljDMoC3umWYNbJqtlxCOcm
 /mLJxqy/WgWA1+6PU+L91+8G+rSqEThDJ/ybVXVU2K/CBuVDYpdvV/YRd5s8x4CmsN9s
 78hGFpfqklfWyYQJweSn291wubwrsuKFNRRTg21BfcxoBmIfciCwabnwKwRX8OAWZrdw
 DRZKQgOi/4JuwuHRQvjFjlF16TRj1WE9ZYyZ3706KoW4q1bOaNufB13p/9goNHip1YBx
 4/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=M7st8zYRftA//6nYaWbb7lkO5v3FUGpG+F+usf39Ve4=;
 b=lBONz5Bf/8rbUHKVIkBa15uaSFSMDitEOuFHdvtkSrX385yTL19BMnzp3vY+vsdBMB
 4Pm+lIKOvD1BPD8ERlAJYqr4iHtuC0ygd7KnmHCJewvOX3CWnEn2xG5psCL7TyUqyV0u
 Dmhp+MOBiUCZsIGmhagpuDbDp3sjaRo0UNV6Z/UUdVo9AL0iEdMNDNl2HPwzh5sggzNY
 zmcNO0MavOS9bogZ5zSRV5EA2qbppoykGC22tpBedHvWfIEkf8MsKI6AP+QoKUB3kvxl
 +T7PtlBwJqWlb2p9Od0fw3xcOqUXGNIJfI/fRY+rGfDdjqXhRFBbEq936O0FdSQ753e4
 fPTA==
X-Gm-Message-State: APjAAAVGLp7zXSEckiD443rMp96hD73ZbVVoMJB/zgs0+4Y0xk4elN0d
 6VYpMomwJM9Igk87q7nLrzMc1jVY
X-Google-Smtp-Source: APXvYqxC01kCDU71i1V4ZVX8np9KmBC21m9bVHDEXAardiJnHHkPeLxsj9uRKiVYKV+mVkZq0zIhow==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr2887169wmj.75.1576670609806; 
 Wed, 18 Dec 2019 04:03:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/87] migration: fix maybe-uninitialized warning
Date: Wed, 18 Dec 2019 13:02:00 +0100
Message-Id: <1576670573-48048-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../migration/ram.c: In function ‘multifd_recv_thread’:
/home/elmarco/src/qq/include/qapi/error.h:165:5: error: ‘block’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  165 |     error_setg_internal((errp), __FILE__, __LINE__, __func__,   \
      |     ^~~~~~~~~~~~~~~~~~~
../migration/ram.c:818:15: note: ‘block’ was declared here
  818 |     RAMBlock *block;
      |               ^~~~~

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 38070f1..219e3ca 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -863,15 +863,17 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
 
-    if (p->pages->used) {
-        /* make sure that ramblock is 0 terminated */
-        packet->ramblock[255] = 0;
-        block = qemu_ram_block_by_name(packet->ramblock);
-        if (!block) {
-            error_setg(errp, "multifd: unknown ram block %s",
-                       packet->ramblock);
-            return -1;
-        }
+    if (p->pages->used == 0) {
+        return 0;
+    }
+
+    /* make sure that ramblock is 0 terminated */
+    packet->ramblock[255] = 0;
+    block = qemu_ram_block_by_name(packet->ramblock);
+    if (!block) {
+        error_setg(errp, "multifd: unknown ram block %s",
+                   packet->ramblock);
+        return -1;
     }
 
     for (i = 0; i < p->pages->used; i++) {
-- 
1.8.3.1



