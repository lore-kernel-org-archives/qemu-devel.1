Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47556C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A07C206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDxL6DE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A07C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idI1a-0006YE-Q6
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOQ-0001ee-BG
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOO-00037N-Pl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHON-00033Y-Rd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZIWyVz0mXJm3WKdFFZ/MDv4wbAF4ZdIGNT+t+b1NIM=;
 b=gDxL6DE/1IjAi8VzFP4328+FXyLjs1PkxQMtPLyTulAm4D5a+n6lJMX0vtji190ALhfULQ
 oSZuMVyfE1Yf56EiNOvH4hG2m65WGl9LnY6qshrPDnErh+jr4VSkd1CEWjNBzfUyob0cTh
 FNxtOcIx8HD2ULoU7GSAyPDr7MJAa7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-D71sZqEuNFWfvlreylC4FA-1; Fri, 06 Dec 2019 12:27:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0DC9107ACC9;
 Fri,  6 Dec 2019 17:27:41 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 73DC86CE40;
 Fri,  6 Dec 2019 17:27:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 02/10] pmu: Let pmu tests take a sub-test
 parameter
Date: Fri,  6 Dec 2019 18:27:16 +0100
Message-Id: <20191206172724.947-3-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: D71sZqEuNFWfvlreylC4FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we intend to introduce more PMU tests, let's add
a sub-test parameter that will allow to categorize
them. Existing tests are in the cycle-counter category.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c         | 22 ++++++++++++++--------
 arm/unittests.cfg |  7 ++++---
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index 1de7d77..2ad6469 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -287,21 +287,27 @@ int main(int argc, char *argv[])
 {
 =09int cpi =3D 0;
=20
-=09if (argc > 1)
-=09=09cpi =3D atol(argv[1]);
-
 =09if (!pmu_probe()) {
 =09=09printf("No PMU found, test skipped...\n");
 =09=09return report_summary();
 =09}
=20
+=09if (argc < 2)
+=09=09report_abort("no test specified");
+
 =09report_prefix_push("pmu");
=20
-=09report("Control register", check_pmcr());
-=09report("Monotonically increasing cycle count", check_cycles_increase())=
;
-=09report("Cycle/instruction ratio", check_cpi(cpi));
-
-=09pmccntr64_test();
+=09if (strcmp(argv[1], "cycle-counter") =3D=3D 0) {
+=09=09report_prefix_push(argv[1]);
+=09=09if (argc > 2)
+=09=09=09cpi =3D atol(argv[2]);
+=09=09report("Control register", check_pmcr());
+=09=09report("Monotonically increasing cycle count", check_cycles_increase=
());
+=09=09report("Cycle/instruction ratio", check_cpi(cpi));
+=09=09pmccntr64_test();
+=09} else {
+=09=09report_abort("Unknown subtest '%s'", argv[1]);
+=09}
=20
 =09return report_summary();
 }
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index daeb5a0..79f0d7a 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -61,21 +61,22 @@ file =3D pci-test.flat
 groups =3D pci
=20
 # Test PMU support
-[pmu]
+[pmu-cycle-counter]
 file =3D pmu.flat
 groups =3D pmu
+extra_params =3D -append 'cycle-counter 0'
=20
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
-#extra_params =3D -icount 0 -append '1'
+#extra_params =3D -icount 0 -append 'cycle-counter 1'
 #groups =3D pmu
 #accel =3D tcg
=20
 # Test PMU support (TCG) with -icount IPC=3D256
 #[pmu-tcg-icount-256]
 #file =3D pmu.flat
-#extra_params =3D -icount 8 -append '256'
+#extra_params =3D -icount 8 -append 'cycle-counter 256'
 #groups =3D pmu
 #accel =3D tcg
=20
--=20
2.20.1


