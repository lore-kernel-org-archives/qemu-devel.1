Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D9EC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE8D207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCML64Gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE8D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTpS-0000q6-AY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbZ-0007DT-1b
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbX-0000nZ-M0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbX-0000mw-3T
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrG6GNGLQzaRBSYfvM/1ebCsTH7JsuVYluuZv1OBM5E=;
 b=FCML64GuhzNq2jVq0MAv4SnKunHFH/Ri6aIrJ7c/niSF8HlpGwISSeq5+GDF2MS6YCYBdC
 KqDSBZCBxjstr7UqSPfWrHbSubjygdpg8HLwxOEOl1Cc4DJMnXVst6T6SHx8K8IhBpP5rP
 GXclo5uwL6i6DRNqRpZhCG16L9nKQww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-O2O729uaM82ZhebG0a4rAQ-1; Mon, 06 Jan 2020 09:43:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 030A4107B79C;
 Mon,  6 Jan 2020 14:43:36 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EE225D9D6;
 Mon,  6 Jan 2020 14:43:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 27/34] iotests: Make 198 work with data_file
Date: Mon,  6 Jan 2020 15:41:59 +0100
Message-Id: <20200106144206.698920-28-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: O2O729uaM82ZhebG0a4rAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

We do not care about the json:{} filenames here, so we can just filter
them out and thus make the test work both with and without external data
files.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20191107163708.833192-21-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/198     | 6 ++++--
 tests/qemu-iotests/198.out | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index c8f824cfae..fb0d5a29d3 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -92,13 +92,15 @@ echo
 echo "=3D=3D checking image base =3D=3D"
 $QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-speci=
fic \
     | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
-          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
+          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/ D=
' \
+    | _filter_json_filename
=20
 echo
 echo "=3D=3D checking image layer =3D=3D"
 $QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-spec=
ific \
     | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' \
-          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
+          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/ D=
' \
+    | _filter_json_filename
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index e86b175e39..831ce3a289 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D checking image base =3D=3D
-image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {"d=
river": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 Format specific information:
@@ -74,7 +74,7 @@ Format specific information:
         master key iters: 1024
=20
 =3D=3D checking image layer =3D=3D
-image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {"d=
river": "file", "filename": "TEST_DIR/t.IMGFMT"}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
--=20
2.24.1


