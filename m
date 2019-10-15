Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ABDECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88F12084B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nj1pctCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88F12084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQAt-0007i6-TL
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPn1-0008FH-AE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPmz-0000Ga-Rm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:15 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKPmz-0000Fo-MY
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:13 -0400
Received: by mail-pf1-x441.google.com with SMTP id x127so12816432pfb.7
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Z9j8volhtgefXr986PnBR9GXQR8t6Mv7RUHoAURHFm8=;
 b=nj1pctCulV9XzosVS4Royndi5VtaskoPn9t4VdjMis/CyzTEtURqNjpJZd22x7ZYpm
 WLYNEe5spgDEGTfxWf1gDIRqnF1u5qw1KKb/W+T/j4YS4cNnWOpedfXn7cpzKSfcFPNN
 +Sjb/QdFyozo32/PHJDjJxA11DRbV4JT+sFVoC+UlK4HoYmleHgjnAdkNIDLl8zsUcfQ
 h0vW2R4JMp0yh4djyTz+GSF/Z4kbwzriTJC9n+umFLa+tM6aH00aqsEV862DdVGhiC6J
 jaXWBawM0qW8E2GzGn/kbCxsLaRA81/AKT4LD6+XEP4mrgesvzFbkMkkgGmAZAoCgW5B
 qLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Z9j8volhtgefXr986PnBR9GXQR8t6Mv7RUHoAURHFm8=;
 b=iPOe91QAX2iqBX1lrw+mO3CkCjj0SWtsqFlGGKCa+MdtO1wpMJ6G5kT2iwRJG1MDNN
 mcTIoSvpONYLrJzUJBtycjAw3uo2Wu7aUEiWpLHM74lXoI3lxIKVxHz0d9Lw9y54ApAI
 IKI5g4P3hlPMQ8nNmRu/F4MvarFd3fHsVCnWGsGKKWHSP9jSkRaV41AkUaqUjQ5/9eaQ
 K2boR3UVf6+b6oLorzsMsZ141lVJ44sS/ekFH0cPH24mTi4JAzPr08VmIlMFpkAgU/XT
 0qWCmP3TUoND/9iSiWtJPTkLSzVoPgGy7MTpjP23bFYa/qAdNtawZIWw8uxxyLod4R5h
 d1EQ==
X-Gm-Message-State: APjAAAUxVhGs4V5AdiYd1vvFCtkKBQHhRHKzENo3aYb/kbzQ5ImjYnco
 32YLDNYWoTzyjr7/fQnNOMkjF4cZkDo=
X-Google-Smtp-Source: APXvYqxkIeYn7eLe7ZWHcykV6S2alU5GzCLCwJhFOCLrbLgmfwdUW5N8tLr/k8ha/G3FoS7quW8B9A==
X-Received: by 2002:a17:90a:9b86:: with SMTP id
 g6mr43664202pjp.76.1571157312303; 
 Tue, 15 Oct 2019 09:35:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m22sm22011593pgj.29.2019.10.15.09.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 09:35:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] target/arm: Add allocation tag storage for user mode
Date: Tue, 15 Oct 2019 09:35:06 -0700
Message-Id: <20191015163507.12153-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015163507.12153-1-richard.henderson@linaro.org>
References: <20191015163507.12153-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: elver@google.com, icb@rice.edu, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Control this with x-tagged-pages, which is off by default.

The limitation to non-shared pages is not part of a future kernel API,
but a limitation of linux-user not being able to map virtual pages back
to physical pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Add the x-tagged-pages cpu property
---
 target/arm/cpu.h        |  4 ++++
 target/arm/cpu64.c      | 20 ++++++++++++++++++++
 target/arm/mte_helper.c | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c3609ef9d5..272df43d3c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -912,6 +912,10 @@ struct ARMCPU {
      */
     bool cfgend;
 
+#ifdef CONFIG_USER_ONLY
+    bool tagged_pages;
+#endif
+
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ac1e2dc2c4..4bf498f778 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -279,6 +279,20 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
     error_propagate(errp, err);
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool aarch64_cpu_get_tagged_pages(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    return cpu->tagged_pages;
+}
+
+static void aarch64_cpu_set_tagged_pages(Object *obj, bool val, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    cpu->tagged_pages = val;
+}
+#endif
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -389,6 +403,12 @@ static void aarch64_max_initfn(Object *obj)
          */
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
+
+        object_property_add_bool(obj, "x-tagged-pages",
+                                 aarch64_cpu_get_tagged_pages,
+                                 aarch64_cpu_set_tagged_pages, NULL);
+        object_property_set_description(obj, "x-tagged-pages",
+            "Set on/off MemAttr Tagged for all pages", NULL);
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 657383ba0e..797c6229ab 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -29,8 +29,39 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
                                    bool write, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
-    /* Tag storage not implemented.  */
-    return NULL;
+    ARMCPU *cpu = env_archcpu(env);
+    uint8_t *tags;
+    uintptr_t index;
+    int flags;
+
+    flags = page_get_flags(ptr);
+
+    if (!(flags & PAGE_VALID) || !(flags & (write ? PAGE_WRITE : PAGE_READ))) {
+        /* SIGSEGV */
+        env->exception.vaddress = ptr;
+        cpu_restore_state(CPU(cpu), ra, true);
+        raise_exception(env, EXCP_DATA_ABORT, 0, 1);
+    }
+
+    if (!cpu->tagged_pages) {
+        /* Tag storage is disabled.  */
+        return NULL;
+    }
+    if (flags & PAGE_SHARED) {
+        /* There may be multiple mappings; pretend not implemented.  */
+        return NULL;
+    }
+
+    tags = page_get_target_data(ptr);
+    if (tags == NULL) {
+        size_t alloc_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
+        tags = page_alloc_target_data(ptr, alloc_size);
+        assert(tags != NULL);
+    }
+
+    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
+                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    return tags + index;
 #else
     CPUState *cs = env_cpu(env);
     uintptr_t index;
-- 
2.17.1


