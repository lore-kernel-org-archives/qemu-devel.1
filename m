Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703DC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DFA217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIcfbYee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DFA217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1E8-0002AC-RM
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS11L-00060k-E1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS11F-0003dX-D8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:45:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS11D-0003c7-FV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYd+75Vh0I232tRLHYDQp9fs9znMgSMu5CD/SE4v7qE=;
 b=iIcfbYeenKzxAvWD24OA1j+SR5CAa3+xLSPcP4CUutOaG/BTzBMNsfliRBuobxCBK6mHVh
 UdJFEqW/6DbncaJtbcu3xLkxz9NrZP31AK98VnFd4rBLAAZ+4qykplp7M4koS86RKW3aMZ
 MrLQgtfm/clUQ075oSfNi+D+DkOh0O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-nD2KBzB7MliR3hgUDDpJmw-1; Tue, 05 Nov 2019 10:45:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A72477;
 Tue,  5 Nov 2019 15:45:14 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B80F5D9CD;
 Tue,  5 Nov 2019 15:45:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] image-fuzzer: Use errors parameter of subprocess.Popen()
Date: Tue,  5 Nov 2019 16:43:31 +0100
Message-Id: <20191105154332.181417-11-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
References: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: nD2KBzB7MliR3hgUDDpJmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Instead of manually encoding stderr and stdout output, use
`errors` parameter of subprocess.Popen().  This will make
process.communicate() return unicode strings instead of bytes
objects.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191016192430.25098-11-ehabkost@redhat.com
Message-Id: <20191016192430.25098-11-ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/image-fuzzer/runner.py | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/image-fuzzer/runner.py b/tests/image-fuzzer/runner.py
index 0793234815..4ba5c79e13 100755
--- a/tests/image-fuzzer/runner.py
+++ b/tests/image-fuzzer/runner.py
@@ -79,16 +79,13 @@ def run_app(fd, q_args):
     devnull =3D open('/dev/null', 'r+')
     process =3D subprocess.Popen(q_args, stdin=3Ddevnull,
                                stdout=3Dsubprocess.PIPE,
-                               stderr=3Dsubprocess.PIPE)
+                               stderr=3Dsubprocess.PIPE,
+                               errors=3D'replace')
     try:
         out, err =3D process.communicate()
         signal.alarm(0)
-        # fd is a text file, so we need to decode the process output befor=
e
-        # writing to it.
-        # We could be simply using the `errors` parameter of subprocess.Po=
pen(),
-        # but this will be possible only after migrating to Python 3
-        fd.write(out.decode(errors=3D'replace'))
-        fd.write(err.decode(errors=3D'replace'))
+        fd.write(out)
+        fd.write(err)
         fd.flush()
         return process.returncode
=20
--=20
2.23.0


