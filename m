Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A1FC4332D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663CB2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 22:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc7+PZxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663CB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEhAq-0005dz-Gp
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 18:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEhA2-0004LH-Qz
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEhA1-00039w-Jk
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEhA1-00038r-F0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 18:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584570457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLKSKnxgSo1J2FOkrUOCNFK1IhXyM0yx/wAhDHC76YI=;
 b=Lc7+PZxspZqUkbr/DwyFbySs+0R/T+ZSQZTZci8OiTwY7VXVBB9XRzicAdexuMQDNz46F9
 YFrkt2UT4hWSBeEF5P58JCIze3ScxShv/xoOQvGnFBfkBSML7P+JXlNx4+ob1dkh+yCeKL
 90lqTjwTtEswhvsfb0+7voY1AhfS5Ws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-nN_OyqovM-2yKqRoY8ugmA-1; Wed, 18 Mar 2020 18:27:33 -0400
X-MC-Unique: nN_OyqovM-2yKqRoY8ugmA-1
Received: by mail-wr1-f70.google.com with SMTP id f13so10310wro.23
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 15:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YGYlQhF1VjxMs44mLMLMVzoNVAGNacvacy8kptpp5I4=;
 b=ZUZHbLOuwZ5IyG0XoGdRhFLDGswi4XK0x76mhQM8hlCA7z+CnIA/fUvgoVJC7JA25Q
 XkaGG7aTLXJZqUTjaGqgYhVJ59m7PUxtBEGsZvutd1P4pkDxXQzxbWM3rqvBPCpQfag4
 wpwhA/REOoMvRhAdbaRvBDD7lGEO+GpVdrZ82eYJyZj5XN3eCgCCV8V3LlJkQWNvFOt/
 /2Ldm6r5VfsUVK5tfhIzemQbrCuUnvKte8mAtjpJL2hQSSd5PIf4vTuqdfbM/Rm85m8x
 ffTRANxexPraMZLwZkJaAsPrCNQngaMnV29bvchELd5J+joMNVUsMLbMm6Ncu7300kT+
 QtBw==
X-Gm-Message-State: ANhLgQ05qswqyYuVIsVeGQF5R4BC2eGqVfqZPI0FYxLpNBxyHI8ARUQh
 2GzGc4pCdSPenM+Cnv/KgZVvxl2qlniRq1b120Z++SkWBBJGQrar4sgdN/GxEcsQ2DhEecYDoY5
 WzEpJKpMSD1vLVJo=
X-Received: by 2002:a1c:b7d7:: with SMTP id h206mr7594074wmf.143.1584570452340; 
 Wed, 18 Mar 2020 15:27:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuARu72X/o63dhGxENi3b8B92viKOf0t5Dod5caMT/7InquDCRqRpr9CsZdhCENiq4UOAenTQ==
X-Received: by 2002:a1c:b7d7:: with SMTP id h206mr7594050wmf.143.1584570452122; 
 Wed, 18 Mar 2020 15:27:32 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id n6sm262271wmn.13.2020.03.18.15.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2020 15:27:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 2/4] tests/test-util-sockets: Skip test on non-x86
 Travis containers
Date: Wed, 18 Mar 2020 23:27:15 +0100
Message-Id: <20200318222717.24676-3-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 216.205.24.74
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

Similarly to commit 4f370b1098, test-util-sockets fails in
restricted non-x86 Travis containers since they apparently
blacklisted some required system calls there.
Let's simply skip the test if we detect such an environment.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-util-sockets.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 5fd947c7bf..046ebec8ba 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -231,11 +231,18 @@ static void test_socket_fd_pass_num_nocli(void)
 int main(int argc, char **argv)
 {
     bool has_ipv4, has_ipv6;
+    char *travis_arch;
=20
     socket_init();
=20
     g_test_init(&argc, &argv, NULL);
=20
+    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
+    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
+        g_printerr("Test does not work on non-x86 Travis containers.");
+        goto end;
+    }
+
     /* We're creating actual IPv4/6 sockets, so we should
      * check if the host running tests actually supports
      * each protocol to avoid breaking tests on machines
--=20
2.21.1


