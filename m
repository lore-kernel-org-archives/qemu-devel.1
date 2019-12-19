Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72971C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC632053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDSrq+oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC632053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx6r-0002OF-3c
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxP-0005Rt-MK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxO-0006kX-Jk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxO-0006iJ-6x
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQbKr/sniJEZGRDbZ7AH+J3gho1VvW8izxsWmwQypRw=;
 b=EDSrq+oRmjh3PxaqCzhtTMli0sIY2i9VJXOKZ2U5OPKROwWWJQh8VY/B3otdZgqB5NqALC
 vnvWwbUAANuus87//oWSaC+BQREtZ3q0CfXNwOA/SUfreQKVI7TsjQyhe1jLCwFb36pk9q
 o8+SyrVCb/YJYumYhM5aXhaaTWIvLsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-dROfp2bCMb-VP4ftyuhRUw-1; Thu, 19 Dec 2019 09:39:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 873CD7A12A;
 Thu, 19 Dec 2019 14:39:11 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0978163BB3;
 Thu, 19 Dec 2019 14:39:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 14/18] iotests: Restrict some Python tests to file
Date: Thu, 19 Dec 2019 15:38:14 +0100
Message-Id: <20191219143818.1646168-15-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dROfp2bCMb-VP4ftyuhRUw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most Python tests are restricted to the file protocol (without
explicitly saying so), but these are the ones that would break
./check -fuse -qcow2.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/206 | 1 +
 tests/qemu-iotests/242 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 5bb738bf23..b3e8c5bb96 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -24,6 +24,7 @@ import iotests
 from iotests import imgfmt
=20
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create',
diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index c176e92da6..452fbb7b80 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -25,6 +25,7 @@ from iotests import qemu_img_create, qemu_io, qemu_img_pi=
pe, \
     file_path, img_info_log, log, filter_qemu_io
=20
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_protocol(supported=3D['file'])
=20
 disk =3D file_path('disk')
 chunk =3D 256 * 1024
--=20
2.23.0


