Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E852C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD0B2084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nuzg6hxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD0B2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPzg-0001p3-Q3
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUPty-0005VB-8v
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUPtx-0000US-AC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUPtx-0000Ss-6W
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573541024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrILqC3AU3m5t+SirPvHklNkfBjrHQ8H9rbBOdAsI5E=;
 b=Nuzg6hxvuPJarOq7+p6xpBfOrjQeMeasfyRaahRzwOa20u2TS0f2Xp+jAdp0I66E9ihEF1
 CpDs+NLzuw8FWZWV2iUFDqN/GkuVDt6yLwu85ecOoKWXNlWlBEuRhMwb1LSZeZ9PLy8DmN
 CVlixwTdfI2ZH3MDhdeKoICBSGXaNLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-YYkXLsASOD6G6vK8J8B_OA-1; Tue, 12 Nov 2019 01:43:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90DA18017E0;
 Tue, 12 Nov 2019 06:43:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 854375DF2A;
 Tue, 12 Nov 2019 06:43:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/6] cpu-plug-test: fix leaks
Date: Tue, 12 Nov 2019 07:43:28 +0100
Message-Id: <20191112064332.5074-3-thuth@redhat.com>
In-Reply-To: <20191112064332.5074-1-thuth@redhat.com>
References: <20191112064332.5074-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YYkXLsASOD6G6vK8J8B_OA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191107192731.17330-4-marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: 021a007efc3 ("cpu-plug-test: fix device_add for pc/q35 machines")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/cpu-plug-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 058cef5ac1..30e514bbfb 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -99,6 +99,7 @@ static void test_plug_with_device_add(gconstpointer data)
=20
         cpu =3D qobject_to(QDict, e);
         if (qdict_haskey(cpu, "qom-path")) {
+            qobject_unref(e);
             continue;
         }
=20
@@ -107,6 +108,7 @@ static void test_plug_with_device_add(gconstpointer dat=
a)
=20
         qtest_qmp_device_add_qdict(qts, td->device_model, props);
         hotplugged++;
+        qobject_unref(e);
     }
=20
     /* make sure that there were hotplugged CPUs */
--=20
2.23.0


