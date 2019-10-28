Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFD2CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FA821721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="REX1WUoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA821721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8al-0006z5-EB
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pt-0005pp-81
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pr-000468-Hi
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:48 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pr-00045Z-CY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id b25so7136501pfi.13
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=B4DzWJmRClZnGWtF1qIJV4FygyaOxQSP++ywZKquvFY=;
 b=REX1WUoNliqFnVDLbWcSAI0HkPLKE7LIwfHXecIbHCYQfPUoGR5mTG1K7ylgS14BWH
 IsDj/4rjWozlR7PYQL6O+kXEEbo2bLEYXI2geYiJV2XD8gyEBRlgn72aQTEORi9R5Xxm
 ei67dasHslcUMaAtBd4m+Of77M3iq3iNjVPnEdccmIyrQ0kVfhzyyGuzrMXlDEClJ4+z
 4ckEvJtdMKRIQEeiBwdg7PMz6YqyynpGjK/o9xe/UEeX2za5Nixv5dPr7bitLHYmJKGx
 UrXcOAQVTLeVeL61gvNHnlNGeh/Xnzt2jRyfALT9OtLyAQZF9SWSuELjfTu/lY01h5zi
 eJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=B4DzWJmRClZnGWtF1qIJV4FygyaOxQSP++ywZKquvFY=;
 b=J/bJ7GuoaK1jo6SWjpVTNlnaX5bq9jMQiKdPFs+EEM4NOg0xfmYmNkP377qcriagHO
 Hi3MsQuI/433SiE8YLZjODBV40q2/zPSyAvfz2SjeTRevfF+rO8K6mGsyfAwAACJubDS
 tMvSdumFwLo24Ij6KX9Wps1EPqS7rMSiFHbScDNTxsO5+/f2Nb5w7IFHovoHvJb1lqYY
 +8/zKiUawKYkvF5cHfb5/1LTpamCn/OWrGk2pFZZPaV018M1GatCTk3kI66Y3s6xveul
 8HRytp5c9DEeapkNHNePhxd9sERydEDwa7fiy8G1RyM1QA74VyVazahbuXbpuD4QEwm8
 pBLw==
X-Gm-Message-State: APjAAAWZmioO+tm+ZZ3g5jgyiDhnir4GQqb4NkBiSy/FEkv1f16M/RuA
 XZzJyD1N6yphOlLcgHdixBLc+wwiVe03Zg==
X-Google-Smtp-Source: APXvYqxFFSQWgC+jiM/JRB7o4WqgnTYD7vT75XHmBLnW1lZwqNYX4kdzSjSLnk7gUf2Vo+H1h3qC0Q==
X-Received: by 2002:a62:1e06:: with SMTP id e6mr20552435pfe.181.1572278326126; 
 Mon, 28 Oct 2019 08:58:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 66sm3855725pgi.49.2019.10.28.08.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:45 -0700 (PDT)
Subject: [PULL 17/18] riscv/boot: Fix possible memory leak
Date: Mon, 28 Oct 2019 08:49:01 -0700
Message-Id: <20191028154902.32491-18-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Coverity (CID 1405786) thinks that there is a possible memory leak as
we don't guarantee that the memory allocated from riscv_find_firmware()
is freed. This is a false positive, but let's tidy up the code to fix
the warning.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 2e92fb0680..7fee98d2f8 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -38,7 +38,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
                                   hwaddr firmware_load_addr)
 {
-    char *firmware_filename;
+    char *firmware_filename = NULL;
 
     if (!machine->firmware) {
         /*
@@ -70,14 +70,11 @@ void riscv_find_and_load_firmware(MachineState *machine,
          * if no -bios option is set without breaking anything.
          */
         firmware_filename = riscv_find_firmware(default_machine_firmware);
-    } else {
-        firmware_filename = machine->firmware;
-        if (strcmp(firmware_filename, "none")) {
-            firmware_filename = riscv_find_firmware(firmware_filename);
-        }
+    } else if (strcmp(machine->firmware, "none")) {
+        firmware_filename = riscv_find_firmware(machine->firmware);
     }
 
-    if (strcmp(firmware_filename, "none")) {
+    if (firmware_filename) {
         /* If not "none" load the firmware */
         riscv_load_firmware(firmware_filename, firmware_load_addr);
         g_free(firmware_filename);
-- 
2.21.0


