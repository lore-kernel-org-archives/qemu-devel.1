Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FCDC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742E52070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVh1fAYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742E52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpTG-0002Ig-Fi
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ7-0005hw-Ud
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ5-0004Xf-K9
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ5-0004Vp-6O; Tue, 21 Apr 2020 05:42:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 188so2806542wmc.2;
 Tue, 21 Apr 2020 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8G62XSTUPNKZGFwOZugFbJOa4c1ZSiwyEE9S8xUHdlI=;
 b=PVh1fAYqEy5lq4uKVL8+41Br7557qI5TISw7YOUxuJncoClwfzgWIEGfNELHo7oSIJ
 Pg6mRIc8Ozct1Eo0FfyUCcPxqvar1B+vBdhdXPrAXHBSyplgNZLPTYjKVj3Ira6ip4Px
 9qzSfwxw5XhmUjuXrpC3Z6kDReKZ69O2eCED7l/1Cn92iXAVl857G9IGmKaKBc7OEjT6
 NhQd23ZweM7jBq+JmzNwgxwi+22ajGqt4ZgaqcnRYt7jIdZXpYCIOhKdsgXLUYVtjLKh
 FkzIEX6I2QcrE1AIdDtxyvUcI1lSwIO7C2YJ0pheaQ4uMN9Agq7/zjn0v4CDkuVufOfU
 H64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8G62XSTUPNKZGFwOZugFbJOa4c1ZSiwyEE9S8xUHdlI=;
 b=pDWcYxJknGfTQ/Q8cQUIR9g9F3qb0e6oWz4A17rVYqdA6rBRad6mqxPscMz9k2Wbsc
 eX6ZpMb1yCO9xixvHStM8Qwk1byaE3O6hbRLEcHu16svlFuq3AB2gomeQX2/h3eBmZ6O
 2z+JIFeSaKNpcnIlH9AeSy3vqzlaUm1N9803PU5BA8PB1HohaZHt7QAR6MFHyM4Z1RAS
 Qac9afMYyyAHbPECVCo3l027NBsgOxF/kyK9lBbF7QmcDhNlWEk9kF2Ph0sE9dTQQ42k
 eFQ59U49WBlokSEFtV5f6g4W2ggP5AjV9VYBKhS8ho3sczwoG4Bbt0wVAvNPb5MjJwsC
 KYpw==
X-Gm-Message-State: AGi0PuY60DyXxlmpHqCbHLokVFIc52eQAuyPHR8x4+g/oIWSKx5wZhej
 sBwy4wt/Hfsxrw/kTzxToTIRZSFS53U=
X-Google-Smtp-Source: APiQypLAAqTSX8s4h8hglYTTj4twY7Y6E9o/+GhFMgXGxwvaPEEELZ8d+709MxN6XlIbCLQPTcGCeQ==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr4220857wml.51.1587462139381; 
 Tue, 21 Apr 2020 02:42:19 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b22sm3082814wmj.1.2020.04.21.02.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 02:42:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] MAINTAINERS: Cover the GDB Python scripts in the gdbstub
 section
Date: Tue, 21 Apr 2020 11:42:13 +0200
Message-Id: <20200421094216.24927-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421094216.24927-1-f4bug@amsat.org>
References: <20200421094216.24927-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Keep an eye on these "same same, but different" files.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: "Alex Bennée" <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..7a7f2b9c31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2083,6 +2083,7 @@ R: Philippe Mathieu-Daudé <philmd@redhat.com>
 S: Maintained
 F: gdbstub*
 F: gdb-xml/
+F: scripts/qemugdb/
 
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.21.1


