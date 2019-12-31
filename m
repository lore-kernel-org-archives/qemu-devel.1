Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C6C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E93E206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjeLYMLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E93E206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imMar-0001gk-9L
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 13:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imMa9-0001Fg-Kx
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imMa6-00078v-E7
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:49:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51992
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imMa6-00073e-99
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 13:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577818164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=POmL33/BVPwiPeFiPmC0S/0zQOg9aytUDVV2QlPQPZY=;
 b=CjeLYMLRnpYfsTCTnHPfHfsGtSTiZFZP276yGu9Xn7FlFftF4aA81GHtynXsKgi169L1bt
 bSXLwCDMhoMXk5ZVvlm+m+/UEuMFbI/eJ2LQpu4KMOoTj3mqqzoy+7odzaamkMgG9OVAVa
 TzV8meqorE/JcsyWiCn6mtpKLbkKZcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-MV486kfkPbO8Zwjm1O5GVA-1; Tue, 31 Dec 2019 13:49:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A7610054E3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 18:49:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD16010001BD;
 Tue, 31 Dec 2019 18:49:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] qapi: Incorrect attempt to fix building with MC146818RTC=n
Date: Tue, 31 Dec 2019 19:49:16 +0100
Message-Id: <20191231184916.10235-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: MV486kfkPbO8Zwjm1O5GVA-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When configured with --without-default-devices and setting
MC146818RTC=3Dn, the build fails:

    LINK    x86_64-softmmu/qemu-system-x86_64
  /usr/bin/ld: qapi/qapi-commands-misc-target.o: in function `qmp_marshal_r=
tc_reset_reinjection':
  qapi/qapi-commands-misc-target.c:46: undefined reference to `qmp_rtc_rese=
t_reinjection'
  /usr/bin/ld: qapi/qapi-commands-misc-target.c:46: undefined reference to =
`qmp_rtc_reset_reinjection'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
  make: *** [Makefile:483: x86_64-softmmu/all] Error 2

This patch tries to fix this, but this is incorrect because QAPI
scripts only provide TARGET definitions, so with MC146818RTC=3Dy we
get:

  hw/rtc/mc146818rtc.c:113:6: error: no previous prototype for =E2=80=98qmp=
_rtc_reset_reinjection=E2=80=99 [-Werror=3Dmissing-prototypes]
    113 | void qmp_rtc_reset_reinjection(Error **errp)
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make[1]: *** [rules.mak:69: hw/rtc/mc146818rtc.o] Error 1

Any idea? :)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/misc-target.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index a00fd821eb..8e49c113d1 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -41,7 +41,7 @@
 #
 ##
 { 'command': 'rtc-reset-reinjection',
-  'if': 'defined(TARGET_I386)' }
+  'if': 'defined(TARGET_I386) && defined(CONFIG_MC146818RTC)' }
=20
=20
 ##
--=20
2.21.0


