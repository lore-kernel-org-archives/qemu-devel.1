Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307BDC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F056920736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ar2V6T3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F056920736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRtxJ-0007Ql-2B
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw1-0005e7-1j
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw0-00024f-7t
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtvz-000248-QK
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdGuvNgNJoclIQOb6lRaWN64KeTwHmGMWZV8PD3OfaY=;
 b=Ar2V6T3ZVOdpMfIzy4TB37bYXmjuRouvvqcKbDhwDf4h3xoxQYMJOEtzq6/9R3x2Vh0pA7
 Ga48Sj6zy7w5E2/CUcjaEAQ8BaQA6jvo6wV1J0LsNHDtZdqzY7m7AeRoLctJFjmOsRdZXr
 IF95YfkRUHsk+rKjxfmnQy8bnVQRNAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-S9UZDmLtOxmslWbeUivCMQ-1; Fri, 24 Apr 2020 04:43:41 -0400
X-MC-Unique: S9UZDmLtOxmslWbeUivCMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B4A18FE861;
 Fri, 24 Apr 2020 08:43:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AFA95D70B;
 Fri, 24 Apr 2020 08:43:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D214311358BD; Fri, 24 Apr 2020 10:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/15] qapi: Belatedly update visitor.h's big comment for
 QAPI modules
Date: Fri, 24 Apr 2020 10:43:24 +0200
Message-Id: <20200424084338.26803-2-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index c5b23851a1..f8a0fc1ea9 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -58,7 +58,7 @@
  *
  * where T is FOO for scalar types, and FOO * otherwise.  The scalar
  * visitors are declared here; the remaining visitors are generated in
- * qapi-visit.h.
+ * qapi-visit-MODULE.h.
  *
  * The @name parameter of visit_type_FOO() describes the relation
  * between this QAPI value and its parent container.  When visiting
@@ -86,16 +86,16 @@
  * by manual construction.
  *
  * For the QAPI object types (structs, unions, and alternates), there
- * is an additional generated function in qapi-visit.h compatible
- * with:
+ * is an additional generated function in qapi-visit-MODULE.h
+ * compatible with:
  *
  * void visit_type_FOO_members(Visitor *v, FOO *obj, Error **errp);
  *
  * for visiting the members of a type without also allocating the QAPI
  * struct.
  *
- * Additionally, in qapi-types.h, all QAPI pointer types (structs,
- * unions, alternates, and lists) have a generated function compatible
+ * Additionally, QAPI pointer types (structs, unions, alternates, and
+ * lists) have a generated function in qapi-types-MODULE.h compatible
  * with:
  *
  * void qapi_free_FOO(FOO *obj);
--=20
2.21.1


