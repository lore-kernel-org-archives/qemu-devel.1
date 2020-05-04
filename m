Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E6CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3453B206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abOtoXNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3453B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcgj-0001a2-D3
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcKG-00061E-3j
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:44:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcKF-0007CE-5r
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588603446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pSthITE56L2hFIEmST/HRha2R7OdLTFLBd7KQqBM514=;
 b=abOtoXNtBk9NIy9anhajpNkaX0Vk77xQ2jbA5zgB9Gglva8r3cwl1MUALdhRI7f3P4SopX
 SYQKUe3/YUpHEgi6XVZNkFPzlgJFQX1SOXmR/AQG7GG8i4lg8h4AnIIjoxYUyZ3i/ylgM8
 b34i9xBej+ZKTNP11Xuwz1I3YhmMmh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-K2G4jJL7Nn-vbrt9gDWc6w-1; Mon, 04 May 2020 10:43:55 -0400
X-MC-Unique: K2G4jJL7Nn-vbrt9gDWc6w-1
Received: by mail-wm1-f70.google.com with SMTP id 71so3610987wmb.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YlpSmQbS4jAahWSUxB8SJZeDNR28kAXnUGMyBMki4DA=;
 b=eNp/HKJ7Tgv9TIsShPEgUnjRg4WRmaC+bwbpWJY4gJHEPoxnYeKyw6lBT2GGcYyd8T
 FQ6OFmqHgQ0MrURatz6OaaDSTcBXBmemZLLjxq3dfEjYGaNUSCjhkOcoam3B0YhLFd+M
 F0JNy986RU//eIhL3O/of6bVg13A61HcthKdpWsRukHYN8WLhs3oFYWVsnXCLHzjCZ0f
 islxK9mF1d+uyYrEOIakPV7mqq2rcUUYp2ulgqyWbSqo0nL1UK+So8ouPi6O6za5rSAk
 7sYjFin0zOrPhqc9YSjXe3nk5KtMqLMejFIDU+sjadUBulNY7wCSdF+vCTsWWm5P5KBY
 2wRA==
X-Gm-Message-State: AGi0PuahyIYkvHZQk9Aw7Oz25hAH68OfIMdqeUB/434enj2T+X9q+8yf
 W3R4f0pkyL/j1DQ7o+BEfAmhIJsYo2JwP6SOKQ3QTEBc5uJfjDnfs6Ad0FWizV21SWVn+kRYWn5
 yKTUl875mLHOajcw=
X-Received: by 2002:adf:8483:: with SMTP id 3mr8129930wrg.206.1588603434238;
 Mon, 04 May 2020 07:43:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJGT6ncZPumsRLgD8w1vAfm+/WuyBFnwXfcPvfpaDjedIpziZNicGcjuwM4OKR0KihcKpmwCA==
X-Received: by 2002:adf:8483:: with SMTP id 3mr8129913wrg.206.1588603434075;
 Mon, 04 May 2020 07:43:54 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k9sm19790478wrd.17.2020.05.04.07.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:43:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] tests/qht-bench: Fix Clang 'implicit-int-float-conversion'
 warning
Date: Mon,  4 May 2020 16:43:52 +0200
Message-Id: <20200504144352.23021-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

  double nextafter( double from, double to );

      Returns the next representable value of 'from'
      in the direction of 'to'.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Supersedes: <20200504144125.22435-1-philmd@redhat.com>

Since v2: corrected patch subject
Since v1: nextafterf() -> nextafter()

Cc: Emilio G. Cota <cota@braap.org>
Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qht-bench.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index e3b512f26f..54ce1e8188 100644
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
+        *threshold =3D rate * nextafter(0x1p64, 0.0);
     }
 }
=20
--=20
2.21.3


