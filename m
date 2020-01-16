Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA31C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E222072E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEQFmVLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E222072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBjh-0003BS-Br
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isBiT-0001GU-VM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isBiP-0007ux-NY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52606
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isBiP-0007uZ-Jx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579206365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9dX+ieTEbRxUEd9ZD3ZdMVLtWiQ48pZ3bMmMZiEq6dk=;
 b=EEQFmVLxCT1cravGKqWdf8gJ+h0Jwbo09bnM682sPaQQvSZ/XoXE3mG40CrzmmViOwlhts
 /3+Z9aVNPuA/ARg/0/nwZdLxDVZnXvoG5a0DQ9lT238E0gOiOVhuQxlL4vGZgs1PhiUFnE
 8dky4cK2nrP9Lm6/J4YLsUqgs/7PnDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-52poiOehP7WXu0SBwdKFig-1; Thu, 16 Jan 2020 15:26:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9486E800EBF;
 Thu, 16 Jan 2020 20:26:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6220B5D9C9;
 Thu, 16 Jan 2020 20:26:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E98DE1138600; Thu, 16 Jan 2020 21:25:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qapi: Fix code generation with Python 3.5
Date: Thu, 16 Jan 2020 21:25:58 +0100
Message-Id: <20200116202558.31473-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 52poiOehP7WXu0SBwdKFig-1
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
Cc: thuth@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
modules" switched QAPISchema.visit() from

    for entity in self._entity_list:

effectively to

    for mod in self._module_dict.values():
        for entity in mod._entity_list:

Visits in the same order as long as .values() is in insertion order.
That's the case only for Python 3.6 and later.  Before, it's in some
arbitrary order, which results in broken generated code.

Fix by making self._module_dict an OrderedDict rather than a dict.

Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0bfc5256fb..5100110fa2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -795,7 +795,7 @@ class QAPISchema(object):
         self.docs =3D parser.docs
         self._entity_list =3D []
         self._entity_dict =3D {}
-        self._module_dict =3D {}
+        self._module_dict =3D OrderedDict()
         self._schema_dir =3D os.path.dirname(fname)
         self._make_module(None) # built-ins
         self._make_module(fname)
--=20
2.21.1


