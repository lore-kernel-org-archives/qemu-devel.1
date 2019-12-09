Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E2AC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1E220726
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk1JqgRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1E220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKaC-0005El-Su
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXn-0003Kl-S0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXm-0001Cj-SQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:51 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXm-0001CC-LQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:50 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so15826614wmc.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aB/U/Tf7guynfrwJbWpfYI+QRcweDccxGqmzLn8iwE8=;
 b=sk1JqgRjhOOTr/dRvGHkiH1p7uHgB+CVM18UIPOXrpZhbYnRlrbR7qYmXbJm+NqPh5
 HOW7KUy+BTldeVw34HHJD4t5H41DSio7UNdj1dP6I84U0A8d641c5Em57lHw+nUhIP9l
 UwQ+Tf7gSymC86/GYraCe6iUrLEpwJr65S4gJPNHg0RzEXU/z4kYHcKCdNdI9bUDR2ve
 2+Hg1EWjXJ1448TVrpezcLXX8nP25fqRqw97ABQOZHY6YLRrOhWbkcwC34Q9MlYazABe
 XfogqzsAWw0YVerOGgXFBrSHn++wfFLSPbTO875k28077a3VI1QpWg4ys7kCbjlpR7oW
 obZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aB/U/Tf7guynfrwJbWpfYI+QRcweDccxGqmzLn8iwE8=;
 b=o5JC25k4ShpkiwLXI37B+e4ibUHNm8veo+B6leYJDsz87LbDaQiT5ieshwQXHFdR4V
 i+ZeQ3LdCFXXjBb7xGMyiLdORu5eAX2Kge98pCIryu6fqfrV8CK+GZcjd67RGmDCUbbj
 yCg7agNKiNQnerSMua9RmsWSiBZnyuvP9z051jJ/ORRU+m7HLMlA7a536+ntFc3UUd08
 isdeovKT4kHihBe6Is8gEot1QxiDUc6vnOJNZsehkyjYsetqzNqHJOYyyNNyiJUyE9LK
 wCbHoaDThIan3kHPPGJaTEQv6CBVLzWkqAOxYqO42z2O2vbizD4oRT+kaFcytJwN9w6p
 ZOxQ==
X-Gm-Message-State: APjAAAV6Zdo/xNG7rBNj7gk8Mn0AUT4hs0o21iYnhbuFDpNE1lpLgH8s
 Nua8cKUkcDF9UaPLIOHOsyog+pA/
X-Google-Smtp-Source: APXvYqyQRF5WjfoEOlGUpyWr04KG4TTpEclG8hBiFJIoujG7eRKtcSBbMSGw79YhtW6i8GmzZiVs5A==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr25987309wmc.161.1575903708518; 
 Mon, 09 Dec 2019 07:01:48 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/18] memory: do not look at current_machine->accel
Date: Mon,  9 Dec 2019 16:01:28 +0100
Message-Id: <1575903705-12925-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"info mtree -f" prints the wrong accelerator name if used with for example
"-machine accel=kvm:tcg".  The right thing to do is to fetch the name
from the AccelClass, which will also work nicely once
current_machine->accel stops existing.

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 06484c2..6d79cf1 100644
--- a/memory.c
+++ b/memory.c
@@ -2979,7 +2979,6 @@ struct FlatViewInfo {
     bool dispatch_tree;
     bool owner;
     AccelClass *ac;
-    const char *ac_name;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -3049,7 +3048,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
                 if (fvi->ac->has_memory(current_machine, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) {
-                    qemu_printf(" %s", fvi->ac_name);
+                    qemu_printf(" %s", fvi->ac->name);
                 }
             }
         }
@@ -3097,8 +3096,6 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
 
         if (ac->has_memory) {
             fvi.ac = ac;
-            fvi.ac_name = current_machine->accel ? current_machine->accel :
-                object_class_get_name(OBJECT_CLASS(ac));
         }
 
         /* Gather all FVs in one table */
-- 
1.8.3.1



