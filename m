Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDB8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C89720729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHPnimvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C89720729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gHd-0004kE-D2
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGS-0002un-Cn
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGQ-00060Z-OZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id a5so15255979wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dVGF3E7lJx6P6MKIaUk/hhZTTCuLXFQFlFFNyp8bJj4=;
 b=qHPnimvq85RowYWbDfcE1SVljOvwEyzRMdvvkIG6FRdXW6xNjzng6y4l3Yohi4oiG0
 8nUnrifIZPFLpO0d6cld56JD3SGDwQV1d+WOkjQSPKKfxeLnoubV6DXwbl78MFbHasYR
 EmMHSVBjtKfQsANDAepRoGsRiH0DJVzEhyM5S31KiLCml0DurvhORL69/bJkQy7Q5/cm
 ER3JO3m7d1wXnN11GCdVvPaYG9nejKU423adFemYW6oagf2KD5Dn+X6e36rtHHWI/XY8
 o77fPil0L5vIz9Q7MuHapy39t5Jnqi2wJshR1F+YBaIi+ecOYwZ8guOwxDeJN86vpLaX
 xT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dVGF3E7lJx6P6MKIaUk/hhZTTCuLXFQFlFFNyp8bJj4=;
 b=UtQMzmWwkUqfka3cphekxH7IuqQXvIzI3mMBEWJbR/5o01+Z2rw/k8l5oWkEDvRXdB
 zDh2WuNvemNo4rzc2OR5Pp7pZ1G1qZdmsqMqWJVOwfKkdV0hkHUXzLod1zEewKyb72GJ
 lIImWQnAbW1Ec5CjTrzrAMWRwW4sIttKVd7jPa7ERJOeV9s22ZRqbHh/ZQD0SP/EPEf5
 ten2S7qGN4F3e7Iako/KD8COvKwKVWu0MGDrdBb0TG3muJ9nzgBGNZlAVfQsHatZpq4W
 rr9m5RYi9OVzIvGGFimklGlrjnMXO/404aQRB56oWVBu+VQXRNoZGUQLbRUCXeYLAeZT
 hqPA==
X-Gm-Message-State: AOAM532RxWgRjyF64Z6xQkKkVNZvItnB9d8yA9baQWJl8OkNDU7BeCnz
 Eof4869azMAUI0EFABxHZ/EYfVXOdQM=
X-Google-Smtp-Source: ABdhPJy+c+Ksv+5WJXERkJt3m8YJqJwJk7N2Rpci+BGRM2YLj0Pd7ccxKSD4wxqmYGV8tsZVhkYlew==
X-Received: by 2002:adf:dfd0:: with SMTP id q16mr17182548wrn.60.1597675049219; 
 Mon, 17 Aug 2020 07:37:29 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 003/150] pc-bios/s390-ccw: do not use rules.mak
Date: Mon, 17 Aug 2020 16:34:56 +0200
Message-Id: <20200817143723.343284-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 50bc880272..cc0f77baa6 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -3,10 +3,26 @@ all: build-all
 	@true
 
 include ../../config-host.mak
-include $(SRC_PATH)/rules.mak
 
+quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
+cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null > /dev/null \
+	      2>&1 && echo OK), $1, $2)
+
+VPATH_SUFFIXES = %.c %.h %.S %.m %.mak %.sh %.rc Kconfig% %.json.in
+set-vpath = $(if $1,$(foreach PATTERN,$(VPATH_SUFFIXES),$(eval vpath $(PATTERN) $1)))
 $(call set-vpath, $(SRC_PATH)/pc-bios/s390-ccw)
 
+# Flags for dependency generation
+QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
+
+%.o: %.c
+	$(call quiet-command,$(CC) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+	       -c -o $@ $<,"CC","$(TARGET_DIR)$@")
+
+%.o: %.S
+	$(call quiet-command,$(CCAS) $(QEMU_CFLAGS) $(QEMU_DGFLAGS) $(CFLAGS) \
+	       -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
+
 .PHONY : all clean build-all
 
 OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
-- 
2.26.2



