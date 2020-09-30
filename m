Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D5DC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A202074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="yqeAtQZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A202074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ3I-0008Ho-Cm
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyk-0003Io-Fz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:54 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:55902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyi-0005D2-Jn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:54 -0400
Received: by mail-pj1-x102c.google.com with SMTP id q4so646847pjh.5
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+9cBS9q+xgUSdyMFawIlbdh6WJVyAxWj5RAwUseTc8A=;
 b=yqeAtQZ9/UiLRGqs2WOHGHimF8asXs95C+pXd3cpLCcjyP3fZ+zNHE1RQ3asLkU7CI
 e5J9avb2clZDMBVkMQqEf2sKfVrW5N03S7iYI3DUpeVIipbPiNvN3iuJI11SHN7RwVIX
 xMq86mfmEt5YTJR6qz5tEKhG647InUICT8g7sGVDbIHMJs1qAxM555k4UCIj7n7ebibq
 sHn1NUFjnR+iebIFbftO4iTDravzH3QUGsopVhl7m34h/BwgqlqDmOyJYj+ikyXD9fLL
 EomBtEg016nXky9gfeQLroLzsWnJwaFKc9hOdjBGDUjWeWwzXSmTaOu4u0+3iPbWQzgl
 iDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+9cBS9q+xgUSdyMFawIlbdh6WJVyAxWj5RAwUseTc8A=;
 b=bbCHrjRPpElRo4/c9x8wXiAE4y1EvKb6HVg1iyG3p1iiwhTXyVjemC98/9WRSl8qP6
 clRu92ZMmFaYctn7VKuGKnAhF+FD2xDa7RryaXRrfLVOBixQdBpMtiH6zQt2jBr+nrCu
 HG3Hgg/NohHIds83jMnVqqWlXrTrWQkIL++OXSy1UuhNMQry3eMIbrP3cUy+wb9FeRrC
 bOOOtLB74wHgOD63fA9K2zSOB1jGfnZu6Jbt17X9zK/PXqqesVG8CeMIpggo0wDe4wjE
 nXB+50+ce+4bya0vvrzOoItZnkoW6uxizeca7S6hInx5Aa7l5zPmpHp5qo1RQUe3oalU
 852Q==
X-Gm-Message-State: AOAM531WUzfsYuM8Y1XvJG79jlVN+35TUufLAod7YzUayw3uc7YzSOCJ
 hkJGNvDYX0/wPIz/nVG7Xi9AzIIlmAPIjQ==
X-Google-Smtp-Source: ABdhPJx0WImcJOY1rJGpv3ECsXXMaUKo7BIYErwQFF00ahw9xT4pixxqU4nDxloDs32yr8d2bQhfAQ==
X-Received: by 2002:a17:90b:715:: with SMTP id
 s21mr1754885pjz.113.1601460291309; 
 Wed, 30 Sep 2020 03:04:51 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c185sm1884230pfb.123.2020.09.30.03.04.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:04:50 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v3 2/3] qapi/run-state.json: introduce memory failure event
Date: Wed, 30 Sep 2020 18:04:39 +0800
Message-Id: <20200930100440.1060708-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200930100440.1060708-1-pizhenwei@bytedance.com>
References: <20200930100440.1060708-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x102c.google.com
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
Cc: qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce memory failure events for hyperviso/guest . Then uplayer
could know when/why/what happened during hitting a hardware memory
failure.

Suggested by Peter Maydell, rename events name&description to make
them architecture-neutral; and suggested by Paolo, add more info to
distinguish a mce is AR/AO, previous mce is still processing in
guest or not.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 qapi/run-state.json | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 7cc9f96a5b..d795dc21fc 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -475,3 +475,88 @@
            'psw-mask': 'uint64',
            'psw-addr': 'uint64',
            'reason': 'S390CrashReason' } }
+
+##
+# @MEMORY_FAILURE:
+#
+# Emitted when a memory failure occurs on host side.
+#
+# @recipient: recipient is defined as @MemoryFailureRecipient.
+#
+# @action: action that has been taken. action is defined as @MemoryFailureAction.
+#
+# @flags: flags for MemoryFailureAction. action is defined as @MemoryFailureFlags.
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
+  'data': { 'recipient': 'MemoryFailureRecipient',
+            'action': 'MemoryFailureAction',
+            'flags': 'MemoryFailureFlags'} }
+
+##
+# @MemoryFailureRecipient:
+#
+# Hardware memory failure occurs, handled by recipient.
+#
+# @hypervisor: memory failure at QEMU process address space.
+#              (none guest memory, but used by QEMU itself).
+#
+# @guest: memory failure at guest memory,
+#
+# Since: 5.2
+#
+##
+{ 'enum': 'MemoryFailureRecipient',
+  'data': [ 'hypervisor',
+            'guest' ] }
+
+
+##
+# @MemoryFailureAction:
+#
+# Hardware memory failure occurs, action by QEMU.
+#
+# @ignore: action optional memory failure which could be ignored.
+#
+# @inject: memory failure at guest memory, and guest enables MCE handling
+#          mechanism, QEMU injects MCE to guest successfully.
+#
+# @fatal: action required memory failure occurs. If recipient is hypervior, QEMU
+#         hits a fatal error and exits later. And if recipient is guest, QEMU
+#         tries to inject MCE to guest, but guest is not ready to handle MCE
+#         (typical cases: guest has no MCE mechanism, or guest disables MCE,
+#         or during previous MCE still in processing, an AR MCE occurs). QEMU
+#         has to raise a fault and shutdown/reset. Also see detailed info in
+#         QEMU log.
+#
+# Since: 5.2
+#
+##
+{ 'enum': 'MemoryFailureAction',
+  'data': [ 'ignore',
+            'inject',
+            'fatal' ] }
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
+  'data': { 'action-required': 'bool',
+            'recursive': 'bool'} }
-- 
2.11.0


