Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB06C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC49C2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAp01WtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC49C2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidQ5-0004jD-7G
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIL-0003PS-G6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIG-0005QK-PQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591705427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLna1p07mKJM7i0zrrlNHyDNNPybX9I6BoX1ZKhLxe8=;
 b=TAp01WtU3y32KVIyDZ5FbtvUAeTy3W5y21mzr6jOzlQ4MRw1dXWtov863iLZpV7OAthKcw
 QnAfIR+6z7YoPjg/cIgdQV2ozaOLB1LeaUrjw91+QSF4iAHAYDLZNaQ2V/3sT8QRqWw3Kv
 9RSfBKqxymjSxwBA5q5+155xqLDDANs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-Uw3oE5cMOcu36dgcawQSEQ-1; Tue, 09 Jun 2020 08:23:45 -0400
X-MC-Unique: Uw3oE5cMOcu36dgcawQSEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D66E8A0BDA;
 Tue,  9 Jun 2020 12:23:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6FFB82044;
 Tue,  9 Jun 2020 12:23:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 32966113846B; Tue,  9 Jun 2020 14:23:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/24] qdev: Assert devices are plugged into a bus that can
 take them
Date: Tue,  9 Jun 2020 14:23:37 +0200
Message-Id: <20200609122339.937862-23-armbru@redhat.com>
In-Reply-To: <20200609122339.937862-1-armbru@redhat.com>
References: <20200609122339.937862-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
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
Cc: pbonzini@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This would have caught some of the bugs I just fixed.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/core/qdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9e5538aeae..b5b42b2616 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -97,6 +97,9 @@ static void bus_add_child(BusState *bus, DeviceState *child)
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
 {
     BusState *old_parent_bus = dev->parent_bus;
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    assert(dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type));
 
     if (old_parent_bus) {
         trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),
-- 
2.26.2


