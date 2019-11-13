Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3284DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B7F222D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSmlikXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B7F222D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUtpJ-0007Ue-FM
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtna-0005hr-M3
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUtnZ-0006I0-OP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUtnZ-0006Hd-Gf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:39:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id l17so2257136wmh.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A6oEcaqPLdIen2KQ+hFkGKCCjU/abr6ShDeleTCaBkU=;
 b=tSmlikXA203u3g/yuMGzzTotMPASusVpWmln/GIQNQS1CcRX88upPTIiD/FYwV/xzq
 +t3SK0p80TVXPBgQNAvJhNb0mdHm21+FZHNQC1y4UQBy1f/6nEIj8NRbvmpAmsO0yOJu
 b3tjsDSi8JZGrdrVsaLHzwKO4PfcYPoRRwvuP9dEusegGHIFD2c8hX8APCQcvKao6lJu
 Sv+PqONvmKIvGxJnm22wlYyYiOIFYiLouUAA1etlIyKjmqqjCNKhdRzThbNj/AAPXRTp
 5c3MMq3bz5KRJG1ZKsYExbfricJV6gqSXt4VT+y+KOm4q7xZ/+sOPWIL2jq5cIlnKXTr
 pZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=A6oEcaqPLdIen2KQ+hFkGKCCjU/abr6ShDeleTCaBkU=;
 b=mXfmI461WegX6Bts4oJnGZP2OUT+pw8qtH6847ZoSb+XnFuOjRaWQ6TiMaTysR/rC/
 /+v7r4rG1gY8LPabDsxR4kZBuAW/f4Jd7XiixCdhTaZhRMe9vlSDujACdyRv23FsuQow
 4yTtzOotnhbCa95mzSemq0x1Kj0ukWZx9LWbVDpDbyiyT89SR4citmo+azfjnJzWVexm
 nl2We/YMlToL70Da35bdpLf1QywqW7dZEBoqJWHr2dZUT9ILr/dvxrAYijyBEnC+AIY6
 0IaO9iFjEs5aAyqjR9MlAX5GhEVtalLdIzT6T0qIO+1NFnFPoG+OFV/m4vVzRD3z2aAZ
 Mb9A==
X-Gm-Message-State: APjAAAXrSO3SfVlqb7lZGyEn5DHHXY7+aGyb/kcOXGD1+b0R8OM+mJmA
 GZUQNvCDRF7li7Yq2EQmCR4OZMwk
X-Google-Smtp-Source: APXvYqyxa9PcRKBCqP/ys4NoVCshVqh87sQ3wECxMg6baWVpJKr9MJFb0fxqLHZ3DzozUKa4rQoJsw==
X-Received: by 2002:a05:600c:2058:: with SMTP id
 p24mr2865406wmg.134.1573655948065; 
 Wed, 13 Nov 2019 06:39:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s11sm2965823wrr.43.2019.11.13.06.39.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Nov 2019 06:39:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/16] memory: do not look at current_machine->accel
Date: Wed, 13 Nov 2019 15:38:50 +0100
Message-Id: <1573655945-14912-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: thuth@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"info mtree" prints the wrong accelerator name if used with for example
"-machine accel=kvm:tcg".  The right thing to do is to fetch the name
from the AccelClass, which will also work nicely once
current_machine->accel stops existing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index c952eab..1764af8 100644
--- a/memory.c
+++ b/memory.c
@@ -2986,7 +2986,6 @@ struct FlatViewInfo {
     bool dispatch_tree;
     bool owner;
     AccelClass *ac;
-    const char *ac_name;
 };
 
 static void mtree_print_flatview(gpointer key, gpointer value,
@@ -3056,7 +3055,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
                 if (fvi->ac->has_memory(current_machine, as,
                                         int128_get64(range->addr.start),
                                         MR_SIZE(range->addr.size) + 1)) {
-                    qemu_printf(" %s", fvi->ac_name);
+                    qemu_printf(" %s", fvi->ac->name);
                 }
             }
         }
@@ -3104,8 +3103,6 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner)
 
         if (ac->has_memory) {
             fvi.ac = ac;
-            fvi.ac_name = current_machine->accel ? current_machine->accel :
-                object_class_get_name(OBJECT_CLASS(ac));
         }
 
         /* Gather all FVs in one table */
-- 
1.8.3.1



