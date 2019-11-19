Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA14C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EB82068F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QO19XdTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EB82068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX747-0002eB-UA
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX6za-0005Rf-34
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX6zX-0004JJ-Te
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44631
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX6zX-0004IX-Pa
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574183319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYii4P4+JrYKFNwRdLteVtAWIb9yFmCttIZd+wgqyNE=;
 b=QO19XdTl4dlrwpSqCvHTTtTlQGdgS4V/2zt248WCC/7Luc1XsZ0mvRkaSwwi0O3DPJSUGy
 75o2yfSNmAUO1A3FwYk+kTps77GiygY9wDAro9d+afg2gL1U7w44tnPNPAygstjFIGvjz0
 WnhtIOd/f2H1URyQQ+aZ5NQki2ISKt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-HQfPu86CPAqJhErcV0TuzA-1; Tue, 19 Nov 2019 12:08:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A76CD802CDD;
 Tue, 19 Nov 2019 17:08:36 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1C635E7A6;
 Tue, 19 Nov 2019 17:08:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/6] tests/test-util-filemonitor: Skip test on non-x86 Travis
 containers
Date: Tue, 19 Nov 2019 18:08:19 +0100
Message-Id: <20191119170822.45649-5-thuth@redhat.com>
In-Reply-To: <20191119170822.45649-1-thuth@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HQfPu86CPAqJhErcV0TuzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

test-util-filemonitor fails in restricted non-x86 Travis containers
since they apparently blacklisted some required system calls there.
Let's simply skip the test if we detect such an environment.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-util-filemonitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 301cd2db61..45009c69f4 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -406,10 +406,21 @@ test_file_monitor_events(void)
     char *pathdst =3D NULL;
     QFileMonitorTestData data;
     GHashTable *ids =3D g_hash_table_new(g_int64_hash, g_int64_equal);
+    char *travis_arch;
=20
     qemu_mutex_init(&data.lock);
     data.records =3D NULL;
=20
+    /*
+     * This test does not work on Travis LXD containers since some
+     * syscalls are blocked in that environment.
+     */
+    travis_arch =3D getenv("TRAVIS_ARCH");
+    if (travis_arch && !g_str_equal(travis_arch, "x86_64")) {
+        g_test_skip("Test does not work on non-x86 Travis containers.");
+        return;
+    }
+
     /*
      * The file monitor needs the main loop running in
      * order to receive events from inotify. We must
--=20
2.23.0


