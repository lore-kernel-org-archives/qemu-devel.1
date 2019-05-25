Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DD6C04AB0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 09:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669402168B
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 09:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669402168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUSej-0003nq-As
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 05:07:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUSdq-0003Ra-Eg
	for qemu-devel@nongnu.org; Sat, 25 May 2019 05:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hUSdp-0002KP-Dz
	for qemu-devel@nongnu.org; Sat, 25 May 2019 05:07:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hUSdn-0002IE-4K; Sat, 25 May 2019 05:06:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E1C03082AEF;
	Sat, 25 May 2019 09:06:58 +0000 (UTC)
Received: from localhost (ovpn-116-47.ams2.redhat.com [10.36.116.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B6E560606;
	Sat, 25 May 2019 09:06:55 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Sat, 25 May 2019 10:05:59 +0100
Message-Id: <20190525090559.31914-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Sat, 25 May 2019 09:06:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] block/io_uring: use pkg-config for liburing
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
Cc: Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that liburing has pkg-config support, use it instead of hardcoding
compiler flags in QEMU's build scripts.  This way distros can customize
the location of liburing's headers and libraries without requiring
changes to QEMU.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Hi Aarushi,
This change is needed to take advantage of the pkg-config patch that
I've just sent to liburing.  It works like this:

  $ cd liburing
  $ ./configure --libdir=3D/usr/lib64 # needed on Fedora x86_64
  $ make && sudo make install

That puts liburing.pc into /usr/lib64/pkgconfig/ where QEMU's
./configure will find it:

  $ cd qemu
  $ ./configure --target-list=3Dx86_64-softmmu # it should detect liburin=
g
  $ make -j$(nproc)

Feel free to squash this patch into your patches, I don't mind if the
authorship information gets lost.  It will be easier for reviewers if
this is present from the start instead of added in a later patch.

 configure           | 12 ++++++------
 block/Makefile.objs |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 86383dc0b3..acbdf04168 100755
--- a/configure
+++ b/configure
@@ -3972,15 +3972,13 @@ fi
 # linux-io-uring probe
=20
 if test "$linux_io_uring" !=3D "no" ; then
-  cat > $TMPC <<EOF
-#include <liburing.h>
-int main(void) { io_uring_queue_init(0, NULL, 0); io_uring_submit(NULL);=
 return 0; }
-EOF
-  if compile_prog "" "-luring" ; then
+  if $pkg_config liburing; then
+    linux_io_uring_cflags=3D$($pkg_config --cflags liburing)
+    linux_io_uring_libs=3D$($pkg_config --libs liburing)
     linux_io_uring=3Dyes
   else
     if test "$linux_io_uring" =3D "yes" ; then
-      feature_not_found "linux io_uring" "Install liburing"
+      feature_not_found "linux io_uring" "Install liburing devel"
     fi
     linux_io_uring=3Dno
   fi
@@ -6884,6 +6882,8 @@ if test "$linux_aio" =3D "yes" ; then
 fi
 if test "$linux_io_uring" =3D "yes" ; then
   echo "CONFIG_LINUX_IO_URING=3Dy" >> $config_host_mak
+  echo "LINUX_IO_URING_CFLAGS=3D$linux_io_uring_cflags" >> $config_host_=
mak
+  echo "LINUX_IO_URING_LIBS=3D$linux_io_uring_libs" >> $config_host_mak
 fi
 if test "$attr" =3D "yes" ; then
   echo "CONFIG_ATTR=3Dy" >> $config_host_mak
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 262d413c6d..eed8043740 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -62,6 +62,7 @@ block-obj-$(if $(CONFIG_LZFSE),m,n) +=3D dmg-lzfse.o
 dmg-lzfse.o-libs   :=3D $(LZFSE_LIBS)
 qcow.o-libs        :=3D -lz
 linux-aio.o-libs   :=3D -laio
-io_uring.o-libs    :=3D -luring
+io_uring.o-flags   :=3D $(LINUX_IO_URING_CFLAGS)
+io_uring.o-libs    :=3D $(LINUX_IO_URING_LIBS)
 parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
 parallels.o-libs   :=3D $(LIBXML2_LIBS)
--=20
2.21.0


