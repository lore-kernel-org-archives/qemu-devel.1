Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA8C5518A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9B020736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRpaZ+ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9B020736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRu14-00069K-Hn
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw3-0005fm-E1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRtw2-0002BD-6s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58615
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRtw1-00026i-L9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlhIBE9wCreqoJev7C2ceZoOivO0fBd4IhEJP3CNvNw=;
 b=NRpaZ+ezPHHIOYNcW7wxvp2jaw8BfFiaRLbwKgsg4waOFty01ZNcAslCen9MwbjWyPfEZo
 UgJ22XY3tM6PDaplFkxTZfjI+Fj/c8DRcfHf8c4moOHsOjwVPLwJlma2v2hYVrPjelP0nv
 z82W13W5gcu1BTy2VhEDebdFgZxZq/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-cRRtKpGVOsiEfhs9985E6w-1; Fri, 24 Apr 2020 04:43:43 -0400
X-MC-Unique: cRRtKpGVOsiEfhs9985E6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 255D5107ACCA;
 Fri, 24 Apr 2020 08:43:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA017600EF;
 Fri, 24 Apr 2020 08:43:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5FED11358C3; Fri, 24 Apr 2020 10:43:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] qapi: Fix Visitor contract for start_alternate()
Date: Fri, 24 Apr 2020 10:43:30 +0200
Message-Id: <20200424084338.26803-8-armbru@redhat.com>
In-Reply-To: <20200424084338.26803-1-armbru@redhat.com>
References: <20200424084338.26803-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

The contract demands v->start_alternate() for input and dealloc
visitors, but visit_start_alternate() actually requires it for input
and clone visitors.  Fix the contract, and delete superfluous
qapi_dealloc_start_alternate().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor-impl.h | 5 ++---
 qapi/qapi-dealloc-visitor.c | 7 -------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 8ccb3b6c20..252206dc0d 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -67,13 +67,12 @@ struct Visitor
     /* Must be set */
     void (*end_list)(Visitor *v, void **list);
=20
-    /* Must be set by input and dealloc visitors to visit alternates;
-     * optional for output visitors. */
+    /* Must be set by input and clone visitors to visit alternates */
     void (*start_alternate)(Visitor *v, const char *name,
                             GenericAlternate **obj, size_t size,
                             Error **errp);
=20
-    /* Optional, needed for dealloc visitor */
+    /* Optional */
     void (*end_alternate)(Visitor *v, void **obj);
=20
     /* Must be set */
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index d192724b13..2239fc6417 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -34,12 +34,6 @@ static void qapi_dealloc_end_struct(Visitor *v, void **o=
bj)
     }
 }
=20
-static void qapi_dealloc_start_alternate(Visitor *v, const char *name,
-                                         GenericAlternate **obj, size_t si=
ze,
-                                         Error **errp)
-{
-}
-
 static void qapi_dealloc_end_alternate(Visitor *v, void **obj)
 {
     if (obj) {
@@ -123,7 +117,6 @@ Visitor *qapi_dealloc_visitor_new(void)
     v->visitor.type =3D VISITOR_DEALLOC;
     v->visitor.start_struct =3D qapi_dealloc_start_struct;
     v->visitor.end_struct =3D qapi_dealloc_end_struct;
-    v->visitor.start_alternate =3D qapi_dealloc_start_alternate;
     v->visitor.end_alternate =3D qapi_dealloc_end_alternate;
     v->visitor.start_list =3D qapi_dealloc_start_list;
     v->visitor.next_list =3D qapi_dealloc_next_list;
--=20
2.21.1


