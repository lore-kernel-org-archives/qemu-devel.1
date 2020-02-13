Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1998FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC745206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNGDk17S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC745206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J66-0005tS-2e
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijs-0000pn-OV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijo-00032S-JO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijo-0002zH-CV
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id s10so7257255wmh.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rbxvM6zBsEyzHKe8nAvY0XhamX4FQe6hP23LCjFR3Y0=;
 b=vNGDk17SjuBWe9uu3NUd9utN4HpXXar9PPjiZoQTTdtyIGizJYkpWvR+1fMOmayS6h
 hWzZJZtVpuCStgWfAPflwgS8jiAdmzfvSOPcSnCOZKk+y+zfOWjHV+P0CcO2xMFXrg+s
 KkFfkf0RowSJVhS/Ht2evj27LjOF0XVKscRf20GE6Qk2CzDIC4in84cDU/OTO23XzMWS
 eFwQYSUDTJpBlRV3pYpNSknLwFtLFQs6imiZR9e3lgjsCYizrzQRUX3brvHuU7U38fes
 ezqA2i9+SzcVkRGfQE0ui05xTDWj3tCFcxTIZ091dvRTt6RGFydrDZ5eVvYQNWNAZibi
 It7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rbxvM6zBsEyzHKe8nAvY0XhamX4FQe6hP23LCjFR3Y0=;
 b=O6mVNOtj6PF5z0Ef3Z6GHdKq/361yLCcoR3r9IP1oiQXxcUQ1EGgRdyrWM2yTlF04A
 fCEojW8QwSJKqhq8vWs8O/sunrBqKZmIMAgGHGnHNe3QPCWXunMecM2O9h6kQiGfp12i
 j3lxSHpVMRytxZpAX82R4G9u1qKjzFiV45KQRAHmAtQBZDVrdV0QNJ1JZO2vPCqF8k1o
 pzwPhPL2sd9Bk/Bvaer5Qnoy6xwnrKbzYvIPnMKn4rJleAqbhlxLCM2I2/JD1K4UGYrc
 +sn2ZB18h6jxp40ng9AvfZ/ejiQttTBoAfcHaBxCiUUvuNlu159dR28Z5PoVONUJt27y
 h8Pg==
X-Gm-Message-State: APjAAAVmuBMmeiR1Gk0DeDUTwVZaDpHz5ibBsE7apu4QE2G9JTVEsKgU
 iCBB7fGGPk0rzSqGcFoIAQW4KbZT5r4=
X-Google-Smtp-Source: APXvYqw/rfnkoIK66D8VNvDpCJ7Wow15y7UMFudd4TZM3C6277u7WF4B0VuZR7/R+oygGqClS2L+CQ==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr6586511wmd.80.1581616638179; 
 Thu, 13 Feb 2020 09:57:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/30] qapi/machine.json: Escape a literal '*' in doc
 comment
Date: Thu, 13 Feb 2020 17:56:37 +0000
Message-Id: <20200213175647.17628-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For rST, '*' is a kind of inline markup (for emphasis), so
"*-softmmu" is a syntax error because of the missing closing '*'.
Escape the '*' with a '\'.

The texinfo document generator will leave the '\' in the
output, which is not ideal, but that generator is going to
go away in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a4..58580602524 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -12,7 +12,7 @@
 #
 # The comprehensive enumeration of QEMU system emulation ("softmmu")
 # targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
+# look for the \*-softmmu targets near the "--target-list" option. The
 # individual target constants are not documented here, for the time
 # being.
 #
-- 
2.20.1


