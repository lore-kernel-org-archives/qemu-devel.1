Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B68C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41A42073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2QIO6Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41A42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzlK-0006B4-5H
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVu-0003Tp-NR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVp-0007VY-8s
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZXFtlUJilR+Fg2pc8i1e5FuQYdjyR/PnHfZpdXP6U8=;
 b=T2QIO6OgXWJSFEQ97GvKHdPqXDtEhBSco+V83j5oUK0L+j01Caym1VX6zJTPx99y6rRGeU
 M/ceLcq9hF+xe6q5FmxKNhG59wF/MN7pjLht3LIkdDtU9FZGh7jJ8QA+a1/VtEHa8LEqQD
 NSmjMP1SDKmZdIHhsJRulO39PDMg1nA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-BGqJFzFWOOOTBOJmzw8KZA-1; Tue, 05 May 2020 11:29:30 -0400
X-MC-Unique: BGqJFzFWOOOTBOJmzw8KZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8983F800687;
 Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5158562482;
 Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5576611358C8; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/18] hw/arm/bcm2835: Drop futile attempts at QOM-adopting
 memory
Date: Tue,  5 May 2020 17:29:20 +0200
Message-Id: <20200505152926.18877-13-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
 ehabkost@redhat.com, philmd@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "bcm2835-peripherals" device's .instance_init() method
bcm2835_peripherals_init() attempts to make two memory regions QOM
children of the device.  This is futile, because memory_region_init()
already did.  The errors are ignored (a later commit will change
that).  Drop the useless calls.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/arm/bcm2835_peripherals.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index edcaa4916d..8b399d67ff 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -43,12 +43,10 @@ static void bcm2835_peripherals_init(Object *obj)
=20
     /* Memory region for peripheral devices, which we export to our parent=
 */
     memory_region_init(&s->peri_mr, obj,"bcm2835-peripherals", 0x1000000);
-    object_property_add_child(obj, "peripheral-io", OBJECT(&s->peri_mr), N=
ULL);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_mr);
=20
     /* Internal memory region for peripheral bus addresses (not exported) =
*/
     memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << =
32);
-    object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL=
);
=20
     /* Internal memory region for request/response communication with
      * mailbox-addressable peripherals (not exported)
--=20
2.21.1


