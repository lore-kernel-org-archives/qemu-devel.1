Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5882C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC69218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikbiwhwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC69218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zoj-0001em-HN
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0B-0003Zq-A1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0A-0003VS-7o
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:51 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0A-0003Ur-0c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id t14so2884156wmi.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T3ISc51CQNGAqf+zLY8WMizzAxQ1TztanrLB+etFevc=;
 b=ikbiwhwyP8Kht6iBMgfXSR81pNVCuAKG5wA1w+N96NaluhCs8eHoCHWpJcxmO1YffR
 jKOofY3iRwUFYCdnqqXqsbVQGf4CdvL8OWtcIHVYgKkc7act8wGWPgMe/LZmsb4bZGAg
 hse4d6E3F6hmvBAJ9HfWgOEDy2AOsfs47hSuAV3UCZ1X8iVIqasHWiBJx/jU9k8TN2eN
 vwvNC0dGWDLur2lksGCAM/Y978Yaof2WkHOOmvW9Q7rmfPv72q0Z5iCtjfh7cErfmm/w
 COtOI+F7e+L2taxSc/jYnvNs8fZaBRGOq6uYvq5wUl/yfGwuAaWu0KhRlwWxwglHkkMZ
 l6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T3ISc51CQNGAqf+zLY8WMizzAxQ1TztanrLB+etFevc=;
 b=pzKU+eNhBhX3prWyMwxg0c7AcN8yvzc5JuSSRH1z9TH6l+1JQ2wkIYEcpp0sXiiRr1
 sNkBm0laZPK5bJURnOA2Y41kpyKI3fnXDdp4KFaoSuVskIUkGB6zFpxS0vpc+5IIo1kc
 2SbdOJDDksOyKfckL3O1fqF5V/6e5iWfIvFCrGtQwyTWpj13TZq510m1y1lKaJKcHbbs
 Ps2gVBUheLKjr4Ip8kyaszLiRkpXZ/HfSwv6aK8ZbCbb6ffWbVHywDWV+bpYSArEiAdj
 mO7uFhUcc30sKt2viZRpWyVRNgKCieBsz32ktXdQOtj5SOLoaUxHWYsBhf2ewWJ6OQL3
 OEVg==
X-Gm-Message-State: APjAAAUqw64xeqXTbzlXOkvOy2yW1T9+9Fn6+qlL6VNaVOL9qGqYZWmN
 3RUbQKrxk4Xor6oWRZrZJYccAIL+
X-Google-Smtp-Source: APXvYqxnsBvkT+89JDTFi8xNYBC//3whv42YR/W7fSVSvx9GN1BsDMSoYEOtEVsk98CPhhzie5sHHg==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr5270757wmi.128.1582632468690; 
 Tue, 25 Feb 2020 04:07:48 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 115/136] hw/ppc/ppc405: Use memory_region_init_rom() with
 read-only regions
Date: Tue, 25 Feb 2020 13:07:13 +0100
Message-Id: <1582632454-16491-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

The scripts/coccinelle/memory-region-housekeeping.cocci reported:
* TODO [[view:./hw/ppc/ppc405_boards.c::face=ovl-face1::linb=195::colb=8::cole=30][potential use of memory_region_init_rom*() in  ./hw/ppc/ppc405_boards.c::195]]
* TODO [[view:./hw/ppc/ppc405_boards.c::face=ovl-face1::linb=464::colb=8::cole=30][potential use of memory_region_init_rom*() in  ./hw/ppc/ppc405_boards.c::464]]

We can indeed replace the memory_region_init_ram() and
memory_region_set_readonly() calls by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-18-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/ppc/ppc405_boards.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 1f721fe..5afe023 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -192,7 +192,7 @@ static void ref405ep_init(MachineState *machine)
 #endif
     {
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "ef405ep.bios", BIOS_SIZE,
                                &error_fatal);
 
         if (bios_name == NULL)
@@ -216,7 +216,6 @@ static void ref405ep_init(MachineState *machine)
             /* Avoid an uninitialized variable warning */
             bios_size = -1;
         }
-        memory_region_set_readonly(bios, true);
     }
     /* Register FPGA */
     ref405ep_fpga_init(sysmem, 0xF0300000);
@@ -461,7 +460,7 @@ static void taihu_405ep_init(MachineState *machine)
         if (bios_name == NULL)
             bios_name = BIOS_FILENAME;
         bios = g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
                                &error_fatal);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
@@ -479,7 +478,6 @@ static void taihu_405ep_init(MachineState *machine)
             error_report("Could not load PowerPC BIOS '%s'", bios_name);
             exit(1);
         }
-        memory_region_set_readonly(bios, true);
     }
     /* Register Linux flash */
     dinfo = drive_get(IF_PFLASH, 0, fl_idx);
-- 
1.8.3.1



