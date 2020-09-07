Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCBC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFE52080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMMGtql9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFE52080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF5mE-0006fK-79
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF5lA-0005J2-UV
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:15:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57176
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kF5l8-0003Hb-UB
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 21:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599441349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbSZmAbx1t0XX9K3FIPuzWI0Sx28Y4x/c2CAULydyHg=;
 b=UMMGtql9uwB1Rt106kh6cOz7wY2lrYz0RavBExM1afWjXntIhSZ9/vmUpU1/N+JGUkmumV
 ohw0ugMR4m1FjVIP64IaAve/vx35YcpXXak2HEP8MTtTxsnhKdMBifRLOfBluARyuLqIkA
 mx560bLLPH5WJh+9gxnnBNmWASlMDyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-5qK8XOpWNsykJscBTUwPZA-1; Sun, 06 Sep 2020 21:15:47 -0400
X-MC-Unique: 5qK8XOpWNsykJscBTUwPZA-1
Received: by mail-wm1-f70.google.com with SMTP id m25so3441130wmi.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 18:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bbSZmAbx1t0XX9K3FIPuzWI0Sx28Y4x/c2CAULydyHg=;
 b=gbFUs31sa3S+F3lQKRit3U9Uqx8VYVP0SaGVCxVQDxhPyDsOBhqu9hlydes7Q8xyfW
 yPa2LMPMmJmnfkGGzcTvwg4QPb4IGfWWxP8EVjka+AcZTPYlr5PgvoqOZ51Wh6gyi6yc
 MM2xVFD9QPPbNyLyBOMDX5L9MspDczihZD+q5VyOVJeFJVBH2AZJUSsq7/No2TAtuw2r
 I0RzhThed0lXiP2KaAJJIQnYthzlW73mOASfFESKVRs+YUKOMlRKHNIEcUrpGJjmsMqZ
 1q42RAImamhu+EvyZpS1AIAv/IaAcKdg0tNP0Hl1Gnc79FFqiH3cnd6wRhk6zh29Xjqs
 6yNw==
X-Gm-Message-State: AOAM532a146ICntj3gu1cEINxIzkhx4fCjmjAduq+bVE5aujinyBnQ8q
 4C2DSkElNYlsQXmdODlbvFPlInC+DgBUNbSGk0pTSWRQnokZZwwPZEQkIp2CIHPRAmrg6tZY8VP
 tQmPh017IkNIJmC8=
X-Received: by 2002:a05:600c:2159:: with SMTP id
 v25mr19406427wml.180.1599441346151; 
 Sun, 06 Sep 2020 18:15:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO7P7MDFSxuNwm8hp+goa/1xw+xrpaBpnqEXGnMQAGa4aDHvieQoyl32P3iwa2FaEdFRdsdg==
X-Received: by 2002:a05:600c:2159:: with SMTP id
 v25mr19406401wml.180.1599441345889; 
 Sun, 06 Sep 2020 18:15:45 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n17sm23201953wrw.0.2020.09.06.18.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:15:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
Date: Mon,  7 Sep 2020 03:15:37 +0200
Message-Id: <20200907011538.818996-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907011538.818996-1-philmd@redhat.com>
References: <20200907011538.818996-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:15:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'mipssim' is not a real hardware, it is a simulator.

There is an ISA MMIO space mapped at 0x1fd00000, however
this is not a real ISA bus (no ISA IRQ). So can not use
the TYPE_ISA_SERIAL device...
Instead we have been using a plain MMIO device, but named
it IO.

TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, using
regshift=0 and endianness=DEVICE_LITTLE_ENDIAN.

Directly use the TYPE_SERIAL_MM device, enforcing the
regshift/endianness values. 'regshift' default is already
'0'. 'endianness' is meaningless for 8-bit accesses.

This change breaks migration back compatibility, but
this is not an issue for the mipssim machine.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/mips/mipssim.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 1b3b7622035..5d4ad74828d 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -216,10 +216,11 @@ mips_mipssim_init(MachineState *machine)
      * MIPS CPU INT2, which is interrupt 4.
      */
     if (serial_hd(0)) {
-        DeviceState *dev = qdev_new(TYPE_SERIAL_IO);
+        DeviceState *dev = qdev_new(TYPE_SERIAL_MM);
 
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
+        qdev_prop_set_uint8(dev, "regshift", 0);
+        qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
         sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
-- 
2.26.2


