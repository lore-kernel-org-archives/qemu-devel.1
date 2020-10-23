Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6D4C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F9020882
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMlHco+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F9020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1xY-0002iB-Tn
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1w2-0000sm-2e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW1vy-0001VH-OS
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603478222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+iYBdrcmuhMEl6dRyZK6e93kq9OOvIMvThuPJhzwRI=;
 b=GMlHco+u+SzQ/LpzIXTHN7yQ9OPSt8JZTEz3xHoM2GgWzF222CmXoD0XEpACTYJtm+3U00
 BzwBgYQzLO8pdATV4HaGKZWJ0KhVujwEbUDBmGrytpbwRBdhYX3Y4sGnH9TaIarjryyM1K
 kpFstb5NgseD4Vc48SaCvUrzzaOFWcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-xs528pwvMZO8Ieav4duWDQ-1; Fri, 23 Oct 2020 14:37:00 -0400
X-MC-Unique: xs528pwvMZO8Ieav4duWDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02E3487953A;
 Fri, 23 Oct 2020 18:36:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A9B860BFA;
 Fri, 23 Oct 2020 18:36:58 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/12] qapi: Move GenericList to qapi/util.h
Date: Fri, 23 Oct 2020 13:36:41 -0500
Message-Id: <20201023183652.478921-2-eblake@redhat.com>
In-Reply-To: <20201023183652.478921-1-eblake@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Placing GenericList in util.h will make it easier for the next patch
to promote QAPI_LIST_ADD() into a public macro without requiring more
files to include the unrelated visitor.h.

However, we can't also move GenericAlternate; this is because it would
introduce a circular dependency: qapi-builtin-types.h needs a complete
definition of QEnumLookup (so it includes qapi/util.h), and
GenericAlternate needs a complete definition of QType (declared in
qapi-builtin-types.h).  Leaving GenericAlternate in visitor.h breaks
the cycle, and doesn't matter since we don't have any further planned
uses for that type outside of visitors.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h | 9 +--------
 include/qapi/util.h    | 8 ++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index ebc19ede7fff..8c2e1c29ad8b 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -16,6 +16,7 @@
 #define QAPI_VISITOR_H

 #include "qapi/qapi-builtin-types.h"
+#include "qapi/util.h"

 /*
  * The QAPI schema defines both a set of C data types, and a QMP wire
@@ -228,14 +229,6 @@

 /*** Useful types ***/

-/* This struct is layout-compatible with all other *List structs
- * created by the QAPI generator.  It is used as a typical
- * singly-linked list. */
-typedef struct GenericList {
-    struct GenericList *next;
-    char padding[];
-} GenericList;
-
 /* This struct is layout-compatible with all Alternate types
  * created by the QAPI generator. */
 typedef struct GenericAlternate {
diff --git a/include/qapi/util.h b/include/qapi/util.h
index a7c3c6414874..50201896c7a4 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,6 +11,14 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H

+/* This struct is layout-compatible with all other *List structs
+ * created by the QAPI generator.  It is used as a typical
+ * singly-linked list. */
+typedef struct GenericList {
+    struct GenericList *next;
+    char padding[];
+} GenericList;
+
 typedef struct QEnumLookup {
     const char *const *array;
     int size;
-- 
2.29.0


