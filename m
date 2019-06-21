Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A115C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FCB2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FCB2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJHj-00073u-Nb
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1heJFa-0005kM-9F
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1heJFX-0006ky-7A
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:06:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1heJFX-000678-2U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD05D3079B83;
 Fri, 21 Jun 2019 13:05:52 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-117-58.ams2.redhat.com [10.36.117.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE0D75C21E;
 Fri, 21 Jun 2019 13:05:46 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 15:05:44 +0200
Message-Id: <20190621130544.18860-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 21 Jun 2019 13:06:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] configure: linux-user doesn't need neither fdt
 nor slirp
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

if softmmu is not enabled, we disable by default fdt and
slirp as they are only used by -softmmu targets.

A side effect is the git submodules are not cloned
if they are not needed.

Clone and build can be forced with --enable-fdt and
--enable-slirp.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 configure | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/configure b/configure
index b091b82cb371..4b3853298c79 100755
--- a/configure
+++ b/configure
@@ -4066,6 +4066,11 @@ if test "$fdt_required" =3D "yes"; then
   fdt=3Dyes
 fi
=20
+# linux-user doesn't need fdt
+if test -z "$fdt" -a "$softmmu" !=3D "yes" ; then
+    fdt=3D"no"
+fi
+
 if test "$fdt" !=3D "no" ; then
   fdt_libs=3D"-lfdt"
   # explicitly check for libfdt_env.h as it is missing in some stable in=
stalls
@@ -5923,6 +5928,11 @@ fi
 ##########################################
 # check for slirp
=20
+# linux-user doesn't need slirp
+if test -z "$slirp" -a "$softmmu" !=3D "yes" ; then
+    slirp=3D"no"
+fi
+
 case "$slirp" in
   "" | yes)
     if $pkg_config slirp; then
--=20
2.21.0


