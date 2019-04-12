Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF0C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F982077C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F982077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35537 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvBj-0006Md-Tk
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:21:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6j-0002h9-0m
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEv6i-0004Va-63
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEv6h-0004VM-W2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55548C05D3F5;
	Fri, 12 Apr 2019 12:16:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-27.ams2.redhat.com
	[10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 813FF5D9CC;
	Fri, 12 Apr 2019 12:16:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 13:16:22 +0100
Message-Id: <20190412121626.19829-2-berrange@redhat.com>
In-Reply-To: <20190412121626.19829-1-berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 12 Apr 2019 12:16:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/5] linux-user: avoid string truncation
 warnings in uname field copying
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
Message-ID: <20190412121622.9OPPnHUCX4PE36Q8zYXTRxDEwbU1r6sdsUywyZRlVtE@z>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from linux-user/uname.c:20:
In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98sys_uname=E2=80=99 at linux-user/uname.c:94:3:
/usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builtin_=
strncpy=E2=80=99 output may be truncated copying 64 bytes from a string o=
f length 64 [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

We don't care where the NUL terminator in the original uname
field was. It suffices to copy the entire original field and
simply force a NUL terminator at the end of the new field.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 linux-user/uname.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/uname.c b/linux-user/uname.c
index 313b79dbad..3dff33effe 100644
--- a/linux-user/uname.c
+++ b/linux-user/uname.c
@@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
 #define COPY_UTSNAME_FIELD(dest, src) \
   do { \
       /* __NEW_UTS_LEN doesn't include terminating null */ \
-      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
+      memcpy((dest), (src), MIN(sizeof(src), __NEW_UTS_LEN));   \
       (dest)[__NEW_UTS_LEN] =3D '\0'; \
   } while (0)
=20
--=20
2.20.1


