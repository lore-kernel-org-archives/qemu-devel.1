Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3BC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CAF52173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQA23ldB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAF52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNOu-00033Q-JD
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNNb-0001gl-1j
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNNY-0002Ca-No
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:37:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNNY-0002CC-Ib
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573054672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/TX7aV4OszRPatM778+K/oMXk8TFeM1NtNjQ7QzNfI=;
 b=QQA23ldBM2YHeHShWfYhLOaaPOJ3j9iNfVOR2vvdoV+xWTyWJUfnGjgY3rupH1jBiTe19Q
 0mDc3QFPwXhKCTax7uBechX2sWM5dyWl5zx2ukV61nEyOxnOwgQmDaL5x95gHOduKjTE3u
 GrbGQPGT/oGSEbdOejaQtwBs8W3UsY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-9jHBK5g7NXutdHmvRCpAWw-1; Wed, 06 Nov 2019 10:37:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 072A68017E0;
 Wed,  6 Nov 2019 15:37:50 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F4AF5DA83;
 Wed,  6 Nov 2019 15:37:32 +0000 (UTC)
Message-ID: <5019fd595dad608f4fd066e2d19755fdc6f9ccd9.camel@redhat.com>
Subject: Re: [PATCH v2 02/21] iotests/qcow2.py: Split feature fields into bits
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:37:32 +0200
In-Reply-To: <20191015142729.18123-3-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-3-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9jHBK5g7NXutdHmvRCpAWw-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> Print the feature fields as a set of bits so that filtering is easier.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/031.out  | 36 +++++++++----------
>  tests/qemu-iotests/036.out  | 18 +++++-----
>  tests/qemu-iotests/039.out  | 22 ++++++------
>  tests/qemu-iotests/060.out  | 20 +++++------
>  tests/qemu-iotests/061.out  | 72 ++++++++++++++++++-------------------
>  tests/qemu-iotests/137.out  |  2 +-
>  tests/qemu-iotests/qcow2.py | 18 +++++++---
>  7 files changed, 99 insertions(+), 89 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 68a74d03b9..d535e407bc 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -18,9 +18,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -46,9 +46,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -74,9 +74,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -109,9 +109,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -142,9 +142,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -175,9 +175,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index e489b44386..15229a9604 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -16,9 +16,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x8000000000000000
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     [63]
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -50,9 +50,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x8000000000000000
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        [63]
>  refcount_order            4
>  header_length             104
> =20
> @@ -78,9 +78,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 2e356d51b6..bdafa3ace3 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -4,7 +4,7 @@ QA output created by 039
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -incompatible_features     0x0
> +incompatible_features     []
>  No errors were found on the image.
> =20
>  =3D=3D Creating a dirty image file =3D=3D
> @@ -12,7 +12,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     0x1
> +incompatible_features     [0]
>  ERROR cluster 5 refcount=3D0 reference=3D1
>  ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D=
0
> =20
> @@ -22,7 +22,7 @@ Data may be corrupted, or further writes to the image m=
ay corrupt it.
>  =3D=3D Read-only access must still work =3D=3D
>  read 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -incompatible_features     0x1
> +incompatible_features     [0]
> =20
>  =3D=3D Repairing the image file must succeed =3D=3D
>  ERROR cluster 5 refcount=3D0 reference=3D1
> @@ -36,7 +36,7 @@ The following inconsistencies were found and repaired:
> =20
>  Double checking the fixed image now...
>  No errors were found on the image.
> -incompatible_features     0x0
> +incompatible_features     []
> =20
>  =3D=3D Data should still be accessible after repair =3D=3D
>  read 512/512 bytes at offset 0
> @@ -47,21 +47,21 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
34217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     0x1
> +incompatible_features     [0]
>  ERROR cluster 5 refcount=3D0 reference=3D1
>  Rebuilding refcount structure
>  Repairing cluster 1 refcount=3D1 reference=3D0
>  Repairing cluster 2 refcount=3D1 reference=3D0
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -incompatible_features     0x0
> +incompatible_features     []
> =20
>  =3D=3D Creating an image file with lazy_refcounts=3Doff =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     0x0
> +incompatible_features     []
>  No errors were found on the image.
> =20
>  =3D=3D Committing to a backing file with lazy_refcounts=3Don =3D=3D
> @@ -70,8 +70,8 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728 backing_file=3DTEST_DIR/
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Image committed.
> -incompatible_features     0x0
> -incompatible_features     0x0
> +incompatible_features     []
> +incompatible_features     []
>  No errors were found on the image.
>  No errors were found on the image.
> =20
> @@ -80,7 +80,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     0x1
> +incompatible_features     [0]
>  ERROR cluster 5 refcount=3D0 reference=3D1
>  ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D=
0
> =20
> @@ -90,6 +90,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134=
217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     0x0
> +incompatible_features     []
>  No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index 0f6b0658a1..d27692a33c 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -7,10 +7,10 @@ ERROR cluster 3 refcount=3D1 reference=3D3
> =20
>  1 errors were found on the image.
>  Data may be corrupted, or further writes to the image may corrupt it.
> -incompatible_features     0x0
> +incompatible_features     []
>  qcow2: Marking image as corrupt: Preventing invalid write on metadata (o=
verlaps with active L1 table); further corruption events will be suppressed
>  write failed: Input/output error
> -incompatible_features     0x2
> +incompatible_features     [1]
>  image: TEST_DIR/t.IMGFMT
>  file format: IMGFMT
>  virtual size: 64 MiB (67108864 bytes)
> @@ -33,10 +33,10 @@ ERROR cluster 2 refcount=3D1 reference=3D2
> =20
>  2 errors were found on the image.
>  Data may be corrupted, or further writes to the image may corrupt it.
> -incompatible_features     0x0
> +incompatible_features     []
>  qcow2: Marking image as corrupt: Preventing invalid write on metadata (o=
verlaps with refcount block); further corruption events will be suppressed
>  write failed: Input/output error
> -incompatible_features     0x2
> +incompatible_features     [1]
>  ERROR refcount block 0 refcount=3D2
>  ERROR cluster 2 refcount=3D1 reference=3D2
>  Rebuilding refcount structure
> @@ -49,10 +49,10 @@ The following inconsistencies were found and repaired=
:
> =20
>  Double checking the fixed image now...
>  No errors were found on the image.
> -incompatible_features     0x0
> +incompatible_features     []
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -incompatible_features     0x0
> +incompatible_features     []
> =20
>  =3D=3D=3D Testing cluster data reference into inactive L2 table =3D=3D=
=3D
> =20
> @@ -69,10 +69,10 @@ Data may be corrupted, or further writes to the image=
 may corrupt it.
