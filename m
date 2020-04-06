Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5DEC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D234F20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdEZqOgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D234F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWQM-0005hl-1E
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrc-0002p2-GG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVra-0003VP-FH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:33434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVra-0003UH-95
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id g21so583566wmh.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IyfLiNmZozxtS04NjEv2J1qw63HPdKKGf5spfnd6BGI=;
 b=IdEZqOgzaQWe76xUqago30NbmRj+8VcwpL9v1NBW565wc1cTJVYJ+izVUIhY37sYN9
 /Wa3hwd6sJHx85GlPWR8AvkBUruqUL91haKYEiXU1q/Wi1bLDlQuHCVwMZYGdfqx+6ak
 rItgrVCHK5jc/o4v9str7JP719aDoxC5L0T0COtkTyx9pU7MYcULu09mvi3vQb5FOOj0
 wsMaWdU7YcL1zzoG30lSyOIo66UZTFuXeKZWwP7SZZZHJAXdT93hDkZSiQV973rkdXYc
 Zwdc78nTH9sDW/OAdbGpWvneTW+b03IxUbKvkHMWSo7kazS8L8cKnuPHfGZF1H0IE29d
 4IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IyfLiNmZozxtS04NjEv2J1qw63HPdKKGf5spfnd6BGI=;
 b=YdHPxxhu4Ig2FZNR77SMWhKbfBtiOvYhtMDEMm3CFr5MOeO3rBDtE0AU7Wa/EvLmYY
 ZC8p8NhEOWymvMVzb6e1VAMDmNbSx2Yj6vbH0rraKz1ZooIOKAK//9CMXeSJypkOq1/a
 VfBEYtH7d26JLESYvixuWhmq728aMZbFnmhy9foyRIRD5fux+aZIDFElYBwTnG6FdUZF
 iGj2pgACFRDWWgj4FfYOuRh387VcWm2wQmUZTowHaNTkSx1q4Jp/Enq24IZCBWcLFkIA
 Sc9SavAYkMtgENLy7rVuP5gWM6WNd80LshJB41Vdhkv/52XH9iCCSjBEy/0mCtF3UQfH
 66DA==
X-Gm-Message-State: AGi0Puah24iEXY0RGwOJnsCc0XW8uKqQYHnwzUUr1qdCuk9PSWZP8g1b
 kiotqZnN2taLBqDTJTkNxfoj6sGQ9Nk=
X-Google-Smtp-Source: APiQypL1LibcRLYgfmY7gkmLVbaoNkncQeEZHskUhYK3Vo+SD3g3KrUppL6T4aLYDNg0lO7ZcIKbFA==
X-Received: by 2002:a1c:6503:: with SMTP id z3mr527237wmb.92.1586195325141;
 Mon, 06 Apr 2020 10:48:45 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 42/54] hw/i386/x86: Add missing error-propagation
 code
Date: Mon,  6 Apr 2020 19:47:31 +0200
Message-Id: <20200406174743.16956-43-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --dir hw

inserted a block after object_property_set_uint("apic-id") which
calls error_propagate() and return.
Thanksfully code review noticed returning here would skip the
'object_unref(cpu)' call.
Manually fix the error propagation code by adding a label to the
existing call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/x86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b82770024c..ec807ce94f 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -124,8 +124,12 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     cpu = object_new(MACHINE(x86ms)->cpu_type);
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
+    if (local_err) {
+        goto out;
+    }
     object_property_set_bool(cpu, true, "realized", &local_err);
 
+out:
     object_unref(cpu);
     error_propagate(errp, local_err);
 }
-- 
2.21.1


