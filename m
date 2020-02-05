Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3301AC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F086A2072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgU0k+lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRWb-0002xI-7g
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1izRUG-0008BY-1D
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1izRUF-000568-2O
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1izRUE-00055T-Ut
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580935286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OCLalSyt+BFfXkOQ9Vf9Z6EQFjhJKX1hmjYwhlz1B6Q=;
 b=CgU0k+lcaSsgniFpU/3kZtdpDmu3fvB4GplgZ5hy4FjUchwbTmsb5+ywezBDzLks2uLJU0
 BDwdQoDeHzshYgFAGqghLxbY/WWsh0angTKspPFnv/johGIel+Lvtx8fBUHWjjCf5Qx+Y3
 Wi0nHiG9VnMY+Hj2d25s1/KHRDqV7Hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-aZAnHPjUMtacEcUrs6r3Aw-1; Wed, 05 Feb 2020 15:41:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02FD8A0CBF;
 Wed,  5 Feb 2020 20:41:24 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-116-229.ams2.redhat.com
 [10.36.116.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ABB210013A1;
 Wed,  5 Feb 2020 20:41:19 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qtest: Fix rtas dependencies
Date: Wed,  5 Feb 2020 21:41:14 +0100
Message-Id: <20200205204115.555212-2-lvivier@redhat.com>
In-Reply-To: <20200205204115.555212-1-lvivier@redhat.com>
References: <20200205204115.555212-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: aZAnHPjUMtacEcUrs6r3Aw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest "rtas" command is only available with pseries not all ppc64 targets,
so if I try to compile only powernv machine, the build fails with:

  /usr/bin/ld: qtest.o: in function `qtest_process_command':
  .../qtest.c:645: undefined reference to `qtest_rtas_call'

We fix this by enabling rtas command only with pseries machine.

Fixes: eeddd59f5962 ("tests: add RTAS command in the protocol")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 qtest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qtest.c b/qtest.c
index 12432f99cf44..587dcbb4b515 100644
--- a/qtest.c
+++ b/qtest.c
@@ -27,7 +27,8 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
-#ifdef TARGET_PPC64
+#include "config-devices.h"
+#ifdef CONFIG_PSERIES
 #include "hw/ppc/spapr_rtas.h"
 #endif
=20
@@ -628,7 +629,7 @@ static void qtest_process_command(CharBackend *chr, gch=
ar **words)
 #else
         qtest_sendf(chr, "OK little\n");
 #endif
-#ifdef TARGET_PPC64
+#ifdef CONFIG_PSERIES
     } else if (strcmp(words[0], "rtas") =3D=3D 0) {
         uint64_t res, args, ret;
         unsigned long nargs, nret;
--=20
2.24.1


