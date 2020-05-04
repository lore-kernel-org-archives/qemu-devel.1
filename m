Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0DBC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47EBC20757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFmjOFc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EBC20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc90-0001pe-6T
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6G-0005F2-1M
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6E-0005wg-GK
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qBFLHcdRaQMUsQlFXqV2eHnPlF70mfC9NFWokqhExU=;
 b=hFmjOFc3Bx5XuC5zeofTmcVFr43ViI2jTaUBFQ7gEyVyzGILyMBpNw4gCY6dEyIpLKYUPW
 KMszKqLWJrKhYuvsHU6LaeF6nU8G3s8dXqR2XgKI2CpXzR7JVop8Xrt9t+CP5cDhmAC6it
 WsCDnhNbeQCnIKTwuEdp5uRUQHgMujw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-9TCcWZ9SPXuXRrJG9mm7WA-1; Mon, 04 May 2020 10:29:35 -0400
X-MC-Unique: 9TCcWZ9SPXuXRrJG9mm7WA-1
Received: by mail-wr1-f72.google.com with SMTP id j16so10828298wrw.20
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=feEST3pElJnPhKM8FHSB9qNteiPsUjugC8IYA15rGhw=;
 b=AkmNuNgeY7NgSyTayyQuTL79b/lkql4Pr/Tf1y8NTt6yOLwwpldDpc4A9FOOZXKi82
 ASSDj+stWIOe8ASVfY4IlFecPYH7V/Ve4fCtXOSK3FZTW0qeW1iN3Z0bFUf2AB1BzOuY
 o2cmUmTMBsDywPpYTYOGF1OdeHZawtiEjYlPYcjaGPdWRh8AumOTE6LpABAZqXS+iLru
 kUwWtlHljKsudY6VnRb84wttF78onuLYvl+2uGdFElTLALj/lKe7IUbGl1OJ5Hflimor
 m4wjLFmCW03aqFQvyFaaFDl50Zk3drU8n4GJqZGAacp47EvaEHu0DQtv12obismq/vTF
 pGug==
X-Gm-Message-State: AGi0PuaVURiQ7LdnldjRt36wythnbZyJST6lnd1ur2jph/qGN4ks+LEe
 Kv83grHXied0uPZXlO4wGyqCJBNa4AUYUKYA9zlAY49PACx4T1AQMPpoOAEPpde+dTR5AA2PLH0
 xQh2PKzGKjp7Ukek=
X-Received: by 2002:adf:dcca:: with SMTP id x10mr19222681wrm.212.1588602574569; 
 Mon, 04 May 2020 07:29:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypLz+U3uacPzJanbbi8OHGeShEmUSgGA/AFr8iP38JVRfxbvGX4nCouwU5+hKxuBdvp1MA/sYQ==
X-Received: by 2002:adf:dcca:: with SMTP id x10mr19222666wrm.212.1588602574359; 
 Mon, 04 May 2020 07:29:34 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 u127sm14472815wme.8.2020.05.04.07.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:33 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/29] rtc: add RTC_ISA_BASE
Message-ID: <20200504142814.157589-9-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Add and use RTC_ISA_BASE define instead of hardcoding 0x70.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20200429140003.7336-7-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/rtc/mc146818rtc.h | 1 +
 hw/rtc/mc146818rtc.c         | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
index 10c93a096a..3713181b56 100644
--- a/include/hw/rtc/mc146818rtc.h
+++ b/include/hw/rtc/mc146818rtc.h
@@ -47,6 +47,7 @@ typedef struct RTCState {
 } RTCState;
=20
 #define RTC_ISA_IRQ 8
+#define RTC_ISA_BASE 0x70
=20
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
                              qemu_irq intercept_irq);
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index dc4269cc55..d18c09911b 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -908,7 +908,6 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
 {
     ISADevice *isadev =3D ISA_DEVICE(dev);
     RTCState *s =3D MC146818_RTC(dev);
-    int base =3D 0x70;
=20
     s->cmos_data[RTC_REG_A] =3D 0x26;
     s->cmos_data[RTC_REG_B] =3D 0x02;
@@ -951,7 +950,7 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
     qemu_register_suspend_notifier(&s->suspend_notifier);
=20
     memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
-    isa_register_ioport(isadev, &s->io, base);
+    isa_register_ioport(isadev, &s->io, RTC_ISA_BASE);
=20
     /* register rtc 0x70 port for coalesced_pio */
     memory_region_set_flush_coalesced(&s->io);
@@ -960,7 +959,7 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
=20
-    qdev_set_legacy_instance_id(dev, base, 3);
+    qdev_set_legacy_instance_id(dev, RTC_ISA_BASE, 3);
     qemu_register_reset(rtc_reset, s);
=20
     object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);
--=20
MST


