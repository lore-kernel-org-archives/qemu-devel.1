Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC63C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90B2205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90B2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSz2-0003AB-No
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSwj-00018b-AT
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwd-0004jo-La
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwX-0004BT-Vk; Mon, 24 Jun 2019 13:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43F2E30832E4;
 Mon, 24 Jun 2019 17:39:42 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D38E660BE2;
 Mon, 24 Jun 2019 17:39:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:22 +0200
Message-Id: <20190624173935.25747-3-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 24 Jun 2019 17:39:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 02/14] qapi: Move to_c_string() to common.py
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function will be useful for code generation once we allow default
values, so move it to the other "C helper functions".  In the process,
rewrite it so it supports all nonprintable and non-ASCII characters.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 scripts/qapi/common.py     | 26 ++++++++++++++++++++++++++
 scripts/qapi/introspect.py |  4 ----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3396ea4a09..c6754a5856 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2208,6 +2208,32 @@ def c_fname(filename):
     return re.sub(r'[^A-Za-z0-9_]', '_', filename)
=20
=20
+# Translates a string to a valid C constant
+def to_c_string(string):
+    result =3D '"'
+
+    python2 =3D isinstance(string, bytes)
+    if not python2:
+        # Will return integers when iterated over
+        string =3D string.encode()
+
+    for c in string:
+        value =3D ord(c) if python2 else c
+        if value < 0x20 or value > 0x7e:
+            result +=3D '\\%03o' % value
+        else:
+            c =3D chr(value)
+            if c =3D=3D '"':
+                result +=3D '\\"'
+            elif c =3D=3D '\\':
+                result +=3D '\\\\'
+            else:
+                result +=3D c
+
+    result +=3D '"'
+    return result
+
+
 def guardstart(name):
     return mcgen('''
 #ifndef %(name)s
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 6a61dd831f..572e0b8331 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -66,10 +66,6 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFa=
lse):
     return ret
=20
=20
-def to_c_string(string):
-    return '"' + string.replace('\\', r'\\').replace('"', r'\"') + '"'
-
-
 class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
=20
     def __init__(self, prefix, unmask):
--=20
2.21.0


