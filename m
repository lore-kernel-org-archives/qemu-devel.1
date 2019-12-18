Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EBCC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3133D21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3wrjEZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3133D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihikQ-0003bi-7z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 18:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihih4-0007Cu-NN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihih3-0003cp-Kg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihih3-0003ch-Gg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576711525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeLcqgAJ0jMqwtYDErQXdX2IVnm/UfYy9v1fDBynv5E=;
 b=f3wrjEZV4e0HReNyASuRP5qCWiJ6lZg+ME00nb1UH5Bds8Wkp3F2tElZEcgm1VArIIEZtu
 FIJbtQLb4PEAA0n6YpBWP7y4siY+ygVZNW+H/kxfVjO5pZhZMF2cML+r0lqKc+Abs8aPfH
 XBxShp0it3kLsOR/nOnX1bJSwwcDQS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-CmnEsEOjMhe6kY_rhWczlA-1; Wed, 18 Dec 2019 18:25:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A73CEDBE6;
 Wed, 18 Dec 2019 23:25:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D46A1001281;
 Wed, 18 Dec 2019 23:25:18 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 3/4] Acceptance tests: add make targets to download images
Date: Wed, 18 Dec 2019 18:24:59 -0500
Message-Id: <20191218232500.23530-4-crosa@redhat.com>
In-Reply-To: <20191218232500.23530-1-crosa@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: CmnEsEOjMhe6kY_rhWczlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
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
---
 tests/Makefile.include | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b381387048..78a6f089ff 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1177,7 +1177,20 @@ $(TESTS_RESULTS_DIR):
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
+get-vmimage-fedora-31-%: $(check-venv)
+=09$(call quiet-command, \
+             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
+             --distro=3Dfedora --distro-version=3D31 --arch=3D$*)
+
+# download all vm images, according to defined targets
+get-vmimage: $(patsubst %,get-vmimage-fedora-31-%, $(FEDORA_31_DOWNLOAD))
+
+check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vmimage
 =09$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RESUL=
TS_DIR) \
@@ -1188,7 +1201,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
=20
 # Consolidated targets
=20
-.PHONY: check-block check-qapi-schema check-qtest check-unit check check-c=
lean
+.PHONY: check-block check-qapi-schema check-qtest check-unit check check-c=
lean get-vmimage
 check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schem=
a/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
--=20
2.21.0


