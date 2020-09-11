Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E907C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE223223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kw/nI0EH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE223223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkUW-0007sw-Uz
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGkTk-0007Bp-QQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:56:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGkTi-00008E-Tm
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:56:44 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so11794880wrt.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=19qgvsEOvtswh8P/1dIqVPRRk97gM4HoI/2ZL6WyXNM=;
 b=Kw/nI0EHB4IeP+i1ReNpOy+QSuyzY72a5JdRzhNLg5cJW9eBlzvjY6YbzW/oKX6TP0
 zrJpIdWoN1M/X4cARWMhUFqKcvSxtfnFqgDLPJNC/8+PSMVcmQBOVUliahoMgv8fLrvp
 z5Z6Kj9KaY6yZ3joGCsxueMm7+kgTAe7sAUtBDfZUpD/lr1fhtYCvqIzjZfoPp9Zza6H
 tzpyp4Mkxipx3kJlTJ4Fv8xzlLdKTShLy34OVQWG3moia6wzygXMlhwQJZv4h1NfRP0d
 9qkKv+RaRm7FTCeZ2Mmu5cAPZDpf4nRApMpXV1cncRQheGymGhWAmFNQRHVLlMhQMZ36
 9/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=19qgvsEOvtswh8P/1dIqVPRRk97gM4HoI/2ZL6WyXNM=;
 b=hiY68fKuNtM+fEYo4wr+K6usaEYfJsy/aUpf2x9GeKdlbCkRr/K8Lkj9896KAo8BVl
 5Xt0p4tFWDeFE7d6rX6larlXVh3HNPinTKPAL9ojLZ/DGicaoZfjC5O4ZXlUij8LiVXq
 3eU5cB5Cdi7eUf5gl+WaZ6IatzivWbXGw0etDkLTNCGKziXuLLsorhh9fa+mZ6gR0OHI
 TFEWdJCpACfIxz05wYLs9KzWLEpONnyJirRqCEwIzid+hKpbLux8iRx5G1YbqP725Lwa
 Wo1rWg5zLJmu4Ko5xIgYqXqZ3eP45SYAHOc+J/n8vcAby0OvV5btvaKeEbEt0P/VEjjy
 Ll8w==
X-Gm-Message-State: AOAM533wu1Cpvd12WGlvC/dGMiLqjM+FX34/f2I9jPwbINcsBRxnPYvg
 xE4ab0KVsEaZ3PTFHsnY3kMPNg==
X-Google-Smtp-Source: ABdhPJymy9RyjqBQ5/FnU5nE+rvyc1pFrfuYlH1d3RDquTy5swTqVKh4mHIkClpzMJf/rZ9cv3OaOQ==
X-Received: by 2002:adf:f290:: with SMTP id k16mr2653199wro.124.1599836201198; 
 Fri, 11 Sep 2020 07:56:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm5710093wrn.3.2020.09.11.07.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 07:56:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A5271FF7E;
 Fri, 11 Sep 2020 15:56:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] linux-user: test,
 don't assert addr != test in pgb_reserved_va
Date: Fri, 11 Sep 2020 15:56:30 +0100
Message-Id: <20200911145630.6560-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On older kernels which don't implement MAP_FIXED_NOREPLACE the kernel
may still fail to give us the address we asked for despite having
already probed the map for a valid hole. Asserting isn't particularly
useful to the user so let us move the check up and expand the
error_report a little to give them a fighting chance of working around
the problem.

Ameliorates: ee94743034
Cc: Bug 1895080 <1895080@bugs.launchpad.net>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4961e6119e2..f6022fd7049 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2331,14 +2331,13 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     assert(guest_base != 0);
     test = g2h(0);
     addr = mmap(test, reserved_va, PROT_NONE, flags, -1, 0);
-    if (addr == MAP_FAILED) {
+    if (addr == MAP_FAILED || addr != test) {
         error_report("Unable to reserve 0x%lx bytes of virtual address "
-                     "space (%s) for use as guest address space (check your "
-                     "virtual memory ulimit setting or reserve less "
-                     "using -R option)", reserved_va, strerror(errno));
+                     "space at %p (%s) for use as guest address space (check your"
+                     "virtual memory ulimit setting, min_mmap_addr or reserve less "
+                     "using -R option)", reserved_va, test, strerror(errno));
         exit(EXIT_FAILURE);
     }
-    assert(addr == test);
 }
 
 void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
-- 
2.20.1


