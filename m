Received: from eggs.gnu.org ([2001:4830:134:3::10]:35450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejozJ-0006fi-PW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ejozH-0005K9-DN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ejozH-0005Jz-93
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E238B79D40
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 16:23:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  8 Feb 2018 17:23:43 +0100
Message-Id: <20180208162343.30809-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180208162343.30809-1-marcandre.lureau@redhat.com>
References: <20180208162343.30809-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] build-sys: enable sanitizers by default
 with --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The original commit 247724cb302af5d70c8853154b640dfabf2bbb56 was meant
to enable sanitizers by default when --enable-debug, but failed
because of a gcc static linking bug. Try to enable it back now that
there is a stronger check.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index beb0de6a77..700ff35383 100755
--- a/configure
+++ b/configure
@@ -355,7 +355,7 @@ rdma=3D""
 gprof=3D"no"
 debug_tcg=3D"no"
 debug=3D"no"
-sanitizers=3D"no"
+sanitizers=3D""
 fortify_source=3D""
 strip_opt=3D"yes"
 tcg_interpreter=3D"no"
@@ -5262,6 +5262,11 @@ have_ubsan=3Dno
 have_asan_iface_h=3Dno
 have_asan_iface_fiber=3Dno
=20
+# enable sanitizers by default if --enable-debug
+if test "$sanitizers" =3D "" -a "$debug" =3D "yes"; then
+  sanitizers=3Dyes
+fi
+
 if test "$sanitizers" =3D "yes" ; then
   if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
       have_asan=3Dyes
--=20
2.16.1.73.g5832b7e9f2
