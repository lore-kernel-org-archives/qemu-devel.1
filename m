Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D8AC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B14420578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW/i+5df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B14420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5B62-0004zO-H1
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5B5P-0004PI-T6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5B5O-0003ZX-PG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:23:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5B5O-0003ZN-Cg
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582302209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vFiPRvFKVsbNzmJDjMRO2L9Swvm9SGW0hfm4mbSD9HI=;
 b=YW/i+5dfh2Gdx8Z1kdxgkhFgPVxQsWyYl4ZtatLfWLKQrGOOpLZCtCOJ+hqca48n1/KxdS
 sJObzTbuuOPynIn4zvvR8RGupJH6lnS7XsZrUmQdfsZzCKgq0zz86vCAF/oFDeTLFjAEr5
 mAo48T5Bno5fI4C+mafoAPD4+i5PM9s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-5YnrrlNENWmrczHBJ2yaJQ-1; Fri, 21 Feb 2020 11:23:28 -0500
X-MC-Unique: 5YnrrlNENWmrczHBJ2yaJQ-1
Received: by mail-wr1-f69.google.com with SMTP id m15so1216678wrs.22
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NcTfhGykjxqUJHmU3wSmXTaQacdRKcUuYEHPVWON51c=;
 b=R+7wqdMKln0oVIQV2gGJj/pNWTlM6A8SlVenp0trWY+2TQ1hOrB5f6az5WK6JEtZlT
 bj632ZotVHSwripb+0DauV/XJ43KNSpPHKtDsHqlMsDTrQ4h2geT+ri6hicK9Oifht20
 o6qBq4CwOgcA2pn5CuO1DFCdwt3mwfRhrAAE0n+XvB2HghShtUhf9dIZc/Yx0e8LdOZq
 P4ArEgzipqFQMyPLtWAQ1NPVyvGFG8raZtYFijEIkZzNA79Vs6c8luapgPLaJU4bN2xU
 PMgKDevwvlhvSUfZIqqd35qTbWWfu6stTLlVg2fkf5IPhffYgeXJKUasPiGmdkjk1t85
 7umQ==
X-Gm-Message-State: APjAAAU2yr5Fb/OU+UUKvP+9Zox313Xl3+Ci1XoNlPCnjNuLPVEIJEqe
 cc9kVw39bdomarMdCQtVJVVG4cKklJndQXuvvHpYYNbaz0wMCthgX1rNXjDAM0Wwsp4AB6zUEiV
 wNgK0l1lRmY595Mg=
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr4630259wmd.69.1582302206919; 
 Fri, 21 Feb 2020 08:23:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPW6MlDqjpVahUai1trotfdKv5CNBBce8BJNdWrULkYlCfHaQVRs9HWS27lBbyek3/wKN6Lg==
X-Received: by 2002:a05:600c:34b:: with SMTP id
 u11mr4630240wmd.69.1582302206723; 
 Fri, 21 Feb 2020 08:23:26 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t81sm4367414wmg.6.2020.02.21.08.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:23:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/unicore32/puv3: Simplify puv3_soc_init()
Date: Fri, 21 Feb 2020 17:23:25 +0100
Message-Id: <20200221162325.28194-1-philmd@redhat.com>
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit d8ed887bdc, the puv3_intc_cpu_handler handler takes
a pointer to UniCore32CPU in its opaque argument.  Directly pass
the cpu pointer.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/unicore32/puv3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 7e933de228..eec7f561eb 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -48,7 +48,7 @@ static void puv3_intc_cpu_handler(void *opaque, int irq, =
int level)
     }
 }
=20
-static void puv3_soc_init(CPUUniCore32State *env)
+static void puv3_soc_init(UniCore32CPU *cpu)
 {
     qemu_irq cpu_intc, irqs[PUV3_IRQS_NR];
     DeviceState *dev;
@@ -56,8 +56,7 @@ static void puv3_soc_init(CPUUniCore32State *env)
     int i;
=20
     /* Initialize interrupt controller */
-    cpu_intc =3D qemu_allocate_irq(puv3_intc_cpu_handler,
-                                 env_archcpu(env), 0);
+    cpu_intc =3D qemu_allocate_irq(puv3_intc_cpu_handler, cpu, 0);
     dev =3D sysbus_create_simple("puv3_intc", PUV3_INTC_BASE, cpu_intc);
     for (i =3D 0; i < PUV3_IRQS_NR; i++) {
         irqs[i] =3D qdev_get_gpio_in(dev, i);
@@ -131,7 +130,7 @@ static void puv3_init(MachineState *machine)
     cpu =3D UNICORE32_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
-    puv3_soc_init(env);
+    puv3_soc_init(cpu);
     puv3_board_init(env, ram_size);
     puv3_load_kernel(kernel_filename);
 }
--=20
2.21.1


