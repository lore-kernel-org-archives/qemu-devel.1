Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1F7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802FF2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 20:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ypq4E8g2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802FF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkwBX-00064s-O8
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 16:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuU-0003KG-HL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkvuP-0000bJ-HC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 16:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592253644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PproFFp9CZqW47mWgs2aeH5cSqQFrm+D4Qk9lQvT4Y=;
 b=Ypq4E8g2UmoJcIc2B6ZZAOZ9w4J3Tw1t2dUAEdI/TUjOuH52dboCssUdueBCdLIXA0mlOz
 0AhrP2xBtKss92dwdkfPMc7ipUfMFChDuG7gIZBd7SKYZnkGZppDllVOs9PCj6VKwSWEBP
 Cwc7WQFrdA+t9QH5Q5OVWA63dAg2q9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-j497jf-HNBqZZ5oWQ9ImQQ-1; Mon, 15 Jun 2020 16:40:15 -0400
X-MC-Unique: j497jf-HNBqZZ5oWQ9ImQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED655AECA;
 Mon, 15 Jun 2020 20:40:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 996066ED96;
 Mon, 15 Jun 2020 20:40:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C62611385EB; Mon, 15 Jun 2020 22:40:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/84] qom: Constify object_get_canonical_path{,
 _component}()'s parameter
Date: Mon, 15 Jun 2020 22:38:45 +0200
Message-Id: <20200615204008.3069956-2-armbru@redhat.com>
In-Reply-To: <20200615204008.3069956-1-armbru@redhat.com>
References: <20200615204008.3069956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 15:33:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200527084754.7531-2-armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qom/object.h | 4 ++--
 qom/object.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index c7c97ead60..43858162ad 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1404,7 +1404,7 @@ Object *object_get_internal_root(void);
  * path is the path within the composition tree starting from the root.
  * %NULL if the object doesn't have a parent (and thus a canonical path).
  */
-char *object_get_canonical_path_component(Object *obj);
+char *object_get_canonical_path_component(const Object *obj);
 
 /**
  * object_get_canonical_path:
@@ -1412,7 +1412,7 @@ char *object_get_canonical_path_component(Object *obj);
  * Returns: The canonical path for a object.  This is the path within the
  * composition tree starting from the root.
  */
-char *object_get_canonical_path(Object *obj);
+char *object_get_canonical_path(const Object *obj);
 
 /**
  * object_resolve_path:
diff --git a/qom/object.c b/qom/object.c
index b0ed560fd8..d1340ba3d9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1881,7 +1881,7 @@ object_property_add_const_link(Object *obj, const char *name,
                                 NULL, OBJ_PROP_LINK_DIRECT);
 }
 
-char *object_get_canonical_path_component(Object *obj)
+char *object_get_canonical_path_component(const Object *obj)
 {
     ObjectProperty *prop = NULL;
     GHashTableIter iter;
@@ -1906,7 +1906,7 @@ char *object_get_canonical_path_component(Object *obj)
     return NULL;
 }
 
-char *object_get_canonical_path(Object *obj)
+char *object_get_canonical_path(const Object *obj)
 {
     Object *root = object_get_root();
     char *newpath, *path = NULL;
-- 
2.26.2


