Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A916C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC8C20866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC8C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqcO-0008FE-6H
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:53:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLqZZ-0006ZS-Ts
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLqZW-0003ns-LH
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hLqZW-0003n1-Cg
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:50:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 250B1C0467E4
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 14:50:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-28.ams2.redhat.com
	[10.36.112.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E93E10018E0;
	Wed,  1 May 2019 14:50:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 15:50:52 +0100
Message-Id: <20190501145052.12579-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 01 May 2019 14:50:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] sockets: avoid string truncation warnings
 when copying UNIX path
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501145052._T3pF1jhNmB7Pv63oZWEbxXENip5ScyT_RlFSgoQvnE@z>

In file included from /usr/include/string.h:494,
                 from include/qemu/osdep.h:101,
                 from util/qemu-sockets.c:18:
In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/qemu=
-sockets.c:925:5:
/usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 108 equals destination size [-Wstringop-=
truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qemu-=
sockets.c:880:5:
/usr/include/bits/string_fortified.h:106:10: warning: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 108 equals destination size [-Wstringop-=
truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We are already validating the UNIX socket path length earlier in
the functions. If we save this string length when we first check
it, then we can simply use memcpy instead of strcpy later, avoiding
the gcc truncation warnings.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 util/qemu-sockets.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 9705051690..ba6335e71a 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -830,6 +830,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr=
,
     int sock, fd;
     char *pathbuf =3D NULL;
     const char *path;
+    size_t pathlen;
=20
     sock =3D qemu_socket(PF_UNIX, SOCK_STREAM, 0);
     if (sock < 0) {
@@ -845,7 +846,8 @@ static int unix_listen_saddr(UnixSocketAddress *saddr=
,
         path =3D pathbuf =3D g_strdup_printf("%s/qemu-socket-XXXXXX", tm=
pdir);
     }
=20
-    if (strlen(path) > sizeof(un.sun_path)) {
+    pathlen =3D strlen(path);
+    if (pathlen > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
                           sizeof(un.sun_path));
@@ -877,7 +879,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr=
,
=20
     memset(&un, 0, sizeof(un));
     un.sun_family =3D AF_UNIX;
-    strncpy(un.sun_path, path, sizeof(un.sun_path));
+    memcpy(un.sun_path, path, pathlen);
=20
     if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
         error_setg_errno(errp, errno, "Failed to bind socket to %s", pat=
h);
@@ -901,6 +903,7 @@ static int unix_connect_saddr(UnixSocketAddress *sadd=
r, Error **errp)
 {
     struct sockaddr_un un;
     int sock, rc;
+    size_t pathlen;
=20
     if (saddr->path =3D=3D NULL) {
         error_setg(errp, "unix connect: no path specified");
@@ -913,7 +916,8 @@ static int unix_connect_saddr(UnixSocketAddress *sadd=
r, Error **errp)
         return -1;
     }
=20
-    if (strlen(saddr->path) > sizeof(un.sun_path)) {
+    pathlen =3D strlen(saddr->path);
+    if (pathlen > sizeof(un.sun_path)) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->pat=
h);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
                           sizeof(un.sun_path));
@@ -922,7 +926,7 @@ static int unix_connect_saddr(UnixSocketAddress *sadd=
r, Error **errp)
=20
     memset(&un, 0, sizeof(un));
     un.sun_family =3D AF_UNIX;
-    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
+    memcpy(un.sun_path, saddr->path, pathlen);
=20
     /* connect to peer */
     do {
--=20
2.21.0


