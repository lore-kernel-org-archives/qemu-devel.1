Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CF6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE392084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqcALcNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE392084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPyB-0000fG-67
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUPtx-0005U2-R8
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUPtw-0000Rv-3D
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUPtv-0000RT-W1
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573541023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rIq20hq5LLLQ1PoTEInTGiLiS27XjiBB63xA8xhCUmc=;
 b=YqcALcNHbnw012ipCr8FKdbSbmdCSju66FMrC6DQ1eXJPtM4vfH8dNNM9c9cDtvknKt5wv
 MYZjEuaZfm8+Y2v11wODiP/hQgv1l1XgRC+iaibSgwiVaNgqm9byRZRrwcqQImejWutIm9
 w/b9dZw6nXMUl7notyJZWOgngy5KYbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-usK_cD3JM5yUkwFdAmWkNg-1; Tue, 12 Nov 2019 01:43:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 369021852E22;
 Tue, 12 Nov 2019 06:43:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27C195DDA8;
 Tue, 12 Nov 2019 06:43:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/6] qtest: fix qtest_qmp_device_add leak
Date: Tue, 12 Nov 2019 07:43:27 +0100
Message-Id: <20191112064332.5074-2-thuth@redhat.com>
In-Reply-To: <20191112064332.5074-1-thuth@redhat.com>
References: <20191112064332.5074-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: usK_cD3JM5yUkwFdAmWkNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191107192731.17330-3-marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: b4510bb4109f5f ("tests: add qtest_qmp_device_add_qdict() helper")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3706bccd8d..91e9cb220c 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1274,6 +1274,7 @@ void qtest_qmp_device_add(QTestState *qts, const char=
 *driver, const char *id,
     qdict_put_str(args, "id", id);
=20
     qtest_qmp_device_add_qdict(qts, driver, args);
+    qobject_unref(args);
 }
=20
 static void device_deleted_cb(void *opaque, const char *name, QDict *data)
--=20
2.23.0


