Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B80C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F86A21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa4o45vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F86A21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhzG-00067x-Ng
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrK-0005Oy-Qr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrJ-0003OF-QR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:33792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrJ-0003MW-Jx
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id y135so5358831wmc.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gwkm7BIFv5Gq9pCfaTUHfWzPGvgH4PsTi5+em8nFU0M=;
 b=fa4o45vjhLkC08Qa54nmAY9BTjZkdWS9WoeavtDyiAVR9pWHSDqqxFUAaDGkkzd6MF
 o/Db/MSf6/FbO6DBLKK7fbzfAygckuTTvhh0N2Wi6BE1UM3KIipCcYcI0R/Ga9W9QTki
 ZoQ1Nrj0LBfa4C57qS3VDhS64Kr0cQE/7NgVtzpnvIlDLR92X9Ze8TWup6d/P/NeYsFV
 6mIV9J9pirfasWT0BsJpDGWwHnv28NegO1L1ovC9X2dC1z1BevEGDO/D9b98CW/vwN8P
 idX9Eq5PHkLrIXZXnWUcWrmkxPme6jPT5bklY2/QPXwZK8xZc6wIliFqk34O+QGP2zRx
 n6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Gwkm7BIFv5Gq9pCfaTUHfWzPGvgH4PsTi5+em8nFU0M=;
 b=qI0nmQH242TeYwgsUb2OeDVhWAnDW6yBM4SBfhWDNCHhNtykrHguCgKwBi8yxWlB6k
 rCP6QwEw6drdYOUln1Qx3fBnqRZUKUtVRZVlli0R1pdGrX6qCtqFU9fDi21TU+Hc2pJK
 55Sf4ByW5d2vwCMfbh6+KghIi0t5gzgK3qh9aWgDSWYg1MeaOLhxxJF3Ey8HlzroWrbU
 G/qDmRmggONJqHi+fiApliQXwW/SqwQWOxW6nvbhnrL1yVjM3LbEAJBqxX0PioHgGqYC
 oN8u+K/oa2T/6viKV7KkJ//wBe2vkUlfvJSupuXdulhiSYPA9HDW6NOpBMT8UrGB/8/D
 f8aQ==
X-Gm-Message-State: APjAAAXr7YrAu3kqMdoWF4u2/rYNS+bX535Be+7Q4NpMRhBUb+du2h+d
 SRQuoad0W4s3QgEcMLTYfAZ0uWRb
X-Google-Smtp-Source: APXvYqwewTrRnzms8LNKk1xv0R958YgLVK+AnWrOfifhvJyGI4yllqhI9ouvdRWmpobgPO0yZjjJoA==
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr3384082wmc.36.1570035132386; 
 Wed, 02 Oct 2019 09:52:12 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/30] hppa: fix leak from g_strdup_printf
Date: Wed,  2 Oct 2019 18:51:40 +0200
Message-Id: <1570035113-56848-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_init_* takes care of copying the name into memory it owns.
Free it in the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/hppa/dino.c    | 1 +
 hw/hppa/machine.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index e0466ee..ab6969b 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -485,6 +485,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
         memory_region_init_alias(&s->pci_mem_alias[i], OBJECT(s),
                                  name, &s->pci_mem, addr,
                                  DINO_MEM_CHUNK_SIZE);
+        g_free(name);
     }
 
     /* Set up PCI view of memory: Bus master address space.  */
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2736ce8..7e23675 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -78,13 +78,15 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Create CPUs.  */
     for (i = 0; i < smp_cpus; i++) {
+        char *name = g_strdup_printf("cpu%ld-io-eir", i);
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
 
         cpu_region = g_new(MemoryRegion, 1);
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
-                              cpu[i], g_strdup_printf("cpu%ld-io-eir", i), 4);
+                              cpu[i], name, 4);
         memory_region_add_subregion(addr_space, CPU_HPA + i * 0x1000,
                                     cpu_region);
+        g_free(name);
     }
 
     /* Limit main memory. */
-- 
1.8.3.1



