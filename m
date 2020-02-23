Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62072C35673
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F6F206E2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVA3wmfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F6F206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60do-0006n8-7S
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j60cn-0005lC-Nj
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j60cm-0004NG-DZ
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j60cm-0004Mn-AL
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582500323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZegvAFjlZ8lPMKIn12dEXQozujBbKNxETEOG2LBKAe8=;
 b=jVA3wmfByruG5ux6mtihujMhcTLB8bGfpP5XzVQDch9jUIcxsj+wU47VyoH61PyMErU/Rg
 JvpgTYj5oIIbOQYpZV8TSpVLyqxCTEQH+qBih3PQhh+9CbF0NQ9G9fXCxcOdllBrNXvw5o
 C1fOZa9CR9BuWVGUMgzGbahudskLmmo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-xf_VG47tNfy5IAD8HkOmxQ-1; Sun, 23 Feb 2020 18:25:21 -0500
X-MC-Unique: xf_VG47tNfy5IAD8HkOmxQ-1
Received: by mail-wr1-f69.google.com with SMTP id n23so4641380wra.20
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 15:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HsH1saFQOYWMUtqcYQSrjb8t2MfdXo+sLZMyek+PG2I=;
 b=T1QNB19D6/F+ioKhYk1KLrL0oVTWPJb2k/Ynh8aIl9maMjXJfACULsZkNBo00BkOwF
 8t8J9hSCumvCg974pc/jhzI0ZfXOYRBeSFSJGPsmJIJXA2s0U2g4UQ1AoZxEtpffYR03
 Leo+rabTMloWda9c7SZy6ySSxdKRwdIcUgvTr2MtDH7bon/zGEUg6NSuTmU4Nav97CaH
 yCfF/bB+5hN5HzhceuzXEndqhX1xK00JCpGmvavTAYySGcDRpJN2EVJ5trEIMlFGEy/b
 inFfjYhEeIE71J2PmYeFQgzm+MIuN9JqgQyA65Xd8vBstLr8rYPLixHO4Y3GesjH/X8U
 cZRw==
X-Gm-Message-State: APjAAAXizM2+Ge2odbtfquNp9Z+POXoemFoN7Hl76FYPWFedIz5jCcHM
 Fg2ZNiB63kx3Agr4FZcdacVxgKS/FymW8AfzRk1Xi2LbjCkIu6AqY2PAAxJdtHAhF0c+HKYwAEe
 XN0Gq/M1Kc9OspeE=
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr18535044wmm.145.1582500320039; 
 Sun, 23 Feb 2020 15:25:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxddUtqnHEzG9BU5Ewy5qygFuUsqH+b27MtPXSXjZJGTj+XcJ5K1odGI3wSvs9sUukT9QIhUg==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr18535035wmm.145.1582500319857; 
 Sun, 23 Feb 2020 15:25:19 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c9sm15671102wrq.44.2020.02.23.15.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:25:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/arm/integratorcp: Map the audio codec controller
Date: Mon, 24 Feb 2020 00:25:15 +0100
Message-Id: <20200223232516.13802-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200223232516.13802-1-philmd@redhat.com>
References: <20200223232516.13802-1-philmd@redhat.com>
MIME-Version: 1.0
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The Linux kernel displays errors why trying to detect the PL041
audio interface:

  Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (Linar=
o GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
  CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00093177
  CPU: VIVT data cache, VIVT instruction cache
  OF: fdt: Machine model: ARM Integrator/CP
  ...
  OF: amba_device_add() failed (-19) for /fpga/aaci@1d000000

Since we have it already modelled, simply plug it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/integratorcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 0cd94d9f09..59804140cd 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -644,6 +644,7 @@ static void integratorcp_init(MachineState *machine)
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_WPROT, =
0));
     qdev_connect_gpio_out(dev, 1,
                           qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CARDIN,=
 0));
+    sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
=20
     if (nd_table[0].used)
         smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
--=20
2.21.1


