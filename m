Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272DDC34036
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA69521D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3Tq+UJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA69521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40F2-0003Ws-3g
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40Dk-00019z-3R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40Di-0007M6-OH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40Di-0007Lr-KM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvBWi2s6/tJLBi+ftR5NPxjefGGwG5hSWq/ZKgtM+YU=;
 b=X3Tq+UJdZkk9h6C3KM2fV3aDM5H+gqVSZPzQK4MIwU/YffmlsQWkYaW2dOI6V8fLnWuEpS
 nNfyWvZLknYzIErbVLe7ngXW1ThM1mSQphCU52fkTXQLfqrVeypiD5IsdhF185buCsQrrn
 qmtlnFNCe0IWwYKq1ebjpYLRIoCloZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-qbxdX0FsOdCmAzmznA_8ug-1; Tue, 18 Feb 2020 05:35:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF8D18A6EC3;
 Tue, 18 Feb 2020 10:35:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2CBE5D9E2;
 Tue, 18 Feb 2020 10:35:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 04/19] iotests: Let 041 use -blockdev for quorum children
Date: Tue, 18 Feb 2020 11:34:39 +0100
Message-Id: <20200218103454.296704-5-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qbxdX0FsOdCmAzmznA_8ug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using -drive with default options means that a virtio-blk drive will be
created that has write access to the to-be quorum children.  Quorum
should have exclusive write access to them, so we should use -blockdev
instead.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/041 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 43556b9727..aa7d54d968 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -885,7 +885,10 @@ class TestRepairQuorum(iotests.QMPTestCase):
             # Assign a node name to each quorum image in order to manipula=
te
             # them
             opts =3D "node-name=3Dimg%i" % self.IMAGES.index(i)
-            self.vm =3D self.vm.add_drive(i, opts)
+            opts +=3D ',driver=3D%s' % iotests.imgfmt
+            opts +=3D ',file.driver=3Dfile'
+            opts +=3D ',file.filename=3D%s' % i
+            self.vm =3D self.vm.add_blockdev(opts)
=20
         self.vm.launch()
=20
--=20
2.24.1


