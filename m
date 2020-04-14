Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8553C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7156120678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlBgHsdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7156120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOva-0005uJ-Fc
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOfb-0004Ph-2x
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOfa-0007Td-1Z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:44:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43407
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLez-0008IG-Ic
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P044dvCGY+OjnhTCca21kcGYqk6pkGT1ZkSmX3AzxY4=;
 b=OlBgHsdw1akwjcLTR2pJx7+X/wxCHp/25lludZ4nyzvc0aOSdd0UEKW1TWgm9Xmr5lWa5s
 HsSj9HR0f9OGem7MCjf3XSz+pM5tZZsnpGGsnrBklhPPXoEn1h+qiYihZ6MGZkuErMyIA5
 z6kx4hiKHABrwhjq4qE9lwfXUzYcqAA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-EXeZjF_pOMy7z_-6C77rdw-1; Tue, 14 Apr 2020 09:31:27 -0400
X-MC-Unique: EXeZjF_pOMy7z_-6C77rdw-1
Received: by mail-wr1-f71.google.com with SMTP id 11so2362487wrc.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xOsd+sUVGYzNkkVeZbzr6M338X1UIcZTXkjxKBvcId0=;
 b=N1qOVKQgTzXB1+gv2FjaeQZJ8WJSxkOy/n20jj72WnsY+17DzpF7RcKHzZfHUmuaFQ
 AqelZKIj4j7LH4U1yL6+PP8g4NVAedEuGl8Pji5dXgds1cLRxmHL5s8pAlxepPnRo3kg
 SR07sRkRWpi/FBG6Ke601ILOFhlSBm574OaG0qxYMp4yxYS0QWfH4qmvhpcu3kYnVp81
 CzpH/+9WQSSIcjJXlPB5XlpUh7R9R2DCvXRcEuqQ+FrCL1vf63CwFQs8xiLw+BU0vxQY
 Lqv9NSJmZiJYD4IrxeRlKFq2B87Vq2d93vrCCJL+KPlPqK5IkLIHZkXKZgi9YX3qgs42
 vOjg==
X-Gm-Message-State: AGi0Pub8iXQhW2W/tCSSJ5pGWT2HDGtS58uwQ8CkJaVlfcZElIV3MTec
 /qs+GxcwxTag7XhNDx66i2Lg1t5sjrBKQ/UVZJNOK0uxEXfYDQZAcJ/kNLPUdpRjuBZ7nvcaJTj
 lZ6ATYuQ6wqzOsH8=
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr25248736wme.82.1586871086013; 
 Tue, 14 Apr 2020 06:31:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYpggjSDgsYUwYvwjJsdDbyn4hOLFjHZrOLIrKXq+2ftERkt+CSot485qp6+APjGWdVvuG4A==
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr25248707wme.82.1586871085864; 
 Tue, 14 Apr 2020 06:31:25 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 145sm19761961wma.1.2020.04.14.06.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 06/12] hw/openrisc/pic_cpu: Use qdev gpio rather than
 qemu_allocate_irqs()
Date: Tue, 14 Apr 2020 15:30:46 +0200
Message-Id: <20200414133052.13712-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Coverity points out (CID 1421934) that we are leaking the
memory returned by qemu_allocate_irqs(). We can avoid this
leak by switching to using qdev_init_gpio_in(); the base
class finalize will free the irqs that this allocates under
the hood.

Patch created mechanically using spatch with this script
inspired from commit d6ef883d9d7:

  @@
  typedef qemu_irq;
  identifier irqs, handler;
  expression opaque, count, i;
  @@
  -   qemu_irq *irqs;
      ...
  -   irqs =3D qemu_allocate_irqs(handler, opaque, count);
  +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
      <+...
  -   irqs[i]
  +   qdev_get_gpio_in(DEVICE(opaque), i)
      ...+>
  ?-  g_free(irqs);

Reported-by: Coverity (CID 1421934 Resource leak)
Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200412212943.4117-4-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/openrisc/pic_cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
index 36f9350830..4b0c92f842 100644
--- a/hw/openrisc/pic_cpu.c
+++ b/hw/openrisc/pic_cpu.c
@@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, int i=
rq, int level)
 void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
 {
     int i;
-    qemu_irq *qi;
-    qi =3D qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS);
+    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS);
=20
     for (i =3D 0; i < NR_IRQS; i++) {
-        cpu->env.irq[i] =3D qi[i];
+        cpu->env.irq[i] =3D qdev_get_gpio_in(DEVICE(cpu), i);
     }
 }
--=20
2.21.1


