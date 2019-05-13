Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF94C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5579520989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5579520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53137 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6NI-0006qU-Ia
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:31:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQ6LX-0005ZK-Az
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQ6LO-0005UU-9C
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:30:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hQ6LC-0005Nb-9u; Mon, 13 May 2019 04:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 666813092648;
	Mon, 13 May 2019 08:29:45 +0000 (UTC)
Received: from thuth.com (ovpn-116-122.ams2.redhat.com [10.36.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 862956B8D1;
	Mon, 13 May 2019 08:29:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Mon, 13 May 2019 10:29:39 +0200
Message-Id: <20190513082940.30295-2-thuth@redhat.com>
In-Reply-To: <20190513082940.30295-1-thuth@redhat.com>
References: <20190513082940.30295-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 13 May 2019 08:29:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 02/29] Makefile: Fix inclusion of the
 config-devices.mak.d Kconfig dependencies
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Makefile tries to include device Kconfig dependencies via

 -include $(SUBDIR_DEVICES_MAK_DEP)

and thus expects files that match *-softmmu/config-devices.mak.d ...
however, the minikconf script currently generates files a la
"*-softmmu-config.devices.mak.d" instead, so the dependency files
simply got ignored so far. For example, after a "touch hw/arm/Kconfig",
the arm-softmmu/config-devices.mak file is currently not re-generated.
Fix it by putting the dependency files in the *-softmmu folders now.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile               | 2 +-
 configure              | 2 +-
 docs/devel/kconfig.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4a8ae0ef95..66d5c65156 100644
--- a/Makefile
+++ b/Makefile
@@ -350,7 +350,7 @@ endif
 # This has to be kept in sync with Kconfig.host.
 MINIKCONF_ARGS =3D \
     $(CONFIG_MINIKCONF_MODE) \
-    $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
+    $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
     CONFIG_KVM=3D$(CONFIG_KVM) \
     CONFIG_SPICE=3D$(CONFIG_SPICE) \
     CONFIG_IVSHMEM=3D$(CONFIG_IVSHMEM) \
diff --git a/configure b/configure
index 63f312bd1f..8999698bc2 100755
--- a/configure
+++ b/configure
@@ -1832,7 +1832,7 @@ exit 0
 fi
=20
 # Remove old dependency files to make sure that they get properly regene=
rated
-rm -f *-config-devices.mak.d
+rm -f */config-devices.mak.d
=20
 if test -z "$python"
 then
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index cce146f87d..d6f8eb0977 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -299,7 +299,7 @@ and also listed as follows in the top-level Makefile'=
s ``MINIKCONF_ARGS``
 variable::
=20
     MINIKCONF_ARGS =3D \
-      $@ $*-config.devices.mak.d $< $(MINIKCONF_INPUTS) \
+      $@ $*/config-devices.mak.d $< $(MINIKCONF_INPUTS) \
       CONFIG_KVM=3D$(CONFIG_KVM) \
       CONFIG_SPICE=3D$(CONFIG_SPICE) \
       CONFIG_TPM=3D$(CONFIG_TPM) \
--=20
2.21.0


