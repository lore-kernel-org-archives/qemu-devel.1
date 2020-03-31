Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70152C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D599212CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkuWEEhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D599212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKVh-0001zz-Dm
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jJKUq-0000eo-PI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jJKUp-0005lQ-IL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:16:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44454
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jJKUp-0005kv-F2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585674974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zluSe7sWi+EQ03Ku1XnFDdBAnxU8/t9URFObDnnQIeE=;
 b=IkuWEEhsb9vJhvsxcfwPXgUYLqgzBWNnXYkqxtoQY1ienV7tBF0a7Gg0OfHnZh2UicnSRU
 DGEjKZVW4YIm+lp7/3q20rXpIF43DOTP1J7M5HcAPq3twIZrparagK5potYJYUeMRodLAh
 AOTL5KAaoV8vai3PoHRLJ5qsUGUB3kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-3Jjx5Z81M32M7ZGEN7SraQ-1; Tue, 31 Mar 2020 13:16:13 -0400
X-MC-Unique: 3Jjx5Z81M32M7ZGEN7SraQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65F08017CC;
 Tue, 31 Mar 2020 17:16:11 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2629160BFE;
 Tue, 31 Mar 2020 17:16:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] configure: warn if not using a separate build directory
Date: Tue, 31 Mar 2020 18:16:06 +0100
Message-Id: <20200331171606.386801-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
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

Changed in v3:
  - Don't try to predict the future so much, just recommend
    a separate build dir

 configure | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..b4d1b01689 100755
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
@@ -6799,6 +6809,22 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
+if test "$in_srcdir" =3D "yes"; then
+    echo
+    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
+    echo
+    echo "Support for running the 'configure' script directly from the"
+    echo "source directory is deprecated. In source dir builds are not"
+    echo "covered by automated testing and thus may not correctly build"
+    echo "QEMU. Users are recommended to use a separate build directory:"
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


