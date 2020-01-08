Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2AAC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910B3206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcP7acUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910B3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAXu-0005YW-JQ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWJ-0003eI-Ef
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWI-0004Fr-Ba
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:07 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:32778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWI-0004FQ-5c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:06 -0500
Received: by mail-wm1-x32b.google.com with SMTP id d139so16419022wmd.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i2g/TgemWgl5O4aQNWuawgyyRlmyRO6mT3xQ0xkXqXE=;
 b=qcP7acUtTX8xWP80zC/e87WsdpTp3Kk0SINaC+Qb8bHdci7Ug5Q00jM5rpLI2Pxh6y
 43u60gKm4b5NT2wzkJ/4AYhJzSfJwIMgRPVxOyoyxur4EOgLzh3FrTNWwNwaancczaSw
 pGo10rVBwX1Bh42YRFRykdh5Bhd1bLDRll8NUV3d48ZQIcqxAyKDUs7OxVekXVOeRj68
 nhtNq6sz/GpePDBcJZ0II2Fu2/oX3KYuinOnwHSBzESJRBQus2QtpcYQFd4ILAZW1hdl
 0acXxyg32TpPIHRAARDYF/pBICohbzBw+slNeuOzmEqcq8S5JyrBupEMtg9k8cGf8ale
 k2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=i2g/TgemWgl5O4aQNWuawgyyRlmyRO6mT3xQ0xkXqXE=;
 b=OOktf7ThfRhqRCO02Z7oE0eg1/9P3N48Dr/qkPlU0DXODBDWj1z3tNvCZJ7a6ov2BP
 gp7DBHM8wgfZIoXr+ycC+79m36TX964VDdySoVXKYvul/xVWRvrnvdBovCVpnKVMuSWV
 m1iHKz30fhexIYT15n4tLEAyzbr2wsGumQLu/fY3pC2+QcrsXSDt7W1sGLNU4OcgaXVy
 tUrEJ3AsnSP6P5Gp9IRi6yIti7C0pKwqjBKiRYvmgp+gVwTLd70BkfXMuSB8GHCVnP02
 tsy8Oq4U1paU2dzFQ/4AxpfFtBiShnnRz/POfHqaN8+eC1xmh7Y4FVzWz3FjounKGxdS
 IJRg==
X-Gm-Message-State: APjAAAXmldKiaAqQbcy+sVLb+xk+uE3+2rQ17caUqd2lZ7/3SWK1tOZa
 PmGyg4VgKAVPBi7inILnGEekJhVf
X-Google-Smtp-Source: APXvYqxmaxTl7dLyTBQzmnAQxGMkqOVL+k5zdDIwuJJv2GyOuy+R0Q3T056fdSfacNmm72HgIXE1UA==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr3725444wmk.85.1578486785006;
 Wed, 08 Jan 2020 04:33:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/38] hw/timer/Kconfig: Intel 8254 PIT depends of ISA bus
Date: Wed,  8 Jan 2020 13:32:25 +0100
Message-Id: <1578486775-52247-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

Since i8254_common.c calls isa_register_ioport() from "hw/isa/isa.h"
we can not select it when ISA_BUS is disabled. Add a 'depends on'
clause.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200106171912.16523-1-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index a990f9f..59b3f44 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -15,6 +15,7 @@ config HPET
 
 config I8254
     bool
+    depends on ISA_BUS
 
 config ALTERA_TIMER
     bool
-- 
1.8.3.1



