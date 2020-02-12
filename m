Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A701C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9F120714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7G66yIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9F120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1v8p-00038K-2h
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v59-0003da-Un
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1v58-0001qW-UB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1v58-0001pF-Ns
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:41:46 -0500
Received: by mail-wm1-x332.google.com with SMTP id p9so3072798wmc.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mz00RFFNAoguGGP8hvX8GCqEJMfOE+04kRLpScSRYxs=;
 b=n7G66yIiq9YaVlpdnBNyz8h5bouoUuZR6ObFfkibce0HmlDRxUuGvfPsoisOwooJPe
 mA9VlrN7Af/5HDezr2i+1AQ0RfHzmnTLBQ34vwnpCatPlOHFIJXV5NUu88AJZbB8Ivla
 sVAIChfAyzBEQlM1wqeLAZ44afNSzu+8CrJiF9jAvgk1Odz9Mm12V9pdhs+z3cQLBtLP
 Tw1XjhTkrXZeJxJ8/HKp2dW/5m7muXZHkNa35diUfiDjdr3o8m0hnAFVhN1mU28BzpDl
 xVrvrqBHhA2WNqO9/HyALP9nrpazpahw7VHcLgv1WO7CvlTgqAsABg7LalFAfOgzWAgE
 K7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Mz00RFFNAoguGGP8hvX8GCqEJMfOE+04kRLpScSRYxs=;
 b=uJt3jbPNnFo2SNMeYbKpyNmT+353bivInLGUiBCpAC2B3rXWimu/2TCca/pkbHBThB
 wyRtzKc1yYnhvOiPRjR3T3hu4CT7zDG+q/Sc1jmpcUH1bPyU45iOMrUkirVPcm6xUT10
 +0kXz+uNrrJm5mZtIvK8508sHgu9XNGA/s5nIR+SMoqIwOkMY3ulRJos7eoUmdi7vAFi
 wxXblEZgYdeGBd/tlAKvNoCLsBuwxd49/+peHRGjLol0P6xreDbyiksoNzsFdfWoZBba
 j/qMYBZdImqX7zuLyEKHP5i2Q0piMiv6ZHaYi95TGEt6sOrE0SvlKTecn/Q7UBjvM32D
 7DJg==
X-Gm-Message-State: APjAAAW54uWtoQ9KUfaPgSqRIrJmLT6JWgIaueJVzXOr9KUxg1KB4WEb
 A92sZyFCj0SyByR1Zs/48P1vNWUa
X-Google-Smtp-Source: APXvYqx1ftccN9hhH/lEPfkyImZ861sYc8RFgBWl0Dl/KtDs8SHKprJ5jU4eM3y4aF212fWsvvkQCw==
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr14356210wmk.128.1581525705540; 
 Wed, 12 Feb 2020 08:41:45 -0800 (PST)
Received: from donizetti.fritz.box ([151.30.86.140])
 by smtp.gmail.com with ESMTPSA id a16sm1195122wrt.30.2020.02.12.08.41.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:41:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] target/i386: enable monitor and ucode revision with -cpu
 max
Date: Wed, 12 Feb 2020 17:41:29 +0100
Message-Id: <20200212164129.6968-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200212164129.6968-1-pbonzini@redhat.com>
References: <20200212164129.6968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

These two features were incorrectly tied to host_cpuid_required rather than
cpu->max_features.  As a result, -cpu max was not enabling either MONITOR
features or ucode revision.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 32efa46852..92fafa2659 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6414,7 +6414,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(&local_err, "CPU model '%s' requires KVM", name);
             goto out;
         }
+    }
 
+    if (cpu->max_features && accel_uses_host_cpuid()) {
         if (enable_cpu_pm) {
             host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
                        &cpu->mwait.ecx, &cpu->mwait.edx);
-- 
2.21.0


