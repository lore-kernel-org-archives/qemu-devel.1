Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4C320714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVWd24zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4C320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJCW-0005wa-E0
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJJBW-0004rK-En
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJJBV-0002F6-A4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:52:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJJBV-0002E9-3y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585669931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fp6o51YOCI0gW9Ryer3bJCxCiqL7ZljVd3anZRqlFTY=;
 b=BVWd24zNsYdFw/C3H8a2n0QAOv2cc03P/I4M/Vie8iv7bWZzmKFI1XxgKjdu4Dgo7QGWV5
 o4oXJSIL5H6r7ednM2l7SuCqFfgK/IYBCTQVB5k1F6Ida+gCHmmTI+GK64dkXdclixcDGT
 UVJpWiXap4kXFgJiYc3VEtUIkIS7QKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-quF_b8DGMYe3LJQgmaWfqQ-1; Tue, 31 Mar 2020 11:52:10 -0400
X-MC-Unique: quF_b8DGMYe3LJQgmaWfqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9647713FB;
 Tue, 31 Mar 2020 15:52:08 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54EF75D9C5;
 Tue, 31 Mar 2020 15:52:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] configure: warn if not using a separate build directory
Date: Tue, 31 Mar 2020 16:51:58 +0100
Message-Id: <20200331155158.381585-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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

Changed in v2:

 - Use existing $source_path variable (Eric)
 - Remove bash-ism in comparison (Eric)
 - Safe quoting of directory paths (Eric)
 - Rename variables to reflect that we're applying canonicalization (Eric)

 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..5991e0e6e5 100755
--- a/configure
+++ b/configure
@@ -285,6 +285,16 @@ then
   error_exit "main directory cannot contain spaces nor colons"
 fi
=20
+canon_build_path=3D$(realpath -- "$PWD")
+canon_source_path=3D$(realpath -- "$source_path")
+
+in_srcdir=3Dno
+if [ "$canon_build_path" =3D "$canon_source_path" ]
+then
+    in_srcdir=3Dyes
+fi
+
+
 # default parameters
 cpu=3D""
 iasl=3D"iasl"
@@ -6799,6 +6809,23 @@ if test "$supported_os" =3D "no"; then
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


