Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72ACC35677
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A111224699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JloYmuje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A111224699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KRD-0000v8-RX
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7KQ0-00085B-NG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7KPz-0000R2-Gj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7KPz-0000Qu-Cd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582814739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkQVHVNk+3v+1AHE1TFgPCuBi+f0YID1uZa8xyXf8ds=;
 b=JloYmujeI4zjAupDDEew8vVFbHjMV2EdgepfKo5e7qzZ/bOvGekWmKu5AIQmw/r2BUxeDk
 mB5hz2jgRITgiD60uby2NW8br8jvcTuRDmf2SL88RjoPnUHyDr85pEKEbgDJrJfEvkPNBM
 wWYlnxNlzgz+xErBxiUWFIcnq7QNENw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-6fVA4mS2NTWYaPCPDrCb4A-1; Thu, 27 Feb 2020 09:45:34 -0500
X-MC-Unique: 6fVA4mS2NTWYaPCPDrCb4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E51511B2C987;
 Thu, 27 Feb 2020 14:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A55D210001BD;
 Thu, 27 Feb 2020 14:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1799811385ED; Thu, 27 Feb 2020 15:45:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] qapi: Inheriting from object is pointless with Python 3,
 drop
Date: Thu, 27 Feb 2020 15:45:28 +0100
Message-Id: <20200227144531.24309-2-armbru@redhat.com>
In-Reply-To: <20200227144531.24309-1-armbru@redhat.com>
References: <20200227144531.24309-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: mdroth@linux.vnet.ibm.com, jsnow@redhat.com, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/gen.py    |  2 +-
 scripts/qapi/parser.py |  6 +++---
 scripts/qapi/schema.py | 12 ++++++------
 scripts/qapi/source.py |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 95afae0615..a53a705c73 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -22,7 +22,7 @@ from qapi.common import *
 from qapi.schema import QAPISchemaVisitor
=20
=20
-class QAPIGen(object):
+class QAPIGen:
=20
     def __init__(self, fname):
         self.fname =3D fname
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 342792e410..2e3a3c5d76 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -23,7 +23,7 @@ from qapi.error import QAPIParseError, QAPISemError
 from qapi.source import QAPISourceInfo
=20
=20
-class QAPISchemaParser(object):
+class QAPISchemaParser:
=20
     def __init__(self, fname, previously_included=3DNone, incl_info=3DNone=
):
         previously_included =3D previously_included or set()
@@ -293,7 +293,7 @@ class QAPISchemaParser(object):
         raise QAPIParseError(self, "documentation comment must end with '#=
#'")
=20
=20
-class QAPIDoc(object):
+class QAPIDoc:
     """
     A documentation comment block, either definition or free-form
=20
@@ -312,7 +312,7 @@ class QAPIDoc(object):
     Free-form documentation blocks consist only of a body section.
     """
=20
-    class Section(object):
+    class Section:
         def __init__(self, name=3DNone):
             # optional section name (argument/member or section name)
             self.name =3D name
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 5100110fa2..c8bcfe2c49 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -24,7 +24,7 @@ from qapi.expr import check_exprs
 from qapi.parser import QAPISchemaParser
=20
=20
-class QAPISchemaEntity(object):
+class QAPISchemaEntity:
     meta =3D None
=20
     def __init__(self, name, info, doc, ifcond=3DNone, features=3DNone):
@@ -89,7 +89,7 @@ class QAPISchemaEntity(object):
         return "%s '%s'" % (self.meta, self.name)
=20
=20
-class QAPISchemaVisitor(object):
+class QAPISchemaVisitor:
     def visit_begin(self, schema):
         pass
=20
@@ -135,7 +135,7 @@ class QAPISchemaVisitor(object):
         pass
=20
=20
-class QAPISchemaModule(object):
+class QAPISchemaModule:
     def __init__(self, name):
         self.name =3D name
         self._entity_list =3D []
@@ -441,7 +441,7 @@ class QAPISchemaObjectType(QAPISchemaType):
                                        self.features)
=20
=20
-class QAPISchemaMember(object):
+class QAPISchemaMember:
     """ Represents object members, enum members and features """
     role =3D 'member'
=20
@@ -519,7 +519,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
                                         self.describe)
=20
=20
-class QAPISchemaObjectTypeVariants(object):
+class QAPISchemaObjectTypeVariants:
     def __init__(self, tag_name, info, tag_member, variants):
         # Flat unions pass tag_name but not tag_member.
         # Simple unions and alternates pass tag_member but not tag_name.
@@ -787,7 +787,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
                             self.arg_type, self.boxed)
=20
=20
-class QAPISchema(object):
+class QAPISchema:
     def __init__(self, fname):
         self.fname =3D fname
         parser =3D QAPISchemaParser(fname)
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 8956885033..e97b9a8e15 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -13,7 +13,7 @@ import copy
 import sys
=20
=20
-class QAPISchemaPragma(object):
+class QAPISchemaPragma:
     def __init__(self):
         # Are documentation comments required?
         self.doc_required =3D False
@@ -23,7 +23,7 @@ class QAPISchemaPragma(object):
         self.name_case_whitelist =3D []
=20
=20
-class QAPISourceInfo(object):
+class QAPISourceInfo:
     def __init__(self, fname, line, parent):
         self.fname =3D fname
         self.line =3D line
--=20
2.21.1


