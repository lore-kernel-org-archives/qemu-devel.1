Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57815C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21584206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTgxwZTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21584206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUmO-0001N3-6D
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXf-0005Wz-Au
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXc-0002D5-Fw
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXc-00029z-AO
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ErHcuT4cm1oXy3g+6iik/P+K8YdI7jU/ISt5Kmux1ac=;
 b=eTgxwZTz/hKdphTYgb7FRrANLEGcttDAWQ4xnO/axGsIEog0heIJvgiqNtzggwDPdYl+3/
 ILsrldjSQVoPKi2yiux3dj/CxxeYXKCp7e2r3IDgwf9draBv1K6EthdwD49Wgvuw6dHUYC
 LSCakApyg0cUpOB1Pdq2npEKjJ5UGKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-EuEESCqtOZW68xCAP41rlw-1; Sun, 15 Mar 2020 10:46:56 -0400
X-MC-Unique: EuEESCqtOZW68xCAP41rlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4758017DF;
 Sun, 15 Mar 2020 14:46:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F200F1009ABB;
 Sun, 15 Mar 2020 14:46:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 81C8611366D1; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/34] docs/devel/qapi-code-gen: Document 'features'
 introspection
Date: Sun, 15 Mar 2020 15:46:23 +0100
Message-Id: <20200315144653.22660-5-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 6a8c0b5102 "qapi: Add feature flags to struct types" neglected
to update section "Client JSON Protocol introspection", and commit
23394b4c39 "qapi: Add feature flags to commands" didn't either.  Make
up for that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 43 +++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 5906602504..297a725084 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -642,13 +642,8 @@ that previously resulted in an error).  QMP clients ma=
y still need to
 know whether the extension is available.
=20
 For this purpose, a list of features can be specified for a command or
-struct type.  This is exposed to the client as a list of strings,
-where each string signals that this build of QEMU shows a certain
-behaviour.
-
-Each member of the 'features' array defines a feature.  It can either
-be { 'name': STRING, '*if': COND }, or STRING, which is shorthand for
-{ 'name': STRING }.
+struct type.  Each list member can either be { 'name': STRING, '*if':
+COND }, or STRING, which is shorthand for { 'name': STRING }.
=20
 The optional 'if' member specifies a conditional.  See "Configuring
 the schema" below for more on this.
@@ -659,6 +654,12 @@ Example:
   'data': { 'number': 'int' },
   'features': [ 'allow-negative-numbers' ] }
=20
+The feature strings are exposed to clients in introspection, as
+explained in section "Client JSON Protocol introspection".
+
+Intended use is to have each feature string signal that this build of
+QEMU shows a certain behaviour.
+
=20
 =3D=3D=3D Naming rules and reserved names =3D=3D=3D
=20
@@ -965,7 +966,7 @@ schema, along with the SchemaInfo type.  This text atte=
mpts to give an
 overview how things work.  For details you need to consult the QAPI
 schema.
=20
-SchemaInfo objects have common members "name" and "meta-type", and
+SchemaInfo objects have common members "name", "meta-type", and
 additional variant members depending on the value of meta-type.
=20
 Each SchemaInfo object describes a wire ABI entity of a certain
@@ -985,12 +986,13 @@ references by name.
 QAPI schema definitions not reachable that way are omitted.
=20
 The SchemaInfo for a command has meta-type "command", and variant
-members "arg-type", "ret-type" and "allow-oob".  On the wire, the
-"arguments" member of a client's "execute" command must conform to the
-object type named by "arg-type".  The "return" member that the server
-passes in a success response conforms to the type named by "ret-type".
-When "allow-oob" is true, it means the command supports out-of-band
-execution.  It defaults to false.
+members "arg-type", "ret-type", "allow-oob", and "features".  On the
+wire, the "arguments" member of a client's "execute" command must
+conform to the object type named by "arg-type".  The "return" member
+that the server passes in a success response conforms to the type
+named by "ret-type".  When "allow-oob" is true, it means the command
+supports out-of-band execution.  It defaults to false.  "features"
+exposes the command's feature strings as a JSON array of strings.
=20
 If the command takes no arguments, "arg-type" names an object type
 without members.  Likewise, if the command returns nothing, "ret-type"
@@ -1025,7 +1027,8 @@ Example: the SchemaInfo for EVENT_C from section Even=
ts
=20
 The SchemaInfo for struct and union types has meta-type "object".
=20
-The SchemaInfo for a struct type has variant member "members".
+The SchemaInfo for a struct type has variant members "members" and
+"features".
=20
 The SchemaInfo for a union type additionally has variant members "tag"
 and "variants".
@@ -1047,6 +1050,16 @@ Example: the SchemaInfo for MyType from section Stru=
ct types
           { "name": "member2", "type": "int" },
           { "name": "member3", "type": "str", "default": null } ] }
=20
+"features" exposes the command's feature strings as a JSON array of
+strings.
+
+Example: the SchemaInfo for TestType from section Features:
+
+    { "name": "TestType", "meta-type": "object",
+      "members": [
+          { "name": "number", "type": "int" } ],
+      "features": ["allow-negative-numbers"] }
+
 "tag" is the name of the common member serving as type tag.
 "variants" is a JSON array describing the object's variant members.
 Each element is a JSON object with members "case" (the value of type
--=20
2.21.1


