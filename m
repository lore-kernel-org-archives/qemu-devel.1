Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BBC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E1D20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWVPZDlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E1D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdTd-00080t-I3
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMp-0005YO-M8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMo-0006E6-V8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52143
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdMo-0006DG-FY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587654137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2cqhM0E1bEKC/9lcpTQwkAhtbzAs7FyjA2Zy3RAW3s=;
 b=KWVPZDlvwAWSizvEcHxjpGd0XodkezYsg1KStB5hEFHq1woaiuhjkrqBezt2fNnX+Aomu0
 7zwl6Z9tk9rkVfV2i/N3KDwlNDCnCfsbdinynCsxsUHF3RiYpkgx+Q042J8ws4TBFcNSpf
 tRkrWvg15+8Tm5qQ81km1mn7yPAJQ6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-BDRbcyOIPE2N1XXN94C_Mg-1; Thu, 23 Apr 2020 11:02:15 -0400
X-MC-Unique: BDRbcyOIPE2N1XXN94C_Mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11F1A107ACF2;
 Thu, 23 Apr 2020 15:02:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C24B610AB;
 Thu, 23 Apr 2020 15:02:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 10/10] qcow2: Forward ZERO_WRITE flag for full preallocation
Date: Thu, 23 Apr 2020 17:01:27 +0200
Message-Id: <20200423150127.142609-11-kwolf@redhat.com>
In-Reply-To: <20200423150127.142609-1-kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BDRV_REQ_ZERO_WRITE is currently implemented in a way that first the
image is possibly preallocated and then the zero flag is added to all
clusters. This means that a copy-on-write operation may be needed when
writing to these clusters, despite having used preallocation, negating
one of the major benefits of preallocation.

Instead, try to forward the BDRV_REQ_ZERO_WRITE to the protocol driver,
and if the protocol driver can ensure that the new area reads as zeros,
we can skip setting the zero flag in the qcow2 layer.

Unfortunately, the same approach doesn't work for metadata
preallocation, so we'll still set the zero flag there.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c              | 22 +++++++++++++++++++---
 tests/qemu-iotests/274.out |  4 ++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ad621fe404..b28e588942 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4170,9 +4170,25 @@ static int coroutine_fn qcow2_co_truncate(BlockDrive=
rState *bs, int64_t offset,
         /* Allocate the data area */
         new_file_size =3D allocation_start +
                         nb_new_data_clusters * s->cluster_size;
-        /* Image file grows, so @exact does not matter */
-        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, prealloc,=
 0,
-                               errp);
+        /*
+         * Image file grows, so @exact does not matter.
+         *
+         * If we need to zero out the new area, try first whether the prot=
ocol
+         * driver can already take care of this.
+         */
+        if (flags & BDRV_REQ_ZERO_WRITE) {
+            ret =3D bdrv_co_truncate(bs->file, new_file_size, false, preal=
loc,
+                                   BDRV_REQ_ZERO_WRITE, errp);
+            if (ret >=3D 0) {
+                flags &=3D ~BDRV_REQ_ZERO_WRITE;
+            }
+        } else {
+            ret =3D -1;
+        }
+        if (ret < 0) {
+            ret =3D bdrv_co_truncate(bs->file, new_file_size, false, preal=
loc, 0,
+                                   errp);
+        }
         if (ret < 0) {
             error_prepend(errp, "Failed to resize underlying file: ");
             qcow2_free_clusters(bs, allocation_start,
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
index 179bd7ccaf..c355b52689 100644
--- a/tests/qemu-iotests/274.out
+++ b/tests/qemu-iotests/274.out
@@ -179,7 +179,7 @@ read 65536/65536 bytes at offset 9437184
 10 MiB (0xa00000) bytes     allocated at offset 5 MiB (0x500000)
=20
 [{ "start": 0, "length": 5242880, "depth": 1, "zero": true, "data": false}=
,
-{ "start": 5242880, "length": 10485760, "depth": 0, "zero": true, "data": =
false, "offset": 327680}]
+{ "start": 5242880, "length": 10485760, "depth": 0, "zero": false, "data":=
 true, "offset": 327680}]
=20
 =3D=3D=3D preallocation=3Dfull =3D=3D=3D
 Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D16777216 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
@@ -198,7 +198,7 @@ read 65536/65536 bytes at offset 11534336
 4 MiB (0x400000) bytes     allocated at offset 8 MiB (0x800000)
=20
 [{ "start": 0, "length": 8388608, "depth": 1, "zero": true, "data": false}=
,
-{ "start": 8388608, "length": 4194304, "depth": 0, "zero": true, "data": f=
alse, "offset": 327680}]
+{ "start": 8388608, "length": 4194304, "depth": 0, "zero": false, "data": =
true, "offset": 327680}]
=20
 =3D=3D=3D preallocation=3Doff =3D=3D=3D
 Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D393216 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
--=20
2.25.3


