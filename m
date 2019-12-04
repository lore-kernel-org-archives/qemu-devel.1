Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B755C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DC22084B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYtdIGws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DC22084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWv5-0000gD-BL
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icWrn-0007Pv-U0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icWrd-0000Dq-Kr
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icWrY-00005w-Vi
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oB+EOiiCttCcGlWig7+GhXmtpFmyqeMozADnXcGVpu4=;
 b=GYtdIGwsy9iaTikeSjgk+DWbq9rnX7ZSho/7K159bwC7W/bbsXunQODqy+ZfBv4lIxuCgg
 /G/XxKOQO7iARe9NRnNwgRhfmwW9JkGuH676e4MhxBiVmutbdwQdFQY3HvACpqn6x9aN4f
 QfceHoWU2oRVg8uhzXD8ll3HRMJaxRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-ja4qg2khPZyU-Tt1v8avcQ-1; Wed, 04 Dec 2019 10:46:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DA9107ACC4;
 Wed,  4 Dec 2019 15:46:40 +0000 (UTC)
Received: from thuth.com (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25925600C8;
 Wed,  4 Dec 2019 15:46:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] tests/hd-geo-test: Skip test when images can not be
 created
Date: Wed,  4 Dec 2019 16:46:15 +0100
Message-Id: <20191204154618.23560-5-thuth@redhat.com>
In-Reply-To: <20191204154618.23560-1-thuth@redhat.com>
References: <20191204154618.23560-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ja4qg2khPZyU-Tt1v8avcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-block@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In certain environments like restricted containers, we can not create
huge test images. To be able to use "make check" in such container
environments, too, let's skip the hd-geo-test instead of failing when
the test images could not be created.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/hd-geo-test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
index 7e86c5416c..a249800544 100644
--- a/tests/hd-geo-test.c
+++ b/tests/hd-geo-test.c
@@ -34,8 +34,13 @@ static char *create_test_img(int secs)
     fd =3D mkstemp(template);
     g_assert(fd >=3D 0);
     ret =3D ftruncate(fd, (off_t)secs * 512);
-    g_assert(ret =3D=3D 0);
     close(fd);
+
+    if (ret) {
+        free(template);
+        template =3D NULL;
+    }
+
     return template;
 }
=20
@@ -934,6 +939,10 @@ int main(int argc, char **argv)
     for (i =3D 0; i < backend_last; i++) {
         if (img_secs[i] >=3D 0) {
             img_file_name[i] =3D create_test_img(img_secs[i]);
+            if (!img_file_name[i]) {
+                g_test_message("Could not create test images.");
+                goto test_add_done;
+            }
         } else {
             img_file_name[i] =3D NULL;
         }
@@ -965,6 +974,7 @@ int main(int argc, char **argv)
                        "skipping hd-geo/override/* tests");
     }
=20
+test_add_done:
     ret =3D g_test_run();
=20
     for (i =3D 0; i < backend_last; i++) {
--=20
2.18.1


