Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2700EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6FC20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+qowDjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6FC20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc4N-00025s-06
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVc3P-0000sV-Va
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:26:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33933
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVc3M-0005Ei-Es
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6KssWYDWKmX2bACLCXDvYL5R7uQ9ktgUSddYGO3LWEc=;
 b=Y+qowDjs1g+uX24UWLWMrguxiTU7atOcGFLwsPRxcE4pC47l7YxTi3LJPCFq3GD3x30r1B
 +pHQ29wGFIaVasf9j6tKx3S/JcRpZVyFN3VTnl9GL4eP9CG8FU1gPDUD7KnK9H30EmOxbd
 oigt90dbyPY3ouYawuvUXafp+Yn+znE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-fTbOWmVPNkGaWeOGmNxZ1Q-1; Mon, 04 May 2020 10:26:34 -0400
X-MC-Unique: fTbOWmVPNkGaWeOGmNxZ1Q-1
Received: by mail-wr1-f72.google.com with SMTP id g10so2082822wrr.10
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xuMjaNYxipgB8albhPc6Ph80ZynRbvJlRqsT2hfDicc=;
 b=a2WCnTEkr3qdV1WmZ93KO6oBD9CQC/gEYj1bOJis7UaMMT46kO2wX15w/WwIz6SRzC
 l4EEP4ZbJAkL1+BKJdZF8jv0gWojFjEnh1IswEyUqLS3ES03aMhdhL2KbE6zPTFfSlOM
 RSUGF6d+u392cEy7JkvpxiwTR1KRYlDzN5rW9zB8wXcgp+KSRin6rZTIjkLeAbgZqXhb
 x7dnkjIpfGGxkLzM3Zv7Z1MsvpAs5RFfyfW5ydHtmAGT81v3t37osbhXK3QNC+BQQViu
 5UcO/T/wDr939wIKOuAbMp8JZdrg04mUDknzN+fUocM7PKLAqgxHnLH39HhTmoRExCtj
 rmFg==
X-Gm-Message-State: AGi0PuYscR1v/H5BsBZH1E+Syq9ciVMfENyim28ERVvCBYXiGgB7aOfM
 ajZY7GkprPVYzPa63uCX00MOcYUdtqUn0EYajWFS+HwTNnXOqmeesVnD5Jg1fj2E1pZMCfvhssa
 d3KZrR9ncjad5dTw=
X-Received: by 2002:a5d:650b:: with SMTP id x11mr19094441wru.405.1588602393117; 
 Mon, 04 May 2020 07:26:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVO+8+jDCxGemtvWiUST40IreBT7h+uUr5YMU2tz1NUVpt2k0Ua08mhJG5n6zjqJbnEvUJKg==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr19094362wru.405.1588602392066; 
 Mon, 04 May 2020 07:26:32 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id s18sm20559545wra.94.2020.05.04.07.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:26:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qht-bench: Fix Clang 'int-conversion' warning
Date: Mon,  4 May 2020 16:26:30 +0200
Message-Id: <20200504142630.12842-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When building with Clang 10 on Fedora 32, we get:

  tests/qht-bench.c:287:29: error: implicit conversion from 'unsigned long'=
 to 'double' changes value from 18446744073709551615 to 1844674407370955161=
6 [-Werror,-Wimplicit-int-float-conversion]
          *threshold =3D rate * UINT64_MAX;
                            ~ ^~~~~~~~~~
  /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
  # define UINT64_MAX             (__UINT64_C(18446744073709551615))
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /usr/include/stdint.h:107:25: note: expanded from macro '__UINT64_C'
  #  define __UINT64_C(c) c ## UL
                          ^~~~~~~
  <scratch space>:14:1: note: expanded from here
  18446744073709551615UL
  ^~~~~~~~~~~~~~~~~~~~~~

Fix by using nextafter() from <math.h>:

  float nextafterf( float from, float to );

      Returns the next representable value of 'from'
      in the direction of 'to'.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Emilio G. Cota <cota@braap.org>
Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qht-bench.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index e3b512f26f..f93f8e0fe2 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -10,6 +10,7 @@
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
 #include "qemu/xxhash.h"
+#include <math.h>
=20
 struct thread_stats {
     size_t rd;
@@ -284,7 +285,7 @@ static void do_threshold(double rate, uint64_t *thresho=
ld)
     if (rate =3D=3D 1.0) {
         *threshold =3D UINT64_MAX;
     } else {
-        *threshold =3D rate * UINT64_MAX;
+        *threshold =3D rate * nextafterf(0x1p64, 0.0);
     }
 }
=20
--=20
2.21.3


