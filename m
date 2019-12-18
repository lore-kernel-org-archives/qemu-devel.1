Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E85BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3F22176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtAQlwSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3F22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihc0N-00070h-3l
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihbzN-00068B-33
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihbzJ-0008L0-Q6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:15:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37656
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihbzJ-0008D8-AG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576685747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5iOfxzYZyoM981zY9wwZcaQw/+9IPpb87KQa9tb1hlw=;
 b=WtAQlwSz5ErmPFUVG1MPNkKff5xIHfPHSWr6p8Gau6wqZ4fC7IFEWv0o/2f61KpE4pHrjR
 B/Pf11ELe2++7TV1L//M2StcCCLEJt/+ekbRGWrFh77bDXxO6D0vFk9nE4i3M5CvFjXXSv
 rxmFXVi4QsRmVd99MfzX/+wMSCeCn3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-9CayVMTdNhCjWAFD_UhGfw-1; Wed, 18 Dec 2019 11:15:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D46510C0128;
 Wed, 18 Dec 2019 16:15:45 +0000 (UTC)
Received: from thuth.com (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3C960C18;
 Wed, 18 Dec 2019 16:15:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] iotests: Add more "_require_drivers" checks to the
 shell-based tests
Date: Wed, 18 Dec 2019 17:15:41 +0100
Message-Id: <20191218161541.30769-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 9CayVMTdNhCjWAFD_UhGfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test 051 should be skipped if nbd is not available, and 267 should
be skipped if copy-on-read is not enabled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/051 | 1 +
 tests/qemu-iotests/267 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 53bcdbc911..a13bce2fd0 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -41,6 +41,7 @@ _supported_proto file
 # A compat=3D0.10 image is created in this test which does not support any=
thing
 # other than refcount_bits=3D16
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
+_require_drivers nbd
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 17ac640a83..c1536f45b9 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_require_drivers copy-on-read
=20
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
--=20
2.18.1


