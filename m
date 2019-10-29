Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B5BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5B520874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAdLBQ0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5B520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOog-0000Uu-8t
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeH-0005am-Di
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeG-0001Gw-5N
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeG-0001GW-28
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9zyM7Nhkvqxf/eDuzfTkeYrVz0KroKSzD8sZvcH50U=;
 b=YAdLBQ0Heii7svb1Bgm429GEiHNOt8JwbQQJXwlM543Cqm4TIFf67Z8duX0UEpTAxLC1FE
 LvlXJr89GV5tNzTP+kk9wBh6p0lKZHrrU4Dy6zlZHfxWGZkjflWAKNt08LbxkLJSnRPPiV
 o6tlr0PEboGqueF8yJEAvWpOJJ6iAgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-VfxINnwjOB-qgTfq0op34g-1; Tue, 29 Oct 2019 06:22:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6B49476
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5A4C60870
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7538113287A; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] qapi: Fold normalize_if() into check_if()
Date: Tue, 29 Oct 2019 11:22:23 +0100
Message-Id: <20191029102228.20740-15-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VfxINnwjOB-qgTfq0op34g-1
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

check_if() is always called together with normalize_if().  Fold the
latter into the former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-15-armbru@redhat.com>
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


