Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF9EC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDD220659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izxX2VJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDD220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zYM-0006sH-2a
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQU-0001Tb-Le
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQT-0005w2-IS
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQT-0005vV-EV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPePaRqkaWNyhfXeO+GdlIKEGlxMZTPmi+n7OlsW4E8=;
 b=izxX2VJ5X7hr4h6+d22li5bSdHN/WJoJaKD/H/fWbJVav8msRgRq36oc3yP55Ku+IKt19p
 rgAafuoAMXQaWrSYeQcF6HzDpIsn52MzXl+tCoJuWeVkNzKxyUJbLDE+VmR4e3f6Js6Q0p
 OIaSykaxq7SxnhugGiSTL/iESoycpqE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-eVMUGXWxMfmuGaGnCcNQXw-1; Tue, 18 Feb 2020 04:44:19 -0500
Received: by mail-wm1-f69.google.com with SMTP id p26so789634wmg.5
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y3Lefu65TV2Zn/tMAo2R8DrtAEmfr+gqWeC3XzYh9go=;
 b=MW8fy68q86DmKL1tFDuMAl1HwdL1zM8l9I5yHXZ4CG6alDZEj4t85iuPPwB0S7bisA
 XLJ7pwz1O9PziObOAzOqXyvHs9GzRoy2piOax24QN6OvnowmCtfc+mcyH9Agbo8kXsMa
 QF7DZu24om3iB7uTVAnXVRzU13y3d8VSwTDskMq/8lLN+ouYhmkTfZlSsrREiWd9NJHE
 PWK/1zgpkKWQdLP+CGSfe8TpFdKbtjIK95ikGwWI/82KYw6q+P8SWdvNlJOBRBaNLZ/6
 yS9usjrxhiXGZRaDUfpTnkh/rBEAjtsBvgXNtmI9E5T9SOXfmpW7wMPrCUkYZo7i3R+U
 7C+A==
X-Gm-Message-State: APjAAAXeRR0aQkKuk7Q0gssKZ3lCigO2I1wa9myMAg1zFOP8zcyTfBWU
 dTR2oOFIRmPVnsTRQ7BNrfPX3Nrl+ZIX+VWE6lhIR9IYDxmM06XGIYc3HEe8BbAQTMzDOuj9ltT
 KakUp9yuSekI71QU=
X-Received: by 2002:a1c:7ec5:: with SMTP id z188mr2131177wmc.52.1582019057884; 
 Tue, 18 Feb 2020 01:44:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjTtT9QKMDVMnwaag5Zq053OrsGaWDS9MMGXhR2QDJAV5hwIy5om9Z1ROzEb1lQaYYh9VbEw==
X-Received: by 2002:a1c:7ec5:: with SMTP id z188mr2131136wmc.52.1582019057681; 
 Tue, 18 Feb 2020 01:44:17 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 06/13] hw/m68k/next-cube: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:55 +0100
Message-Id: <20200218094402.26625-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: eVMUGXWxMfmuGaGnCcNQXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 956a78118bf
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/m68k/next-cube.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e5343348d0..350c6fec78 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -734,7 +734,7 @@ void next_irq(void *opaque, int number, int level)
     switch (number) {
     /* level 3 - floppy, kbd/mouse, power, ether rx/tx, scsi, clock */
     case NEXT_FD_I:
-        shift =3D 7;;
+        shift =3D 7;
         break;
     case NEXT_KBD_I:
         shift =3D 3;
--=20
2.21.1


