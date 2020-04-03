Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5504C2BA15
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C4B207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQ+LJSZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C4B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQEP-0006Hf-5S
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ90-0008VQ-AU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8z-000776-7I
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8z-00076X-4A
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585935012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwMbTnwhfzMiAiyZnYW7hK9aHLKsKW++Ddp5/XMkP9c=;
 b=CQ+LJSZHyPOl8Nx5V0nHbSVTB/hLcSPCRclWrEINLnGKUURYG/bOjQtqcQtVmYRG2h4h5p
 pZB8hURK1+2+1JoFVhsTA/Wus6xNfzgA3i7OWcqpg+YZXFcW37wRUQqfmWSJPd7elMwEli
 ZkiYBAts01PNCl0qWiKD6mYLWuXgrh0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-rB-JvtDQNXOG0zEAUIO_Sw-1; Fri, 03 Apr 2020 13:30:07 -0400
X-MC-Unique: rB-JvtDQNXOG0zEAUIO_Sw-1
Received: by mail-wr1-f71.google.com with SMTP id 91so2581262wro.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hVonjlCXyDYttqsQIZZbl5+zpGGdnL6FgePB/Kdk6NI=;
 b=KGDqzwuHzaLtOmELLu9ns89BtEfbZvzz+HGLUZVeJqexGcMwt5BpE3CIGsagAQSXkg
 SsaloneKqsza1iMr8fohVAY/IFUuhKcvZUs/zUpVXloXQY62oy9CCbhrQYDwoaHg644w
 jTGQOvQMCTJ+PfPQ2PHs6T3sjIgFyxI33ciGfHJa5MYQbtnbhyIsMAjC8z3UCW+HdNqb
 H1IU321kA9nfFkOKfycEXN/G4YIq07SVx0UwbDWvPYCX0ox2xnH/S4Vh/CguMFPY0A6P
 ug1Tc7xscJWsNjHKsWBfSVSbqIp3M5hp49otE+m9TBZVScbzqGmR1hSuZNm6tscJeSog
 XzUA==
X-Gm-Message-State: AGi0PuY+4CCYQOboAW1hXf4kYaht4NfS6SYe6vqQWtCaJhwl2z0yGIf3
 PwgSm8SHBhiw5csvuibg7XYfpPq1xXD1f8cVCo9DNWE+VEgASX47spl2A7esqOaO7EpnzfNk663
 /ZX03MYvZXCyLz4Y=
X-Received: by 2002:adf:8b8e:: with SMTP id o14mr4422882wra.392.1585935006088; 
 Fri, 03 Apr 2020 10:30:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLm2kFvkjL5Hl7KTEoMcZJZN2Xp2XBQp6Qc0X84c3AEp8uHZk2cUxG08ulwcqLE013l2nUJbQ==
X-Received: by 2002:adf:8b8e:: with SMTP id o14mr4422863wra.392.1585935005925; 
 Fri, 03 Apr 2020 10:30:05 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id e5sm13109459wru.92.2020.04.03.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:30:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 7/8] .travis.yml: Run fetch-acceptance-assets before
 check-acceptance
Date: Fri,  3 Apr 2020 19:29:18 +0200
Message-Id: <20200403172919.24621-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 2fd63eceaa..c6b32da447 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -317,7 +317,7 @@ jobs:
       dist: bionic
       env:
         - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha-s=
oftmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-so=
ftmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sp=
arc-softmmu,x86_64-softmmu,xtensa-softmmu"
-        - TEST_CMD=3D"make check-acceptance"
+        - TEST_CMD=3D"travis_retry make -j1 fetch-acceptance-assets check-=
acceptance DEBUG=3D1"
         - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
       after_script:
         - python3 -c 'import json; r =3D json.load(open("tests/results/lat=
est/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"=
] not in ("PASS", "SKIP")]' | xargs cat
--=20
2.21.1


