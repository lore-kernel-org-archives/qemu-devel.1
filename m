Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C263C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C2B233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C2B233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59JD-0002jf-LZ
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58yp-0002QW-5V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58yn-0006QE-Lu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:36:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58yl-0006Mg-7s; Tue, 03 Sep 2019 09:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EE597F76C;
 Tue,  3 Sep 2019 13:36:14 +0000 (UTC)
Received: from localhost (ovpn-204-98.brq.redhat.com [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 286B019D7A;
 Tue,  3 Sep 2019 13:36:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  3 Sep 2019 15:35:45 +0200
Message-Id: <20190903133553.6500-9-mreitz@redhat.com>
In-Reply-To: <20190903133553.6500-1-mreitz@redhat.com>
References: <20190903133553.6500-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 03 Sep 2019 13:36:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 08/16] vmdk: Reject invalid compressed writes
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Compressed writes generally have to write full clusters, not just in
theory but also in practice when it comes to vmdk's streamOptimized
subformat.  It currently is just silently broken for writes with
non-zero in-cluster offsets:

$ qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 1M
$ qemu-io -c 'write 4k 4k' -c 'read 4k 4k' foo.vmdk
wrote 4096/4096 bytes at offset 4096
4 KiB, 1 ops; 00.01 sec (443.724 KiB/sec and 110.9309 ops/sec)
read failed: Invalid argument

(The technical reason is that vmdk_write_extent() just writes the
incomplete compressed data actually to offset 4k.  When reading the
data, vmdk_read_extent() looks at offset 0 and finds the compressed data
size to be 0, because that is what it reads from there.  This yields an
error.)

For incomplete writes with zero in-cluster offsets, the error path when
reading the rest of the cluster is a bit different, but the result is
the same:

$ qemu-img create -f vmdk -o subformat=3DstreamOptimized foo.vmdk 1M
$ qemu-io -c 'write 0k 4k' -c 'read 4k 4k' foo.vmdk
wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 00.01 sec (362.641 KiB/sec and 90.6603 ops/sec)
read failed: Invalid argument

(Here, vmdk_read_extent() finds the data and then sees that the
uncompressed data is short.)

It is better to reject invalid writes than to make the user believe they
might have succeeded and then fail when trying to read it back.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190815153638.4600-5-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/vmdk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index a7f82e665e..fed3b50c8a 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1734,6 +1734,16 @@ static int vmdk_write_extent(VmdkExtent *extent, i=
nt64_t cluster_offset,
     if (extent->compressed) {
         void *compressed_data;
=20
+        /* Only whole clusters */
+        if (offset_in_cluster ||
+            n_bytes > (extent->cluster_sectors * SECTOR_SIZE) ||
+            (n_bytes < (extent->cluster_sectors * SECTOR_SIZE) &&
+             offset + n_bytes !=3D extent->end_sector * SECTOR_SIZE))
+        {
+            ret =3D -EINVAL;
+            goto out;
+        }
+
         if (!extent->has_marker) {
             ret =3D -EINVAL;
             goto out;
--=20
2.21.0


