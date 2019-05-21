Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA60C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947962173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947962173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1Wb-0004qm-Se
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:57:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT1VR-0004Ow-6G
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT1VQ-0002Q4-1K
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:56:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT1VP-0002Ms-Pn
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2D94356E9
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:56:15 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-26.ams2.redhat.com
	[10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD72E600C6;
	Tue, 21 May 2019 09:56:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 10:56:13 +0100
Message-Id: <20190521095613.16584-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 21 May 2019 09:56:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] authz: optimize linking of objects for
 authorization services
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The core authorization API is a dependancy of the crypto code for the
TLS servers. The TLS server code is pulled into anything which links
to the crypto objects, which is every QEMU tool. This in turns means
that every tool ended up linking to the authz code, which in turn
pulls in the PAM library dep.

This splits the authz code so that everything links to the base object
which defines the API. Only the system emulators and qemu-nbd link to
the object classes providing the implementations of the authz object
API. This has the effect of removing the PAM library dep from qemu-img,
qemu-io and other helper tools.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---

In v2:

  - Now with 100% less unit test failures due to missing objs :-)

 Makefile               | 5 +++--
 Makefile.objs          | 1 +
 Makefile.target        | 3 ++-
 authz/Makefile.objs    | 9 +++++----
 tests/Makefile.include | 6 +++---
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 66d5c65156..508a3e014b 100644
--- a/Makefile
+++ b/Makefile
@@ -396,6 +396,7 @@ endif
 dummy :=3D $(call unnest-vars,, \
                 stub-obj-y \
                 authz-obj-y \
+                authz-impl-obj-y \
                 chardev-obj-y \
                 util-obj-y \
                 qga-obj-y \
@@ -444,7 +445,7 @@ qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_P=
ATH)/scripts/hxtool
 SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
 SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
=20
-$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
+$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y) $(authz-impl-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
 $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
@@ -512,7 +513,7 @@ COMMON_LDADDS =3D libqemuutil.a
 qemu-img.o: qemu-img-cmds.h
=20
 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
-qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj=
-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(authz-impl-obj-y) $(block=
-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y=
) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
=20
 qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed..929c3ea045 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -9,6 +9,7 @@ chardev-obj-y =3D chardev/
 # authz-obj-y is code used by both qemu system emulation and qemu-img
=20
 authz-obj-y =3D authz/
+authz-impl-obj-y =3D authz/
=20
 #######################################################################
 # block-obj-y is code used by both qemu system emulation and qemu-img
diff --git a/Makefile.target b/Makefile.target
index ae02495951..da32dac316 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -176,6 +176,7 @@ all-obj-y :=3D $(obj-y)
 include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,.., \
                authz-obj-y \
+               authz-impl-obj-y \
                block-obj-y \
                block-obj-m \
                chardev-obj-y \
@@ -187,7 +188,7 @@ dummy :=3D $(call unnest-vars,.., \
                common-obj-m)
 all-obj-y +=3D $(common-obj-y)
 all-obj-y +=3D $(qom-obj-y)
-all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y)
+all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y) $(authz-impl-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
diff --git a/authz/Makefile.objs b/authz/Makefile.objs
index ed7b273596..e4c22447db 100644
--- a/authz/Makefile.objs
+++ b/authz/Makefile.objs
@@ -1,7 +1,8 @@
 authz-obj-y +=3D base.o
-authz-obj-y +=3D simple.o
-authz-obj-y +=3D list.o
-authz-obj-y +=3D listfile.o
-authz-obj-$(CONFIG_AUTH_PAM) +=3D pamacct.o
+
+authz-impl-obj-y +=3D simple.o
+authz-impl-obj-y +=3D list.o
+authz-impl-obj-y +=3D listfile.o
+authz-impl-obj-$(CONFIG_AUTH_PAM) +=3D pamacct.o
=20
 pamacct.o-libs =3D -lpam
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 60de085ee1..0b0688b687 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -496,10 +496,10 @@ test-qapi-obj-y =3D tests/test-qapi-types.o \
 	tests/test-qapi-visit-sub-sub-module.o \
 	tests/test-qapi-introspect.o \
 	$(test-qom-obj-y)
-benchmark-crypto-obj-y =3D $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj=
-y)
-test-crypto-obj-y =3D $(authz-obj-y) $(crypto-obj-y) $(test-qom-obj-y)
+benchmark-crypto-obj-y =3D $(authz-obj-y) $(authz-impl-obj-y) $(crypto-o=
bj-y) $(test-qom-obj-y)
+test-crypto-obj-y =3D $(authz-obj-y) $(authz-impl-obj-y) $(crypto-obj-y)=
 $(test-qom-obj-y)
 test-io-obj-y =3D $(io-obj-y) $(test-crypto-obj-y)
-test-authz-obj-y =3D $(test-qom-obj-y) $(authz-obj-y)
+test-authz-obj-y =3D $(test-qom-obj-y) $(authz-obj-y) $(authz-impl-obj-y=
)
 test-block-obj-y =3D $(block-obj-y) $(test-io-obj-y) tests/iothread.o
=20
 tests/check-qnum$(EXESUF): tests/check-qnum.o $(test-util-obj-y)
--=20
2.21.0


