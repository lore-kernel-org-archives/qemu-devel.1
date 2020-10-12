Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B66C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D012067C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvYICIhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D012067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0DX-0005Z0-0C
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqr-0007Oz-FI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:35:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqe-0007MV-Es
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:35:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id a72so6922029wme.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TFEeAigEIjpMhWK7DoHcFuCUqfcQKRxgqCRDpAIxz64=;
 b=JvYICIhMLv4zFkf9pBCtbx9anD+Ds35GexppRV3VwkBSIooNwcjog+od02pop5BRJ3
 POQF0HomuH4ORVut/cS1Jl1pn5vYtGpDVK/bu6ObWxsaNfF1jNMch7dwmv37MUxrEVa9
 /gTRTNsLGZnkvJcmZdv3bJKGVBUSXUoZscUUfrfrmFJtpfr2j2gkMbluIfjNouixAtNu
 O2jZtiDzSZvnJH5qvXbmNuL37qb1ihRjxIBJ7NRvBmftL7WmIGaWgVbHWJkfosKocHcG
 DFARHoU5hryh5Mj3H/mPE0d1WKt+fAb6033PiB0PKDhvkiEsGcaHWH4OlAXJ8sOjNEcI
 bpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TFEeAigEIjpMhWK7DoHcFuCUqfcQKRxgqCRDpAIxz64=;
 b=XZ1rwhnJ7waSYS5FiH5zV1r2tot5i1/TjH+3uCRYQyIcuJfKZUEJ4ILRwGYh6MWBpT
 YWeoJUREJ6vNH6Jxj6Ipu9+7nqMWKM9zq/vcylfBjvmxKNTKslkhdAilNOanCwZZeILZ
 aG/ARSSwt1l+3Gu+n2cW4KGVfjZmpmIvr6wCyYYiBgYqVXGz19I0IaUQeOMOk7SjsOWp
 Jd7bhmcYRlSr7bVWSIhHRswFmgro5nMnqhCtyJBNEMNc8VbG7LYIOg7a8pyn4wDgR3sb
 v1Dthuh2c3j3aBF+O7/I4swTejiZXMMgT/PSh5ik3ncvxoenf/oqVsB8sveo8uVw2CW3
 k6iw==
X-Gm-Message-State: AOAM531bdQXm1FXn2xK9RQQFBg3lyGQS+k16p0YnvT8LcYhFk8VGMPCx
 BHbWqx5LQE+P6/yzEiy+v5ljeg==
X-Google-Smtp-Source: ABdhPJwArLN0tTpsSJ4Jg1YrFeNwJJ+/NEmVlovzDDUHp8LZVH5GzYSchA8abKrlyHUyPMwR/A1Htg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr11600760wmb.143.1602516880521; 
 Mon, 12 Oct 2020 08:34:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
Date: Mon, 12 Oct 2020 16:33:49 +0100
Message-Id: <20201012153408.9747-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a documentation comment for qemu_get_thread_id(): since this
is rather host-OS-specific it's useful if people writing the
implementation and people thinking of using the function know
what the purpose and limitations are.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Based on conversation with Dan on IRC, and prompted by the recent
patch to add OpenBSD support.

Q: should we document exactly what the thread-id value is for
each host platform in the QMP documentation ? Somebody writing
a management layer app should ideally not have to grovel through
the application to figure out what they should do with the
integer value they get back from query-cpus...

 include/qemu/osdep.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4841b5c6b5f..8279f72e5ed 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -515,6 +515,20 @@ bool qemu_has_ofd_lock(void);
 
 bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
+/**
+ * qemu_get_thread_id: Return OS-specific ID of current thread
+ *
+ * This function returns an OS-specific identifier of the
+ * current thread. This will be used for the "thread-id" field in
+ * the response to the QMP query-cpus and query-iothreads commands.
+ * The intention is that a VM management layer application can then
+ * use it to tie specific QEMU vCPU and IO threads to specific host
+ * CPUs using whatever the host OS's CPU affinity setting API is.
+ * New implementations of this function for new host OSes should
+ * return the most sensible integer ID that works for that purpose.
+ *
+ * This function should not be used for anything else inside QEMU.
+ */
 int qemu_get_thread_id(void);
 
 #ifndef CONFIG_IOVEC
-- 
2.20.1


