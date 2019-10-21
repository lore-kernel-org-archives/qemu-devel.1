Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A609CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049182084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mtb7Ypmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049182084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMfUF-0008Ct-65
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iMfSv-0007h0-2U
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iMfSu-0003yJ-58
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:43:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iMfSu-0003yD-27
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571694227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q+Nx2C88Wh27y9fAFoQWqvREh2MN8i0sIAWasA8cMu4=;
 b=Mtb7Ypmof/tLxBJxlAXpfHSWwm8o8R2wZfKDBKqCdxJ5KwrUgPTZohyhwuIRw/cdnYpQyw
 r7tIrxcX0h76svP0f4mpte5nZ72zaKTJ+sw5/NuyswEGHuF7p04ooijWWudk5Szk3ZAYkA
 VqS7FOuP8KiC80NqVmTp+0WXV5Hk8ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-uTGHIcO6M1WX0wAh-MQFDw-1; Mon, 21 Oct 2019 17:43:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079401800D79;
 Mon, 21 Oct 2019 21:43:43 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1F119C4F;
 Mon, 21 Oct 2019 21:43:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] image-fuzzer: Use OSerror.strerror instead of tuple subscript
Date: Mon, 21 Oct 2019 18:41:17 -0300
Message-Id: <20191021214117.18091-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uTGHIcO6M1WX0wAh-MQFDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OSError can't be used like a tuple on Python 3, so change the
code to use `e.sterror` instead of `e[1]`.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/image-fuzzer/runner.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 95d84f38f3..1eb2138f94 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -159,7 +159,7 @@ class TestEnv(object):
             os.makedirs(self.current_dir)
         except OSError as e:
             print("Error: The working directory '%s' cannot be used. Reaso=
n: %s"\
-                % (self.work_dir, e[1]), file=3Dsys.stderr)
+                % (self.work_dir, e.strerror), file=3Dsys.stderr)
             raise TestException
         self.log =3D open(os.path.join(self.current_dir, "test.log"), "w")
         self.parent_log =3D open(run_log, "a")
@@ -246,7 +246,7 @@ class TestEnv(object):
             except OSError as e:
                 multilog("%sError: Start of '%s' failed. Reason: %s\n\n"
                          % (test_summary, os.path.basename(current_cmd[0])=
,
-                            e[1]),
+                            e.strerror),
                          sys.stderr, self.log, self.parent_log)
                 raise TestException
=20
--=20
2.21.0


