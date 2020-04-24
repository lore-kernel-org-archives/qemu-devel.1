Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B430C55186
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9B20781
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PenBfbKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3vJ-0001sz-3c
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sK-0003PX-7l
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sJ-00043L-Oj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jS3sJ-00041x-8q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587756034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zz6PIHu4D9IJMAUYz5GlS7tUaH56am6CeocpGy7vUGA=;
 b=PenBfbKVp8irDfpJLbvIhA1Q1Zfk/p6Scx1HEgDs2YtWbxGjU2zooaC7EU+1nTjXMer4se
 dwG+wa9pPr7oRJp7WXdXmfRKCDO7Jb/k+SPJDiOy2D1ylunVemIEytAk0QgtO/4h/xb5By
 OYVHC5hitIW+1WjKSHcP7LDrOrf+6og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-wQXZRtGYODiiH5cS1TWTug-1; Fri, 24 Apr 2020 15:20:32 -0400
X-MC-Unique: wQXZRtGYODiiH5cS1TWTug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDB11005510
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 19:20:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF53A605CF
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 19:20:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3776811358C1; Fri, 24 Apr 2020 21:20:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/11] tests/migration: Tighten error checking
Date: Fri, 24 Apr 2020 21:20:21 +0200
Message-Id: <20200424192027.11404-6-armbru@redhat.com>
In-Reply-To: <20200424192027.11404-1-armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

migrate_get_socket_address() neglects to check
visit_type_SocketAddressList() failure.  This smells like a leak, but
it actually will crash dereferencing @addrs.  Pass &error_abort to
remove the code smell.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/migration-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 2568c9529c..dc3490c9fa 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
=20
 #include "libqtest.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -301,7 +302,6 @@ static char *migrate_get_socket_address(QTestState *who=
, const char *parameter)
 {
     QDict *rsp;
     char *result;
-    Error *local_err =3D NULL;
     SocketAddressList *addrs;
     Visitor *iv =3D NULL;
     QObject *object;
@@ -310,7 +310,7 @@ static char *migrate_get_socket_address(QTestState *who=
, const char *parameter)
     object =3D qdict_get(rsp, parameter);
=20
     iv =3D qobject_input_visitor_new(object);
-    visit_type_SocketAddressList(iv, NULL, &addrs, &local_err);
+    visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
     visit_free(iv);
=20
     /* we are only using a single address */
--=20
2.21.1


