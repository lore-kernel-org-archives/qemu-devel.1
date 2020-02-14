Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82A3C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F872187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 06:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evKCetlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F872187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2UYH-00077R-RR
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 01:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2UXi-0006gK-9C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2UXg-0003Q4-Od
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:33:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2UXg-0003PE-GQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 01:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581662015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsEYvC0eKwgkQ2juh+ugBLsHp2nsoiOTFyxVniiyVBg=;
 b=evKCetlDSNDjnUtMjT2EaND2ZbCIP6/OoCNlamUxGNiAui5groYDA66GC0FHFOMglh3wZq
 yb3tDdbgDj2h9yMiKwrZpjm2ButEXhnF9OUOP5nhn5gPjN9KdttuR9lHWyqehisQx+pzA0
 LlHUAxtDw5qU6WS/MToygkODHIxfm2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-QayF-b8rO5KKroJp1DWewA-1; Fri, 14 Feb 2020 01:33:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23FC5189F760;
 Fri, 14 Feb 2020 06:33:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A4581001B30;
 Fri, 14 Feb 2020 06:33:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C598311385C9; Fri, 14 Feb 2020 07:33:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 01/30] configure: Allow user to specify sphinx-build
 binary
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-2-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 07:33:24 +0100
In-Reply-To: <20200213175647.17628-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:18 +0000")
Message-ID: <87v9o91xvv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: QayF-b8rO5KKroJp1DWewA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Does not work out of the box on my Fedora 30 build host, where
sphinx-build gives me sphinx-build-2.  I have to specify
--sphinx-build=3D/usr/bin/sphinx-build-3 to unbreak it.  Which of course
breaks things when I try to build anything before this commit

The appended patch makes it work out of the box.  Please consider
squashing it in.

diff --git a/configure b/configure
index 14172909f0..a9d175c400 100755
--- a/configure
+++ b/configure
@@ -584,7 +584,6 @@ query_pkg_config() {
 }
 pkg_config=3Dquery_pkg_config
 sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
-sphinx_build=3Dsphinx-build
=20
 # If the user hasn't specified ARFLAGS, default to 'rv', just as make does=
.
 ARFLAGS=3D"${ARFLAGS-rv}"
@@ -903,6 +902,7 @@ fi
=20
 : ${make=3D${MAKE-make}}
 : ${install=3D${INSTALL-install}}
+
 # We prefer python 3.x. A bare 'python' is traditionally
 # python 2.x, but some distros have it as python 3.x, so
 # we check that too
@@ -915,6 +915,19 @@ do
         break
     fi
 done
+
+set -x
+sphinx_build=3D
+for binary in sphinx-build-3 sphinx-build
+do
+    if has "$binary"
+    then
+        sphinx_build=3D$(command -v "$binary")
+        break
+    fi
+done
+set +x
+
 : ${smbd=3D${SMBD-/usr/sbin/smbd}}
=20
 # Default objcc to clang if available, otherwise use CC
@@ -4803,7 +4816,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDI=
R1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMP=
DIR1/sphinx/out" >/dev/null 2>&1
 }
=20
 # Check if tools are available to build documentation.


