Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0037BC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DDE20645
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV4g+Jd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DDE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43091 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTubb-0007CY-0E
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:46:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZg-0005wM-PI
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZf-0002wD-C2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:28 -0400
Received: from mail-yw1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:35896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZf-0002tm-7I
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:27 -0400
Received: by mail-yw1-xc2d.google.com with SMTP id e68so2793885ywf.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=APMSNSqtnnFNaM+yj1wHvrpXrKFzgMoEIGWJUZ5RW6k=;
	b=JV4g+Jd9G4uHzV8WwmEzYOVJwTMSC+dLPipIHVzoLm2jZE7f9P69rq6hAAnOEmDW8h
	pMPKjNKGZfvpJz/lFSw5kbY99DPpwxUI8Q0ygc12vgLg5AdmRJhYsCw/HA8kgzE9YKDO
	xNab/Q1pckAdd/3pDmyCExvJ2WMQVN+w78h1CwUOvr5SrFHNsb7+l0OCb0zuN32ae8PM
	9TViObmDTBdI42QjRX45F8fTJ1t9XEVMbwjj0MOnyxiil9BUDCaRFTE5YdSVYXa7pf64
	s/TJz/vFUqnEiYpLJ0aKK17gYwMKEWFvwb/1k0rVWYPkCd5iq7pbB+ixO3MmoPsfjyCw
	WjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=APMSNSqtnnFNaM+yj1wHvrpXrKFzgMoEIGWJUZ5RW6k=;
	b=aSP0kn+HHqRtMa4nA5e0RsiCfrcBzoRwEU1E6nsOh5Z+u37++tmsekuvhpw4BmBzj9
	rqNyb8GI/vy0EVbLOoJo31Z+M5orz7+mEWByJiMpX9J/uTJRxISBS1kH4JfQmkzu56By
	TyRJmlapE7JP44yp2bNA33WdrUjf/Mf595Fz1ib65wWsRo/bMDG2rbC0krBi+yPxOTNN
	pf601D8IAnX42nt4H+IGugxZqWKGQqMJNauKAfj5iKQBU6hyYmUsENGL4r8c3cKiZfVO
	0Oonokvu7tl90SxNMGtof9lkit+wv5tj5CI3flmgcNzkDi4E10djm9nYOQ5Gc4q9pfR4
	5oLw==
X-Gm-Message-State: APjAAAUtvLxLcQypFD5IUEoeN3fjoemBW0lV2Om2YqEgAHaJmd9sZDEy
	GL0Wxjjjw31yLllriFixUvtCDcFt
X-Google-Smtp-Source: APXvYqwZ7n9EdgML+6JYE4JFsm1aoRSS4H2W3v35gCM3dJVf/PvS0H4ElHywFrgnxczTc7F2tczpAA==
X-Received: by 2002:a81:300c:: with SMTP id w12mr47550161yww.57.1558644266428; 
	Thu, 23 May 2019 13:44:26 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:25 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:59 -0400
Message-Id: <20190523204409.21068-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2d
Subject: [Qemu-devel] [RISU v3 01/11] Makefile: undefine the arch name symbol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At least GCC defines the symbol "i386" to 1 to signal the target
platform. We need to use "i386" as an undefined symbol in order to
correctly include risu_reginfo_i386.h from risu.h. Add an -U option to
the build command to make sure the symbol remains undefined.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4aad448..b362dbe 100644
--- a/Makefile
+++ b/Makefile
@@ -17,7 +17,7 @@ VPATH=$(SRCDIR)
 
 CFLAGS ?= -g
 
-ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) $(BUILD_INC) $(CFLAGS) $(EXTRA_CFLAGS)
+ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) -U$(ARCH) $(BUILD_INC) $(CFLAGS) $(EXTRA_CFLAGS)
 
 PROG=risu
 SRCS=risu.c comms.c reginfo.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
-- 
2.20.1


