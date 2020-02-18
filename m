Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D121C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5C32070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ep23fMk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5C32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zU6-0006wh-6A
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQT-0001QQ-JG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQS-0005vA-Ia
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31829
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQS-0005un-FE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twD42LsJdxtk70mtkC2JiuCyIG9SZpU8nshsRUT8WmY=;
 b=Ep23fMk8v2ext4p6Maj/ihjBjmpl4o8y7/BJqNO2lP/MiIRWhSWxiu9SpAOPeijrazEoWd
 w+gK6+j8AV9p26HOdWhe0vW4x6kCzsVpaBwmORR5m2cJOUFs/8fzbFaHUCZs2UA+g+1rhf
 9vmMBoqLWYBp2Ij5OTFZsAoxPjVcnDQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-nplV5Z1BP0KsmYq1dUOQyw-1; Tue, 18 Feb 2020 04:44:15 -0500
Received: by mail-wr1-f72.google.com with SMTP id m15so10436288wrs.22
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IhIk9nB8PMGzSNjXgBFB3gJKa0gAiyLYRyAtuExQk+A=;
 b=F5r8q6c93ZvABrCWYOEWFkT/0E4/qrCpYpG2U0k3H/CrHBDCynYBBd7Qgy4TUO7TB/
 vXS7TeGrY6JOLOThyRiF3xnutT6g7266uHMM/He1Z4oX9yRt0R7XBauDVHMExvmXAnzj
 WDSd7eXLEGpimHhv8BGbZ9lpSRKIDU9033a5N0/uJFQhBWXwox4GTu2fDQePE8FwydgJ
 g73KQ2wHiV6MhDaP74bty7ecoV+9Y48QQ8I/V3LZs1sMIkNbnERjFqBALHihf7gFr4+x
 vYmk9v4I+p0AQYTzUHjOJvQyvmIxNQj2Icwjci+ha18w+UReZ9bxZP7J2qnqeAm7qu0D
 IIbg==
X-Gm-Message-State: APjAAAUIQ2yGprYwokm9hgLpApiWDWeAH8wFlaSBIKSGG1CYdyqdUC2t
 rjZun8N39k5o7ndBXMH8/uL+QetVh5yKAr3aYiuDH4ZXgRf7TvLuhRBo1WO1/oWnLG6WgWs0vBU
 YzXNwnYE87tVrZOU=
X-Received: by 2002:a05:600c:34d:: with SMTP id
 u13mr2157064wmd.77.1582019053904; 
 Tue, 18 Feb 2020 01:44:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyxSaLMTZVbF80I8bs0+LLcodBrB/Et/yW70LRDg9VCjT1WlC6Vrdyy+j7Ie6N1FZP9RWoAjw==
X-Received: by 2002:a05:600c:34d:: with SMTP id
 u13mr2157015wmd.77.1582019053713; 
 Tue, 18 Feb 2020 01:44:13 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 04/13] block/io_uring: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:53 +0100
Message-Id: <20200218094402.26625-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: nplV5Z1BP0KsmYq1dUOQyw-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
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

Fixes: 6663a0a3376
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Stefano Garzarella <sgarzare@redhat.com>
---
 block/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index 56892fd1ab..a3142ca989 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -187,7 +187,7 @@ static void luring_process_completions(LuringState *s)
                     ret =3D 0;
                 }
             } else {
-                ret =3D -ENOSPC;;
+                ret =3D -ENOSPC;
             }
         }
 end:
--=20
2.21.1


