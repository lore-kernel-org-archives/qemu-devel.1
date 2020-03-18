Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A09C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7379120663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 00:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah8Ycxix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7379120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEMUc-00084S-LU
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 20:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jEMRC-0004L3-7X
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jEMRA-00084Y-Ly
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jEMRA-000821-HR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 20:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584490796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoD/z+A1PszJF4eckXJDLUHboiQsadxXrSrIBOl8OZI=;
 b=Ah8Ycxix+VguO9iyLXbqfjU74JEMQ24FzUSWuAZY+PFtE8+mkyl8+UCl6yF19yZjjkraUv
 0KvMtkcM1no6SopSuht78U0d4bI7uO93RJ2t4OkSkSEWv9hfXHgUF0TpUIhJMpNoAH1PAJ
 C8kxoG+tEH280cTWiyim4vStHviB3SM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-fr6DtnFUMteppFoCqIbDoA-1; Tue, 17 Mar 2020 20:19:54 -0400
X-MC-Unique: fr6DtnFUMteppFoCqIbDoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B719013E2;
 Wed, 18 Mar 2020 00:19:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-2.rdu2.redhat.com
 [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F92210016EB;
 Wed, 18 Mar 2020 00:19:50 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/6] Acceptance tests: add make targets to download images
Date: Tue, 17 Mar 2020 20:19:30 -0400
Message-Id: <20200318001932.180617-5-crosa@redhat.com>
In-Reply-To: <20200318001932.180617-1-crosa@redhat.com>
References: <20200318001932.180617-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>, Willian Rampazzo <willianr@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The newly introduced "boot linux" tests make use of Linux images that
are larger than usual, and fall into what Avocado calls "vmimages",
and can be referred to by name, version and architecture.

The images can be downloaded automatically during the test. But, to
make for more reliable test results, this introduces a target that
will download the vmimages for the architectures that have been
configured and are available for the currently used distro (Fedora
31).

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
[Cleber: implemented suggestions by Alex, download message, check-venv targ=
et]
Message-Id: <20200317141654.29355-4-crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/Makefile.include | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 67e8fcddda..68c5d73d28 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -20,6 +20,8 @@ check-help:
 =09@echo " $(MAKE) check-venv           Creates a Python venv for tests"
 =09@echo " $(MAKE) check-clean          Clean the tests and related data"
 =09@echo
+=09@echo " $(MAKE) get-vm-images        Downloads all images used by accep=
tance tests, according to configured targets (~350 MB each, 1.5 GB max)"
+=09@echo
 =09@echo
 =09@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
 =09@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they c=
an be"
@@ -889,7 +891,21 @@ $(TESTS_RESULTS_DIR):
=20
 check-venv: $(TESTS_VENV_DIR)
=20
-check-acceptance: check-venv $(TESTS_RESULTS_DIR)
+FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
+FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
+FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDI=
DATES))
+
+# download one specific Fedora 31 image
+get-vm-image-fedora-31-%: check-venv
+=09$(call quiet-command, \
+             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
+             --distro=3Dfedora --distro-version=3D31 --arch=3D$*, \
+=09"AVOCADO", "Downloading acceptance tests VM image for $*")
+
+# download all vm images, according to defined targets
+get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDORA_=
31_DOWNLOAD))
+
+check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 =09$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RESUL=
TS_DIR) \
@@ -900,7 +916,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
=20
 # Consolidated targets
=20
-.PHONY: check-block check-qapi-schema check-qtest check-unit check check-c=
lean
+.PHONY: check-block check-qapi-schema check-qtest check-unit check check-c=
lean get-vm-images
 check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schem=
a/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 ifeq ($(CONFIG_TOOLS),y)
--=20
2.25.1


