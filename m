Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FB3C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C9A4208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ1V1CP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9A4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5B3W-0002dw-MX
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5B2K-0001dh-4J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5B2J-0002hx-81
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:20:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5B2J-0002hq-3Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582302018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RlS28yLXsqsfr1rK9KjCIUl+K4ng7LhTJEdDyW+5qGY=;
 b=FJ1V1CP2s5ywI0RD7hXTAOJ0pbqhvSzMkKVqmPnKDltIRj8ODRNGf18gjMj8+Bv96MWJdx
 CLbvA70//MsxrskHnrGWEyP7dPl1OALkue0BSHeYztIe7bx7c1q+dPo9MgJo+FEGrxA7Et
 VZ8+iTy2/kxgODpVjpf2DNouk8hsRSU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-qb0EgROyPp6ivTfMXwKQrw-1; Fri, 21 Feb 2020 11:20:17 -0500
X-MC-Unique: qb0EgROyPp6ivTfMXwKQrw-1
Received: by mail-wm1-f70.google.com with SMTP id p2so781287wma.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NucZwwxE2rLlPt85TcvEmJXYWjTSnxUvHMBjuRGVljM=;
 b=P+GOeTD9hNVfOXPntFi4lFJZ2vmYNrjSySTLeuBf1NAVSd9v59LP8R3kUvpcwdhb/3
 +SbSMb5tCG4OH0HPbGr/pDPWr5f7n73fYKkpNGa6ONBMKkEtXQtPwFIF3yJY//J1hNcM
 Mpi6UIIX3Em25lke/ufx8QBeanwi0mRVA/tKNHrT5ynyNWKUvlZzwc3PemkBtZaHtAba
 748BuTOKrSTZhLRAg23hZ58SfOeE33TgQCYWr3EfNW82Ay6lLEjalSNYs01sd+btYu3x
 2LZ355KhGRkCIJG+k9ierZhQdFr1yvEFBE237A6mRKVNTlu4pipbyOWEYsLqUWjjCZwe
 2W2Q==
X-Gm-Message-State: APjAAAWRYYwjLWYN70HZkO+4d1TtVIfnw0CW7P8skXCj+pN56dk0oX3l
 G+W0tsIgLLmOwGdj6i0JVhKz3hpgTIi7mYggHBrrGvQZLkRDCbjRGSIegoo+qPGqSB3pRtKpDbG
 ieqLGsMdyeticx7w=
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4525625wmg.169.1582302013788; 
 Fri, 21 Feb 2020 08:20:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9z6EixTMiFYsow6hAX8LAVG6PSqH9NH4eeyEdDQu17lUUYHZUu3LrWmjllaTPPs2qq5d1KA==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4525601wmg.169.1582302013534; 
 Fri, 21 Feb 2020 08:20:13 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id m3sm4558996wrs.53.2020.02.21.08.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:20:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/mips/mips_int: Simplify cpu_mips_irq_init_cpu()
Date: Fri, 21 Feb 2020 17:20:11 +0100
Message-Id: <20200221162011.26383-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit d8ed887bdc, the cpu_mips_irq_request handler takes
a pointer to MIPSCPU in its opaque argument.  Directly pass the
cpu pointer.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 863ed45659..796730b11d 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -77,7 +77,7 @@ void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
     qemu_irq *qi;
     int i;
=20
-    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, env_archcpu(env), 8);
+    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
     for (i =3D 0; i < 8; i++) {
         env->irq[i] =3D qi[i];
     }
--=20
2.21.1


