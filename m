Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18C9C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7B920726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YocdlLed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7B920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZfH-0001yx-KV
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlJ-0001sD-Tz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlI-0001Wl-SG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:29 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlI-0001RN-Kp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:28 -0500
Received: by mail-wr1-x42c.google.com with SMTP id m16so14334437wrx.11
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JMAZIaMNsNrZFFPWfKlMlMKRAGFUPcQHmsKBaJZ/EIM=;
 b=YocdlLedkukH8TDyyGdanVLlvV0hZfWox1kXQtql0ek8/6ieZRlQn5ABFUhbIfkg5M
 Pa0ZNGwGzou37uBagmCV4Ikw5zHUkJOUuWNC1LTXwwYc4jDcY/Xpap0wWSJ77knyhZM8
 zkd5DOsidTNH//Ih/WIz7GlIjrUa4F7PDL1w71p8gD+qMD57ICTXiNPd6rll7+aJNxCy
 +VASDXb8Vcw+m6YWt0a9VU7S2oEXy0XEvIwO2JyMSWz6YFbRrmvozoLc6esFKtjZ2qtm
 tsUqNBk501WYxdDIHMybqIR8uVOkgJB7XA11A9bHNjZMoKF4JZPZhNS/q0ld9oqeyz5F
 s+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JMAZIaMNsNrZFFPWfKlMlMKRAGFUPcQHmsKBaJZ/EIM=;
 b=tf7NW9c8PUipz4ADIn6uV8IIJntvpdBuOTN4H/CmWE8fTdtRxVBqmX0ftuNMUuCEie
 wGCRSmOdkVdXjqFuHUPDzwvgpYxY/diPaz7GWfx4XZ8u/w+sx7JFmULLz1c8oS2uUtrS
 OEYsu8qiSfga/FiZOM2Tqt5ugC0gGJ9ULv96LmAH75WtP+cJjBgMCWHAZ5lEiF67uOdh
 aeMooPqodG3aoKBj6JeIbUZMw2WVkLE8x5pmbINQ6bKAi9N3erocNIYEZGmvwO2zW+mI
 BsREF3NuVBbT4iP0rpf21sfGTDndjewnAkKH7zI10A9wAchu2ywZ9W6bYxTOc2MXXbvU
 YrWw==
X-Gm-Message-State: APjAAAXt5M43vVTdgn171jAdYgG1czbXL/a4lx84ltFfqh1moe07tv//
 EE84ENiJ9D0kJia1bfRJYXMvZw0j
X-Google-Smtp-Source: APXvYqylG7QGQIYdJkxZaPOmLXyCXboAWquAd6RukLm6M28NqICmscu94xRKur7DduQeTBeDYDXvyQ==
X-Received: by 2002:a5d:678f:: with SMTP id v15mr74289182wru.27.1582631547450; 
 Tue, 25 Feb 2020 03:52:27 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 087/136] exec: Let the cpu_[physical]_memory API use void
 pointer arguments
Date: Tue, 25 Feb 2020 12:50:17 +0100
Message-Id: <1582631466-13880-87-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As we are only dealing with a blob buffer, use a void pointer
argument. This will let us simplify other APIs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c                    | 8 +++++---
 include/exec/cpu-all.h    | 2 +-
 include/exec/cpu-common.h | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/exec.c b/exec.c
index 3d6ee06..58664ac 100644
--- a/exec.c
+++ b/exec.c
@@ -3019,11 +3019,12 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, int is_write)
 {
     int flags;
     target_ulong l, page;
     void * p;
+    uint8_t *buf = ptr;
 
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
@@ -3311,7 +3312,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
     }
 }
 
-void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
+void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, int is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
@@ -3789,10 +3790,11 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, int is_write)
 {
     hwaddr phys_addr;
     target_ulong l, page;
+    uint8_t *buf = ptr;
 
     cpu_synchronize_state(cpu);
     while (len > 0) {
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e96781a..49e96ca 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -388,7 +388,7 @@ void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        uint8_t *buf, target_ulong len, int is_write);
+                        void *ptr, target_ulong len, int is_write);
 
 int cpu_exec(CPUState *cpu);
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 81753bb..55e5740 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -69,7 +69,7 @@ void qemu_ram_unset_migratable(RAMBlock *rb);
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
-void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
+void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, int is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
                                             void *buf, hwaddr len)
-- 
1.8.3.1



