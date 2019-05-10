Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A805FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788CC2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788CC2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38805 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP0nC-0004Kr-KV
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 04:22:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hP0mK-0003zX-Hh
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hP0mG-0007Qw-Sk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:21:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hP0mE-0007Np-Sm
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:21:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B678E85376;
	Fri, 10 May 2019 08:21:08 +0000 (UTC)
Received: from thuth.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B7117646AE;
	Fri, 10 May 2019 08:21:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 10:20:57 +0200
Message-Id: <20190510082057.9104-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 10 May 2019 08:21:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] Makefile: Fix inclusion of the
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Makefile tries to include device Kconfig dependencies via

 -include $(SUBDIR_DEVICES_MAK_DEP)

and thus expects files that match *-softmmu/config-devices.mak.d ...
However, the minikconf script currently generates files a la
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
index a971247cac..d878767066 100644
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


