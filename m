Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4F3C4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA26824650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzPoKAff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA26824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76o9-0006bo-4W
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j76hc-0004w9-58
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j76hb-000642-2P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41472
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j76ha-000635-Uw
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582762014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4oPJhfkI0aRGGAECXKuAWDJVkZzi1afNH0v3JIceBRE=;
 b=RzPoKAff0zWW5fN0hSrIbjjqTTu2dJ4ZNcqFVT/bunWSmQDsQXUIyzJwYa6tPFUMnJFYD0
 nVU44HhOw28uiK8mNW6xEMLCyhEKXXefXWeHojExhXZBsn4FBy+FxbBe4HQXtSdqT4A6Tz
 Xzo/FB5IIb2glfkNPC8OO5WwC1AqBEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-ilqkU8zhMEigNxUy8-w1pQ-1; Wed, 26 Feb 2020 19:06:51 -0500
X-MC-Unique: ilqkU8zhMEigNxUy8-w1pQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDF631005514;
 Thu, 27 Feb 2020 00:06:49 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7038A390;
 Thu, 27 Feb 2020 00:06:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 8/9] iotests: don't use 'format' for drive_add
Date: Wed, 26 Feb 2020 19:06:38 -0500
Message-Id: <20200227000639.9644-9-jsnow@redhat.com>
In-Reply-To: <20200227000639.9644-1-jsnow@redhat.com>
References: <20200227000639.9644-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It shadows (with a different type) the built-in format.
Use something else.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/055        | 3 ++-
 tests/qemu-iotests/iotests.py | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 82b9f5f47d..4175fff5e4 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -469,7 +469,8 @@ class TestDriveCompression(iotests.QMPTestCase):
         qemu_img('create', '-f', fmt, blockdev_target_img,
                  str(TestDriveCompression.image_len), *args)
         if attach_target:
-            self.vm.add_drive(blockdev_target_img, format=3Dfmt, interface=
=3D"none")
+            self.vm.add_drive(blockdev_target_img,
+                              img_format=3Dfmt, interface=3D"none")
=20
         self.vm.launch()
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 214f59995e..8bf640c632 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -492,21 +492,21 @@ def add_drive_raw(self, opts):
         self._args.append(opts)
         return self
=20
-    def add_drive(self, path, opts=3D'', interface=3D'virtio', format=3Dim=
gfmt):
+    def add_drive(self, path, opts=3D'', interface=3D'virtio', img_format=
=3Dimgfmt):
         '''Add a virtio-blk drive to the VM'''
         options =3D ['if=3D%s' % interface,
                    'id=3Ddrive%d' % self._num_drives]
=20
         if path is not None:
             options.append('file=3D%s' % path)
-            options.append('format=3D%s' % format)
+            options.append('format=3D%s' % img_format)
             options.append('cache=3D%s' % cachemode)
             options.append('aio=3D%s' % aiomode)
=20
         if opts:
             options.append(opts)
=20
-        if format =3D=3D 'luks' and 'key-secret' not in opts:
+        if img_format =3D=3D 'luks' and 'key-secret' not in opts:
             # default luks support
             if luks_default_secret_object not in self._args:
                 self.add_object(luks_default_secret_object)
--=20
2.21.1


