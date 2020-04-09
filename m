Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D39C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D637206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqKbhUy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D637206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMcW1-0004ET-CK
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 15:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMcVQ-0003ot-N8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMcVO-0004zG-V7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:06:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37090
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMcVO-0004yu-Rt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586459185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RtwQBAbTW7BWKvrSIJQ7+1pntJJwuL8RjCFmlk7YZag=;
 b=CqKbhUy5VfdnW7Jgjek/vR7sOjvNAWk3kmb/IRkaUh6H0oZFE84GO0Fj6gbhvDRX7LiGeQ
 4E9CIRT/UyUlxLDbuWXUNj0QXnf4Co6uRxQlBNzf96q97YVhsIy9QgRp5oj81u7EbdO56l
 3t49t7UDhaxAw3uF4BjEzQRIZlgXNHs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-IRFmSOGaNhq1uZ2FnHJxag-1; Thu, 09 Apr 2020 15:06:22 -0400
X-MC-Unique: IRFmSOGaNhq1uZ2FnHJxag-1
Received: by mail-wm1-f71.google.com with SMTP id f9so506449wme.7
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 12:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sdQBmgEPqZ+soXjb8a3HCcVvzi2W+whd++8qhuX2MMI=;
 b=mfLUykWN91m3xgoDKOO8dz/zUpYRg19cXOO3l0twG4FAmTeI5BATxU40E6FlGu5doW
 A+GuqmDECRIAQY38EpkZ/noAK0GCmBq2IIpds4vCDGPFjMjSf6mTNenS8aCvat5nR1VX
 STDSKzWhcjIDJdvzNNyEuGPWQfdIu0Enfvu5mciZ68OsJjJ/CCgCNg+7wDhRD6PYgrQ/
 eOoLHgqIjUSTlBbndegGMGcbTRCNlctbjp088bE1fKa+cKvvxN+Pz2RWqzKbjH/BagvF
 tg2WuqS4fVd1uhHmL5IhiMf/+cy+uoc4Rgphog/+slhOPGLOKt6zrQ8gCa1Ldh7ah3s4
 6UiQ==
X-Gm-Message-State: AGi0PubRab4x/ziF/aLcFFwKKcyEu16rGHZgz3MNasyZ+HRjBsOtarPq
 ovM2KK39hyWCgd8F0HI0hb0kxrGk2zh4LF5G7FIbTrsrc4b7zp0qa0yVVbkrzhB9kZSyE5GPS/Q
 rGdV9LzGyYN5DS9k=
X-Received: by 2002:adf:f9cc:: with SMTP id w12mr667797wrr.148.1586459181520; 
 Thu, 09 Apr 2020 12:06:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKSd7QaL4s4qogqdcKPhPzOmc2frmhUtkSWYop+uvtKJRjpzMo4bYD/vCmKvgi2OrujG15Msw==
X-Received: by 2002:adf:f9cc:: with SMTP id w12mr667768wrr.148.1586459181226; 
 Thu, 09 Apr 2020 12:06:21 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i8sm44168458wrb.41.2020.04.09.12.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 12:06:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] .travis.yml: Build OSX 10.14 with Xcode 10.0
Date: Thu,  9 Apr 2020 21:06:18 +0200
Message-Id: <20200409190618.7402-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Travis recently made a change which generates various warnings
such [*]:

    CC      utils.o
  In file included from cs.c:11:
  In file included from /Library/Developer/CommandLineTools/SDKs/MacOSX10.1=
4.sdk/usr/include/stdio.h:64:
  /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_std=
io.h:93:16: warning: pointer is missing a nullability type specifier (_Nonn=
ull, _Nullable, or _Null_unspecified) [-Wnullability-completeness]
          unsigned char   *_base;
                          ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_std=
io.h:93:16: note: insert '_Nullable' if the pointer may be null
          unsigned char   *_base;
                          ^
                            _Nullable

We only aim to support MacOS 10.14 and 10.15. 10.14 comes with
Xcode 10.0. These warnings are not emitted with this Xcode version,
so switch back to it.

[*] https://travis-ci.org/github/qemu/qemu/jobs/673000302#L1387

Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 2fd63eceaa..7c92206ea3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -272,12 +272,12 @@ jobs:
=20
     # MacOSX builds - cirrus.yml also tests some MacOS builds including la=
test Xcode
=20
-    - name: "OSX Xcode 10.3"
+    - name: "OSX 10.14 (Xcode 10.0)"
       env:
         - BASE_CONFIG=3D"--disable-docs --enable-tools"
         - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softmmu=
,m68k-softmmu,x86_64-softmmu"
       os: osx
-      osx_image: xcode10.3
+      osx_image: xcode10
       compiler: clang
       addons:
         homebrew:
--=20
2.21.1


