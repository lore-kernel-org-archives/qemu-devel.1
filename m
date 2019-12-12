Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BC2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015FE214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 08:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="kNs6Dm9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015FE214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifJsz-00027G-1e
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 03:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1ifJrY-00018O-UK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1ifJrX-0000nF-0C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:30:20 -0500
Received: from nwk-aaemail-lapp01.apple.com ([17.151.62.66]:51170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1ifJrV-0000dA-2w
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 03:30:17 -0500
Received: from pps.filterd (nwk-aaemail-lapp01.apple.com [127.0.0.1])
 by nwk-aaemail-lapp01.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xBC8RmDX048568; Thu, 12 Dec 2019 00:30:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=mime-version :
 content-transfer-encoding : content-type : sender : from : to : cc :
 subject : date : message-id : in-reply-to : references; s=20180706;
 bh=5e4LyPFD8SY9z1AM5+4RvlgMYF4Af5pTgqwBlYwzz7Y=;
 b=kNs6Dm9OyqIrkM+BZe1PBq0dplsBmaAJ1zBeciLbITyhz666OKaIg6fIeOIwP4LtuSrO
 YOKctoi5cLoOgvN66BFXh1fGgj2HzUROEENlIU3/HD+Wg4vje7N6D8ndc9fpxZuZoi3d
 Id3uVPVCSHw/7y56YuQufhppLUWcHLj9FGOkZ16ev+KO/WRGNGlin7TuzUTK+0tOj1x3
 zR7dVwnv5WamfxHvMrYp7v3UT2oR59b+QwgAoAj4VFnc2pRfFz5HIuElkeIOLETZv1pY
 c5mPnn35iGx9mdyg1U/IhEGx+HDd/L75vKrOvBhvM33UDzsl5LVSheRBU6Vru7EtcDE+ eQ== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com
 [17.40.76.5])
 by nwk-aaemail-lapp01.apple.com with ESMTP id 2wrbw5t7mn-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 12 Dec 2019 00:30:15 -0800
Received: from nwk-mmpp-sz12.apple.com
 (nwk-mmpp-sz12.apple.com [17.128.115.204]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q2E005DP4YDCC40@ma1-mtap-s01.corp.apple.com>; Thu,
 12 Dec 2019 00:30:14 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz12.apple.com by
 nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q2E00I004YAN000@nwk-mmpp-sz12.apple.com>; Thu,
 12 Dec 2019 00:30:14 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: 184497b7-56c2-4a96-820b-e71b6e928569
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: 23211c4d1a52fad660c01b45a8ae163d
X-V-R-CD: 53b3d9b34eb02e63e8b72fb35603acfa
X-V-CD: 0
X-V-ID: ff24d9bf-027a-46bd-a0ab-48637cdb4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-12-12_01:,, signatures=0
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Received: from pontoon.com (unknown [17.234.123.27]) by nwk-mmpp-sz12.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q2E003IX4YA9MC0@nwk-mmpp-sz12.apple.com>; Thu,
 12 Dec 2019 00:30:11 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@redhat.com>
Subject: [PATCH v3 1/1] display/bochs-display: fix memory leak
Date: Thu, 12 Dec 2019 00:30:08 -0800
Message-id: <5f747e7faa7339a5406501db8326fa25c0260d48.1576139278.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1576139278.git.dirty@apple.com>
References: <cover.1576139278.git.dirty@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-12-12_01:, , signatures=0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 nwk-aaemail-lapp01.apple.com id xBC8RmDX048568
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.151.62.66
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
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

Fix memory leak in bochs_display_update().  Leaks 304 bytes per frame.

Fixes: 33ebad54056
Signed-off-by: Cameron Esfahani <dirty@apple.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/bochs-display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index dc1bd1641d..215db9a231 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -252,6 +252,8 @@ static void bochs_display_update(void *opaque)
             dpy_gfx_update(s->con, 0, ys,
                            mode.width, y - ys);
         }
+
+        g_free(snap);
     }
 }
=20
--=20
2.24.0


