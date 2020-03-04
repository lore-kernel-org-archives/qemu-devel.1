Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A58AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4429520838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DetkJUTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4429520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bpA-0007Cn-GP
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9biw-0006Rx-7t
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9biv-0007fP-4E
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54616
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9biv-0007f0-1D
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583357916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv6o6f8b1Q4FefHhXsxFTjQdb4skVJt1N5hqGDVXzJE=;
 b=DetkJUTQ061pjj/V+LwqQQbF7MonpzqqWuznJ0tkqnEamRdaTuSbBUlv7tcXBCTOUpYBh8
 vUBzonFqWI4OeKRlqiWDlx5gzEDuB/GV+9pFP8TShrXTvTrvccR2TPgIpJpcnY6y3a3Ibf
 gzg2aWSDKFof2W12J5VEvQrW9EV8k90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-YVNuONhdMnyXYPkItW3rnw-1; Wed, 04 Mar 2020 16:38:33 -0500
X-MC-Unique: YVNuONhdMnyXYPkItW3rnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CF5D8017CC;
 Wed,  4 Mar 2020 21:38:32 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B92F5C1D4;
 Wed,  4 Mar 2020 21:38:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/10] iotest 258: use script_main
Date: Wed,  4 Mar 2020 16:38:16 -0500
Message-Id: <20200304213818.15341-9-jsnow@redhat.com>
In-Reply-To: <20200304213818.15341-1-jsnow@redhat.com>
References: <20200304213818.15341-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since this one is nicely factored to use a single entry point,
use script_main to run the tests.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/258 | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
index a65151dda6..e305a1502f 100755
--- a/tests/qemu-iotests/258
+++ b/tests/qemu-iotests/258
@@ -23,12 +23,6 @@ import iotests
 from iotests import log, qemu_img, qemu_io_silent, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
-# Need backing file and change-backing-file support
-iotests.script_initialize(
-    supported_fmts=3D['qcow2', 'qed'],
-    supported_platforms=3D['linux'],
-)
-
 # Returns a node for blockdev-add
 def node(node_name, path, backing=3DNone, fmt=3DNone, throttle=3DNone):
     if fmt is None:
@@ -161,4 +155,7 @@ def main():
     test_concurrent_finish(False)
=20
 if __name__ =3D=3D '__main__':
-    main()
+    # Need backing file and change-backing-file support
+    iotests.script_main(main,
+                        supported_fmts=3D['qcow2', 'qed'],
+                        supported_platforms=3D['linux'])
--=20
2.21.1


