Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0772C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F41D20707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAnWiCRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F41D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU2q-0000ww-8Z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbU-00076X-U1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbT-0000k4-HN
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbT-0000jf-Dl
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsW9A/KuWJzfMXhzNLmReZ4zVfg0ysO1L/7uPXDRxUE=;
 b=fAnWiCRT2kU1ajTJA4NJMQzzz+Ihv/sIrJ2qMHUVhS9y+BxFYt3ByPaVqa9yK16Wg4uTHT
 jMBcMaFyQtYmSsOS5WC3nQPviKC9fb951cb7tD5vM7cecI1WD/0tg9B2sES1hcDMKg57iI
 jRHQjDM4YFwu34BkhDRjW8O9XOq2Zsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-9Dmy-FBQOk2lD5sfMK30sg-1; Mon, 06 Jan 2020 09:43:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B53A5802C81;
 Mon,  6 Jan 2020 14:43:30 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AC9A5D9E1;
 Mon,  6 Jan 2020 14:43:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/34] iotests: Make 110 work with data_file
Date: Mon,  6 Jan 2020 15:41:57 +0100
Message-Id: <20200106144206.698920-26-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9Dmy-FBQOk2lD5sfMK30sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

The only difference is that the json:{} filename of the image looks
different.  We actually do not care about that filename in this test, we
are only interested in (1) that there is a json:{} filename, and (2)
whether the backing filename can be constructed.

So just filter out the json:{} data, thus making this test pass both
with and without data_file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20191107163708.833192-19-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/110     | 7 +++++--
 tests/qemu-iotests/110.out | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index f78df0e6e1..139c02c2cf 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -67,6 +67,7 @@ echo
 # Across blkdebug without a config file, you cannot reconstruct filenames,=
 so
 # qemu is incapable of knowing the directory of the top image from the fil=
ename
 # alone. However, using bdrv_dirname(), it should still work.
+# (Filter out the json:{} filename so this test works with external data f=
iles)
 TEST_IMG=3D"json:{
     'driver': '$IMGFMT',
     'file': {
@@ -82,7 +83,8 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info | grep -v 'backing file format'
+}" _img_info | _filter_img_info | grep -v 'backing file format' \
+    | _filter_json_filename
=20
 echo
 echo '=3D=3D=3D Backing name is always relative to the backed image =3D=3D=
=3D'
@@ -114,7 +116,8 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info | grep -v 'backing file format'
+}" _img_info | _filter_img_info | grep -v 'backing file format' \
+    | _filter_json_filename
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index f60b26390e..f835553a99 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGF=
MT.base)
=20
 =3D=3D=3D Non-reconstructable filename =3D=3D=3D
=20
-image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio",=
 "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver": "b=
lkdebug", "set-state.0.new_state": 42}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
@@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108=
864 backing_file=3Dt.IMGFMT.b
=20
 =3D=3D=3D Nodes without a common directory =3D=3D=3D
=20
-image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file", =
"filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_DIR/=
t.IMGFMT.copy"}], "driver": "quorum", "vote-threshold": 1}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
--=20
2.24.1


