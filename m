Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59913C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0952083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7L+pyW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0952083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2zzY-0005yR-6M
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zyd-0004cR-66
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zyZ-0001Oh-21
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zyY-0001OR-Tn
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581782846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9lANoO2hEBAiK6Abua/ChKi8GNRcgOtuBPCjmr2dzdE=;
 b=a7L+pyW29o1ifd79Sc5fwH+/GVzR6y8zYMRpfQB/p7O6amhqKCFd6FnczxHBSqiM+kqHje
 pRqJDLqVRg8UFHrOzpahq/mg6jN8+JaEzX/Ox4kBSkSv53Rv8QcAmQm4HtKuwIuvNa/Wt3
 +Qvd5yNpFRXIy53mJD87a77tfIf9Gts=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-V9BeUBltNOWmc0a31Oe1Eg-1; Sat, 15 Feb 2020 11:07:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id m15so5858248wrs.22
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d8e6F3HqEE0x4iPGnHEvC8Ht6riximn+mFoIVOHHMnY=;
 b=ocA3t8AYcHN/sS5GtVzzKKOPVDh/Ts6RPkikkWdm85VdPp/bItfpOOBedYWUu6nUUr
 OctqR9GAVxsRHaLd0+cFZe5TexL3wtEk7SCGrJoTERyzVcsXyVKdDwCPlWpwadzSC19W
 sXE9vHIDhrb4++WoMjuIOp3esNyk9IHGXlbsolA/y0XZzUc9u3dLoJXJ2IOCC8JuxwUJ
 dnU8MCBC/3gmUaRROv9J7Z1QpFUKbbSeXo0IhOYTfF55yG/8DU7NVDccIOjsR/3QadxM
 2vRASrp6WY7Pyl2WIX0uJJCqKFrVpuQAy8gD2pdVowZqHUMY6XN8djnTH61B47PMBpjf
 ly6A==
X-Gm-Message-State: APjAAAU1oCQtzyf5ESZF2r1C6eTxNQ3X8s4aQlfk+zf5e89sVNR3iO+R
 YTpTl1WDjRRweSx1UVurQiel0JdiQc3vdNU8RORXQW4cK5TkGm8uUb35DtbMgIrdfZH6OZehhNp
 14qglQbadfSoSRJc=
X-Received: by 2002:a1c:670a:: with SMTP id b10mr11318159wmc.2.1581782843096; 
 Sat, 15 Feb 2020 08:07:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqziF1UIS6+lmgyIdT2IxhVdJc63drWLai8tkYBPVSLGT8C7ke6WufVmOX1aWniDmkaGzy5aNQ==
X-Received: by 2002:a1c:670a:: with SMTP id b10mr11318145wmc.2.1581782842914; 
 Sat, 15 Feb 2020 08:07:22 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b18sm12103829wru.50.2020.02.15.08.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:07:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tools/virtiofsd/fuse_lowlevel: Fix fuse_out_header.error
 value
Date: Sat, 15 Feb 2020 17:07:16 +0100
Message-Id: <20200215160716.1262-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215160716.1262-1-philmd@redhat.com>
References: <20200215160716.1262-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: V9BeUBltNOWmc0a31Oe1Eg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      tools/virtiofsd/fuse_lowlevel.o
  tools/virtiofsd/fuse_lowlevel.c:195:9: warning: Value stored to 'error' i=
s never read
          error =3D -ERANGE;
          ^       ~~~~~~~

Fixes: 2de121f01e
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC because untested
---
 tools/virtiofsd/fuse_lowlevel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 704c0369b2..2dd36ec03b 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -192,7 +192,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int erro=
r, struct iovec *iov,
=20
     if (error <=3D -1000 || error > 0) {
         fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n", error);
-        error =3D -ERANGE;
+        out.error =3D -ERANGE;
     }
=20
     iov[0].iov_base =3D &out;
--=20
2.21.1


