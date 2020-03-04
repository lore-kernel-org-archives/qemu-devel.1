Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F5CC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAF720838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZTppGYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAF720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bkD-00086n-F6
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9bik-00068K-Ix
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9bij-0007Wf-GN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27520
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9bij-0007WU-D2
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583357905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ScD/gNA7sMopVFgfYEOmgfOv0OIkpDBFqBbAiYW2czE=;
 b=ZZTppGYGprprHaS1t9QG/zxvyFctekqwsOxl0DmAfb8YdPmSpQ2bG0gq5SZGAvzDNE/bpT
 nvvqa1FE2gB6LALbDfW2CJ9w+7l7oa6YwsTt8QJSOBcv5ewFRYMheVyB8r69Jm8B6cPVFo
 8MJl3vcqq35/YBNaGK3G2yApuL/1ng8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-cU1QzuQpN6CjxipV_Ju7EQ-1; Wed, 04 Mar 2020 16:38:23 -0500
X-MC-Unique: cU1QzuQpN6CjxipV_Ju7EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FDDC8010E3;
 Wed,  4 Mar 2020 21:38:22 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6171A5C1D4;
 Wed,  4 Mar 2020 21:38:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/10] iotests: don't use 'format' for drive_add
Date: Wed,  4 Mar 2020 16:38:10 -0500
Message-Id: <20200304213818.15341-3-jsnow@redhat.com>
In-Reply-To: <20200304213818.15341-1-jsnow@redhat.com>
References: <20200304213818.15341-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It shadows (with a different type) the built-in format.
Use something else.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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
index c3aa857140..cd0f185d30 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -482,21 +482,21 @@ def add_drive_raw(self, opts):
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


