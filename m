Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE24C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B5C21D7A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7eAS9UD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B5C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLTln-0008Kn-K6
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jLTkq-0007Wk-CO
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jLTko-0007lf-4a
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:33:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jLTkn-0007lS-Uq
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586187217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=54m8rxTt54kFBq7OA+fqcF0qFo/2VaJKpZ5ghHw46Co=;
 b=S7eAS9UDVeWHoJLhLbzKB43uCbBoOJZnDAdVi/WhSftBijo+tiKFO4ZeSleUWmrfLTIB9x
 k2UKmRC4cMGh0AKrYnMV5aEnt1iLn56tWjntOr/EQ35qEpIqmQhV7w+WdmAm7DpTUZelB2
 LjNJXQd3+Mqo6UA+y4ipfxGXKlTWSts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-9QYrib-zN6ieD2UzAETHyw-1; Mon, 06 Apr 2020 11:33:34 -0400
X-MC-Unique: 9QYrib-zN6ieD2UzAETHyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C645119057A0;
 Mon,  6 Apr 2020 15:33:32 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7756C92D57;
 Mon,  6 Apr 2020 15:33:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 for-5.0] configure: warn if not using a separate build
 directory
Date: Mon,  6 Apr 2020 16:33:26 +0100
Message-Id: <20200406153326.806024-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
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

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

Changed in v5:

 - Use PeterM's suggested wording instead.
 - Dropped previous R-bs due to wording change

 configure | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/configure b/configure
index 22870f3867..b8f1d26293 100755
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
@@ -6751,6 +6761,23 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
+if test "$in_srcdir" =3D "yes"; then
+    echo
+    echo "NOTE: we recommend against building in the source directory"
+    echo
+    echo "You've run the 'configure' script directly from the source"
+    echo "directory. This will work, but we recommend using a separate"
+    echo "build directory, especially if you plan to work with the QEMU"
+    echo "sources rather than just building it once. You can switch to"
+    echo "a separate build directory like this:"
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


