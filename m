Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2385FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E771621D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVkhjAuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E771621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vzX-0007nF-3I
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl4-0002xm-Uw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl3-0004dT-Ig
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:02 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vl3-0004cy-B9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:01 -0500
Received: by mail-pg1-x52e.google.com with SMTP id d9so676100pgu.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=TFaI+CsTEBm5jcbgK52B+eLHOA/XNjrGjXU/SzxCs/E=;
 b=UVkhjAuNk0MHOJJG9SQzHcRGZeJ0jkhV/9L7HgZ4y3WpEm1NySfdJ6CO2oR+Zr1v4L
 TGetjWt/4X68WaeCpgSzlG26VEUnujlAkwm6Ehxz5W1KO9MeNE1LAebzV+nb+bjrNUSq
 y2w//hO7TSI+/Xk6EHxwEyh2x0CssLAPGOIZg0Ni4E9OskcKav9JNbR9061DZV8YQX5u
 GhvKg/6NI6GS8M85Z4YiHBkIPvt0WLqoX17wmB3+DCV/aVA9nfFIDDZ1q/TgVuR/cDVR
 xxoSTBqStIcoZ5GZf+Q1rslKz29mGhrR43zn2NCg1zqAGaj/9X0LrVDZilSRou4nKSrS
 0scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=TFaI+CsTEBm5jcbgK52B+eLHOA/XNjrGjXU/SzxCs/E=;
 b=Q9hAy6ztr+fm6Bboxdjs4gY2/pFh2dgzzpj7uRjf8c9tuHbsif/9L6UpLC3j8Kqt83
 rdYJ1iZI1h457AMFpL3M9fOUQVpPnLwzSOPYg7nf3axbd8ijbwzHtE9BwDCGUHdv65/b
 ina0P1533Y7Y1aCuk5WlHCUTFnxg+pVMstYm1lvunx7tWnGSlbqk/rJ+H9u7VigCGhii
 uaikpiDuZu8DsEEKvVLyonV6bYA+cpXJm/aCuTT9yG/h5TM9UB/m7jrkaM/X2YyywwQx
 lNQElg9iKoFPwHOx/zPKUMjtQRPR91PtXANGEH3tMxVE6cjn9+HsYIQ7Xc6xUf4nZaIp
 g9Qg==
X-Gm-Message-State: ANhLgQ0QnzCiilJq0JQBr0VHWoV3Ra7VexAMM0Sqc4vl6poc67cvG+ra
 et4YIR4YT4D1SQ9j/O9ea7H/dw==
X-Google-Smtp-Source: ADFU+vsvTnLhLBoYoTp2B6i7YnvgNtmFsLVIUsNqTjQvX8AX65VyXKStRdMcRFYXp8cd5uPApHAC2Q==
X-Received: by 2002:a62:e70e:: with SMTP id s14mr1579661pfh.115.1583196600269; 
 Mon, 02 Mar 2020 16:50:00 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id c3sm22271988pfb.85.2020.03.02.16.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:49:59 -0800 (PST)
Subject: [PULL 36/38] riscv: virt: Allow PCI address 0
Date: Mon,  2 Mar 2020 16:48:46 -0800
Message-Id: <20200303004848.136788-37-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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

From: Bin Meng <bmeng.cn@gmail.com>

When testing e1000 with the virt machine, e1000's I/O space cannot
be accessed. Debugging shows that the I/O BAR (BAR1) is correctly
written with address 0 plus I/O enable bit, but QEMU's "info pci"
shows that:

  Bus  0, device   1, function 0:
    Ethernet controller: PCI device 8086:100e
  ...
      BAR1: I/O at 0xffffffffffffffff [0x003e].
  ...

It turns out we should set pci_allow_0_address to true to allow 0
PCI address, otherwise pci_bar_address() treats such address as
PCI_BAR_UNMAPPED.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7f9e1e5176..5d175d5c9e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -641,6 +641,7 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->init = riscv_virt_board_init;
     mc->max_cpus = 8;
     mc->default_cpu_type = VIRT_CPU;
+    mc->pci_allow_0_address = true;
 }
 
 static const TypeInfo riscv_virt_machine_typeinfo = {
-- 
2.25.0.265.gbab2e86ba0-goog


