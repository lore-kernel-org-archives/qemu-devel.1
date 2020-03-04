Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7EEC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197F320848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKTuAcrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197F320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cOL-0005Uq-8G
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLf-0000Wd-Qa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLe-0006vp-QE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36563
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLe-0006va-N4
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFcihQRQW984a0z/mekZG0vNwXsxhiN/8+AlkGU0X9k=;
 b=XKTuAcrSm3awrrlcZIVhOvaP5diNQ0SHz+OJ6M/A4HwGQ/HBsSEHY20cmMymyDSUmRvNoA
 1oN77DXlJdoYexzMHblMCgHPms3ZpU4R8ZxQE6L0RSCuUsym7qouEGP4JzOOXTYPx3+snd
 3bfUeNZKYSAM8Yb05YNSzlqzhyPZr2o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-40ZlwSWsOfmwVbFthSEnmg-1; Wed, 04 Mar 2020 17:18:36 -0500
X-MC-Unique: 40ZlwSWsOfmwVbFthSEnmg-1
Received: by mail-ed1-f70.google.com with SMTP id a11so1291904eds.15
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NxwSRvf3xC8N2g5o+oXCsfEFodIN9fcThiRrbeywMlg=;
 b=a9hufVGYEH0L+XjUlRtC0MBzx+bcNPXrwEH2ZDnzPleOXbaMCDNKUvhc3IrzcKp24N
 oa+cPpd1Ygq0Vlyodvx9NyLbK/LhULGXW/lus4mByWJ9NT4fPCVk/D3hHP1f0jickyXE
 LdudB1teLB3AZ2tTCmBx+9M38NvUo9cdSIRLxEhBfbIhmqkZHsGW+KhbQZCSYX1zn1ul
 I9UnjZCgc2XahSmPraEsTpDpnRzJ5T08R+lHq/2lgVgjB65Y66/ayBACXsqTgR/SXlGy
 gEzGn/KhxwPLlbRYBbXIuiK7Rv/SlAyyfFSQlSUCDLwEiV/3qMcpiwiy561epWAew3g8
 EBRg==
X-Gm-Message-State: ANhLgQ1rrAopIdpMrhl2+zBy6fDC1mTif6Siw36yguaQnOJdDpbXYdB0
 9xR/Za3zZJ9nlcN0t5XxnoxZ1PUjokNaMoMpnCzBe6JHLD2yjU+wgPeDMfGCQUbpGBOH8hT/YU9
 Z/lcaEWOABx4fvpY=
X-Received: by 2002:aa7:c247:: with SMTP id y7mr4714026edo.376.1583360315010; 
 Wed, 04 Mar 2020 14:18:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsCGvKZw64GnBwnakygOFTqcpNPa/Q3gqpp7wrdeUodsHHy6zRbfAFju5NyQpibcxt/UU0/iw==
X-Received: by 2002:aa7:c247:: with SMTP id y7mr4713988edo.376.1583360314628; 
 Wed, 04 Mar 2020 14:18:34 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a10sm1714629edt.50.2020.03.04.14.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] ui/curses: Make control_characters[] array const
Date: Wed,  4 Mar 2020 23:18:06 +0100
Message-Id: <20200304221807.25212-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304221807.25212-1-philmd@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we only use this array as input, make it const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 ui/curses.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/curses.c b/ui/curses.c
index 3a1b71451c..3bafc10c1c 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -529,7 +529,7 @@ static void font_setup(void)
      * Control characters are normally non-printable, but VGA does have
      * well-known glyphs for them.
      */
-    static uint16_t control_characters[0x20] =3D {
+    static const uint16_t control_characters[0x20] =3D {
       0x0020,
       0x263a,
       0x263b,
--=20
2.21.1


