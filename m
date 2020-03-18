Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76792C4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF862076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiT1wVr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF862076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhAn-0005WZ-FH
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEh9x-0004Cn-7b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEh9w-0002uM-3W
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEh9w-0002tj-0Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17907eneF3pjV9XWQsxfSrtHUmlGTQuRuCUPetJ4V9Y=;
 b=iiT1wVr+q3KAKixj1dpxSSoE0t+zsnbelO9DF4w4myAET6Tvv+LAM536yLjACYsgRTcKs6
 /60sfS1Z7qsQi4mmvUyyYnPzQe6FYs+ShxdTEcdlikY8hWlctECcWr4AvmAvXCV9rVL0VO
 UnI6YcoXPNlkFxy7bg3D9rtweNuYwbk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-1yakSns0NTafyOUCrukAQQ-1; Wed, 18 Mar 2020 18:27:28 -0400
X-MC-Unique: 1yakSns0NTafyOUCrukAQQ-1
Received: by mail-ed1-f70.google.com with SMTP id y10so148507edw.23
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nyoHCB74S9lVE3tfOvwoPCIMho5tsPWrhsK8fjVRoww=;
 b=U2YkUrIL0sG2E6K639ClZgg2WNuZ/tHzeY1qCnqM/nfo69juxAe06r3s5TdVMsfzEi
 j6fFdqjwzd5+7GCtd15wCS7MCM68R13Vbb7/1emDvMfjI3kaCpU+iPmJpgai8VbSZbUn
 VfnZw1NhHxq4E8P/u/Mdw2ZlYz5QjXBRx2FRcyd5k1Uc2ulWtCTS2rf5e01jvVYxY2wQ
 B/r09W/6wyuWcm5h7xBLJMITBcg7rY0ItXmQMrzmqkv8gsJ+TL2mJ0lPOT0arlOCKxFu
 BVdZA9plm4VFEiO/QJoiWAt6x8EYWkYibccjr/oLF9sGnAjmJXuNXMLxf6WvJuC9tGx8
 v9sA==
X-Gm-Message-State: ANhLgQ0DEPjPeO19nSdfhLMXomvGyW5vzmvxV/DG6zIbyGH49kq0YQlZ
 Xma0YJ2v2fKcolSdYCLbNw3iBy6lXhfi141FWeJ6OVlnJUeDSbzt655/S02JhLUu530FOBjjyIt
 NBhrF7nNp72wjHzU=
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr6257471edx.111.1584570446638; 
 Wed, 18 Mar 2020 15:27:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vssjZfXtF54JiJR1r5tC3R50gXaZMjBDJqtY2pAkKpDfVTKOFkXV0rXPEkaRDNtMAnyMUFrgA==
X-Received: by 2002:a05:6402:543:: with SMTP id
 i3mr6257449edx.111.1584570446439; 
 Wed, 18 Mar 2020 15:27:26 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id u20sm17788ejx.80.2020.03.18.15.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:27:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 1/4] tests/test-util-filemonitor: Fix Travis-CI
 $ARCH env variable name
Date: Wed, 18 Mar 2020 23:27:14 +0100
Message-Id: <20200318222717.24676-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318222717.24676-1-philmd@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we can find reference of a 'TRAVIS_ARCH' variable in
the environment and source [1], per the Travis-CI multi-arch
documentation [2] the variable is named TRAVIS_CPU_ARCH.

[1] https://github.com/travis-ci/travis-build/blob/v10.0.0/lib/travis/build=
/bash/travis_setup_env.bash#L39
[2] https://docs.travis-ci.com/user/multi-cpu-architectures/#identifying-cp=
u-architecture-of-build-jobs

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-util-filemonitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 45009c69f4..e703a7f8fc 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -415,7 +415,7 @@ test_file_monitor_events(void)
      * This test does not work on Travis LXD containers since some
      * syscalls are blocked in that environment.
      */
-    travis_arch =3D getenv("TRAVIS_ARCH");
+    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
     if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
         g_test_skip("Test does not work on non-x86 Travis containers.");
         return;
--=20
2.21.1


