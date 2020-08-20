Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2720C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C152075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 19:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kILRmGLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C152075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8qUy-0008EV-Pk
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 15:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k8qTX-0006xd-TK; Thu, 20 Aug 2020 15:43:51 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k8qTV-00031k-Mz; Thu, 20 Aug 2020 15:43:51 -0400
Received: by mail-lj1-x241.google.com with SMTP id 185so3399800ljj.7;
 Thu, 20 Aug 2020 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c8wpmAgqCqAHnfIdeu/oimk3TM9NkNrxhsLvuET5w5I=;
 b=kILRmGLvaFjrXujfI7LIlBV7nOEcVS3j9wQAzU4D9WA+fHmgbDIoMDKiDH4zpoxSsF
 pAtcmwjzfS/1MXttloKt/IFcmz/lfpKVvES4G3FwvUO0LbLhAvS1/MC+59qCOwMvwxoV
 T1/HJUQltWZAAz+7VpAaEgqCutklDcji2qLM/cSwG+T0Fp/Rds4xb05qaKuQwnrVqJ8S
 6bg7pCcdk1N9uP7gJ9R9yc+N/cjusxsvK7UWhahD/ueIBbeVrgece5OrNvWB43GStJcJ
 UAVBjl0QxLHwgFK0ZhOXICMpPc78ro6Au1990R8hc9eWJeDLhQG4Eyj2YU4oS7vyfUiJ
 Hgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c8wpmAgqCqAHnfIdeu/oimk3TM9NkNrxhsLvuET5w5I=;
 b=OskeWQvzUZIoCM/1Ka3aImhQKukvT2bsm8oAMZK3NUcz/dR0OL+x+T56A4iNVOIuSY
 eqjOs6ufL2UNl0csJv4LCiZ0/JHkhEcBmKrVuAa0C6m6LG3o/VfJhwyNfZJZmCZ1VAfa
 rzPn+J0a0Jaqsf4C1XXG0cVU1sjYl0QRVOA9gbx40mSgLVlguiFG+rqYaigTlyEoWUel
 oxy7PQ/nOS7vq/Wd74ZOAlbQ+4nO1WLD/7mtpu+7c2tKsE9PcdftLE+9YEPjTkAr7aIl
 dSiKmulg+bO5w90PvvQVJbx1c/Q4pbt4ETX52Dx/fjFrDJUFI8tQn673YhYjgVvB8ypS
 8GSQ==
X-Gm-Message-State: AOAM531I3VO8tyuDABGqpxki40vR79aeXMPo1cBBaVGwda2fzVQrKQjx
 Oy8G0r+8WmQ9U7nJ8xVMTeLpLS1dYwU=
X-Google-Smtp-Source: ABdhPJwf+lcorfhWWAinxgtlBLiJbVY6LNgPixV5+Lr6IA7vK94vRktoJeOaybUY77ohl2kvfzT9pQ==
X-Received: by 2002:a2e:a489:: with SMTP id h9mr2340168lji.121.1597952626319; 
 Thu, 20 Aug 2020 12:43:46 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a19sm691383lff.25.2020.08.20.12.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 12:43:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] microblaze: petalogix-s3adsp1800: Add device-tree
 source
Date: Thu, 20 Aug 2020 21:43:42 +0200
Message-Id: <20200820194342.1292611-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820194342.1292611-1-edgar.iglesias@gmail.com>
References: <20200820194342.1292611-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add a device-tree source for petalogix-s3adsp1800 and
recompile the DTB.

This also removes the unused mpmc node which causes
compilation warnings.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 pc-bios/petalogix-s3adsp1800.dtb | Bin 8259 -> 8161 bytes
 pc-bios/petalogix-s3adsp1800.dts | 282 +++++++++++++++++++++++++++++++
 2 files changed, 282 insertions(+)
 create mode 100644 pc-bios/petalogix-s3adsp1800.dts

