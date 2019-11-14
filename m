Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD3C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC192070E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwSDotmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC192070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVGSV-0002ew-7u
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iVGPM-0000EJ-VI
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iVGPJ-0004jA-Nw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:47:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iVGPJ-0004hq-He
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573742856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sda8jhAYFmaT4wNFwT/2rbIqomRyFRvTlCBB/wU359U=;
 b=TwSDotmQySD1vUvPY/oTyP5QpFpXpSdgoQGgsR3b/f4Xsoxuxj9jlLq985WfdRjIhh1oha
 qLygAjzpJ1t2AK/euPw2g/wRioo+9tzjuaZyFSHjkAjRtK7dIEXo4wmn4vyEUCVlXr3amg
 YWQZdt16Pm82uSaJzRFecGANHZhsLRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-1zTNCVlFOAinLNgcF3RHKQ-1; Thu, 14 Nov 2019 09:47:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 814531005511
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 14:47:34 +0000 (UTC)
Received: from localhost (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 227195C1C3;
 Thu, 14 Nov 2019 14:47:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] qemu-gdb: add an Object pretty printer
Date: Thu, 14 Nov 2019 18:47:25 +0400
Message-Id: <20191114144725.2310-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1zTNCVlFOAinLNgcF3RHKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Inspired by GObject/GType pretty printer.

Example:
machine_set_accel (obj=3D0x555556807550 [pc-i440fx-4.0-machine],...

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qemu-gdb.py | 58 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 mode change 100644 =3D> 100755 scripts/qemu-gdb.py

diff --git a/scripts/qemu-gdb.py b/scripts/qemu-gdb.py
old mode 100644
new mode 100755
index f2a305c42e..b9fc1d10d4
--- a/scripts/qemu-gdb.py
+++ b/scripts/qemu-gdb.py
@@ -18,6 +18,9 @@ import gdb
=20
 import os, sys
=20
+if sys.version_info[0] < 3:
+    int =3D long
+
 # Annoyingly, gdb doesn't put the directory of scripts onto the
 # module search path. Do it manually.
=20
@@ -44,3 +47,58 @@ coroutine.CoroutinePCFunction()
 # Default to silently passing through SIGUSR1, because QEMU sends it
 # to itself a lot.
 gdb.execute('handle SIGUSR1 pass noprint nostop')
+
+
+def is_object(val):
+    def is_object_helper(type):
+        if str(type) =3D=3D "Object":
+            return True
+
+        while type.code =3D=3D gdb.TYPE_CODE_TYPEDEF:
+            type =3D type.target()
+
+        if type.code !=3D gdb.TYPE_CODE_STRUCT:
+            return False
+
+        fields =3D type.fields()
+        if len (fields) < 1:
+            return False
+
+        first_field =3D fields[0]
+        return is_object_helper(first_field.type)
+
+    type =3D val.type
+    if type.code !=3D gdb.TYPE_CODE_PTR:
+        return False
+    type =3D type.target()
+    return is_object_helper (type)
+
+
+def object_class_name(instance):
+    try:
+        inst =3D instance.cast(gdb.lookup_type("Object").pointer())
+        klass =3D inst["class"]
+        typ =3D klass["type"]
+        return typ["name"].string()
+    except RuntimeError:
+        pass
+
+
+class ObjectPrinter:
+    def __init__(self, val):
+        self.val =3D val
+
+    def to_string(self):
+        name =3D object_class_name(self.val)
+        if name:
+            return ("0x%x [%s]")% (int(self.val), name)
+        return  ("0x%x") % (int(self.val))
+
+
+def lookup_type(val):
+    if is_object(val):
+        return ObjectPrinter(val)
+    return None
+
+
+gdb.pretty_printers.append(lookup_type)
--=20
2.24.0


