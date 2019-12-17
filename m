Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80901C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4960220733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnsJfw10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4960220733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5hY-00058l-3z
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5D8-000324-95
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5D7-0003MW-2k
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:15:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5D6-0003LD-Vm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXjHJ/nHmfAHIatMjaNdnTAvIONIZN05s8S26P3Z/mo=;
 b=ZnsJfw10RQn44VAjOmihnWacJ3w1p8P+phYGXVD+28QlwwOXSfvgY2CjlSad6APfpdW1Fx
 t1sfB7ivwd5VIUfDh66CeW8PsAQhkqyVeJFPJh7GFT1RmnyTwgLv2U2cj8fs38DHzWpyXv
 2iNzklFdlMkXIcFH01GRO9leHACb70A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-n2n22fOBN5eOqTM-Hs74IA-1; Tue, 17 Dec 2019 00:15:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4554A189CD01;
 Tue, 17 Dec 2019 05:15:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4194819C4F;
 Tue, 17 Dec 2019 05:15:42 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/15] analyze-migration.py: fix find() type error
Date: Tue, 17 Dec 2019 00:15:09 -0500
Message-Id: <20191217051521.1239-4-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: n2n22fOBN5eOqTM-Hs74IA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Traceback (most recent call last):
  File "../scripts/analyze-migration.py", line 611, in <module>
    dump.read(desc_only =3D True)
  File "../scripts/analyze-migration.py", line 513, in read
    self.load_vmsd_json(file)
  File "../scripts/analyze-migration.py", line 556, in load_vmsd_json
    vmsd_json =3D file.read_migration_debug_json()
  File "../scripts/analyze-migration.py", line 89, in read_migration_debug_=
json
    nulpos =3D data.rfind("\0")
TypeError: argument should be integer or bytes-like object, not 'str'

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191127101038.327080-2-marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/analyze-migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index e527eb168e..2b835d9b70 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -86,8 +86,8 @@ class MigrationFile(object):
=20
         # Find the last NULL byte, then the first brace after that. This s=
hould
         # be the beginning of our JSON data.
-        nulpos =3D data.rfind("\0")
-        jsonpos =3D data.find("{", nulpos)
+        nulpos =3D data.rfind(b'\0')
+        jsonpos =3D data.find(b'{', nulpos)
=20
         # Check backwards from there and see whether we guessed right
         self.file.seek(datapos + jsonpos - 5, 0)
--=20
2.21.0


