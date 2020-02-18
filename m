Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D271AC34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC9921D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLmbrA1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC9921D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3za7-0002C4-OW
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQe-0001yA-7P
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQd-000658-5Y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQd-00064d-0m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2H4J2vu3KXwWqexWZLOkS7UYkLLeRSP92ejNeD36GIo=;
 b=fLmbrA1PguWd4xTZgZzaIu4QgOXoPlJ4cbx84zoZeT1DNKiGcSDjo8A8NRnlolcAu451Ie
 vOQHpGHlc6vseo06sByk7ELOMS5AVAYDbsQgzl5y24dMaFAYlI8GU0LCmwmq1sFF1j2H80
 U7u7dO1wBSU+SAAWfiHFf9wqM+mHTSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-Yp8misK6MMyYCssu3sLzqA-1; Tue, 18 Feb 2020 04:44:29 -0500
Received: by mail-wr1-f69.google.com with SMTP id u8so10519220wrp.10
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6ueQmicwIeIWE9QVKujYvFp2EZixSOWD+HCjjhY2qH0=;
 b=fQILIPh9cMEOVkjwtr5e6EFRKKlO+M3AqQ/juvYX5k0DV660nCmejlgutTK6TXDd8S
 nEHSZYOKnF8Ec1LLHLJcgUxhL553F1Qls9rii6wDKPDIkOHrjrRf7+Y0MlupkI9trtfa
 xIrcSzKfy6ZzAP6NVj7cpmiwKRb0T/ltgOWOZS0FUY8A/Arj/eKRgu39lNIqPpsr2dXQ
 gXOCz/6aGcJe9HKf67GoB0Pxa5M5X+kyhK2d9/ZMATBJ/FszmABicKC2tPh4vHNoCL9u
 9BS1qDXii6jddG1uuHxngg2X8QgU0qri4CgIEFeE5M9HQvw00luK2fnm5x2xORmcnpdy
 aLRQ==
X-Gm-Message-State: APjAAAUveOHDTnm3rhZ4WsUO5mAmh6A3He8PqgeVuKg1WM2vMdTEw9fK
 ZPdcA83E3NniumeHSa/YWJWJRiNMhMfIubb7ZRgRIRchk1ugCPK0ZoJv1/DmjBL2XfPjyxC+1e8
 wwiRhrSfL/XrtIuw=
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr2148686wmi.71.1582019067778; 
 Tue, 18 Feb 2020 01:44:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCA059Ogn7CXouSGQm9+beUhkgs8qHWq3OziNenbn6goYgA3XySp+oQl0mgJ91wP5MvnEJ7A==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr2148654wmi.71.1582019067602; 
 Tue, 18 Feb 2020 01:44:27 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 11/13] target/i386/whpx: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:44:00 +0100
Message-Id: <20200218094402.26625-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Yp8misK6MMyYCssu3sLzqA-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Justin Terry <juterry@microsoft.com>, qemu-block@nongnu.org,
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

Fixes: 812d49f2a3e
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Justin Terry (VM) <juterry@microsoft.com>
---
 target/i386/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 3ed2aa1892..35601b8176 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -511,7 +511,7 @@ static void whpx_get_registers(CPUState *cpu)
     /* WHvX64RegisterPat - Skipped */
=20
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterSysenterCs);
-    env->sysenter_cs =3D vcxt.values[idx++].Reg64;;
+    env->sysenter_cs =3D vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterSysenterEip);
     env->sysenter_eip =3D vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterSysenterEsp);
--=20
2.21.1


