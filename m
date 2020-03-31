Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536FD20774
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap1nwBxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536FD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4Ti-0007rr-9n
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jJ4Kt-00045X-Ag
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jJ4Ks-0000Ze-3e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jJ4Kr-0000YP-VO
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585612853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv6o6f8b1Q4FefHhXsxFTjQdb4skVJt1N5hqGDVXzJE=;
 b=ap1nwBxrB7pWf7/QnO04FUyitUPCSefyv7xuB1Qs3v3LKoUeG2XCaTZHhhmMijxRgLIne6
 4+UgBRv/iU5ZkmCZh1kAxbm2vWAG3wo6goQiz8cmvzCUAFJShC7iyv7pQHj9ljMZ/J+I6I
 t+ZpI4ReUNdeyldjAzt6mjQuDXti+Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-tDY3U3rfPBuBndipP1vtsA-1; Mon, 30 Mar 2020 20:00:50 -0400
X-MC-Unique: tDY3U3rfPBuBndipP1vtsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E4D11005509;
 Tue, 31 Mar 2020 00:00:49 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46ED61001B2D;
 Tue, 31 Mar 2020 00:00:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 12/14] iotest 258: use script_main
Date: Mon, 30 Mar 2020 20:00:12 -0400
Message-Id: <20200331000014.11581-13-jsnow@redhat.com>
In-Reply-To: <20200331000014.11581-1-jsnow@redhat.com>
References: <20200331000014.11581-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@redhat.com
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


