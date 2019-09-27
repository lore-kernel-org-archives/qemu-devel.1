Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A6C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3C0205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 15:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3C0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsRa-0005FE-3H
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 11:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iDqa8-0001D4-Dt
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iDqa6-00062q-Ij
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iDqa6-00062D-7p
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:46:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AA013003AFE;
 Fri, 27 Sep 2019 13:46:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1719510001BC;
 Fri, 27 Sep 2019 13:46:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8311911385CB; Fri, 27 Sep 2019 15:46:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/26] qapi: Use check_name_str() where it suffices
Date: Fri, 27 Sep 2019 15:46:23 +0200
Message-Id: <20190927134639.4284-11-armbru@redhat.com>
In-Reply-To: <20190927134639.4284-1-armbru@redhat.com>
References: <20190927134639.4284-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 27 Sep 2019 13:46:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Replace check_name() by check_name_str() where the name is known to be
a string.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 6f35cd131e..d0d997f31c 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -816,8 +816,8 @@ def check_type(value, info, source,
=20
     # value is a dictionary, check that each member is okay
     for (key, arg) in value.items():
-        check_name(key, info, "member of %s" % source,
-                   allow_optional=3DTrue, permit_upper=3Dpermit_upper)
+        check_name_str(key, info, "member of %s" % source,
+                       allow_optional=3DTrue, permit_upper=3Dpermit_uppe=
r)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswit=
h('has_'):
             raise QAPISemError(
                 info, "member of %s uses reserved name '%s'" % (source, =
key))
@@ -920,8 +920,7 @@ def check_union(expr, info):
         raise QAPISemError(info, "union '%s' has no branches" % name)
=20
     for (key, value) in members.items():
-        check_name(key, info, "member of union '%s'" % name)
-
+        check_name_str(key, info, "member of union '%s'" % name)
         check_known_keys(value, info,
                          "member '%s' of union '%s'" % (key, name),
                          ['type'], ['if'])
@@ -951,7 +950,7 @@ def check_alternate(expr, info):
         raise QAPISemError(info,
                            "alternate '%s' cannot have empty 'data'" % n=
ame)
     for (key, value) in members.items():
-        check_name(key, info, "member of alternate '%s'" % name)
+        check_name_str(key, info, "member of alternate '%s'" % name)
         check_known_keys(value, info,
                          "member '%s' of alternate '%s'" % (key, name),
                          ['type'], ['if'])
--=20
2.21.0


