Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF5C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19ABB20409
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp2LLhML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19ABB20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFfX-0000MX-67
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBFbG-0000ti-3O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBFbE-0002WT-G1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:25:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52337
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBFbE-0002WK-Bl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583749528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrWGN4kYZuoPFxwmblW4wvDAA9pDEly+wRW+jrXAzKY=;
 b=Rp2LLhMLUNaFq1LmWS5/QI078N6RlEDW/O6OGBs0pZaJCq5Do02bo8Y8UsT0X1l3gbWai/
 QgwaQ1FuN1WCvKCSjcdPnxaWVw1UrvcLsmByLiIt8oSYLl/qL8vKz/fLBBY9UHiPLp7qvN
 GIzXKjLrG0O/4171xR1Jq8NiFoia+UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-3iwoK79oPYWyIVmmRhOhiw-1; Mon, 09 Mar 2020 06:25:24 -0400
X-MC-Unique: 3iwoK79oPYWyIVmmRhOhiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0933ADB22;
 Mon,  9 Mar 2020 10:25:23 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2120890779;
 Mon,  9 Mar 2020 10:25:19 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 12/13] arm/arm64: ITS: migration tests
Date: Mon,  9 Mar 2020 11:24:19 +0100
Message-Id: <20200309102420.24498-13-eric.auger@redhat.com>
In-Reply-To: <20200309102420.24498-1-eric.auger@redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, andre.przywara@arm.com,
 thuth@redhat.com, yuzenghui@huawei.com, alexandru.elisei@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test maps LPIs (populates the device table, the collection table,
interrupt translation tables, configuration table), migrates and make
sure the translation is correct on the destination.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- assert in its_get_device/collection if the id is not found
---
 arm/gic.c                  | 58 ++++++++++++++++++++++++++++++++++----
 arm/unittests.cfg          |  8 ++++++
 lib/arm/asm/gic-v3-its.h   |  4 +++
 lib/arm64/asm/gic-v3-its.h |  3 ++
 lib/arm64/gic-v3-its.c     | 22 +++++++++++++++
 5 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 3ac90be..96f0fd6 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -653,13 +653,19 @@ static int its_prerequisites(int nb_cpus)
 	return 0;
 }
=20
-static void test_its_trigger(void)
+/*
+ * Setup the configuration for those mappings:
+ * dev_id=3D2 event=3D20 -> vcpu 3, intid=3D8195
+ * dev_id=3D7 event=3D255 -> vcpu 2, intid=3D8196
+ * LPIs ready to hit
+ */
+static int its_setup1(void)
 {
 	struct its_collection *col3, *col2;
 	struct its_device *dev2, *dev7;
=20
 	if (its_prerequisites(4))
-		return;
+		return -1;
=20
 	dev2 =3D its_create_device(2 /* dev id */, 8 /* nb_ites */);
 	dev7 =3D its_create_device(7 /* dev id */, 8 /* nb_ites */);
@@ -673,14 +679,10 @@ static void test_its_trigger(void)
 	its_send_invall(col2);
 	its_send_invall(col3);
=20
-	report_prefix_push("int");
 	/*
 	 * dev=3D2, eventid=3D20  -> lpi=3D 8195, col=3D3
 	 * dev=3D7, eventid=3D255 -> lpi=3D 8196, col=3D2
-	 * Trigger dev2, eventid=3D20 and dev7, eventid=3D255
-	 * Check both LPIs hit
 	 */
-
 	its_send_mapd(dev2, true);
 	its_send_mapd(dev7, true);
=20
@@ -689,6 +691,23 @@ static void test_its_trigger(void)
=20
 	its_send_mapti(dev2, 8195 /* lpi id */, 20 /* event id */, col3);
 	its_send_mapti(dev7, 8196 /* lpi id */, 255 /* event id */, col2);
+	return 0;
+}
+
+static void test_its_trigger(void)
+{
+	struct its_collection *col3, *col2;
+	struct its_device *dev2, *dev7;
+
+	if (its_setup1())
+		return;
+
+	col3 =3D its_get_collection(3);
+	col2 =3D its_get_collection(2);
+	dev2 =3D its_get_device(2);
+	dev7 =3D its_get_device(7);
+
+	report_prefix_push("int");
=20
 	lpi_stats_expect(3, 8195);
 	its_send_int(dev2, 20);
@@ -751,6 +770,29 @@ static void test_its_trigger(void)
 	check_lpi_stats("no LPI after collection unmap");
 	report_prefix_pop();
 }
