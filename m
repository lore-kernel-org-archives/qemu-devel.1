Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6BDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF33208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="NKgh89W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF33208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoux-00028S-7P
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHolc-0004SW-Vm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:37 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHolb-0003Dh-Bo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id o20so12649666pfp.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zoKhLvexSKKYei1gir7mK7K/SpLcA8kaJU8i6ucZAWw=;
 b=NKgh89W650cMzLxY0cCC/hzh9Led3M1MVzosGxjYMKCsqjlV/J1icAycchtwdvuu60
 hrhs7X+E19i9ZaxzAIBqtfcIrMnoUpxr1XQ0HKlwsV3xJYxN2gQeV6FX6TBNn8adchUN
 w+HqdC2G+h9dpJYoLH4gekqVb6oUlfsI3g5pzg/3KI+sY/KXaTtUT+ishcmopzRUMIZx
 +7umaITeT36VnGlym/H2l1HokX0bDZJyAHy1d4XK+7uxcETAHZN5ja8cd6X5ruu1tVnU
 NwrBlaaeO5qzz9jMc6puhhFk3DYTKkypxN4qdoka7dVZeyB6SYgbUziGakwLSCWw01w2
 hbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zoKhLvexSKKYei1gir7mK7K/SpLcA8kaJU8i6ucZAWw=;
 b=erL7TqW3X2XLTjugxZZn9USs7LuQTWdtBuYB8CwfumJvTFvAk6uPsdoDjg9ApIIyDm
 T3BOWJhA2dzDc7uNIVRT8HWpcA9gvNN+BHTG3AZXTvJeby1rW246XgthGivhUU6qSYz/
 Hm8iiwmBIQriKeO9Rs/3zyLIJ8UfzRNiRYGBbWjFcn+KDKLtj6m+u5VnreYcoqDKfm9t
 nMI20sKG+z3Yc1sZ1FKMU5kLuQ1GB9+6k0oYpzJa5gLnc6v3xIKi3RwTdpIHxC4mE+li
 WREpVacNYyesLo3lv/1HX8xjA8o0N4MYzbQ0R8mKh4Z/6ZL/2QM9ZIAauii2jjJct48s
 wG0w==
X-Gm-Message-State: AOAM532TM79e9d8Dl3H2MxpY7RPVI+EI4zEUMeJBBBmD/mCUyKR3ZTc4
 jvcQ7bz2dYL7GE8CJYigsrGRFhgOnp+caw==
X-Google-Smtp-Source: ABdhPJy9Ac3gg7uyHLthdUyrmFWrWgUy/wO2Dq1jvBS3jQjmFWFD7gIxlV+wrfQyB3NDy+Q5ZvacZA==
X-Received: by 2002:a63:f53:: with SMTP id 19mr11024521pgp.26.1600091013884;
 Mon, 14 Sep 2020 06:43:33 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c4sm7626378pjq.7.2020.09.14.06.43.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Sep 2020 06:43:33 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: armbru@redhat.com,
	pbonzini@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 2/3] iqapi/run-state.json: introduce memory failure event
Date: Mon, 14 Sep 2020 21:43:20 +0800
Message-Id: <20200914134321.958079-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200914134321.958079-1-pizhenwei@bytedance.com>
References: <20200914134321.958079-1-pizhenwei@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x442.google.com
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
Cc: qemu-devel@nongnu.org, pizhenwei@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce 4 memory failure events for a guest. Then uplayer could
know when/why/what happened to a guest during hitting a hardware
memory failure.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 qapi/run-state.json | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 7cc9f96a5b..fdc39ce262 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -475,3 +475,49 @@
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
+  'data': { 'action': 'MemoryFailureAction'} }
+
+##
+# @MemoryFailureAction:
+#
+# Host memory failure occurs, handled by QEMU.
+#
+# @hypervisor-ignore: action optional memory failure at QEMU process
+#                     addressspace (none PC-RAM), QEMU could ignore this
+#                     hardware memory failure.
+#
+# @hypervisor-stop: action required memory failure at QEMU process address
+#                   space (none PC-RAM), QEMU has to stop itself.
+#
+# @guest-mce: action required memory failure at PC-RAM, and guest enables MCE
+#             handling, QEMU injects MCE to guest.
+#
+# @guest-triple-fault: action required memory failure at PC-RAM, but guest does
+#                      not enable MCE handling. QEMU raises triple fault and
+#                      shutdown/reset. Also see detailed info in QEMU log.
+#
+# Since: 5.2
+#
+##
+{ 'enum': 'MemoryFailureAction',
+  'data': [ 'hypervisor-ignore',
+            'hypervisor-stop',
+            'guest-mce',
+            'guest-triple-fault' ] }
-- 
2.11.0


