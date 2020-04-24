Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F9C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B56A20700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWH1wDeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B56A20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyn4-0001TP-QI
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRyf4-0000qg-BA
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRyf3-0006No-T1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:46:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46114
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRyf3-0006Hy-G9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587735991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7baQuGzOMCTDE2fIMrgSRgkBAfdpdc29YxIGXt3InpM=;
 b=dWH1wDeQpa0fJl2SnOw3ZlqGGWImvNtjtBEaHNPQvGLT5JqYIW60f2ch6UJAcGq1+2TGdK
 9448wqQIt+OFI45kXNvlo0MxmjBfV6lNFSEJzYHtLOib4q9kEMNYrIgGI80oQLuPaXuMYe
 0Qng629og+4Svo27G1UnIKqgSKueUhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-XllVg-1AM0OQ9PFfe5IDjg-1; Fri, 24 Apr 2020 09:46:29 -0400
X-MC-Unique: XllVg-1AM0OQ9PFfe5IDjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B28F1107ACCA;
 Fri, 24 Apr 2020 13:46:28 +0000 (UTC)
Received: from localhost (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51908610EC;
 Fri, 24 Apr 2020 13:46:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/041: Fix NBD socket path
Date: Fri, 24 Apr 2020 15:46:26 +0200
Message-Id: <20200424134626.78945-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should put all UNIX socket files into the sock_dir, not test_dir.

Reported-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 5d67bf14bf..46bf1f6c81 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -35,7 +35,7 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quorum3.i=
mg')
 quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.img')
 quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snapshot.i=
mg')
=20
-nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
+nbd_sock_path =3D os.path.join(iotests.sock_dir, 'nbd.sock')
=20
 class TestSingleDrive(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
--=20
2.25.3


