Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52456206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiBNkKhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52456206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCG4-0003Bn-HQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCBY-0002os-EA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:04:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqCBN-0002vm-Tz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbX+F0YOBtVPOL7TP27P03pO8+dHGl4EEswJatoom00=;
 b=GiBNkKhPzFPSK4i8hLF4bMhER4HIMjNrp/alp+0V9PtjvX9PKvfnEt8YI18M1KZeH0ROx2
 DNvnBO3kYstHNbzESvvf/p99uYFWFx0nXKRyJIO7ffpooyxeheCNIdeQV+sxuuq3yzhy7G
 kze1jfq97cBINjcrQ9efzRc6HfzCRwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-NM0l2at7OIuTdB4I2TmKQg-1; Tue, 30 Jun 2020 05:03:59 -0400
X-MC-Unique: NM0l2at7OIuTdB4I2TmKQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63EF18015F7;
 Tue, 30 Jun 2020 09:03:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3102710023A6;
 Tue, 30 Jun 2020 09:03:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38A161138484; Tue, 30 Jun 2020 11:03:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/26] hw/arm/armsse: Fix armsse_realize() error API
 violation
Date: Tue, 30 Jun 2020 11:03:49 +0200
Message-Id: <20200630090351.1247703-25-armbru@redhat.com>
In-Reply-To: <20200630090351.1247703-1-armbru@redhat.com>
References: <20200630090351.1247703-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

armsse_realize() is wrong that way: it passes &err to
object_property_set_int() multiple times without checking it, and then
to sysbus_realize().  Harmless, because the former can't actually fail
here.

Fix by passing &error_abort instead.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/armsse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index c73cc6badf..e2cf43ee0b 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -991,13 +991,13 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, 0x40020000);
     /* System control registers */
     object_property_set_int(OBJECT(&s->sysctl), info->sys_version,
-                            "SYS_VERSION", &err);
+                            "SYS_VERSION", &error_abort);
     object_property_set_int(OBJECT(&s->sysctl), info->cpuwait_rst,
-                            "CPUWAIT_RST", &err);
+                            "CPUWAIT_RST", &error_abort);
     object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
-                            "INITSVTOR0_RST", &err);
+                            "INITSVTOR0_RST", &error_abort);
     object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
-                            "INITSVTOR1_RST", &err);
+                            "INITSVTOR1_RST", &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.26.2


