Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E142070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pg2xzB+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E142070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zWG-0002HF-Kk
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQW-0001aq-LW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQV-0005yA-LH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQV-0005xm-HA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFwSqFOqQSCSww1xvrmrTjGR2tB5knkZUpnBFKdTlOc=;
 b=Pg2xzB+GFwXNnz2ELBVPqPZmUDpISaWHyPO+QDWtq5gp1+RfBJXS/s/wiSnNSAZSAw83x3
 EY5FIzyddITCBLT7muEKaZOQTLPE7vGuPW2kJr+NhV63k7OHBwYw/CFjQWdkCJoQx/38oL
 oLE//XP5K6eP5neE3eJMgBMsrrBUjyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-6OgMTHLZMBSEm4HpWTGoEQ-1; Tue, 18 Feb 2020 04:44:21 -0500
Received: by mail-wr1-f72.google.com with SMTP id a12so10517168wrn.19
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EdIcfUQ/U2hHF17TjP9T3eQu8UrcSLlBv6lIHRbb1ng=;
 b=tk/8zV6Pv68QCXU/PHdqdHkAqejVbiHjxSs/UuhmUJkGxKG2UOgtGd7mwevkq2MlDo
 5OxQdpYZsXpoF0VF4lgmSHKhtk+eS7SgyynKbxN58YEuvHzPZNu+cJr26V8eD2dVnOkK
 KhMoLIYi5fUfwLOOSbBfFz/ju7/y9izP8XdCoQ7ajtF4bjPSw7XWe2MPGbA8d6/UKu0z
 a4IzjaOKlKnCwYWQQdc8cfbwerjYsGCSS7KpTkFTcibxlDGqH6cU5s/1QpFljZSBDADm
 Cv0EarYuI3W391iKPxxA3Veo8+q804+BdUS3PNGF/SdU/GxLZHIUzqiUhhTSBAjt/06/
 DdXQ==
X-Gm-Message-State: APjAAAUG1oVZHnORBg046Oz75PatFB5HVWhZd3cbOgNpslci+zkvPKjW
 Eq2KYhAU2naAtv4DZaVglFPQkXuI04uX07iq7+zu0ieEg7xA/AeBdEzWYoLn38+js5QgHUCY0Uh
 y/8V8oNiHoKc1fsI=
X-Received: by 2002:a05:600c:299:: with SMTP id
 25mr2223530wmk.68.1582019059883; 
 Tue, 18 Feb 2020 01:44:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKMOFmz8WuMxWwTBTyCBST4g/cP1AY409LS+ZZl+FoOdhI+u7Ak15lTGc2mNST2Qgj7Z9wbg==
X-Received: by 2002:a05:600c:299:: with SMTP id
 25mr2223512wmk.68.1582019059684; 
 Tue, 18 Feb 2020 01:44:19 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 07/13] hw/scsi/esp: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:56 +0100
Message-Id: <20200218094402.26625-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 6OgMTHLZMBSEm4HpWTGoEQ-1
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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

Fixes: 74d71ea16bc
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f8fc30cccb..405f8b7cbc 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -293,7 +293,7 @@ static void handle_satn_stop(ESPState *s)
         s->dma_cb =3D handle_satn_stop;
         return;
     }
-    s->pdma_cb =3D satn_stop_pdma_cb;;
+    s->pdma_cb =3D satn_stop_pdma_cb;
     s->cmdlen =3D get_cmd(s, s->cmdbuf, sizeof(s->cmdbuf));
     if (s->cmdlen) {
         trace_esp_handle_satn_stop(s->cmdlen);
--=20
2.21.1


