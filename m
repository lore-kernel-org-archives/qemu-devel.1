Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6194620772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gsk0ADN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6194620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEIH-0006s8-IZ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJEHa-0006Q6-KD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJEHZ-0005EA-KI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:38:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJEHZ-0005Dn-H0
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585651088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/PXJdTRRANQj75wsPD9WT+3tlz+4Azw2OA3jRBkC6l8=;
 b=Gsk0ADN9rC8UcwkGiCozZ/qMAnOpAwbx0abGITCXMMX7+SM9RtaPvJ+T+fQeLV7NUO6n3a
 7GSKNt1JUPtGsjXOimgRpBq9TU9J7HpQ5nIA1n9fE8FbTuVLfPBnC3vXigtQpLy6nUQqMW
 L2blc/4rMBt65BB1nCrqM5xlgvkpizY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-gG-2o7HSM0O9AUg-9mF16g-1; Tue, 31 Mar 2020 06:38:05 -0400
X-MC-Unique: gG-2o7HSM0O9AUg-9mF16g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2E5D8018A1;
 Tue, 31 Mar 2020 10:38:03 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC1396B6C;
 Tue, 31 Mar 2020 10:37:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: warn if not using a separate build directory
Date: Tue, 31 Mar 2020 11:37:58 +0100
Message-Id: <20200331103758.370644-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running configure directly from the source directory is a build
configuration that will go away in future. It is also not currently
covered by any automated testing. Display a deprecation warning if
the user attempts to use an in-srcdir build setup, so that they are
aware that they're building QEMU in an undesirable manner.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..1ab7492ab5 100755
--- a/configure
+++ b/configure
@@ -3,6 +3,19 @@
 # qemu configure script (c) 2003 Fabrice Bellard
 #
=20
+BUILDDIR=3D$(pwd)
+SRCDIR=3D$(dirname "$0")
+
+ABS_BUILDDIR=3D$(realpath $BUILDDIR)
+ABS_SRCDIR=3D$(realpath $SRCDIR)
+
+in_srcdir=3Dno
+if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]
+then
+    in_srcdir=3Dyes
+fi
+
+
 # Unset some variables known to interfere with behavior of common tools,
 # just as autoconf does.
 CLICOLOR_FORCE=3D GREP_OPTIONS=3D
@@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
+if test "$in_srcdir" =3D "yes"; then
+    echo
+    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
+    echo
+    echo "Support for running the 'configure' script directly from the"
+    echo "source directory is deprecated and will go away in a future"
+    echo "release. In source dir builds are not covered by automated"
+    echo "testing and are liable to break without warning. Users are"
+    echo "strongly recommended to switch to a separate build directory:"
+    echo
+    echo "  $ mkdir build"
+    echo "  $ cd build"
+    echo "  $ ../configure"
+    echo "  $ make"
+    echo
+fi
+
 config_host_mak=3D"config-host.mak"
=20
 echo "# Automatically generated by configure - do not modify" >config-all-=
disas.mak
--=20
2.24.1


