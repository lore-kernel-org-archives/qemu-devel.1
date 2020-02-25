Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE29C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE5C20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGx9FlFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE5C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZJH-0006O2-66
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlR-0002Bf-OJ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlQ-00023W-JQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlQ-000228-BR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so2668699wmj.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jor9jpTp+5pWMuC6CCCrbht9VdaHvp6JocNHSYpHXR8=;
 b=tGx9FlFSwKLsKOdUi47qITlXSb9f4vYWkdyQCiL16stAEuwhDp+O35hmn69K2aUBGE
 bftevVEn8qIH5ejRHp3qorusTJX/T3fTHwqxT0RWuVA+l9fuo2zMFl5CaE83fhxLK/rd
 nDMIlsgonPskgfTNgPL/LwiYswEsFjHO+1S/6ItgHdLZUepk3PxGCTCw07SznSfT5+58
 +h67m4Zx7LGj9vkndTfO303lJb7J94RSbIFaI/TYzZgZW20N6uuHPshmaH4AzOEdPR91
 Bkrw39D9+s5B+GeeCqbDnW9G6yPE/FNQRQU1ZdTGAMJu42lEbPzgeDmDiuiKOoZnOkeI
 L0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Jor9jpTp+5pWMuC6CCCrbht9VdaHvp6JocNHSYpHXR8=;
 b=jJwuCFm0TZQmLKESIIgw/dXmge0IkHYER3NRoyne08DTW65ipeyJUboHitKeD9G7VF
 +Ta528ekv1icMO4HKWfwpFoUH+dEXdTmnscUaQ+nl74+7njO5B65vNLhfydwS8hjfR8N
 e7EtGwDzG7pdipF1eZeTPdm6K1V89GOzaHca67+o1iuYRRv63wqDyQNl9yai0Rnkyk5z
 34ukF+KkLUVhO+IXqAXj7KRealm5IUrT+8Lr/kSkIAUxGuLqQg1yKlifyuihp9oqI9Hq
 NrEJ6tGIPoAdhcfPMKZoiRHATcqVHTwPQieIc1fSoiXmxQ5kBQKKsaFjST4goDK67cUX
 NA9g==
X-Gm-Message-State: APjAAAVNf+Px4fTcCu3yqR9tOspvEIczkl9/o6zMZAL7xOrUoWBE47j6
 k3QMva04pC+QNJW1k9yq+HKeTQbx
X-Google-Smtp-Source: APXvYqzUDkYwDuA2ZVyw+GGC8yu7js8WR+E2kh3buJbjzce0mQzCIKXBtAmks9X7WX8FJ5j86FpXSQ==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4890417wmc.36.1582631555033; 
 Tue, 25 Feb 2020 03:52:35 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 096/136] exec: Let cpu_[physical]_memory API use a boolean
 'is_write' argument
Date: Tue, 25 Feb 2020 12:50:26 +0100
Message-Id: <1582631466-13880-96-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The 'is_write' argument is either 0 or 1.
Convert it to a boolean type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c                    | 10 +++++-----
 include/exec/cpu-all.h    |  2 +-
 include/exec/cpu-common.h |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/exec.c b/exec.c
index ec6e460..758af30 100644
--- a/exec.c
+++ b/exec.c
@@ -3019,7 +3019,7 @@ MemoryRegion *get_system_io(void)
 /* physical memory access (slow version, mainly for debug) */
 #if defined(CONFIG_USER_ONLY)
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, bool is_write)
 {
     int flags;
     target_ulong l, page;
@@ -3313,7 +3313,7 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr, MemTxAttrs attrs,
 }
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, int is_write)
+                            hwaddr len, bool is_write)
 {
     address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
                      buf, len, is_write);
@@ -3632,14 +3632,14 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
-                              int is_write)
+                              bool is_write)
 {
     return address_space_map(&address_space_memory, addr, plen, is_write,
                              MEMTXATTRS_UNSPECIFIED);
 }
 
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
-                               int is_write, hwaddr access_len)
+                               bool is_write, hwaddr access_len)
 {
     return address_space_unmap(&address_space_memory, buffer, len, is_write, access_len);
 }
@@ -3790,7 +3790,7 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
 
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, int is_write)
+                        void *ptr, target_ulong len, bool is_write)
 {
     hwaddr phys_addr;
     target_ulong l, page;
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 49e96ca..49384bb 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -388,7 +388,7 @@ void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
-                        void *ptr, target_ulong len, int is_write);
+                        void *ptr, target_ulong len, bool is_write);
 
 int cpu_exec(CPUState *cpu);
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 55e5740..d127d84 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -70,7 +70,7 @@ size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, int is_write);
+                            hwaddr len, bool is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
                                             void *buf, hwaddr len)
 {
@@ -83,9 +83,9 @@ static inline void cpu_physical_memory_write(hwaddr addr,
 }
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
-                              int is_write);
+                              bool is_write);
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
-                               int is_write, hwaddr access_len);
+                               bool is_write, hwaddr access_len);
 void cpu_register_map_client(QEMUBH *bh);
 void cpu_unregister_map_client(QEMUBH *bh);
 
-- 
1.8.3.1



