Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A48C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF92A20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG95yaGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF92A20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdU1-0006jm-Tb
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOdRf-0002j4-9C
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOdRe-0004KL-4n
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53821
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOdRd-0004Ia-V7
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586939453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqvqhL54gOLcZoA08mHwefRccp/M1IutyokYX7aejLE=;
 b=XG95yaGllczc6Z/l5OgSOsX+CbdInFnkTgp22j2AF7qurFJIf3fRWAfzv+DHCpH7B6vK5b
 Dp+oPqnWqGx1Yp7OaDEotJzePnuQqpGLUULQdkOWxrdud7iL3BmHD9H+z7SrsEQUt2L5HA
 4UUpLkk5jxo49bLykwnjsXN6ur3/xRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-CY13wxkdNQyU1_SBvk0iHA-1; Wed, 15 Apr 2020 04:30:51 -0400
X-MC-Unique: CY13wxkdNQyU1_SBvk0iHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F0D58017F3;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2314D5D9E2;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B57D11384A9; Wed, 15 Apr 2020 10:30:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 1/5] qobject: Clean up QLIST_FOREACH_ENTRY()
Date: Wed, 15 Apr 2020 10:30:44 +0200
Message-Id: <20200415083048.14339-2-armbru@redhat.com>
In-Reply-To: <20200415083048.14339-1-armbru@redhat.com>
References: <20200415083048.14339-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

QLIST_FOREACH_ENTRY() traverses a tail queue manually.  Use
QTAILQ_FIRST() and QTAILQ_NEXT() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


