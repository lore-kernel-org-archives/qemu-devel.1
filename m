Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA795C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8168D206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8168D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsGd-0004GS-LE
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hxsC4-0000FF-Q9
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxsC3-0001gt-Ae
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hxsBr-0001cK-1T; Wed, 14 Aug 2019 08:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FD2D300BEA8;
 Wed, 14 Aug 2019 12:15:41 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-203.brq.redhat.com [10.40.204.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9EFB83093;
 Wed, 14 Aug 2019 12:15:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Richard W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Pino Toscano <ptoscano@redhat.com>
Date: Wed, 14 Aug 2019 14:15:24 +0200
Message-Id: <20190814121527.17876-2-philmd@redhat.com>
In-Reply-To: <20190814121527.17876-1-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 14 Aug 2019 12:15:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 1/4] configure: Improve libssh check
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?=E5=91=A8=E6=96=87=E9=9D=92?= <1151451036@qq.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The libssh pkg-config is not complete, the libraries required to
link with libssh are not returned. For example on Ubuntu 18.04:

  $ dpkg -l|fgrep libssh
  ii libssh-4:arm64 0.8.0~20170825.94fa1e38-1ubuntu0.2 arm64 tiny C SSH l=
ibrary (OpenSSL flavor)
  ii libssh-dev 0.8.0~20170825.94fa1e38-1ubuntu0.2 arm64 tiny C SSH libra=
ry. Development files (OpenSSL flavor)

  $ pkg-config libssh --libs
  -lssh

Since the ./configure script tries to link an object to figure if
libssh is available, it fails:

  $ cat  config.log
  [...]
  cc -pthread -I/usr/include/glib-2.0 [...] -o config-temp/qemu-conf.exe =
config-temp/qemu-conf.c -m64 -static -g -lssh
  /usr/lib/gcc/x86_64-linux-gnu/7/../../../x86_64-linux-gnu/libssh.a(dh.c=
.o): In function `ssh_crypto_init':
  (.text+0x1a9): undefined reference to `BN_new'
  (.text+0x1c2): undefined reference to `BN_set_word'
  (.text+0x1c7): undefined reference to `BN_new'
  (.text+0x1e7): undefined reference to `BN_bin2bn'
  (.text+0x1ec): undefined reference to `BN_new'
  (.text+0x20c): undefined reference to `BN_bin2bn'
  (.text+0x218): undefined reference to `OPENSSL_init_crypto'
  [...]
  collect2: error: ld returned 1 exit status

To bypass this check, simply compile an object using libssh headers.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Should we check for libcrypto?

$ pkg-config --libs libssh openssl
-lssh -lssl -lcrypto
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 714e7fb6a1..1d5c07de1f 100755
--- a/configure
+++ b/configure
@@ -3951,7 +3951,7 @@ if test "$libssh" =3D "yes"; then
 #include <libssh/libssh.h>
 int main(void) { return ssh_get_server_publickey(NULL, NULL); }
 EOF
-  if compile_prog "$libssh_cflags" "$libssh_libs"; then
+  if compile_object "$libssh_cflags"; then
     libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
   fi
 fi
--=20
2.20.1


