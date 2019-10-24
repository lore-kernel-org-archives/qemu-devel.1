Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB620CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9987120679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xxyxg68t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9987120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcB3-00067c-0t
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNatK-0000yX-9F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNatJ-0004ul-01
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNatI-0004tQ-QE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571914971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GfmVbadjrgclZy0LJ41Pf6eZUvpccx4mCNTJBvCxeE=;
 b=Xxyxg68t0tsB4Y0yMooD8NH4REXmz1MZyIgUqObSc0sBnsvLhA3SRa0y6+Se1BsndREuk2
 4H1y2tmruFJmGqVj4K66SK0VW4JgH0LH7wmgU7bsB39EWgzsmW0TH1k7nzFA8wCC6q1xDt
 Nr1/1uM2+Bv8Elk0+pfhIZrKbypV77s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-cWe2SOjIOmuCks5uQDiCWw-1; Thu, 24 Oct 2019 07:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11DAE476;
 Thu, 24 Oct 2019 11:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D14F0196B2;
 Thu, 24 Oct 2019 11:02:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 759051130341; Thu, 24 Oct 2019 13:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/19] qapi: Fold normalize_if() into check_if()
Date: Thu, 24 Oct 2019 13:02:32 +0200
Message-Id: <20191024110237.30963-15-armbru@redhat.com>
In-Reply-To: <20191024110237.30963-1-armbru@redhat.com>
References: <20191024110237.30963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: cWe2SOjIOmuCks5uQDiCWw-1
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

check_if() is always called together with normalize_if().  Fold the
latter into the former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/expr.py | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 7c7394f835..aa0fe69f99 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -95,12 +95,6 @@ def check_flags(expr, info):
                 info, "flag '%s' may only use true value" % key)
=20
=20
-def normalize_if(expr):
-    ifcond =3D expr.get('if')
-    if isinstance(ifcond, str):
-        expr['if'] =3D [ifcond]
-
-
 def check_if(expr, info, source):
=20
     def check_if_str(ifcond, info):
@@ -126,6 +120,7 @@ def check_if(expr, info, source):
             check_if_str(elt, info)
     else:
         check_if_str(ifcond, info)
+        expr['if'] =3D [ifcond]
=20
=20
 def normalize_members(members):
@@ -175,7 +170,6 @@ def check_type(value, info, source,
             raise QAPISemError(info, "%s uses reserved name" % key_source)
         check_keys(arg, info, key_source, ['type'], ['if'])
         check_if(arg, info, key_source)
-        normalize_if(arg)
         check_type(arg['type'], info, key_source, allow_array=3DTrue)
=20
=20
@@ -198,7 +192,6 @@ def check_features(features, info):
         source =3D "%s '%s'" % (source, f['name'])
         check_name_str(f['name'], info, source)
         check_if(f, info, source)
-        normalize_if(f)
=20
=20
 def normalize_enum(expr):
@@ -227,7 +220,6 @@ def check_enum(expr, info):
         check_name_str(member['name'], info, source,
                        enum_member=3DTrue, permit_upper=3Dpermit_upper)
         check_if(member, info, source)
-        normalize_if(member)
=20
=20
 def check_struct(expr, info):
@@ -259,7 +251,6 @@ def check_union(expr, info):
         check_name_str(key, info, source)
         check_keys(value, info, source, ['type'], ['if'])
         check_if(value, info, source)
-        normalize_if(value)
         check_type(value['type'], info, source, allow_array=3Dnot base)
=20
=20
@@ -273,7 +264,6 @@ def check_alternate(expr, info):
         check_name_str(key, info, source)
         check_keys(value, info, source, ['type'], ['if'])
         check_if(value, info, source)
-        normalize_if(value)
         check_type(value['type'], info, source)
=20
=20
@@ -376,7 +366,6 @@ def check_exprs(exprs):
         else:
             assert False, 'unexpected meta type'
=20
-        normalize_if(expr)
         check_if(expr, info, meta)
         check_flags(expr, info)
=20
--=20
2.21.0


