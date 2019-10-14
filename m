Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFE4C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527A52133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527A52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1sk-0002ud-GJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iK1qs-0001VK-3N
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iK1qq-0005Dv-NK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:01:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iK1qq-0005Cx-HQ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29F3C18C893A;
 Mon, 14 Oct 2019 15:01:35 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B92D7194B6;
 Mon, 14 Oct 2019 15:01:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] sphinx: Use separate doctree directories for different
 builders
Date: Mon, 14 Oct 2019 12:01:33 -0300
Message-Id: <20191014150133.14318-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 14 Oct 2019 15:01:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sphinx-build is buggy when multiple processes are using the same
doctree directory in parallel.  See the 3-year-old Sphinx bug
report at: https://github.com/sphinx-doc/sphinx/issues/2946

Instead of avoiding parallel builds or adding some kind of
locking, I'm using the simplest solution: just using a different
doctree cache for each builder.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 30f0abfb42..d20e7ffce3 100644
--- a/Makefile
+++ b/Makefile
@@ -983,7 +983,10 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MA=
NUAL_BUILDDIR)/interop/index
=20
 # Canned command to build a single manual
 # Arguments: $1 =3D manual name, $2 =3D Sphinx builder ('html' or 'man')
-build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" sphinx=
-build $(if $(V),,-q) -W -n -b $2 -D version=3D$(VERSION) -D release=3D"$=
(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1=
 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+# Note the use of different doctree for each (manual, builder) tuple;
+# this works around Sphinx not handling parallel invocation on
+# a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
+build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" sphinx=
-build $(if $(V),,-q) -W -n -b $2 -D version=3D$(VERSION) -D release=3D"$=
(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)=
/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$=
1/conf.py $(SRC_PATH)/docs/conf.py
=20
--=20
2.21.0


