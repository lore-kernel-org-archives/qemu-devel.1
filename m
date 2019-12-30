Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B34C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45E520722
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 18:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2cW/MRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45E520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1im02H-00014W-3Z
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 13:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1im010-0008T2-0q
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1im00y-0007gP-Kg
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51186
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1im00y-0007fa-H9
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 13:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577731419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USzUYj0L9wnNf0dJoiZ13++LmbCeGGEzFD+mt4bduvM=;
 b=Y2cW/MRXPyXIpsMSj+ekl7L1JGlUIl8Brjp92v1XVay7/tn2NiyXMtXy84D818OWLAs9in
 RqG5rT8hi7NrrZrhfavnwa2Bal7YDcf1HWBzWPM9bdg04NawXcCKV0oAZ3tOmN3WKsu/Os
 LmX78WqjipPwx8iWWAMJuZK+SD7kWwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-F1GjuvjBPVWu07BYI2vk6A-1; Mon, 30 Dec 2019 13:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7087800EBF;
 Mon, 30 Dec 2019 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 363DA60579;
 Mon, 30 Dec 2019 18:43:34 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] travis.yml: avocado: Print logs of non-pass tests only
Date: Mon, 30 Dec 2019 15:43:26 -0300
Message-Id: <20191230184327.2800-2-wainersm@redhat.com>
In-Reply-To: <20191230184327.2800-1-wainersm@redhat.com>
References: <20191230184327.2800-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: F1GjuvjBPVWu07BYI2vk6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The acceptance tests build on Travis is configured to print
the entire Avocado's job log in case any test fail. Usually one is
interested on failed tests only though. So this change the Travis
configuration in order to show the log of tests which status is
different from 'PASS' and 'SKIP' only. Note that 'CANCEL'-ed tests
will have the log printed too because it can help to debug some
condition on CI environment which is not being fulfilled.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 376b7d6dfa..e7fdcb238c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -262,8 +262,8 @@ matrix:
     - env:
         - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-sof=
tmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmm=
u,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD=3D"make check-acceptance"
-      after_failure:
-        - cat tests/results/latest/job.log
+      after_script:
+        - python3 -c 'import json; r =3D json.load(open("tests/results/lat=
est/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"=
] not in ("PASS", "SKIP")]' | xargs cat
       addons:
         apt:
           packages:
--=20
2.23.0


