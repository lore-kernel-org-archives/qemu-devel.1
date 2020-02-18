Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8145C34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723862070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8+CeeoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723862070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zWI-0002Jm-H6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQc-0001rc-41
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQb-00063a-7W
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45580
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQb-00063G-3l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40zqfghgSnOWp3sxm5Gs0HxCk7BfBA2vJWHYVREX1q4=;
 b=E8+CeeoW47A2zECyZrfhxjzugs14QsajtMdJxXgnWWSg5hOvvVjzoJCgvNKfzTEInoV/MG
 sLOpxDBLy0nb9LNLb9HZs/0AZNlAQ35GWU3t9wa9VAXQjkeuNwQ++rX2Kl2KVZoRu0dwCs
 KjyZ3Yw+p0s/KryPM5x0lw1iRFiRn0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-E1EKGlwRO4ypUit_rfj8AQ-1; Tue, 18 Feb 2020 04:44:27 -0500
Received: by mail-wm1-f69.google.com with SMTP id f66so870947wmf.9
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bfCwsKB+QGICVw4yPnq5z2hHQ+37s3RqO+sYab9kkJ4=;
 b=ESfoOCOeNc2T/eXcsBWAeWIq8A65CgoDgVKxzVtas8CLccCtL8RoNWXQJLRX/XbhAk
 wbdSVS/0QgglV/34QCHDDmEqPSFoe4LhToIfe/vbsF87Q1e0pBvrWj3TZ2BlLOsT+MDI
 xWjz2wRHw8TW1Vh9ZBjelRY9zdEpPwsvkYbcpPm460tLvWGmjXxlc5G3mzOF0u/WIdHD
 UOke64WU51YzbobYiff5UACFz0KdzgGpUqTRn5WixBcaqLN6u1eDte78y1rApPSvs789
 gN7lik5+jaEr0Qkusx0I3cf2n6u+9vQnUdWtB3s1prX5sWrmQUqfVVbrruO+fhh4F7h4
 83QQ==
X-Gm-Message-State: APjAAAXzx+bged8+lmYl7o0QNk92m05kUSSorxwT0rK97hlqcxzP+v1z
 X/ldWONSs7/qBAYaxRTzdM6iA/fvJsxmKWQ7D2Bsp4Ou8sqIC7pLNGJD3VfVp/iY60mkKkErfH+
 pTcxAJP9klep0q5s=
X-Received: by 2002:adf:8b54:: with SMTP id v20mr28936795wra.390.1582019065740; 
 Tue, 18 Feb 2020 01:44:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxyiqZGixY74dt7rvy2/XkLF8pR4v15It2iHhUudf3pLbbos0wkdDFg4OcP8GN5Io4KyVOXhQ==
X-Received: by 2002:adf:8b54:: with SMTP id v20mr28936743wra.390.1582019065492; 
 Tue, 18 Feb 2020 01:44:25 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 10/13] ui/input-barrier: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:59 +0100
Message-Id: <20200218094402.26625-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: E1EKGlwRO4ypUit_rfj8AQ-1
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

Fixes: 6105683da35
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
---
 ui/input-barrier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index fe35049b83..527c75e130 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -455,7 +455,7 @@ static gboolean writecmd(InputBarrier *ib, struct barri=
erMsg *msg)
         break;
     default:
         write_cmd(p, barrierCmdEUnknown, avail);
-        break;;
+        break;
     }
=20
     len =3D MAX_HELLO_LENGTH - avail - sizeof(int);
--=20
2.21.1


