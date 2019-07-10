Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE2C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8256820665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gb3bRGeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8256820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9rH-0005QU-QL
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hl9nk-0001J0-Oq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hl9nj-0000mC-KV
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hl9nj-0000Ns-9V
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id y4so1872725wrm.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZMvoxsO3ETl4fqBEf7cACx/37SrGiYDPW48cWDQTBJA=;
 b=gb3bRGeFYyrALzSvDTUqmg07n90tD6vdem80Fxl8lWu46a8rosiiStkPIrZ44WlkwD
 G9xlTEoJEJoitBJ1oIkj/DUw9HVrZGOyymgwy82HOvFJiQevdJylcoJ686JTN9bESZ9N
 nJ05okDudDlTV1X0fAMXyxB45g0zPkblSr4sXvPRuJUhfAlw0+d1IpBrvy6YV6kGPwmM
 1Qkg2fA6Qa1GMy7IzeOiSDPfEsGh0wxfeS9pyCBUFHBaTpeGJdGtJIpni+ypYZ/MyAzz
 ZvJ34gDNgBsFWgTsHsJEfzb54jgAfpA7I1/1n9INHmgikp1izb6HhHP1CKndt7KP6O0O
 Sb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZMvoxsO3ETl4fqBEf7cACx/37SrGiYDPW48cWDQTBJA=;
 b=n07jloUNT9giUK0z27kwUGgGkSOBfRvez6qyLieRfx+jnqN/4rwYUmgaqW5k2TZ32V
 Umbw68PrEU2qym0it9QhgKgV+F9L8azRfHJf0T6GP4vgRz7lKHoTjWwIXxAzZZ142pXP
 h6tfdmV+VANcgGi9u6KojEMb86nlhfC05tP8FwWW47h8+JwxvNT0GlOSL7Ipt2zZyijx
 FaZ0DW/qQG/paurkYiCpG9e1qhvjLtmKGwRLQtTpOInGspfIU3iqybahKmHQVhuen8PA
 duHu5NwLmKzoAct8dYmC0AnOOILs64GEoRdZD7QrCjvEQk7GAJuZ66DG7b1wzobnW7A8
 kQaQ==
X-Gm-Message-State: APjAAAUbAe5Dz83QVnrunD9+INISSDWUXPy3yQN6DLPkLmnyw4/iPca0
 2SCfwtpcSR2kw3EObI1Jcqsi9g==
X-Google-Smtp-Source: APXvYqy0JLxDWiaWMOcN0LqXGkYUXfCqPbXvlnwSE/VentMqXlCsleamLRnKiYOdk3wK6zcywtMfGA==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr11560301wrw.21.1562754359420; 
 Wed, 10 Jul 2019 03:25:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w7sm1547939wmc.46.2019.07.10.03.25.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 03:25:58 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC0D81FF8C;
 Wed, 10 Jul 2019 11:25:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 10 Jul 2019 11:25:54 +0100
Message-Id: <20190710102557.3107-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710102557.3107-1-alex.bennee@linaro.org>
References: <20190710102557.3107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 1/4] tests/tcg: fix up test-i386-fprem.ref
 generation
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We never shipped the reference data in the source tree because it's
quite big (64M). As a result the only option is to generate it
locally. Although we have a rule to generate the reference file we
missed the dependency and location changes, probably because it's only
run for SLOW test runs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index b4033ba3d1..d0eb7023e5 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -35,9 +35,9 @@ test-i386-fprem.ref: test-i386-fprem
 	$(call quiet-command, ./$< > $@,"GENREF","generating $@")
 
 run-test-i386-fprem: TIMEOUT=60
-run-test-i386-fprem: test-i386-fprem
+run-test-i386-fprem: test-i386-fprem test-i386-fprem.ref
 	$(call run-test,test-i386-fprem, $(QEMU) $<,"$< on $(TARGET_NAME)")
-	$(call diff-out,test-i386-fprem, $(I386_SRC)/$<.ref)
+	$(call diff-out,test-i386-fprem, test-i386-fprem.ref)
 else
 run-test-i386-fprem: test-i386-fprem
 	$(call skip-test, $<, "SLOW")
-- 
2.20.1


