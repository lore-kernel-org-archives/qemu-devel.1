Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB1C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCFA2077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ6AaIC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCFA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSl6P-0003XB-0l
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSknE-0003Xi-O3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSknC-0005p4-Hx
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSknC-0005oI-F4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3b2/2Nn/7L9h+OFBNqkNBGn+i8/lEEYN3/ifXGQNJ0=;
 b=LQ6AaIC1xJX5o6hhkKgLM70ReDvhNg+rd3MkPJzWEl01Ra1AFSbn5jFtHsHMwr4De7SZW9
 VMf9gh14HhuQrARX9O6LjF1fu9+YlEt5RLcM24RqXBUJMYuedpD1y6APOUpaikv7mcRweM
 QscBh9OWsrtgnRt0RIfzWK8lAO8i7hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-_XDyaV1cOUmRuhEALGkE6A-1; Thu, 07 Nov 2019 11:37:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBDDD1005500;
 Thu,  7 Nov 2019 16:37:48 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 780DC60BFB;
 Thu,  7 Nov 2019 16:37:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 18/22] iotests: Make 110 work with data_file
Date: Thu,  7 Nov 2019 17:37:04 +0100
Message-Id: <20191107163708.833192-19-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _XDyaV1cOUmRuhEALGkE6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
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
2.23.0


