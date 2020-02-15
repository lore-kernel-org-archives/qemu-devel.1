Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55143C4741C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC3F20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODscVZ5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC3F20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vqP-0006Ij-7w
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpR-0004XB-RI
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpQ-0006th-Fa
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53096
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpQ-0006tO-BB
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vtia4GZR1hLlkjsafHbZ9CjPMju58Oq7A0n89OrclnA=;
 b=ODscVZ5hHZBSwCp1jzys9IiUXtP8I0ggWUVo/jaxrXRL2lSFyVEU41OTfizNKH1ce4ArRp
 7Sa1BsIsMF/UlQhdeiCIFtgL+8WAhyKg1Y/xnJ4NIy+ssJvxbJoJtZZaDGddRNF/MSA5XU
 JHNqwmUxkDCU2pg9K+f5Q944shJ7b8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-vvDi8kK0MFyMCCavcLDR9Q-1; Sat, 15 Feb 2020 06:41:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1CE8800D54;
 Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9CF519756;
 Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2470211366C5; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] configure: Pick sphinx-build-3 when available
Date: Sat, 15 Feb 2020 12:41:18 +0100
Message-Id: <20200215114133.15097-4-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vvDi8kK0MFyMCCavcLDR9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next commit will require a sphinx-build that uses Python 3.  On
some systems, sphinx-build is fine, on others you need to use
sphinx-build-3.  To keep things working out of the box on both kinds
of systems, try sphinx-build-3, then sphinx-build.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <87a75lqe8e.fsf@dusky.pond.sub.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 14172909f0..9f7bded369 100755
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
@@ -915,6 +914,17 @@ do
         break
     fi
 done
+
+sphinx_build=3D
+for binary in sphinx-build-3 sphinx-build
+do
+    if has "$binary"
+    then
+        sphinx_build=3D$(command -v "$binary")
+        break
+    fi
+done
+
 : ${smbd=3D${SMBD-/usr/sbin/smbd}}
=20
 # Default objcc to clang if available, otherwise use CC
@@ -4803,7 +4813,7 @@ has_sphinx_build() {
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
--=20
2.21.1