+
+static void test_its_migration(void)
+{
+	struct its_device *dev2, *dev7;
+
+	if (its_setup1())
+		return;
+
+	dev2 =3D its_get_device(2);
+	dev7 =3D its_get_device(7);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report_info("Migration complete");
+
+	lpi_stats_expect(3, 8195);
+	its_send_int(dev2, 20);
+	check_lpi_stats("dev2/eventid=3D20 triggers LPI 8195 en PE #3 after mig=
ration");
+
+	lpi_stats_expect(2, 8196);
+	its_send_int(dev7, 255);
+	check_lpi_stats("dev7/eventid=3D255 triggers LPI 8196 on PE #2 after mi=
gration");
+}
 #endif
=20
 int main(int argc, char **argv)
@@ -788,6 +830,10 @@ int main(int argc, char **argv)
 		report_prefix_push(argv[1]);
 		test_its_trigger();
 		report_prefix_pop();
+	} else if (!strcmp(argv[1], "its-migration")) {
+		report_prefix_push(argv[1]);
+		test_its_migration();
+		report_prefix_pop();
 	} else if (strcmp(argv[1], "its-introspection") =3D=3D 0) {
 		report_prefix_push(argv[1]);
 		test_its_introspection();
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index b9a7a2c..480adec 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -136,6 +136,14 @@ extra_params =3D -machine gic-version=3D3 -append 'i=
ts-trigger'
 groups =3D its
 arch =3D arm64
=20
+[its-migration]
+file =3D gic.flat
+smp =3D $MAX_SMP
+accel =3D kvm
+extra_params =3D -machine gic-version=3D3 -append 'its-migration'
+groups =3D its migration
+arch =3D arm64
+
 # Test PSCI emulation
 [psci]
 file =3D psci.flat
diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 956d7b8..4d849c4 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -22,5 +22,9 @@ static inline void test_its_trigger(void)
 {
 	report_abort("not supported on 32-bit");
 }
+static inline void test_its_migration(void)
+{
+	report_abort("not supported on 32-bit");
+}
=20
 #endif /* _ASMARM_GICv3_ITS */
diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
index 889d6ce..e9f89c1 100644
--- a/lib/arm64/asm/gic-v3-its.h
+++ b/lib/arm64/asm/gic-v3-its.h
@@ -166,4 +166,7 @@ extern void __its_send_sync(struct its_collection *co=
l, bool verbose);
 #define its_send_movi_nv(dev, col, id)			__its_send_movi(dev, col, id, f=
alse)
 #define its_send_sync_nv(col)				__its_send_sync(col, false)
=20
+extern struct its_device *its_get_device(u32 id);
+extern struct its_collection *its_get_collection(u32 id);
+
 #endif /* _ASMARM64_GIC_V3_ITS_H_ */
diff --git a/lib/arm64/gic-v3-its.c b/lib/arm64/gic-v3-its.c
index fa84c00..d817a7d 100644
--- a/lib/arm64/gic-v3-its.c
+++ b/lib/arm64/gic-v3-its.c
@@ -148,3 +148,25 @@ struct its_collection *its_create_collection(u32 col=
_id, u32 pe)
 	its_data.nr_collections++;
 	return new;
 }
+
+struct its_device *its_get_device(u32 id)
+{
+	int i;
+
+	for (i =3D 0; i < GITS_MAX_DEVICES; i++) {
+		if (its_data.devices[i].device_id =3D=3D id)
+			return &its_data.devices[i];
+	}
+	assert(0);
+}
+
+struct its_collection *its_get_collection(u32 id)
+{
+	int i;
+
+	for (i =3D 0; i < GITS_MAX_COLLECTIONS; i++) {
+		if (its_data.collections[i].col_id =3D=3D id)
+			return &its_data.collections[i];
+	}
+	assert(0);
+}
--=20
2.20.1


