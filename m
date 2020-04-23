Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA3C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6F220857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwfhtOXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6F220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRaii-0003Uc-M4
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahN-00024Y-D9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahN-00085q-1P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:21 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jRahM-00084u-Ke; Thu, 23 Apr 2020 08:11:20 -0400
Received: by mail-lf1-x144.google.com with SMTP id g10so4510826lfj.13;
 Thu, 23 Apr 2020 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZXHuJLnfVKlM3eLt5lleezX6bddMyflnOWtIAO7U7a8=;
 b=fwfhtOXq0fpq/HCyBVyXBNdwzozudu965KbJ6pjtxaTNH7V9SAYdK58yAzuE6NUMqZ
 /4OD032rX9dw5D3z73AfCXBggcCb0Y0J2ZkS86ePrmlTJxHrE9JcRcNpEc/TsIK9IgXF
 z0+/IOBQtwZRDT/uqZE/GtObJEjEmXzRx3iabl590cVHlGm1uX9F9qAcktzEGNrGtNF6
 qPrMGQ7w1ZDaKJSiROeGN07kk4t9Aj+G+zogPsXgdiw8cqro1a6TJ8cdFI5WjklwcEto
 m1ewwwNu62QPTTr/d8ZY+2900Kkg9hVns7nS8I1mm5I5z6LeBBZAi2RPOfk+GOv9wzNV
 plJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZXHuJLnfVKlM3eLt5lleezX6bddMyflnOWtIAO7U7a8=;
 b=lwr8Y+0iLXqU5qavjkEA3RvE7IaQnyJF9xU6UYFcT/wK61CP91DjgslCRMGFV0/eU9
 ZthHBjAprNqEmbWa9gIeZpx4+wj+UXx3o5VY9jMC+rAVJSx6bz+DCWtIRNuWd/b/bUoO
 dlzEkcgcF1owzmK5T3QHBCvQzng24PEBkgDGS6wz/g7FjXHupQs5Xgo5rxn/83oNnHYJ
 h+2Picl6yGjlkFPaf2m9EzQcHimUc4jZwizfCjvoed8VBCgFwMAM24SrQmElKH9LHupl
 9NJnfCR4QcHhJ4AIFUNTLtqd4ezdZ6s3fFUiiluk4htlGNyWIBhGO1CsjuZzxsDbYutc
 Pqng==
X-Gm-Message-State: AGi0PuaEfgUSxgrSpm3fdyytXTYfG/6AWwSazNEnO/Ur9TpbZ0J6h20L
 Y4qJWQg7vkxcuA3YtYd5+ceFQ2kwIq4=
X-Google-Smtp-Source: APiQypIOVTL/UkehtEQGbPX1a21ZuXiM7FkbCZ3WHyelf/mS0Hlvwlrh47/4nA4XegStdlnWdSsBUQ==
X-Received: by 2002:a19:48c3:: with SMTP id v186mr2210409lfa.194.1587643875276; 
 Thu, 23 Apr 2020 05:11:15 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q125sm1635708ljb.34.2020.04.23.05.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:11:14 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] hw/arm: xlnx-zcu102: Disable unsupported FDT firmware
 nodes
Date: Thu, 23 Apr 2020 14:11:10 +0200
Message-Id: <20200423121114.4274-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

When users try direct Linux runs on the ZynqMP models without enabling
EL3 (and using appropriate FW) they run into trouble because the
upstream kernel device-tree has EL3 based firmware nodes by default.
PSCI firmware nodes work because we emulate the firmware in QEMU.

This series avoids that problem by disabling firmware nodes that the
machine cannot support due to lack of EL3 or EL2 support.

This means we can now (without manually editing DTBs) run the following
in a current Linux tree:

qemu-system-aarch64 -M xlnx-zcu102 -m 2G -dtb arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb -serial mon:stdio -kernel arch/arm64/boot/Image -initrd zu-rootfs.cpio.gz -append rdinit=/bin/sh

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Constify compat in qemu_fdt_node_path().

Edgar E. Iglesias (4):
  device_tree: Allow name wildcards in qemu_fdt_node_path()
  device_tree: Constify compat in qemu_fdt_node_path()
  hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102
  hw/arm: xlnx-zcu102: Disable unsupported FDT firmware nodes

 device_tree.c                |  4 ++--
 hw/arm/xlnx-zcu102.c         | 39 ++++++++++++++++++++++++++++++++----
 include/sysemu/device_tree.h |  5 ++++-
 3 files changed, 41 insertions(+), 7 deletions(-)

-- 
2.20.1


