Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A897CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEF820684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqb+nr/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEF820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNazl-0002jF-1u
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatG-0000sf-OU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatE-0004qj-Kv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatE-0004ow-As
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QN4XS8mVxl3mT4akw3IWg+VFgDuH1hftq+VYLTzdD0g=;
 b=Rqb+nr/b/W17INdm0iQ6hNwxMft/L7bW5XZoxeoXpMQSZDsYMapvXnPb1I4WPPsU27PrJm
 MzGv1BkT0G2bjv9RycVbd26vdB7CKp/lP3JrZciP+kRMaWyK8mU5otEhagu1GUbEItX9Qv
 etV42ELLw41spfxl19k4YZkL5ob24Uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-VEVY2JijNAmKFRPGTlJE8g-1; Thu, 24 Oct 2019 07:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2AD107AD34;
 Thu, 24 Oct 2019 11:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5CD860BF3;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F8CE1130346; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/19] qapi: Fold normalize_enum() into check_enum()
Date: Thu, 24 Oct 2019 13:02:34 +0200
Message-Id: <20191024110237.30963-17-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VEVY2JijNAmKFRPGTlJE8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check_features() is always called together with normalize_features().
Fold the latter into the former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


