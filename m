Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE4CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA322388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="RHzC4Fj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA322388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKf5o-0007rB-Rk
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2U-0002RR-JU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:35423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2S-0001sM-OG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id k8so11968974pfk.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Uq/e3kDQ8bi9U/Y2eWtsT7JIOpjroHauOp1FhUJ+aGU=;
 b=RHzC4Fj5sQCX8L7J4kmLqjRuRELpu1LSqD/2iI+DmiopC03DRXBsOfen/d8R0Ks6n7
 4fsF8UzRMLfLcLom/0xsz7JIXBK4v98RFS3krRGIf538WSR/bk389yX1iRlacqGDTAXZ
 IzA1WiBKJ6x/XNLpp/jzDMEAnKHNhD6WYoHDWu+IakGLh8RqR+NPDz1AKzKXn1HTbBo4
 Q1R6Mn4HBFrXP0llXkVMA0aSwNqtn26/KJCtjKLJ5rHZVTcy9FYB9sCWamURArRNr/pA
 vC/lpOA44Mb4ow1TEZc/xNnUbkh3XSUnU1tPuh+m0UERAlBCC0qNo8Y3NJxDuBYl/OPB
 Gz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Uq/e3kDQ8bi9U/Y2eWtsT7JIOpjroHauOp1FhUJ+aGU=;
 b=NdlUjQbLM1y8PuNk0UWbkZv7NgdZd9ZCPdo2iOk6pFOryy4+PbKvutBvsLByuZfjAx
 zblR8eqlPn452RqXsO+wHeYHxcSGsKR7FMZpG+6KdjJZwwoLjzcW44vrK+hzNW3kH/TY
 PBmlnON03IvGQdgYT9QxpAgVJtlhNKRPkG2gntKiktgq75O+EMpXXbSfhxCqEo2jC++U
 xQAZm8HXNQpbOYebR2Jtj9ZrFoAS49GhRGCUiyVyXFbUx9zm+T4QScJQRrmQoHCf2q+p
 4NoytC2hM2io5XldxImcN396oZ3nE0vUwgMlQ9IFnMT7DPQ9ACRs3G/1j/1SJo1g40p9
 AveQ==
X-Gm-Message-State: AOAM533DFBH/z8mkKmcmXtCD2ri4T9sKtTo5tKSIJSsaNKNGOABdvUyJ
 sW4zMpHo2X3f3SZ+u8j/1i5iDQ==
X-Google-Smtp-Source: ABdhPJypq0QKnZwTRNlvH8UZz80TqziW0Jax8kXY1JyMopFmqGk741s7JVd93CGFEi+yPeeL7Nyyng==
X-Received: by 2002:a63:1257:: with SMTP id 23mr2639600pgs.401.1600768603380; 
 Tue, 22 Sep 2020 02:56:43 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id e2sm2013239pjm.27.2020.09.22.02.56.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:56:42 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v2 2/3] qapi/run-state.json: introduce memory failure event
Date: Tue, 22 Sep 2020 17:56:29 +0800
Message-Id: <20200922095630.394893-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200922095630.394893-1-pizhenwei@bytedance.com>
References: <20200922095630.394893-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42d.google.com
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
Cc: mtosatti@redhat.com, armbru@redhat.com, pizhenwei@bytedance.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce 4 memory failure events for a guest. Then uplayer could
know when/why/what happened to a guest during hitting a hardware
memory failure.

Suggested by Peter Maydell, rename events name&description to make
them architecture-neutral; and suggested by Paolo, add more info to
distinguish a guest-mce is AR/AO.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 qapi/run-state.json | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 7cc9f96a5b..f40111ac67 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -475,3 +475,70 @@
            'psw-mask': 'uint64',
            'psw-addr': 'uint64',
            'reason': 'S390CrashReason' } }
+
+##
+# @MEMORY_FAILURE:
+#
+# Emitted when a memory failure occurs on host side.
+#
+# @action: action that has been taken. action is defined as @MemoryFailureAction.
+#
+# Since: 5.2
+#
+# Example:
+#
+# <- { "event": "MEMORY_FAILURE",
+#      "data": { "action": "guest-mce" } }
+#
+##
+{ 'event': 'MEMORY_FAILURE',
+  'data': { 'action': 'MemoryFailureAction',
+            '*flags': 'MemoryFailureFlags'} }
+
+##
+# @MemoryFailureAction:
+#
+# Hardware memory failure occurs, handled by QEMU.
+#
+# @hypervisor-ignore: action optional memory failure at QEMU process address
+#                     space (none guest memory, but used by QEMU itself), QEMU
+#                     could ignore this hardware memory failure.
+#
+# @hypervisor-fatal: action required memory failure at QEMU process address
+#                    space (none guest memory, but used by QEMU itself), QEMU
+#                    has to stop itself.
+#
+# @guest-mce-inject: memory failure at guest memory, and guest enables MCE
+#                    handling mechanism, QEMU injects MCE to guest.
+#
+# @guest-mce-fatal: memory failure at guest memory, but guest is not ready to
+#                   to handle MCE(typical cases: guest has no MCE mechanism, or
+#                   guest disables MCE, or during previous MCE still in
+#                   processing, an AR MCE occurs). QEMU has to raise a fault and
+#                   shutdown/reset. Also see detailed info in QEMU log.
+#
+# Since: 5.2
+#
+##
+{ 'enum': 'MemoryFailureAction',
+  'data': [ 'hypervisor-ignore',
+            'hypervisor-fatal',
+            'guest-mce-inject',
+            'guest-mce-fatal' ] }
+
+##
+# @MemoryFailureFlags:
+#
+# Structure of flags for each memory failure event.
+#
+# @action-required: describe a MCE event as AR/AO.
+#
+# @recursive: previous MCE in processing in guest, another AO MCE
+#             occurs, set recursive as true.
+#
+# Since: 5.2
+#
+##
+{ 'struct': 'MemoryFailureFlags',
+  'data': { '*action-required': 'bool',
+            '*recursive': 'bool'} }
-- 
2.11.0


