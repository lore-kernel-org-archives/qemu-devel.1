Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C434A208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C434A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zwl-00071J-Qz
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmO-0004kC-Lg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmL-0007hP-Nc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmL-0007gb-FM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31ED0305AB7A;
 Tue, 10 Sep 2019 06:37:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 938EB5C224;
 Tue, 10 Sep 2019 06:37:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 253A2116536A; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:10 +0200
Message-Id: <20190910063724.28470-3-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 10 Sep 2019 06:37:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/16] qapi: Drop check_type()'s redundant
 parameter @allow_optional
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check_type() uses @allow_optional only when @value is a dictionary and
@allow_dict is True.  All callers that pass allow_dict=3DTrue also pass
allow_optional=3DTrue.

Therefore, @allow_optional is always True when check_type() uses it.
Drop the redundant parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d61bfdc526..9aefcfe015 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -783,9 +783,8 @@ def check_if(expr, info):
         check_if_str(ifcond, info)
=20
=20
-def check_type(info, source, value, allow_array=3DFalse,
-               allow_dict=3DFalse, allow_optional=3DFalse,
-               allow_metas=3D[]):
+def check_type(info, source, value,
+               allow_array=3DFalse, allow_dict=3DFalse, allow_metas=3D[]=
):
     global all_names
=20
     if value is None:
@@ -821,7 +820,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
         check_name(info, "Member of %s" % source, key,
-                   allow_optional=3Dallow_optional)
+                   allow_optional=3DTrue)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
             raise QAPISemError(info, "Member of %s uses reserved name '%=
s'"
                                % (source, key))
@@ -843,14 +842,14 @@ def check_command(expr, info):
     if boxed:
         args_meta +=3D ['union', 'alternate']
     check_type(info, "'data' for command '%s'" % name,
-               expr.get('data'), allow_dict=3Dnot boxed, allow_optional=3D=
True,
+               expr.get('data'), allow_dict=3Dnot boxed,
                allow_metas=3Dargs_meta)
     returns_meta =3D ['union', 'struct']
     if name in returns_whitelist:
         returns_meta +=3D ['built-in', 'alternate', 'enum']
     check_type(info, "'returns' for command '%s'" % name,
                expr.get('returns'), allow_array=3DTrue,
-               allow_optional=3DTrue, allow_metas=3Dreturns_meta)
+               allow_metas=3Dreturns_meta)
=20
=20
 def check_event(expr, info):
@@ -861,7 +860,7 @@ def check_event(expr, info):
     if boxed:
         meta +=3D ['union', 'alternate']
     check_type(info, "'data' for event '%s'" % name,
-               expr.get('data'), allow_dict=3Dnot boxed, allow_optional=3D=
True,
+               expr.get('data'), allow_dict=3Dnot boxed,
                allow_metas=3Dmeta)
=20
=20
@@ -889,7 +888,7 @@ def check_union(expr, info):
     else:
         # The object must have a string or dictionary 'base'.
         check_type(info, "'base' for union '%s'" % name,
-                   base, allow_dict=3DTrue, allow_optional=3DTrue,
+                   base, allow_dict=3DTrue,
                    allow_metas=3D['struct'])
         if not base:
             raise QAPISemError(info, "Flat union '%s' must have a base"
@@ -1012,7 +1011,7 @@ def check_struct(expr, info):
     features =3D expr.get('features')
=20
     check_type(info, "'data' for struct '%s'" % name, members,
-               allow_dict=3DTrue, allow_optional=3DTrue)
+               allow_dict=3DTrue)
     check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=3D['struct'])
=20
--=20
2.21.0


