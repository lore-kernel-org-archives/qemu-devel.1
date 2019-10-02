Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE06FC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7DF2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCQvm/r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7DF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi6A-0005UQ-4j
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrQ-0005YU-E1
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrP-0003VL-3S
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrO-0003Td-SX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id n14so20461408wrw.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vqzgHL7aRM9BJ5Yw7NhTakoGS6o9s+EDo3MElhnA4Yo=;
 b=YCQvm/r58Rd7V9C4pIDVGgbSnl+SCGIA34OAJuj8Z2qGD5hCEZUwS4D9VVvqGylmag
 +1Caz/bLtW2B3rqlNESurtD3Rq9t/wEDfnzbz3Po+xU9w5S5EltdjK6F5IIPGsFHp984
 E455mhamRZUT1Irq7RBvLuUT7TfzLfhYBJlyoX9tsc2UPptvafU+lLa3X0oJ73rYdBRr
 COyroZwqZ9DLVFfHeDKhgU9Wj0SqAwsScrIw9LBPrCdWwbitvNfiJqQrtw9QV57qgBte
 L998gYSeKT5Ym9+ESpSjOZWUQMrpY2GKI1JU7G6xrX5LkMpBtaZM0z577KxOCtDSVe9c
 iTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=vqzgHL7aRM9BJ5Yw7NhTakoGS6o9s+EDo3MElhnA4Yo=;
 b=e3Ct5RSaEh/uBu/SvLZ7k8tFWszxnUCE+rIl8dkdADxFZ7EKNVD4imPIOKwaomopZU
 zD+m4lr4gA4EwbxtT15Qy3650q8Av3qE6Qr/J8UAS7kLTo03IqTuepmjB0I5agbDJghS
 ug7E2TCTCPQMvB2M2z7nHSjaU/3ZgsZLwKSqX5coO8hrE78UW6fHH/tKPN7ilp6o91lM
 0FI0lSYqNyJcaM9PZB0xj9/sE0eE2VGkMkoZJMJFO6+u/RDUKQtcgG2qhl20ev4KdqxO
 KovNs0XbnQXEZgHo3dihfy92us37ag7nzPLJ6TLZ4S+G576uW7xYNGcZq9Zhkge/yvJ7
 aHSw==
X-Gm-Message-State: APjAAAXLE8rIJ3CvSFdcgqJBFLx+Az7gmyT8ZouIsf7PIh0LBfymjvk0
 3eTdXTgSM+r5P5q2OmtW/h5/S2lC
X-Google-Smtp-Source: APXvYqw9OF7jliYLO+M78sZLBp2m+T320tFbytLcZwQFCGC0au/pfrW96Y4IDcImc3P+dgMqW9mS4w==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3340604wre.245.1570035137640; 
 Wed, 02 Oct 2019 09:52:17 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/30] i386: Add CPUID bit for CLZERO and XSAVEERPTR
Date: Wed,  2 Oct 2019 18:51:45 +0200
Message-Id: <1570035113-56848-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The CPUID bits CLZERO and XSAVEERPTR are availble on AMD's ZEN platform
and could be passed to the guest.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b771f1..313a2ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1130,7 +1130,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_8000_0008_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
+            "clzero", NULL, "xsaveerptr", NULL,
             NULL, NULL, NULL, NULL,
             NULL, "wbnoinvd", NULL, NULL,
             "ibpb", NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c62e3b6..033991c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -723,6 +723,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
 
+#define CPUID_8000_0008_EBX_CLZERO		(1U << 0) /* CLZERO instruction */
+#define CPUID_8000_0008_EBX_XSAVEERPTR	(1U << 2) /* Always save/restore FP error pointers */
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
                                                                              do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
-- 
1.8.3.1



