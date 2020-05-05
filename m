Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F368C47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9C7206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbIvNRHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9C7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxGr-00048S-RV
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9k-0000qn-8x
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9i-0000f7-Oz
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPAfN00ZliTVI9TYbx640ixixPfDk00853mVgD7qnhU=;
 b=NbIvNRHuMjKd7PbSQiEuYcV+s+AazEPEIEZs3z+mamHZ4a+eU0vswbICNIzvA2SnhDqxkB
 t9i1aYt0nhor6jE1c14PNHcQP/fkhvDAJvb7VQOkpC+nXkhPOo/DodDLfWG435K+w+vHKW
 Cr1wDWSkjllzMqCFyGhgOnLnsYX0CF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-7ZVPI7JUOCucE-9wv3M52w-1; Tue, 05 May 2020 08:58:33 -0400
X-MC-Unique: 7ZVPI7JUOCucE-9wv3M52w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D962B8014C0;
 Tue,  5 May 2020 12:58:32 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE1B63F9E;
 Tue,  5 May 2020 12:58:32 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/24] iotests: don't use 'format' for drive_add
Date: Tue,  5 May 2020 14:58:04 +0200
Message-Id: <20200505125826.1001451-3-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

It shadows (with a different type) the built-in format.
Use something else.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200331000014.11581-3-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
index 6f6363f3ec..aca7d50524 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -486,21 +486,21 @@ class VM(qtest.QEMUQtestMachine):
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
2.26.2


