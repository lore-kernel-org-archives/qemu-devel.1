Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A09C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F4E20724
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/oUX8PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F4E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqICy-0007m7-70
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqI8z-0002UT-3D
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:25:57 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqI8v-0000L8-9u
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:25:56 -0400
Received: by mail-ed1-x542.google.com with SMTP id d16so9973388edz.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TLroeih9NBidBGSg3FuKZ7ZAT7w/rCVSOE3rWqHtmeM=;
 b=e/oUX8PAqiaPwvLB5cvaxo3/vqvR+E3kbLPdscOKN1oV+gsLH736RMUnhFT2ERYOHj
 MfImHnGe1hyNARDkz8RU1wa6xyMGWwf2dIvNgABHqiRpfIRilRwuLOcqdGayTjJSAZol
 n3eDy1gM3INqsG/Aft7SRf1IqtNQ1Z/oPtF+ETfjzbTH70SqZD53Q2+y8I5mH4mBGzEf
 2Ron1kJTZ/bStdP+S/ztV4TzNjSZVPCHprfK0Jq7wT1Tcj2CE7vPPXqD6vlmsdrOqHqE
 1xjnRqQkNWZ4p2E+7grGb5yFD7e1gAL/iJhb3LlGHrhMLz+6UN1EP1mqibP9fCuTv3in
 PUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TLroeih9NBidBGSg3FuKZ7ZAT7w/rCVSOE3rWqHtmeM=;
 b=BaaADASqU0qpyfYNIzYVUgxgW1z7lh6cWYg1xBY3UYUzPA6DQgYZV5EV3hNwPO230n
 jxJcvoQcolA+J94jpRUkAP8xXHwf7rqDMAHE/G29RILPJp8D9ywCsd1eoD1kmegVl9l8
 jFbnsv8arLqzgVaCjTC4gGXltVD4czuAlVq0sd2lQ7kKjBHZmYzNjiUNEzAiVVLD5Dhp
 kiJY9ZElgv3i6P71o9E8jusxChHKdKb7OzlnaafUbtOCNtCCPI81c4PeGXdsrl35G/cB
 TOkFvs7icuCSUQwWUUvFGLfP0+yCoiE9zM7azxcqCYpkOEkVfIDBIV6ZtAFByZrV81HF
 59UQ==
X-Gm-Message-State: AOAM532TNa8Oafx8NxcWZIHYm0ux2AI1GSM6Dxe9FSPv5uHx/tNFbAqb
 f5GXa45G4WsxU73jcQcNXYNShAk2
X-Google-Smtp-Source: ABdhPJzoN2qbY23cOps0MCaj3wf4E/IBgo9c0a/YJbEI8xcKQPUuN8eCUD3SsiaX16RNHEHIPFx/RA==
X-Received: by 2002:a50:ce45:: with SMTP id k5mr24037894edj.80.1593530751259; 
 Tue, 30 Jun 2020 08:25:51 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id q21sm2272398ejc.112.2020.06.30.08.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 08:25:50 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] MAINTAINERS: Adjust MIPS maintainership
Date: Tue, 30 Jun 2020 17:25:31 +0200
Message-Id: <20200630152531.20657-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630152531.20657-1-aleksandar.qemu.devel@gmail.com>
References: <20200630152531.20657-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paul Burton <paul.burton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paul Burton and Aurelien Jarno removed for not being present.

Huacai Chen and Jiaxun Yang step in as reinforcement.

CC: Paul Burton <paul.burton@kernel.org>
CC: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8acf8d31..908431580c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -213,7 +213,8 @@ F: disas/microblaze.c
 
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
+M: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
@@ -1061,7 +1062,6 @@ F: hw/dma/rc4030.c
 Malta
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
-R: Aurelien Jarno <aurelien@aurel32.net>
 S: Maintained
 F: hw/isa/piix4.c
 F: hw/acpi/piix4.c
@@ -1080,7 +1080,6 @@ F: hw/net/mipsnet.c
 
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/r4k.c
@@ -1103,7 +1102,7 @@ S: Maintained
 F: hw/intc/loongson_liointc.c
 
 Boston
-M: Paul Burton <pburton@wavecomp.com>
+M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
@@ -2677,7 +2676,8 @@ F: disas/i386.c
 
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aurelien Jarno <aurelien@aurel32.net>
+M: Huacai Chen <chenhc@lemote.com>
+R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
-- 
2.20.1


