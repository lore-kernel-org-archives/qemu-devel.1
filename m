Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0A6C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D5F20707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdoTCz0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D5F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU4b-0003Qa-EF
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbo-0007bc-F1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbn-00010n-13
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbm-00010K-Sa
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DeSUCviWHZQY9JorE/4l/D0VLkp714elLDjRGRsT3w=;
 b=IdoTCz0kaBaAlvQ/z2BfgTduJw8Os91+F2GcYWSGZCM9AFZzIQIuc4gTGNHbhRGOchWF4P
 dItZmF8KKWSCx34Lr25wuKeLTgcMIy394G5I4bymb7tr2G5+ME1359wL+PFbgvHtfWnrRH
 F7fU+ULe3BGPMRvfWw/cxkrnMj1JNjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-XLXAmsEmNLC_avfGINCcyg-1; Mon, 06 Jan 2020 09:43:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC8DA100F7E4;
 Mon,  6 Jan 2020 14:43:49 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F2D860C88;
 Mon,  6 Jan 2020 14:43:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 32/34] tests/qemu-iotests: add case to write compressed data of
 multiple clusters
Date: Mon,  6 Jan 2020 15:42:04 +0100
Message-Id: <20200106144206.698920-33-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XLXAmsEmNLC_avfGINCcyg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Add the case to the iotest #214 that checks possibility of writing
compressed data of more than one cluster size. The test case involves
the compress filter driver showing a sample usage of that.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 1575288906-551879-4-git-send-email-andrey.shinkevich@virtuozzo.=
com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/214     | 43 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/214.out | 14 +++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index 0f2e61280a..3500e0c47a 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -90,6 +90,49 @@ _check_test_img -r all
 $QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fi=
lter_testdir
 $QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | _fi=
lter_testdir
=20
+echo
+echo "=3D=3D=3D Write compressed data of multiple clusters =3D=3D=3D"
+echo
+cluster_size=3D0x10000
+_make_test_img 2M -o cluster_size=3D$cluster_size
+
+echo "Write uncompressed data:"
+let data_size=3D"8 * $cluster_size"
+$QEMU_IO -c "write -P 0xaa 0 $data_size" "$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+sizeA=3D$($QEMU_IMG info --output=3Djson "$TEST_IMG" |
+        sed -n '/"actual-size":/ s/[^0-9]//gp')
+
+_make_test_img 2M -o cluster_size=3D$cluster_size
+echo "Write compressed data:"
+let data_size=3D"3 * $cluster_size + $cluster_size / 2"
+# Set compress on. That will align the written data
+# by the cluster size and will write them compressed.
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c "write -P 0xbb 0 $data_size" --image-opts \
+         "driver=3Dcompress,file.driver=3D$IMGFMT,file.file.driver=3Dfile,=
file.file.filename=3D$TEST_IMG" \
+         2>&1 | _filter_qemu_io | _filter_testdir
+
+let offset=3D"4 * $cluster_size + $cluster_size / 4"
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c "write -P 0xcc $offset $data_size" "json:{\
+    'driver': 'compress',
+    'file': {'driver': '$IMGFMT',
+             'file': {'driver': 'file',
+                      'filename': '$TEST_IMG'}}}" | \
+                          _filter_qemu_io | _filter_testdir
+
+sizeB=3D$($QEMU_IMG info --output=3Djson "$TEST_IMG" |
+        sed -n '/"actual-size":/ s/[^0-9]//gp')
+
+if [ $sizeA -le $sizeB ]
+then
+    echo "Compression ERROR"
+fi
+
+$QEMU_IMG check --output=3Djson "$TEST_IMG" |
+          sed -n 's/,$//; /"compressed-clusters":/ s/^ *//p'
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/214.out b/tests/qemu-iotests/214.out
index 0fcd8dc051..9fc67287f8 100644
--- a/tests/qemu-iotests/214.out
+++ b/tests/qemu-iotests/214.out
@@ -32,4 +32,18 @@ read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4194304/4194304 bytes at offset 4194304
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D=3D Write compressed data of multiple clusters =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2097152
+Write uncompressed data:
+wrote 524288/524288 bytes at offset 0
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2097152
+Write compressed data:
+wrote 229376/229376 bytes at offset 0
+224 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 229376/229376 bytes at offset 278528
+224 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+"compressed-clusters": 8
 *** done
--=20
2.24.1


