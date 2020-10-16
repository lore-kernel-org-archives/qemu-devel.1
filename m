Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA525207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TU8C2WOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA525207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTNuS-0001Dp-B9
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kTNsx-00083z-Qi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:26:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:35161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kTNst-0008P1-KC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:26:57 -0400
Received: by mail-pf1-x429.google.com with SMTP id k8so1336707pfk.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9yP8toNqZXEMn5okbHcbki+5+xtmd1t1JiosrOc17qA=;
 b=TU8C2WOE2EJfVwRCOhvQHzdWTWaET+ysvkI5x65IO+tXhfoAlc4bfwtrwstJAkyTHS
 E1d+UHReRhw1THPijbb+iSqhU6+tFsM2vvMNFNUAu+frE03npiBJU7yeCRebmbxiTjiL
 qpRaC9NC1I4UviKajNTsPhIXUSvEPDZhIDYrxN4ZAWwKrP1oSBnm3pFt6SqfZXX0dDlI
 q+PVqOJHxoVT/b/RW/HGFDpgy+vAXTW7AjI6OFfNhDTXHH2/rZhN5vvSxKkmZOD538Lz
 A8guRnhHGZI305EQQJh8C6y9ndq5I985ydgPw2QAjNCs26ruvU8AFuE5PXOK+CP7ncWi
 Af4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9yP8toNqZXEMn5okbHcbki+5+xtmd1t1JiosrOc17qA=;
 b=Bq6c8bmrX0V/1jzyVvjdaWkXp46dXN7KvzdC8V/zAiWF5FRxFGAcXhbkNJ7QBzR+FZ
 SScjlt2ox0R4svCbSnbG/aeGMtQi0l+3QE5hCaxS1i6/4RPlqkqNKK/WQYdEuJB0ennU
 I08SANahV+XbT5XPLlw2BZlTpYZ5WenlHdG76EaTaGVaOON4ziBuhgqNFwExvN7A7R2J
 B0yLXroo3+uzBnzHmNYYky6ShB1aK9tU72+S543hewIfLNTjf48uq9RDie5UzgoKeVIw
 7V+j+9ZLt0gmB7chbjFsOdPNLwMENr8cVuL4itfYrNdChBtUHBG0ydPqAWXW4eb9Rxem
 rqgQ==
X-Gm-Message-State: AOAM530nacZL2rYII7/MiU1Hu66VrL7c3HMck6N/jDkzk9NfSd+ogt+x
 5A4cacfiDQaLXD2EKdtMYiTFsNlcKFhdmVYJ
X-Google-Smtp-Source: ABdhPJwe6TSHQ1UrfAn0q3l0y6poeeM2SLkGzt8ii3VzLddbjqqjCS5vV7/dpLWULl0V6gylRNvprg==
X-Received: by 2002:a65:4485:: with SMTP id l5mr2728419pgq.121.1602847613226; 
 Fri, 16 Oct 2020 04:26:53 -0700 (PDT)
Received: from MacBook-Pro.local.net ([61.120.150.78])
 by smtp.gmail.com with ESMTPSA id t15sm3238192pjy.33.2020.10.16.04.26.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Oct 2020 04:26:52 -0700 (PDT)
From: wanghonghao <wanghonghao@bytedance.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] QSLIST: add atomic replace operation
Date: Fri, 16 Oct 2020 19:26:39 +0800
Message-Id: <20201016112640.91141-1-wanghonghao@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 wanghonghao <wanghonghao@bytedance.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace a queue with another atomicly. It's useful when we need to transfer
queues between threads.

Signed-off-by: wanghonghao <wanghonghao@bytedance.com>
---
 include/qemu/queue.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index e029e7bf66..1f0cbdf87e 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -226,6 +226,10 @@ struct {                                                                \
         (dest)->slh_first = qatomic_xchg(&(src)->slh_first, NULL);       \
 } while (/*CONSTCOND*/0)
 
+#define QSLIST_REPLACE_ATOMIC(dest, src, old) do {                            \
+        (old)->slh_first = qatomic_xchg(&(dest)->slh_first, (src)->slh_first); \
+} while (/*CONSTCOND*/0)
+
 #define QSLIST_REMOVE_HEAD(head, field) do {                             \
         typeof((head)->slh_first) elm = (head)->slh_first;               \
         (head)->slh_first = elm->field.sle_next;                         \
-- 
2.24.3 (Apple Git-128)


