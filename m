Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2658C20658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlZ5FeaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2658C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGep-0003qN-8N
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZ8-0004fm-M3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZ7-00073g-Ek
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZ7-00072t-AU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZRM5vgUAJU2FA1AmspXimPttE4N5rGzBVUC8cRGLtw=;
 b=FlZ5FeaFoy6fvvGbwGpcPcbUOqOwTPNjgG/ONV/mKr+b0JEHNFv96yxNE66FOdntrn3OIU
 FhoAVEAC9yYsMVhHv1vMLJ8lPYV5xpHStCFhGCNiJ0CoWRIg4xkiOUb1Vat7VO+2DI28fa
 jRRJLKNYVLr4lb0Rk9vPeVatVuyYMfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-1nJCWdC6Ny6RXdrY1GlFdw-1; Fri, 06 Mar 2020 12:15:10 -0500
X-MC-Unique: 1nJCWdC6Ny6RXdrY1GlFdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B90D313F6;
 Fri,  6 Mar 2020 17:15:09 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B782C73873;
 Fri,  6 Mar 2020 17:15:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/29] iotests/026: Test EIO on allocation in a data-file
Date: Fri,  6 Mar 2020 18:14:32 +0100
Message-Id: <20200306171458.1848-4-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Test what happens when writing data to an external data file, where the
write requires an L2 entry to be allocated, but the data write fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200225143130.111267-4-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/026             | 32 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/026.out         |  6 ++++++
 tests/qemu-iotests/026.out.nocache |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index 0c1273c339..b05a4692cf 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -30,6 +30,7 @@ _cleanup()
 {
 =09_cleanup_test_img
     rm "$TEST_DIR/blkdebug.conf"
+    rm -f "$TEST_IMG.data_file"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -239,6 +240,37 @@ $QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IMG"=
 | _filter_qemu_io
=20
 _check_test_img
=20
+echo
+echo =3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+echo
+
+# Similar test as the last one, except we test what happens when there
+# is an error when writing to an external data file instead of when
+# writing to a preallocated zero cluster
+_make_test_img -o "data_file=3D$TEST_IMG.data_file" $CLUSTER_SIZE
+
+# Put blkdebug above the data-file, and a raw node on top of that so
+# that blkdebug will see a write_aio event and emit an error
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" \
+    "json:{
+         'driver': 'qcow2',
+         'file': { 'driver': 'file', 'filename': '$TEST_IMG' },
+         'data-file': {
+             'driver': 'raw',
+             'file': {
+                 'driver': 'blkdebug',
+                 'config': '$TEST_DIR/blkdebug.conf',
+                 'image': {
+                     'driver': 'file',
+                     'filename': '$TEST_IMG.data_file'
+                 }
+             }
+         }
+     }" \
+    | _filter_qemu_io
+
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 83989996ff..c1b3b58482 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -653,4 +653,10 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
+
+=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTEST_=
DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.ou=
t.nocache
index 9359d26d7e..8d5001648a 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -661,4 +661,10 @@ wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 write failed: Input/output error
 No errors were found on the image.
+
+=3D=3D=3D Avoid freeing external data clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024 data_file=3DTEST_=
DIR/t.IMGFMT.data_file
+write failed: Input/output error
+No errors were found on the image.
 *** done
--=20
2.20.1