> =20
>  1 leaked clusters were found on the image.
>  This means waste of disk space, but no harm to data.
> -incompatible_features     0x0
> +incompatible_features     []
>  qcow2: Marking image as corrupt: Preventing invalid write on metadata (o=
verlaps with inactive L2 table); further corruption events will be suppress=
ed
>  write failed: Input/output error
> -incompatible_features     0x2
> +incompatible_features     [1]
>  ERROR cluster 4 refcount=3D1 reference=3D2
>  Leaked cluster 9 refcount=3D1 reference=3D0
>  Repairing cluster 4 refcount=3D1 reference=3D2
> @@ -85,10 +85,10 @@ The following inconsistencies were found and repaired=
:
> =20
>  Double checking the fixed image now...
>  No errors were found on the image.
> -incompatible_features     0x0
> +incompatible_features     []
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -incompatible_features     0x0
> +incompatible_features     []
>  read 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  No errors were found on the image.
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index d6a7c2af95..8b3091a412 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -18,9 +18,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x1
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       [0]
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -42,9 +42,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -76,9 +76,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x1
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       [0]
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -100,9 +100,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -132,9 +132,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x1
> -compatible_features       0x1
> -autoclear_features        0x0
> +incompatible_features     [0]
> +compatible_features       [0]
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -161,9 +161,9 @@ refcount_table_offset     0x80000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -187,9 +187,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x40000000000
> -autoclear_features        0x40000000000
> +incompatible_features     []
> +compatible_features       [42]
> +autoclear_features        [42]
>  refcount_order            4
>  header_length             104
> =20
> @@ -211,9 +211,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -237,9 +237,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             72
> =20
> @@ -256,9 +256,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x1
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       [0]
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -290,9 +290,9 @@ refcount_table_offset     0x10000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x1
> -compatible_features       0x1
> -autoclear_features        0x0
> +incompatible_features     [0]
> +compatible_features       [0]
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> @@ -319,9 +319,9 @@ refcount_table_offset     0x80000
>  refcount_table_clusters   1
>  nb_snapshots              0
>  snapshot_offset           0x0
> -incompatible_features     0x0
> -compatible_features       0x0
> -autoclear_features        0x0
> +incompatible_features     []
> +compatible_features       []
> +autoclear_features        []
>  refcount_order            4
>  header_length             104
> =20
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 1c6569eb2c..bd4523a853 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -36,7 +36,7 @@ qemu-io: Unsupported value 'blubb' for qcow2 option 'ov=
erlap-check'. Allowed are
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  ./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_QEMU_=
IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$=
@" )
> -incompatible_features     0x0
> +incompatible_features     []
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index d813b4fc81..91e4420b9f 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -42,9 +42,9 @@ class QcowHeader:
>          [ uint64_t, '%#x',  'snapshot_offset' ],
> =20
>          # Version 3 header fields
> -        [ uint64_t, '%#x',  'incompatible_features' ],
> -        [ uint64_t, '%#x',  'compatible_features' ],
> -        [ uint64_t, '%#x',  'autoclear_features' ],
> +        [ uint64_t, 'mask', 'incompatible_features' ],
> +        [ uint64_t, 'mask', 'compatible_features' ],
> +        [ uint64_t, 'mask', 'autoclear_features' ],
>          [ uint32_t, '%d',   'refcount_order' ],
>          [ uint32_t, '%d',   'header_length' ],
>      ];
> @@ -130,7 +130,17 @@ class QcowHeader:
> =20
>      def dump(self):
>          for f in QcowHeader.fields:
> -            print("%-25s" % f[2], f[1] % self.__dict__[f[2]])
> +            value =3D self.__dict__[f[2]]
> +            if f[1] =3D=3D 'mask':
> +                bits =3D []
> +                for bit in range(64):

Very very minor nitpick, the type size (64 bit) is hardcoded here
but I think it is OK.

> +                    if value & (1 << bit):
> +                        bits.append(bit)
> +                value_str =3D str(bits)
> +            else:
> +                value_str =3D f[1] % value
> +
> +            print("%-25s" % f[2], value_str)
>          print("")
> =20
>      def dump_extensions(self):


This is  very good idea and implementation.
Thanks!

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky


