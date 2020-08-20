Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA97C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2B22078D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkcQcUaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2B22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YXq-0003wZ-RN
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDj-0007mS-8e
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59373
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDh-0002Tj-CH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQVyrUbCtmmNgI3C+81SAgz6c0+ixe7u++HKZB2efvQ=;
 b=gkcQcUaSskx6RHLZ8PtwOpxB2BDdFYYi2+7lGdxXzpYxjvhvdn1E2fJt8ZGS8rydjm30Nb
 hx2/b4qHBrtAKhmXbf0kZ5NJ73GNLpjP+DWHoQlqvaIuxe++wH9mqyN9kxNiC6/+I5c9VA
 0HxXnXQ3eVV46LNpQhUh2PvFKISz4Hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-WFSOmUCWOu-8LNwEUB9lqQ-1; Wed, 19 Aug 2020 20:14:14 -0400
X-MC-Unique: WFSOmUCWOu-8LNwEUB9lqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E72C2FD02;
 Thu, 20 Aug 2020 00:14:13 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFDBD709DC;
 Thu, 20 Aug 2020 00:14:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/58] rocker: Move QOM macros to header
Date: Wed, 19 Aug 2020 20:12:16 -0400
Message-Id: <20200820001236.1284548-39-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Jiri Pirko <jiri@resnulli.us>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
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


