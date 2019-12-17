Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B68C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E08A2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKcSwiHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E08A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5t8-0002VL-Q0
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5Db-0003on-Rf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5Da-0003uU-Ng
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5Da-0003tN-Jc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6e9dmtG6oZZcoSJJsYBqEqR/a1t6qZG4SswHex2xLR4=;
 b=LKcSwiHWDOwvGvJrLi12glOeLTVphzQQcPhrr8DaO7I+IgpDcEOc6AcOZWaA+NKNAlNqkv
 cqxkRr+qUArq4ri/cdYtzREZOdat+PLnGEVcBBY50L16fJW/Dy+PswOFVyP6v89ZoAwLft
 2xqzdOc17p9Oq8bc7JPiymkirQXmQI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-sHlM-8mtOMey6Axmo5VTOw-1; Tue, 17 Dec 2019 00:16:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7807189CD01;
 Tue, 17 Dec 2019 05:16:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D9BC19C4F;
 Tue, 17 Dec 2019 05:16:15 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/15] Acceptance tests: introduce utility method for tags
 unique vals
Date: Tue, 17 Dec 2019 00:15:14 -0500
Message-Id: <20191217051521.1239-9-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: sHlM-8mtOMey6Axmo5VTOw-1
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently a test can describe the target architecture binary that it
should primarily be run with, be setting a single tag value.

The same approach is expected to be done with other QEMU aspects to be
tested, for instance, the machine type and accelerator, so let's
generalize the logic into a utility method.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190924194501.9303-3-crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/a=
vocado_qemu/__init__.py
index 9a57c020d8..e676d9c4e7 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -100,14 +100,21 @@ def exec_command_and_wait_for_pattern(test, command,
=20
=20
 class Test(avocado.Test):
+    def _get_unique_tag_val(self, tag_name):
+        """
+        Gets a tag value, if unique for a key
+        """
+        vals =3D self.tags.get(tag_name, [])
+        if len(vals) =3D=3D 1:
+            return vals.pop()
+        return None
+
     def setUp(self):
         self._vms =3D {}
-        arches =3D self.tags.get('arch', [])
-        if len(arches) =3D=3D 1:
-            arch =3D arches.pop()
-        else:
-            arch =3D None
-        self.arch =3D self.params.get('arch', default=3Darch)
+
+        self.arch =3D self.params.get('arch',
+                                    default=3Dself._get_unique_tag_val('ar=
ch'))
+
         default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
         self.qemu_bin =3D self.params.get('qemu_bin',
                                         default=3Ddefault_qemu_bin)
--=20
2.21.0


