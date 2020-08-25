Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3082C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE332074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BH12wePk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE332074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeu9-0001rY-NL
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWq-00017z-5V
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWo-0006Gq-Dv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1gQBjifxFRhyNhK7QGZN3DKHnAo3ux9ddl1nelaNjM=;
 b=BH12wePkTwj2AvjYzAEmDPdXr12gpyYT0bu3TSEPgAPig8ShO6uEw5v5iXhbRIk7Eekx3k
 QWHb79nHmgbFYhmvc9T+HayIFfyAgOaezPceI3xJG8pX3T3U+oei6nh6Adl6bUS9tQTx/H
 9kE1lnt16bVPopdcjEVKttYb6eTXkK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-zFaIUqfpN8y-YL583LqUDw-1; Tue, 25 Aug 2020 15:22:39 -0400
X-MC-Unique: zFaIUqfpN8y-YL583LqUDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4C7610066FF;
 Tue, 25 Aug 2020 19:22:38 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 389CC10013C2;
 Tue, 25 Aug 2020 19:22:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 38/74] rocker: Move QOM macros to header
Date: Tue, 25 Aug 2020 15:20:34 -0400
Message-Id: <20200825192110.3528606-39-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jiri Pirko <jiri@resnulli.us>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes series v1 -> v2: new patch in series v2

Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/net/rocker/rocker.h | 6 +++++-
 hw/net/rocker/rocker.c | 5 -----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/net/rocker/rocker.h b/hw/net/rocker/rocker.h
index 7ae0495d9e..e4c22db4ff 100644
--- a/hw/net/rocker/rocker.h
+++ b/hw/net/rocker/rocker.h
@@ -66,11 +66,15 @@ static inline bool ipv6_addr_is_multicast(const Ipv6Addr *addr)
     return (addr->addr32[0] & htonl(0xFF000000)) == htonl(0xFF000000);
 }
 
-typedef struct rocker Rocker;
 typedef struct world World;
 typedef struct desc_info DescInfo;
 typedef struct desc_ring DescRing;
 
+#define TYPE_ROCKER "rocker"
+typedef struct rocker Rocker;
+#define ROCKER(obj) \
+    OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)
+
 Rocker *rocker_find(const char *name);
 uint32_t rocker_fp_ports(Rocker *r);
 int rocker_event_link_changed(Rocker *r, uint32_t pport, bool link_up);
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 15d66f6cbc..1af1e6fa2f 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -73,11 +73,6 @@ struct rocker {
     QLIST_ENTRY(rocker) next;
 };
 
-#define TYPE_ROCKER "rocker"
-
-#define ROCKER(obj) \
-    OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)
-
 static QLIST_HEAD(, rocker) rockers;
 
 Rocker *rocker_find(const char *name)
-- 
2.26.2


