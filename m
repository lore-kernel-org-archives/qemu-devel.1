Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0DBCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80C020874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hu4HlbuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOyA-0001zY-1u
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeM-0005jm-Q6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeL-0001Nc-Oi
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeL-0001Mz-Ki
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdEghAFjyk3DnbTpW/iUY4A1QqUqAgUKvtrL5qp70JU=;
 b=Hu4HlbuUWcWj8cjglVtNAeyBZX7TROQ0A27wYHQOsXiHZy43LfXKh4iE7lkBJbt1gkCqe0
 dHA9D3Hr8zYNoMyyvYzEvnLqfDa8umKmC2OcMimiiMXHM5kvpRM5UA0SZcRdnGOnaC/0KK
 jldNfI6Mik6Ub+aiBY6Yqb1dO+HyuMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-QD67w9oGN62C_sKTe8VH3A-1; Tue, 29 Oct 2019 06:22:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453E681A334
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 167285D9C8
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD4D711326E8; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] qapi: Fold normalize_enum() into check_enum()
Date: Tue, 29 Oct 2019 11:22:25 +0100
Message-Id: <20191029102228.20740-17-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QD67w9oGN62C_sKTe8VH3A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

check_features() is always called together with normalize_features().
Fold the latter into the former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-17-armbru@redhat.com>
---
 scripts/qapi/expr.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 66014e2bb2..d7a289eded 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -190,12 +190,6 @@ def check_features(features, info):
         check_if(f, info, source)
=20
=20
-def normalize_enum(expr):
-    if isinstance(expr['data'], list):
-        expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
-                        for m in expr['data']]
-
-
 def check_enum(expr, info):
     name =3D expr['enum']
     members =3D expr['data']
@@ -208,6 +202,8 @@ def check_enum(expr, info):
=20
     permit_upper =3D name in info.pragma.name_case_whitelist
=20
+    members[:] =3D [m if isinstance(m, dict) else {'name': m}
+                  for m in members]
     for member in members:
         source =3D "'data' member"
         check_keys(member, info, source, ['name'], ['if'])
@@ -325,7 +321,6 @@ def check_exprs(exprs):
         if meta =3D=3D 'enum':
             check_keys(expr, info, meta,
                        ['enum', 'data'], ['if', 'prefix'])
-            normalize_enum(expr)
             check_enum(expr, info)
         elif meta =3D=3D 'union':
             check_keys(expr, info, meta,
--=20
2.21.0