diff --git a/pc-bios/petalogix-s3adsp1800.dtb b/pc-bios/petalogix-s3adsp1800.dtb
index 8ac80f2f2d191a8491b71182be50b3df2989551d..2513599438bffca96a93e877a1981efdd1a91115 100644
GIT binary patch
literal 8161
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
EKNww{&j0`b

literal 8259
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

diff --git a/pc-bios/petalogix-s3adsp1800.dts b/pc-bios/petalogix-s3adsp1800.dts
new file mode 100644
index 0000000000..f53c36f870
--- /dev/null
+++ b/pc-bios/petalogix-s3adsp1800.dts
@@ -0,0 +1,282 @@
+/*
+ * Copyright (c) 2020 Xilinx Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>.
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <0x01>;
+	#size-cells = <0x01>;
+	compatible = "xlnx,microblaze";
+	model = "testing";
+
+	memory@90000000 {
+		device_type = "memory";
+		reg = <0x90000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyUL0,115200";
+		stdout-path = "/plb/serial@84000000";
+	};
+
+	cpus {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		#cpus = <0x01>;
+
+		cpu@0 {
+			clock-frequency = <0x3b9aca0>;
+			compatible = "xlnx,microblaze-7.10.d";
+			d-cache-baseaddr = <0x90000000>;
+			d-cache-highaddr = <0x97ffffff>;
+			d-cache-line-size = <0x10>;
+			d-cache-size = <0x800>;
+			device_type = "cpu";
+			i-cache-baseaddr = <0x90000000>;
+			i-cache-highaddr = <0x97ffffff>;
+			i-cache-line-size = <0x10>;
+			i-cache-size = <0x800>;
+			model = "microblaze,7.10.d";
+			reg = <0x00>;
+			timebase-frequency = <0x3b9aca0>;
+			xlnx,addr-tag-bits = <0x10>;
+			xlnx,allow-dcache-wr = <0x01>;
+			xlnx,allow-icache-wr = <0x01>;
+			xlnx,area-optimized = <0x00>;
+			xlnx,cache-byte-size = <0x800>;
+			xlnx,d-lmb = <0x01>;
+			xlnx,d-opb = <0x00>;
+			xlnx,d-plb = <0x01>;
+			xlnx,data-size = <0x20>;
+			xlnx,dcache-addr-tag = <0x10>;
+			xlnx,dcache-always-used = <0x00>;
+			xlnx,dcache-byte-size = <0x800>;
+			xlnx,dcache-line-len = <0x04>;
+			xlnx,dcache-use-fsl = <0x01>;
+			xlnx,debug-enabled = <0x01>;
+			xlnx,div-zero-exception = <0x00>;
+			xlnx,dopb-bus-exception = <0x00>;
+			xlnx,dynamic-bus-sizing = <0x01>;
+			xlnx,edge-is-positive = <0x01>;
+			xlnx,family = "spartan3adsp";
+			xlnx,fpu-exception = <0x00>;
+			xlnx,fsl-data-size = <0x20>;
+			xlnx,fsl-exception = <0x00>;
+			xlnx,fsl-links = <0x00>;
+			xlnx,i-lmb = <0x01>;
+			xlnx,i-opb = <0x00>;
+			xlnx,i-plb = <0x01>;
+			xlnx,icache-always-used = <0x00>;
+			xlnx,icache-line-len = <0x04>;
+			xlnx,icache-use-fsl = <0x01>;
+			xlnx,ill-opcode-exception = <0x00>;
+			xlnx,instance = "microblaze_0";
+			xlnx,interconnect = <0x01>;
+			xlnx,interrupt-is-edge = <0x00>;
+			xlnx,iopb-bus-exception = <0x00>;
+			xlnx,mmu-dtlb-size = <0x04>;
+			xlnx,mmu-itlb-size = <0x02>;
+			xlnx,mmu-tlb-access = <0x03>;
+			xlnx,mmu-zones = <0x10>;
+			xlnx,number-of-pc-brk = <0x03>;
+			xlnx,number-of-rd-addr-brk = <0x02>;
+			xlnx,number-of-wr-addr-brk = <0x02>;
+			xlnx,opcode-0x0-illegal = <0x00>;
+			xlnx,pvr = <0x01>;
+			xlnx,pvr-user1 = <0x00>;
+			xlnx,pvr-user2 = <0x00>;
+			xlnx,reset-msr = <0x00>;
+			xlnx,sco = <0x00>;
+			xlnx,unaligned-exceptions = <0x01>;
+			xlnx,use-barrel = <0x01>;
+			xlnx,use-dcache = <0x01>;
+			xlnx,use-div = <0x00>;
+			xlnx,use-ext-brk = <0x01>;
+			xlnx,use-ext-nm-brk = <0x01>;
+			xlnx,use-extended-fsl-instr = <0x00>;
+			xlnx,use-fpu = <0x00>;
+			xlnx,use-hw-mul = <0x01>;
+			xlnx,use-icache = <0x01>;
+			xlnx,use-interrupt = <0x01>;
+			xlnx,use-mmu = <0x03>;
+			xlnx,use-msr-instr = <0x01>;
+			xlnx,use-pcmp-instr = <0x01>;
+		};
+	};
+
+	plb {
+		#address-cells = <0x01>;
+		#size-cells = <0x01>;
+		compatible = "xlnx,plb-v46-1.03.a\0simple-bus";
+		ranges;
+
+		ethernet@81000000 {
+			compatible = "xlnx,xps-ethernetlite-2.00.a";
+			device_type = "network";
+			interrupt-parent = <0x01>;
+			interrupts = <0x01 0x00>;
+			local-mac-address = [02 00 00 00 00 00];
+			reg = <0x81000000 0x10000>;
+			xlnx,duplex = <0x01>;
+			xlnx,family = "spartan3adsp";
+			xlnx,rx-ping-pong = <0x00>;
+			xlnx,tx-ping-pong = <0x00>;
+		};
+
+		flash@a0000000 {
+			bank-width = <0x01>;
+			compatible = "xlnx,xps-mch-emc-2.00.a\0cfi-flash";
+			reg = <0xa0000000 0x1000000>;
+			xlnx,family = "spartan3adsp";
+			xlnx,include-datawidth-matching-0 = <0x01>;
+			xlnx,include-datawidth-matching-1 = <0x00>;
+			xlnx,include-datawidth-matching-2 = <0x00>;
+			xlnx,include-datawidth-matching-3 = <0x00>;
+			xlnx,include-negedge-ioregs = <0x00>;
+			xlnx,include-plb-ipif = <0x01>;
+			xlnx,include-wrbuf = <0x01>;
+			xlnx,max-mem-width = <0x08>;
+			xlnx,mch-native-dwidth = <0x20>;
+			xlnx,mch-plb-clk-period-ps = <0x3e80>;
+			xlnx,mch-splb-awidth = <0x20>;
+			xlnx,mch0-accessbuf-depth = <0x10>;
+			xlnx,mch0-protocol = <0x00>;
+			xlnx,mch0-rddatabuf-depth = <0x10>;
+			xlnx,mch1-accessbuf-depth = <0x10>;
+			xlnx,mch1-protocol = <0x00>;
+			xlnx,mch1-rddatabuf-depth = <0x10>;
+			xlnx,mch2-accessbuf-depth = <0x10>;
+			xlnx,mch2-protocol = <0x00>;
+			xlnx,mch2-rddatabuf-depth = <0x10>;
+			xlnx,mch3-accessbuf-depth = <0x10>;
+			xlnx,mch3-protocol = <0x00>;
+			xlnx,mch3-rddatabuf-depth = <0x10>;
+			xlnx,mem0-width = <0x08>;
+			xlnx,mem1-width = <0x20>;
+			xlnx,mem2-width = <0x20>;
+			xlnx,mem3-width = <0x20>;
+			xlnx,num-banks-mem = <0x01>;
+			xlnx,num-channels = <0x00>;
+			xlnx,priority-mode = <0x00>;
+			xlnx,synch-mem-0 = <0x00>;
+			xlnx,synch-mem-1 = <0x00>;
+			xlnx,synch-mem-2 = <0x00>;
+			xlnx,synch-mem-3 = <0x00>;
+			xlnx,synch-pipedelay-0 = <0x02>;
+			xlnx,synch-pipedelay-1 = <0x02>;
+			xlnx,synch-pipedelay-2 = <0x02>;
+			xlnx,synch-pipedelay-3 = <0x02>;
+			xlnx,tavdv-ps-mem-0 = <0x11170>;
+			xlnx,tavdv-ps-mem-1 = <0x3a98>;
+			xlnx,tavdv-ps-mem-2 = <0x3a98>;
+			xlnx,tavdv-ps-mem-3 = <0x3a98>;
+			xlnx,tcedv-ps-mem-0 = <0x11170>;
+			xlnx,tcedv-ps-mem-1 = <0x3a98>;
+			xlnx,tcedv-ps-mem-2 = <0x3a98>;
+			xlnx,tcedv-ps-mem-3 = <0x3a98>;
+			xlnx,thzce-ps-mem-0 = <0x61a8>;
+			xlnx,thzce-ps-mem-1 = <0x1b58>;
+			xlnx,thzce-ps-mem-2 = <0x1b58>;
+			xlnx,thzce-ps-mem-3 = <0x1b58>;
+			xlnx,thzoe-ps-mem-0 = <0x61a8>;
+			xlnx,thzoe-ps-mem-1 = <0x1b58>;
+			xlnx,thzoe-ps-mem-2 = <0x1b58>;
+			xlnx,thzoe-ps-mem-3 = <0x1b58>;
+			xlnx,tlzwe-ps-mem-0 = <0x1388>;
+			xlnx,tlzwe-ps-mem-1 = <0x00>;
+			xlnx,tlzwe-ps-mem-2 = <0x00>;
+			xlnx,tlzwe-ps-mem-3 = <0x00>;
+			xlnx,twc-ps-mem-0 = <0x11170>;
+			xlnx,twc-ps-mem-1 = <0x3a98>;
+			xlnx,twc-ps-mem-2 = <0x3a98>;
+			xlnx,twc-ps-mem-3 = <0x3a98>;
+			xlnx,twp-ps-mem-0 = <0xafc8>;
+			xlnx,twp-ps-mem-1 = <0x2ee0>;
+			xlnx,twp-ps-mem-2 = <0x2ee0>;
+			xlnx,twp-ps-mem-3 = <0x2ee0>;
+			xlnx,xcl0-linesize = <0x04>;
+			xlnx,xcl0-writexfer = <0x01>;
+			xlnx,xcl1-linesize = <0x04>;
+			xlnx,xcl1-writexfer = <0x01>;
+			xlnx,xcl2-linesize = <0x04>;
+			xlnx,xcl2-writexfer = <0x01>;
+			xlnx,xcl3-linesize = <0x04>;
+			xlnx,xcl3-writexfer = <0x01>;
+		};
+
+		gpio@81400000 {
+			compatible = "xlnx,xps-gpio-1.00.a";
+			interrupt-parent = <0x01>;
+			interrupts = <0x02 0x02>;
+			reg = <0x81400000 0x10000>;
+			xlnx,all-inputs = <0x00>;
+			xlnx,all-inputs-2 = <0x00>;
+			xlnx,dout-default = <0x00>;
+			xlnx,dout-default-2 = <0x00>;
+			xlnx,family = "spartan3adsp";
+			xlnx,gpio-width = <0x08>;
+			xlnx,interrupt-present = <0x01>;
+			xlnx,is-bidir = <0x00>;
+			xlnx,is-bidir-2 = <0x01>;
+			xlnx,is-dual = <0x00>;
+			xlnx,tri-default = <0xffffffff>;
+			xlnx,tri-default-2 = <0xffffffff>;
+		};
+
+		serial@84000000 {
+			clock-frequency = <0x3b9aca0>;
+			compatible = "xlnx,xps-uartlite-1.00.a";
+			current-speed = <0x1c200>;
+			device_type = "serial";
+			interrupt-parent = <0x01>;
+			interrupts = <0x03 0x00>;
+			port-number = <0x00>;
+			reg = <0x84000000 0x10000>;
+			xlnx,baudrate = <0x1c200>;
+			xlnx,data-bits = <0x08>;
+			xlnx,family = "spartan3adsp";
+			xlnx,odd-parity = <0x00>;
+			xlnx,use-parity = <0x00>;
+		};
+
+		debug@84400000 {
+			compatible = "xlnx,mdm-1.00.d";
+			reg = <0x84400000 0x10000>;
+			xlnx,family = "spartan3adsp";
+			xlnx,interconnect = <0x01>;
+			xlnx,jtag-chain = <0x02>;
+			xlnx,mb-dbg-ports = <0x01>;
+			xlnx,uart-width = <0x08>;
+			xlnx,use-uart = <0x01>;
+			xlnx,write-fsl-ports = <0x00>;
+		};
+
+		interrupt-controller@81800000 {
+			#interrupt-cells = <0x02>;
+			compatible = "xlnx,xps-intc-1.00.a";
+			interrupt-controller;
+			reg = <0x81800000 0x10000>;
+			xlnx,kind-of-intr = <0x0a>;
+			xlnx,num-intr-inputs = <0x04>;
+			linux,phandle = <0x01>;
+		};
+
+		timer@83c00000 {
+			compatible = "xlnx,xps-timer-1.00.a";
+			interrupt-parent = <0x01>;
+			interrupts = <0x00 0x02>;
+			reg = <0x83c00000 0x10000>;
+			xlnx,count-width = <0x20>;
+			xlnx,family = "spartan3adsp";
+			xlnx,gen0-assert = <0x01>;
+			xlnx,gen1-assert = <0x01>;
+			xlnx,one-timer-only = <0x00>;
+			xlnx,trig0-assert = <0x01>;
+			xlnx,trig1-assert = <0x01>;
+		};
+	};
+};
-- 
2.25.1


