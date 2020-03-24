Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761DD206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvHj9Cft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761DD206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGndF-00010h-In
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jGnZe-0004nG-Mb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jGnZd-0007WC-DL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23133)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jGnZd-0007Vx-A3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Os7shVWGnwyIrqpsGwPcel1dyMctuX/2vS68bUpjp3s=;
 b=WvHj9CftMIxopi01pP35s03oRw8+EvqayWPxwHqUHJ0KtkDvE9Fi93sG/VdAlSgNWPggUr
 yFjORvtgbZ0yBQJ2pbaqyqtISSYqjPnz8iqLt7Mtd4NOQTw4PJCPIdlTKqDXT35DIuYt/w
 ZWy1ATORdXEjp0HJNc2gzxwzBUvmaqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-jtPHLTuANZ2abgNMvILVqw-1; Tue, 24 Mar 2020 13:42:40 -0400
X-MC-Unique: jtPHLTuANZ2abgNMvILVqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835F0800D5B;
 Tue, 24 Mar 2020 17:42:38 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 041FB1001B0B;
 Tue, 24 Mar 2020 17:42:37 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] qcow2: Avoid feature name extension on small cluster
 size
Date: Tue, 24 Mar 2020 12:42:32 -0500
Message-Id: <20200324174233.1622067-4-eblake@redhat.com>
In-Reply-To: <20200324174233.1622067-1-eblake@redhat.com>
References: <20200324174233.1622067-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the feature name table can be quite large (over 9k if all 64 bits
of all three feature fields have names; a mere 8 features leaves only
8 bytes for a backing file name in a 512-byte cluster), it is unwise
to emit this optional header in images with small cluster sizes.

Update iotest 036 to skip running on small cluster sizes; meanwhile,
note that iotest 061 never passed on alternative cluster sizes
(however, I limited this patch to tests with output affected by adding
feature names, rather than auditing for other tests that are not
robust to alternative cluster sizes).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c          | 11 +++++++++--
 tests/qemu-iotests/036 |  6 ++++--
 tests/qemu-iotests/061 |  6 ++++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 67b0c214fba4..9475ace57163 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2823,8 +2823,15 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -=3D ret;
     }

-    /* Feature table */
-    if (s->qcow_version >=3D 3) {
+    /*
+     * Feature table.  A mere 8 feature names occupies 392 bytes, and
+     * when coupled with the v3 minimum header of 104 bytes plus the
+     * 8-byte end-of-extension marker, that would leave only 8 bytes
+     * for a backing file name in an image with 512-byte clusters.
+     * Thus, we choose to omit this header for cluster sizes 4k and
+     * smaller.
+     */
+    if (s->qcow_version >=3D 3 && s->cluster_size > 4096) {
         static const Qcow2Feature features[] =3D {
             {
                 .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 512598421c20..cf522de7a1aa 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -44,8 +44,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 # Only qcow2v3 and later supports feature bits;
-# qcow2.py does not support external data files
-_unsupported_imgopts 'compat=3D0.10' data_file
+# qcow2.py does not support external data files;
+# this test requires a cluster size large enough for the feature table
+_unsupported_imgopts 'compat=3D0.10' data_file \
+=09=09     'cluster_size=3D\(512\|1024\|2048\|4096\)'

 echo
 echo =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 36b040491fef..ce285d308408 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -44,8 +44,10 @@ _supported_os Linux
 # Conversion between different compat versions can only really work
 # with refcount_bits=3D16;
 # we have explicit tests for data_file here, but the whole test does
-# not work with it
-_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)' data_file
+# not work with it;
+# we have explicit tests for various cluster sizes, the remaining tests
+# require the default 64k cluster
+_unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)' data_file cl=
uster_size

 echo
 echo "=3D=3D=3D Testing version downgrade with zero expansion =3D=3D=3D"
--=20
2.26.0.rc2


