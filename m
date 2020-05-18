Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF098C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8866B20715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEz6ZI0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8866B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaYDm-0001WS-PA
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXwv-0000Dv-0z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaXws-0004Ol-Mj
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589778261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAi9EUCPLhJvfOSGj2kGGrtspMXz0+eDeEMBqbWPO+k=;
 b=eEz6ZI0udab5FR7aOSCml9PmWBEWxWyjfbDPZfT7GSEuFZl2EWSaDmR+Afl+2Bgq/Zuqq8
 oWHag+6sFXHg+AaKzheDzJPyUab7S2C7tk8sCex1zvvhGi5X/Te0unDaATLWL7F5DAD4wF
 b0nR7TP1lsNpy+VlZEcU7rlbxkVrnM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-oqoSJTA2NSqhwhsZv4yYsA-1; Mon, 18 May 2020 01:04:13 -0400
X-MC-Unique: oqoSJTA2NSqhwhsZv4yYsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC79EC1A2;
 Mon, 18 May 2020 05:04:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 333796298C;
 Mon, 18 May 2020 05:04:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2515911358C1; Mon, 18 May 2020 07:04:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/24] aspeed: Don't create unwanted "cortex-a7-arm-cpu"
 devices
Date: Mon, 18 May 2020 07:03:49 +0200
Message-Id: <20200518050408.4579-6-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-1-armbru@redhat.com>
References: <20200518050408.4579-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, pbonzini@redhat.com,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The number of CPUs is controlled by property "num-cpus".
aspeed_soc_ast2600_init() creates the maximum supported number.
aspeed_soc_ast2600_realize() realizes only the wanted number.  Works,
although it leaves unrealized devices hanging around in the QOM
composition tree.  Affects machines ast2600-evb and tacoma-bmc.

Make the init functions create only the wanted ones.  Visible in "info
qom-tree"; here's the change for ast2600-evb:

     /machine (ast2600-evb-machine)
       [...]
       /soc (ast2600-a1)
         [...]
         /cpu[0] (cortex-a7-arm-cpu)
           /unnamed-gpio-in[0] (irq)
           /unnamed-gpio-in[1] (irq)
           /unnamed-gpio-in[2] (irq)
           /unnamed-gpio-in[3] (irq)
    -    /cpu[1] (cortex-a7-arm-cpu)
    -      /unnamed-gpio-in[0] (irq)
    -      /unnamed-gpio-in[1] (irq)
    -      /unnamed-gpio-in[2] (irq)
    -      /unnamed-gpio-in[3] (irq)
         /ehci[0] (platform-ehci-usb)

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 0a6a77dd54..6ffa587a7f 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -287,6 +287,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    for (; i < sc->num_cpus; i++) {
+        object_unparent(OBJECT(&s->cpu[i]));
+    }
 
     /* A7MPCORE */
     object_property_set_int(OBJECT(&s->a7mpcore), s->num_cpus, "num-cpu",
-- 
2.21.1


