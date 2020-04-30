Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB525C83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946962073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWMpoOti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946962073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1ob-0007BN-NN
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n0-0004yD-IN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1mx-0002cX-Ih
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mw-0002bv-NC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIiSgE60NUCwBhv80nDmBf7OFGMkvfU0yPlkIU9QsYI=;
 b=HWMpoOtis5xMxPIyfTQDDFPra6XTfdRP1nw2Kgg/+qZNV0yyjdvllD4BMR9TOK4ToTXFc+
 tvs2a6BgZcXfkAPc6ldd3taomlcY6GkbfvCyJU7vgXnRradS4TdGyINo8kyEGqgY5iYv60
 TWwUcPhYWX8ZztxaJ1mp0glmZxf4D5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-3iP3KCxbOOmt7c3sLScZrA-1; Thu, 30 Apr 2020 01:31:07 -0400
X-MC-Unique: 3iP3KCxbOOmt7c3sLScZrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 804571005510
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F1C0196AE;
 Thu, 30 Apr 2020 05:31:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D2DA011358BD; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] qobject: Clean up QLIST_FOREACH_ENTRY()
Date: Thu, 30 Apr 2020 07:30:45 +0200
Message-Id: <20200430053104.32204-2-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QLIST_FOREACH_ENTRY() traverses a tail queue manually.  Use
QTAILQ_FIRST() and QTAILQ_NEXT() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200415083048.14339-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qlist.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 8d2c32ca28..07ecae81e4 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -34,10 +34,10 @@ void qlist_append_int(QList *qlist, int64_t value);
 void qlist_append_null(QList *qlist);
 void qlist_append_str(QList *qlist, const char *value);
=20
-#define QLIST_FOREACH_ENTRY(qlist, var)             \
-        for ((var) =3D ((qlist)->head.tqh_first);     \
-            (var);                                  \
-            (var) =3D ((var)->next.tqe_next))
+#define QLIST_FOREACH_ENTRY(qlist, var)                 \
+        for ((var) =3D QTAILQ_FIRST(&(qlist)->head);      \
+             (var);                                     \
+             (var) =3D QTAILQ_NEXT((var), next))
=20
 static inline QObject *qlist_entry_obj(const QListEntry *entry)
 {
--=20
2.21.1


