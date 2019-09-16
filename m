Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB41DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD496206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDjFmcOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD496206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tHb-00014y-7u
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD3-0006d8-Dq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD2-0007WR-1W
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sD1-0007WA-Nd
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id a11so29423730wrx.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Clgbn8VC1npnngFnwGDRl9+7yey7IgZd01g1UbgiZRo=;
 b=aDjFmcOMH5mA7YsMiJ3BFlA9SMqxaVialQRmvoWCb/BgOe+uT8H52C++ZFVrbnJKgg
 wdHdGutf/hlHeHVx5/ZX+0TFIrtcZjMWNyjPJbqSIOL9VI1H6jopvuadUGjMVZNOpYcw
 BAp/izoBIMLN/gWsifaNk+6ArreO8c9yR8x+dAWrellpRYqsze4zEza8rBVHNBZG5w0t
 IlYlZH1hUIn7UCbisXvE1vq0xeqC4sk1iVM5tvlvx5jC7RsU6AIdHy3V4EtUwYLK9ZlU
 wT74mGJyK4EM3TRMrSroFgGNrxVpQ0otUoT4RJJmc0wal4cw7AzaCYkpe2G0WDA7FC0l
 ht2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Clgbn8VC1npnngFnwGDRl9+7yey7IgZd01g1UbgiZRo=;
 b=Hy8v8ukG2tCys2lOJC9nUQQE+PQk+SwbM1r3URsLhl+AflG5LpxWm0ihODJ6a8NQui
 IZIINjl8f4QDUByoL/VZv0tna11ovVk9Td5E8zgebWvHwBx+uluHBHtk6w22YhoW6Qsr
 P5O++0wwyjT25gXkFCQkqze5QyL1j6IrqVIb9OpGntnjz0ouZpxXZQqbVndDUrsgpwK6
 NR/lBy0V+FYsYCS+nWhHu+3KABWiXFJoJJbthGgIXNulMGJWPk2RKrSe+Ad0FOHo8YGv
 Fx4OyeOXDChIL6FwMXZZUNsC/YHfBr4c18CC3XBqM6mISPasbpf9eLheuaCqzKZwxKv3
 BjAA==
X-Gm-Message-State: APjAAAV4SLqrAU28TZ5F1l8BToYaEZRePjTp69KQgNG6zAGTvutrVRwt
 UQ6xWs7V9rqnvvRVNd4/aCOOZ7E4
X-Google-Smtp-Source: APXvYqywElG9yC3S3GoKxj3QMAgxr7mwz425mWj6dg96HevMBsy5VrqFN95i+lS08Vy4yMSwsYrgqg==
X-Received: by 2002:adf:df91:: with SMTP id z17mr126630wrl.116.1568644950397; 
 Mon, 16 Sep 2019 07:42:30 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:57 +0200
Message-Id: <1568644929-9124-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 17/29] hw/i386/pc: Use address_space_memory in
 place
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

The address_space_memory variable is used once.
Use it in place and remove the argument.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-4-philmd@redhat.com>
---
 hw/i386/pc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 81e5a59..dd5ec2e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -936,7 +936,7 @@ static void pc_build_smbios(PCMachineState *pcms)
     }
 }
 
-static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
+static FWCfgState *bochs_bios_init(PCMachineState *pcms)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
@@ -946,7 +946,8 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     MachineState *ms = MACHINE(pcms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
+                                &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
 
     /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
@@ -1868,7 +1869,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
 
-    fw_cfg = bochs_bios_init(&address_space_memory, pcms);
+    fw_cfg = bochs_bios_init(pcms);
 
     rom_set_fw(fw_cfg);
 
-- 
1.8.3.1



