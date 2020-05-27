Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F46C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029D4207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj7lst8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029D4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpC2-0002Iq-6b
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6d-0002bW-3j
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:00:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6X-0004F1-Sx
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZP0qJvOwAC4h1HCMRaDbDRJbB+KSn/nLPEOMovO5Cs=;
 b=fj7lst8P4PsdsgMokekIJNeZ0CvqOkq69M+UyLVUKHsdj4sP0+Tm6Y+AO+N9Ul+lcuo3oP
 CLqDATK4i764Jxd0710exmVYiQkCY31jih2ey9gex8Rfm9Ptp0qqNtMo1Hg1AvKdmcUiiN
 OPrz8R/4l7r5mRBs0i2CrkZj4Pka9wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-phsY-FpCNqSgX9IDqPgYaw-1; Wed, 27 May 2020 01:59:50 -0400
X-MC-Unique: phsY-FpCNqSgX9IDqPgYaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685FA1005512;
 Wed, 27 May 2020 05:59:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 064565D9E8;
 Wed, 27 May 2020 05:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0869411358C0; Wed, 27 May 2020 07:59:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] arm/sabrelite: Consistently use &error_fatal in
 sabrelite_init()
Date: Wed, 27 May 2020 07:59:44 +0200
Message-Id: <20200527055945.6774-10-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
References: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200505101908.6207-10-armbru@redhat.com>
[Straightforward conflict with resolved d2623129a7 "qom: Drop
parameter @errp of object_property_add() & friends"]
---
 hw/arm/sabrelite.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 6f0e233d77..96cb30aa3c 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -41,7 +41,6 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
 static void sabrelite_init(MachineState *machine)
 {
     FslIMX6State *s;
-    Error *err = NULL;
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
@@ -52,11 +51,7 @@ static void sabrelite_init(MachineState *machine)
 
     s = FSL_IMX6(object_new(TYPE_FSL_IMX6));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_bool(OBJECT(s), true, "realized", &err);
-    if (err != NULL) {
-        error_report("%s", error_get_pretty(err));
-        exit(1);
-    }
+    object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
-- 
2.21.3


