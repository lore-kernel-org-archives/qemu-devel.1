Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689BFC38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304CC218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVaqCleL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304CC218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42145 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KgG-0004CY-9z
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Kel-00011Z-Cn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Kek-000661-Cw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Kek-00065P-7c
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582577325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKIXWkZQ88WTduFFFkbsC3MYjrqzYmU5aP3tKw4s+ro=;
 b=EVaqCleLEx4N3hbWnVaxYwZxzK1HcQTlBL4zEXxH0yct1q+26cDyY981YpXqbyPT9MJyMC
 q57DSxG3lbTv3cE+ZY4TC3GKYkhvrT+lmClnvK7hy0O8UevL9G4X0LEfQVNw4YI+AueXJS
 z6/BCifpw7AU1u93ia7LqPxDX39fu+w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Khfejm_nM5-6X5sipbKpqQ-1; Mon, 24 Feb 2020 15:48:42 -0500
X-MC-Unique: Khfejm_nM5-6X5sipbKpqQ-1
Received: by mail-wm1-f70.google.com with SMTP id m4so139619wmi.5
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 12:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pKNOtl8y4WJnqPTmGJ+A9Z44KVpFXaN4HJISuiqMTmo=;
 b=YLnIqiNWX9pUPIOpRXJdbA57fhJXCP4YbEeCJSeknq6+b7hAf87JE2AiFGyP+reJC4
 wiUtVo4bD39lERBlC7dJwRqsb2Txouw1JtoaVsses+azCCEUjJgSXLNSCY96pqGPSidS
 YoByugb63pCCF5Xf9XFhhiYcDd8ObjhY9o/pccO4Ako4KsvXZ+KDBaiA4YhaVsQLNnfT
 UBjv5O05tL22gF3dtqVe1hDePXt8RaooCqOTtGgUjaxkT5emcalQKx/E9PEyqJMJnaWd
 CEn0TqMZmHKYr6r//8jqaOM++FIAauA+sd17hW9wCHg0zHlBQwwJ/0fvqG6wads0WpeU
 yAjQ==
X-Gm-Message-State: APjAAAX7PWNiNDIgjerxtAw+PQgXYOSlUABvnZrE14VnfUZj0zZmP4Y6
 vuC5BFKpIew+1InIgnThu+Vx1PeKR2tjOVIlLnhRbgtjaWcRjoRWwKof2QP5POqrJY+1W4e0cZ4
 44ux1HjS6xYYqNDE=
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr69172187wrt.343.1582577320904; 
 Mon, 24 Feb 2020 12:48:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4MCZfRxgscfc/5ZSigtanCe63LnJ5kZKwhRv/zQemHwh1Jrdht+paqBfLCcFYfOZJBrKrrA==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr69172166wrt.343.1582577320715; 
 Mon, 24 Feb 2020 12:48:40 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t81sm863436wmg.6.2020.02.24.12.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 12:48:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 04/32] scripts/cocci: Patch to replace
 memory_region_init_{ram, readonly -> rom}
Date: Mon, 24 Feb 2020 21:48:00 +0100
Message-Id: <20200224204828.23167-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224204828.23167-1-philmd@redhat.com>
References: <20200224204828.23167-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a semantic patch to replace memory_region_init_ram(readonly)
by memory_region_init_rom().

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../memory-region-housekeeping.cocci           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/=
coccinelle/memory-region-housekeeping.cocci
index 3699c1017e..ee3923d369 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -11,6 +11,24 @@
 */
=20
=20
+// Replace memory_region_init_ram(readonly) by memory_region_init_rom()
+@@
+expression E1, E2, E3, E4, E5;
+symbol true;
+@@
+(
+- memory_region_init_ram(E1, E2, E3, E4, E5);
++ memory_region_init_rom(E1, E2, E3, E4, E5);
+  ... WHEN !=3D E1
+- memory_region_set_readonly(E1, true);
+|
+- memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
++ memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
+  ... WHEN !=3D E1
+- memory_region_set_readonly(E1, true);
+)
+
+
 // Replace by-hand memory_region_init_ram_nomigrate/vmstate_register_ram
 // code sequences with use of the new memory_region_init_ram function.
 // Similarly for the _rom and _rom_device functions.
--=20
2.21.1


