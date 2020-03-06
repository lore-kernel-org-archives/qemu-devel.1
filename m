Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37504C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041872051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THdfdnPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041872051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGb5-0007LJ-25
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZA-0004gE-39
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZ8-00075P-6g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZ8-00074F-3Q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Omoi/sEq5CITopR+p4fflWC2UR9+E6aTKjKMk9A1Res=;
 b=THdfdnPOrdfpTinlcn6KADwLQY4db+27xFzASJ0WMFqM34/OF2N4XLyh2LUKBftiREnEh/
 i0QR9DYizJILK84w/VKuU9ys47A5qA/romNGYWmJAboft5zMxPe8ffrlrCXoNM3YNZTNHy
 kFK/r09Ly+nvftzVf7TjNeajrJQUwUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-wDEMXzbSMhedwOdEZQxCog-1; Fri, 06 Mar 2020 12:15:09 -0500
X-MC-Unique: wDEMXzbSMhedwOdEZQxCog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71EC7801E6D;
 Fri,  6 Mar 2020 17:15:08 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E2E973873;
 Fri,  6 Mar 2020 17:15:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/29] iotests/026: Test EIO on preallocated zero cluster
Date: Fri,  6 Mar 2020 18:14:31 +0100
Message-Id: <20200306171458.1848-3-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Test what happens when writing data to a preallocated zero cluster, but
the data write fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200225143130.111267-3-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/026             | 21 +++++++++++++++++++++
 tests/qemu-iotests/026.out         | 10 ++++++++++
 tests/qemu-iotests/026.out.nocache | 10 ++++++++++
 3 files changed, 41 insertions(+)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index a4aa74764f..0c1273c339 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -218,6 +218,27 @@ _make_test_img 64M
 $QEMU_IO -c "write 0 1M" -c "write 0 1M" "$BLKDBG_TEST_IMG" | _filter_qemu=
_io
 _check_test_img
=20
+echo
+echo =3D=3D=3D Avoid freeing preallocated zero clusters on failure =3D=3D=
=3D
+echo
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event =3D "write_aio"
+errno =3D "5"
+once =3D "on"
+EOF
+
+_make_test_img $CLUSTER_SIZE
+# Create a preallocated zero cluster
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" -c "write -z 0 $CLUSTER_SIZE" "$TEST_I=
MG" \
+    | _filter_qemu_io
+# Try to overwrite it (prompting an I/O error from blkdebug), thus
+# triggering the alloc abort code
+$QEMU_IO -c "write 0 $CLUSTER_SIZE" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index ff0817b6f2..83989996ff 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -643,4 +643,14 @@ write failed: Input/output error
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+=3D=3D=3D Avoid freeing preallocated zero clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+write failed: Input/output error
+No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/026.out.nocache b/tests/qemu-iotests/026.ou=
t.nocache
index 495d013007..9359d26d7e 100644
--- a/tests/qemu-iotests/026.out.nocache
+++ b/tests/qemu-iotests/026.out.nocache
@@ -651,4 +651,14 @@ write failed: Input/output error
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
+
+=3D=3D=3D Avoid freeing preallocated zero clusters on failure =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1024
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+write failed: Input/output error
+No errors were found on the image.
 *** done
--=20
2.20.1


