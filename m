Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01CC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617192077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617192077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEv8l-0003sW-FM
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:18:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6l-0002he-Gd
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6k-0004WN-JR
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6k-0004W7-Cp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B016930842B5;
	Fri, 12 Apr 2019 12:16:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-27.ams2.redhat.com
	[10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E1905D9CC;
	Fri, 12 Apr 2019 12:16:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 13:16:23 +0100
Message-Id: <20190412121626.19829-3-berrange@redhat.com>
In-Reply-To: <20190412121626.19829-1-berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 12 Apr 2019 12:16:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/5] linux-user: avoid string truncation
 warnings in elf field copying
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412121623.1kmN5W3FbqQyxYDNCCJSrFAn4a6-KRbyBFdo7-XVTKE@z>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from linux-user/elfload.c:2:
In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98fill_psinfo=E2=80=99 at linux-user/elfload.c:32=
08:12,
    inlined from =E2=80=98fill_note_info=E2=80=99 at linux-user/elfload.c=
:3390:5,
    inlined from =E2=80=98elf_core_dump=E2=80=99 at linux-user/elfload.c:=
3539:9:
/usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 16 equals destination size [-Wstringop-t=
runcation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

We don't require the field to be NUL terminated, so can just
copy the lower of the string length and the target field size
using memcpy.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 linux-user/elfload.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a26021f8..caa060f7b7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3180,6 +3180,7 @@ static int fill_psinfo(struct target_elf_prpsinfo *=
psinfo, const TaskState *ts)
 {
     char *base_filename;
     unsigned int i, len;
+    size_t pathlen;
=20
     (void) memset(psinfo, 0, sizeof (*psinfo));
=20
@@ -3201,12 +3202,9 @@ static int fill_psinfo(struct target_elf_prpsinfo =
*psinfo, const TaskState *ts)
     psinfo->pr_gid =3D getgid();
=20
     base_filename =3D g_path_get_basename(ts->bprm->filename);
-    /*
-     * Using strncpy here is fine: at max-length,
-     * this field is not NUL-terminated.
-     */
-    (void) strncpy(psinfo->pr_fname, base_filename,
-                   sizeof(psinfo->pr_fname));
+    pathlen =3D strlen(base_filename) + 1;
+    pathlen =3D MIN(pathlen, sizeof(psinfo->pr_fname));
+    memcpy(psinfo->pr_fname, base_filename, pathlen);
=20
     g_free(base_filename);
     bswap_psinfo(psinfo);
--=20
2.20.1


