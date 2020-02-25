Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D02C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65B721744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOVCUFgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65B721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a1R-0004r8-00
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0W-00046m-Ff
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0S-0003gO-SE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0S-0003fr-Lt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:08 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so2909570wma.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=nRYIH3y8Xom3CDp8/YJ/8ijjUz0MFPeZCZ7j0YIYXuA=;
 b=FOVCUFgw2lwD0DRu/yfu/+4h/GffIBwjEahoISDTSz0pU12fqAIFZB3i7PABQSYlgP
 Dfqjlsagoa54o92wwdf6ZJoegEJso8A8+7eTyObtGTnauPk8REIwop+/6K8IE927DehZ
 ErZ2szhDY5XhQJ5SG35fbOWity4XVOzEfBekRpLux/dUeJB3M72HbdBk1p7dZIo7re3E
 x5V0SZjCLVYgHykcDbXt68pkyivqP2dhltxu9U6wihNgU2zstwcSzeWpSpNYmyEFXq3M
 kijQUsIpL+kH0cjTCHrekpIVG6TDUM078o75yCp70xoMUC5J8ZTrbTBvJ9CyJG+rytjK
 5Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=nRYIH3y8Xom3CDp8/YJ/8ijjUz0MFPeZCZ7j0YIYXuA=;
 b=FwEv24aSZlp301xKRcGYeEdILIIYYO8x4vAqyU4wa4L0xHgYdVoBZJpLuFlSnCo0sy
 qqjFxR0n5FoxsKGIMA72RwINiVrKThLcLMhfwiyyEdtEOkbgFA7ao7I3SYDxrIxi+i0i
 ko1NUi5QCewPL63Ly/b9Uu4nZGttWer9042RP/y7U4wklVFk/Ziafh8QCdDaTI+peHnN
 ub8x1aKS0OrzDWTpera1VezcxZdhBMWjNBjG+y65CdSiVbMoZBaRlzrvrQMbjAmjr0cd
 ky8MRWldwbnt5HTQk/DYJ3eGYMfoAWPxoohZ/N+0TaEDKkdM4tlley1ke9xmqwBT0El0
 jeaw==
X-Gm-Message-State: APjAAAX4owA0ec4q40Ui41gSQZx2oB4O4z24wKepr8+gJ96tWyF2vD0u
 Nw63P41UYLepxZ16J7VAGqJqY1x/
X-Google-Smtp-Source: APXvYqx19jLdegQumBGiGuw8C8p+Lvt8/mia6eShoJH7UZe1kglwzu2mb/syedICyF1vOsn6cqn7Lg==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5208682wmb.155.1582632487426; 
 Tue, 25 Feb 2020 04:08:07 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 134/136] target/i386: check for empty register in FXAM
Date: Tue, 25 Feb 2020 13:07:32 +0100
Message-Id: <1582632454-16491-32-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

The fxam instruction returns the wrong result after fdecstp or after
an underflow.  Check fptags to handle this.

Reported-by: <chengang@emindsoft.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/fpu_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 99f28f2..792a128 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -991,7 +991,11 @@ void helper_fxam_ST0(CPUX86State *env)
         env->fpus |= 0x200; /* C1 <-- 1 */
     }
 
-    /* XXX: test fptags too */
+    if (env->fptags[env->fpstt]) {
+        env->fpus |= 0x4100; /* Empty */
+        return;
+    }
+
     expdif = EXPD(temp);
     if (expdif == MAXEXPD) {
         if (MANTD(temp) == 0x8000000000000000ULL) {
-- 
1.8.3.1



