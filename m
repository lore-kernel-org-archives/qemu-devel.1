Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898B4CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5715A2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIguV4hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5715A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNf2V-0002cn-DR
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdit-0007im-Ni
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdio-0007h0-Lj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdio-0007gH-Cp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so15444067wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8c/3/yDPtbmBA5j6HPKqTm5tEp67D1/8CMXeibduBpY=;
 b=EIguV4hmi4rSCjBXMEW8soNlceIS4yXE49wVCQQh3SRbc8n+1xC+coO10jeQoi7nIb
 C5zbyukq6kFQDyMf4niIzM74rMzqMI4pcya+taVsFn098yrcvWjZyf0N3LXoADnhuNiR
 5Lj6yKLdnWdFrduAZq8q+nZRcay9ML4vieUrVzlWNtl3UEz9H1+TVjf5EVyPR6UpaB3g
 Kpo5G6kTnthI8UHVwy343DEoQzTVdHK3xeJXr1xbdT2cIIkPV/l4XqpyEatY3IxfVwca
 d0LGCZ0tkE/MItCBpr51VA+toJ3qIeoNyfJEmc208KEnAMCvShmDNU49nPlVxQ44RKDa
 khdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8c/3/yDPtbmBA5j6HPKqTm5tEp67D1/8CMXeibduBpY=;
 b=KL7LCxJ2GSBjlh/kRd5+4+RzT/aWqCdu6cDwKdKmpzLpuNfOqB4yFQU5pWhOBQd/G4
 WpWbnPAcLL7e0byUKJiSeCPFB0Oo3P4anMAc2If2x/VXODVcFaUFuT39voyxP8n5LvNu
 nz5MHmakuUMxB0IS8yFZZPcRVlDMMCa4REe8AbvxBJnuosbaY1TdBOkW8h1E/gkJC+GF
 hRsv9LZLRlZdBw2pWGHXgnpXKnGoHKzJSEZ2zplkxh6mi/PFmpyi0evZsrM4fERJWlH7
 mB21pwUCco/70h6AYg/LhDL9rs4bca4RtkSYxSsr19m+pvyijWgglLAD2E0mVS05R0wm
 y/Tw==
X-Gm-Message-State: APjAAAU/gYkm/LPMj4Eg1M3LR9oloNWuBqM9tV3KQPXHarNLu8FKK+1N
 Btzl5B4yFkTX+VC/PExf0Lo54KgU
X-Google-Smtp-Source: APXvYqxPwG9m1rXXM7N7w1+gA0X+PG5MSgUd6/xLEp6kWk3xus11d+F3g+3f2hhuhrc34oqzhjR6Ew==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr3754421wru.136.1571925851806; 
 Thu, 24 Oct 2019 07:04:11 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/39] hw/i386/pc: remove commented out code from
 x86_load_linux()
Date: Thu, 24 Oct 2019 16:03:28 +0200
Message-Id: <1571925835-31930-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Follow checkpatch.pl recommendation and remove commented out code from
x86_load_linux().

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/i386/pc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 77198d5..903bc05 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1061,9 +1061,6 @@ static void x86_load_linux(PCMachineState *pcms,
     }
 
     /* kernel protocol version */
-#if 0
-    fprintf(stderr, "header magic: %#x\n", ldl_p(header+0x202));
-#endif
     if (ldl_p(header + 0x202) == 0x53726448) {
         protocol = lduw_p(header + 0x206);
     } else {
@@ -1155,16 +1152,6 @@ static void x86_load_linux(PCMachineState *pcms,
         prot_addr    = 0x100000;
     }
 
-#if 0
-    fprintf(stderr,
-            "qemu: real_addr     = 0x" TARGET_FMT_plx "\n"
-            "qemu: cmdline_addr  = 0x" TARGET_FMT_plx "\n"
-            "qemu: prot_addr     = 0x" TARGET_FMT_plx "\n",
-            real_addr,
-            cmdline_addr,
-            prot_addr);
-#endif
-
     /* highest address for loading the initrd */
     if (protocol >= 0x20c &&
         lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
-- 
1.8.3.1



