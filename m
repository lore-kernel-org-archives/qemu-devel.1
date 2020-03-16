Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E4C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4A720663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPF9dq0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4A720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDekO-0008UE-6P
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdMA-0008Lx-8P
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdM9-0005Ij-89
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51420
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdM9-0005HA-46
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5oHwdalGSUh9fUiAtO6F1i/o9Ne148Jqojt7pJjorc=;
 b=hPF9dq0DgvpqMxhM0etEDsbrgevM0kLoIrgdfJwvM0ievPd/9ciDEjPNN3dYehu4vQmYFC
 l9bBdbuNaKtTMYDlG9BY8/dyYRmTJogmUXg6RSXBwNx3SmXmhbbNXj6sbSghZzmpwzhKUG
 Circ8SIQEDGP5NInUi/5GjZwRDg0YMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-w3CibJ0pMbqC4Prwj8VfiA-1; Sun, 15 Mar 2020 20:11:43 -0400
X-MC-Unique: w3CibJ0pMbqC4Prwj8VfiA-1
Received: by mail-wr1-f71.google.com with SMTP id v6so8067762wrg.22
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D3R81IpDiBCPcJm6v/qjLXKSHFAs8r3O5+h73S1rpfw=;
 b=OhR+Q+TxSjOt0gEn0ci3gWKfRWSvoyXHdNiZT7fa/jyoFaaro7EtljaN4ssQ4SlyPY
 UHkIHG6kWspDIDtxgzYYzei+i14X9gCVSgGXn+n3LC1QPDqp/FAbAipNtwPBTg0/XN3y
 eRN/p3pEEPUAqRlMYZXcSF9mM/V4nF9t7KSRh8JBQIMRxyxGhloWMus//YV2Ph/ICufY
 dWDobdY9rnros3Jt1f5oze7Gkxi+eUQpNC4J9yIZywGlyQFht6naGiFxuLcUia1zQeeM
 Y5P0YQbyn/fbJRK899RB01H5ngM5G0zX3P43suQVFlTQ5G8o89LAjhG7Hm7NYi6Zl0Ay
 Ttww==
X-Gm-Message-State: ANhLgQ1AITJR9eR+3iq+PvoMdvJ5Wf1DTMJ6Z0eQnJ4NMitv06290O99
 0rC2aLCRCee2tusiaVx7fQ8WIjcqu8FoDhdzqzuCI+vjR+CBm+PU/c/Fd1UDHskse5mEeYIe0+D
 0q1oyGDarcyYgTYE=
X-Received: by 2002:a7b:c381:: with SMTP id s1mr22723453wmj.0.1584317501203;
 Sun, 15 Mar 2020 17:11:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vssZmjyburU8BaWOP+arhyyQ9r5jXISw+aZfNKA/6GUbNbJR6vj5QZ/sLeZybJnLmz9saXbXA==
X-Received: by 2002:a7b:c381:: with SMTP id s1mr22723434wmj.0.1584317500998;
 Sun, 15 Mar 2020 17:11:40 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id t124sm28387358wmg.13.2020.03.15.17.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] hw/core/qdev-properties: Export qdev_prop_enum
Date: Mon, 16 Mar 2020 01:11:07 +0100
Message-Id: <20200316001111.31004-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/qdev-properties.h | 1 +
 hw/core/qdev-properties.c    | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..134753d595 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -8,6 +8,7 @@
 extern const PropertyInfo qdev_prop_bit;
 extern const PropertyInfo qdev_prop_bit64;
 extern const PropertyInfo qdev_prop_bool;
+extern const PropertyInfo qdev_prop_enum;
 extern const PropertyInfo qdev_prop_uint8;
 extern const PropertyInfo qdev_prop_uint16;
 extern const PropertyInfo qdev_prop_uint32;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 3f3a008938..7e89c11dfd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -84,6 +84,13 @@ void qdev_propinfo_set_default_value_enum(ObjectProperty=
 *op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
 }
=20
+const PropertyInfo qdev_prop_enum =3D {
+    .name  =3D "enum",
+    .get   =3D qdev_propinfo_get_enum,
+    .set   =3D qdev_propinfo_set_enum,
+    .set_default_value =3D qdev_propinfo_set_default_value_enum,
+};
+
 /* Bit */
=20
 static uint32_t qdev_get_prop_mask(Property *prop)
--=20
2.21.1


