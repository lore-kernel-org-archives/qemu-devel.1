Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F21C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1114A2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jChyk8lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1114A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZuIz-00012g-0x
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 05:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZuHr-0008I6-Ge
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZuHq-00007j-Hv
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:11:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iZuHq-00007A-EK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574849465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+3CrAnD3nCGAlbhEhjkPfsB9yw41Btd3/Hc6PMR26w=;
 b=jChyk8lxbBoV+M7Qb3sXU80BTqISDwZmE5TRknly9WDLb+EbIROtLr38p3CPjaT2Ena/9X
 Mcan4I4jRQOBHTxsYzlXIK8OxOM/HY5tOljh82/CYZTSNjEktA99b+hHmOEaMfgmMss2Pj
 C5E1KvYsyFsbYtehFY1puWIRSyv5gGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-sLx1ubNtPb6qw_fqg3XrZA-1; Wed, 27 Nov 2019 05:11:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AE92107ACE4
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:11:00 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640CC5C3F8;
 Wed, 27 Nov 2019 10:10:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] analyze-migration.py: fix find() type error
Date: Wed, 27 Nov 2019 14:10:37 +0400
Message-Id: <20191127101038.327080-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191127101038.327080-1-marcandre.lureau@redhat.com>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sLx1ubNtPb6qw_fqg3XrZA-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.24.0


