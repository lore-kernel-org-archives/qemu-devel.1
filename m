Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778C9C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4384D20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHCdvcjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4384D20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZbY-0003Em-Bx
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlG-0001iT-9y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlE-00019r-8t
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:26 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlE-00017O-2d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:24 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so2861444wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JImAuaX0wkn2tgnJiEdNQRpcHEBlhK4sGVLX4H6xCw8=;
 b=QHCdvcjqY1H/UAXJAGfHofJE+Y/CnFahTQXE5EDRXE/WErwn4pjqoNWA81/p38b6uZ
 dFxNZbNo1xEwVq3HVaIJb4fMQMvKbx9NAFdZw+4uhdRM9WCndnYSveIVHah0kmMwB9H8
 P93Km4Grzqz5NMWy3qb7ttQTR4jljUDs961gEsiTWA3XRasrmDcYlwEVn28rqicxa821
 8mA2bYDYPXxYUeCWSMrhnNU5T4aRk70EtYq8dlQb0YwRICYvsFblI1tSgTOKtrWnKOZ/
 5zgNLMTOn9GgGUsNpAH4B65g3xBJ+hNKdKKs8uunVRJWofOaGVrE9lJ9JwTRc0f6sf9w
 /3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JImAuaX0wkn2tgnJiEdNQRpcHEBlhK4sGVLX4H6xCw8=;
 b=M6diK6eop6Gi4ICxVYh0XVcG8vMBExppPu1z8Q0h6d36haUSo2bJsPOfdXLQsXFxVR
 WVekjLuhLl5X5gMzlk3LFvuAnR1TMD7bV++FrYg7/lVHifMvz+/NUEP+xh6u/743zPkQ
 l6LmK5xvQy5chzSszn9NjQ7yLY7mfN/6l+PQgT2kmrkB24LBZsGCu6qty7AjCKqDhN7A
 lVY+eK4ooTaEdOwoVbBfNg8bnU3g1xjbUlgto7WGl8HAjwZVJvsjljxYsLWqwwoL9Rc6
 tOz+PBqhiXtrZ3a3gaFOadNhpLPzBynYh+TxgCHNb62QxzezQYpuN/oRhGW20haaAhIV
 bPGw==
X-Gm-Message-State: APjAAAX7QvuymOivKLy8W9028PUJJvNAEioU8plhUtf/+JM0kNCgON5U
 zmxrTZiBJ4/e2vlDorpw/NUrcqkG
X-Google-Smtp-Source: APXvYqxLVD/T6Vy7Q4Y6uLaGb/vp23ayxpXVpNX1BIuYEnxMWUYOIRcQkSDc0AoWuX3W5eiuWEBSog==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr4889330wmc.36.1582631542612; 
 Tue, 25 Feb 2020 03:52:22 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 082/136] exec: Rename ram_ptr variable
Date: Tue, 25 Feb 2020 12:50:12 +0100
Message-Id: <1582631466-13880-82-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

As we are going to use a different 'ptr' variable, rename the 'ram
pointer' variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/exec.c b/exec.c
index 8e9cc3b..08a30f6 100644
--- a/exec.c
+++ b/exec.c
@@ -3151,7 +3151,7 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                            hwaddr len, hwaddr addr1,
                                            hwaddr l, MemoryRegion *mr)
 {
-    uint8_t *ptr;
+    uint8_t *ram_ptr;
     uint64_t val;
     MemTxResult result = MEMTX_OK;
     bool release_lock = false;
@@ -3167,8 +3167,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
                                                    size_memop(l), attrs);
         } else {
             /* RAM case */
-            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(ptr, buf, l);
+            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            memcpy(ram_ptr, buf, l);
             invalidate_and_set_dirty(mr, addr1, l);
         }
 
@@ -3215,7 +3215,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    hwaddr len, hwaddr addr1, hwaddr l,
                                    MemoryRegion *mr)
 {
-    uint8_t *ptr;
+    uint8_t *ram_ptr;
     uint64_t val;
     MemTxResult result = MEMTX_OK;
     bool release_lock = false;
@@ -3230,8 +3230,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
-            ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(buf, ptr, l);
+            ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
+            memcpy(buf, ram_ptr, l);
         }
 
         if (release_lock) {
@@ -3329,7 +3329,7 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
                                                            enum write_rom_type type)
 {
     hwaddr l;
-    uint8_t *ptr;
+    uint8_t *ram_ptr;
     hwaddr addr1;
     MemoryRegion *mr;
 
@@ -3343,14 +3343,14 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
             l = memory_access_size(mr, l, addr1);
         } else {
             /* ROM/RAM case */
-            ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
+            ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
             switch (type) {
             case WRITE_DATA:
-                memcpy(ptr, buf, l);
+                memcpy(ram_ptr, buf, l);
                 invalidate_and_set_dirty(mr, addr1, l);
                 break;
             case FLUSH_CACHE:
-                flush_icache_range((uintptr_t)ptr, (uintptr_t)ptr + l);
+                flush_icache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr + l);
                 break;
             }
         }
-- 
1.8.3.1



