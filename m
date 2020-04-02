Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8936BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B4B20719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCm7gjbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B4B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1GP-000813-FF
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jK1ER-0004QA-TX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jK1EQ-0001C6-78
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:54:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jK1EQ-0001BY-2Y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585839249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhrZeK5drwApiePPY4lvBKjmy/lVD4J+Wgvu5CSrsas=;
 b=VCm7gjbi4eSie3Hv3l8537M65R/tn+Z7keFBlICGVY9/sQtPXBaE1tCVV0s1crkwBFAgmp
 bSiozr90NB04Vvzmg0I74FHSzBQhP1d+rmKWs3heZHHejVG1EVD4LTmXWHQxaN4dxd6yD/
 dgAqHNl1wHZ66VOn6FdU1JZyygd18YA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-wnr8vXZKObeps7E-lb9zaA-1; Thu, 02 Apr 2020 10:54:08 -0400
X-MC-Unique: wnr8vXZKObeps7E-lb9zaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F02618C35A1;
 Thu,  2 Apr 2020 14:54:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C7755D9C9;
 Thu,  2 Apr 2020 14:53:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v8 13/13] arm/arm64: ITS: pending table
 migration test
Date: Thu,  2 Apr 2020 16:52:27 +0200
Message-Id: <20200402145227.20109-14-eric.auger@redhat.com>
In-Reply-To: <20200402145227.20109-1-eric.auger@redhat.com>
References: <20200402145227.20109-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, andre.przywara@arm.com,
 thuth@redhat.com, yuzenghui@huawei.com, alexandru.elisei@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add two new migration tests. One testing the migration of
a topology where collection were unmapped. The second test
checks the migration of the pending table.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v7 -> v8:
- removed set_lpi()
- change expected alloc, ie. s/malloc/calloc,
  this latter does memset()

v6 -> v7:
- test_migrate_unmapped_collection now uses pe0=3D0. Otherwise,
  depending on SMP value it collides with collections created
  by setup1()
- use of for_each_present_cpu

v5 -> v6:
- s/Set the PTZ/Clear the PTZ
- Move the collection inval after MAPC
- remove the unmap collection test

v4 -> v5:
- move stub from header to arm/gic.c

v3 -> v4:
- do not talk about odd/even CPUs, use pe0 and pe1
- comment the delay

v2 -> v3:
- tests belong to both its and migration groups
- use LPI(i)
- gicv3_lpi_set_pending_table_bit renamed into gicv3_lpi_set_clr_pending
---
 arm/gic.c         | 130 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  16 ++++++
 2 files changed, 146 insertions(+)

diff --git a/arm/gic.c b/arm/gic.c
index 6ae5515..ddf0f9d 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -193,6 +193,7 @@ static void lpi_handler(struct pt_regs *regs __unused=
)
 	smp_rmb(); /* pairs with wmb in lpi_stats_expect */
 	lpi_stats.observed.cpu_id =3D smp_processor_id();
 	lpi_stats.observed.lpi_id =3D irqnr;
+	acked[lpi_stats.observed.cpu_id]++;
 	smp_wmb(); /* pairs with rmb in check_lpi_stats */
 }
=20
@@ -238,6 +239,22 @@ static void secondary_lpi_test(void)
 	while (1)
 		wfi();
 }
+
+static void check_lpi_hits(int *expected, const char *msg)
+{
+	bool pass =3D true;
+	int i;
+
+	for_each_present_cpu(i) {
+		if (acked[i] !=3D expected[i]) {
+			report_info("expected %d LPIs on PE #%d, %d observed",
+				    expected[i], i, acked[i]);
+			pass =3D false;
+			break;
+		}
+	}
+	report(pass, "%s", msg);
+}
 #endif
=20
 static void gicv2_ipi_send_self(void)
@@ -593,6 +610,8 @@ static void gic_test_mmio(void)
 static void test_its_introspection(void) {}
 static void test_its_trigger(void) {}
 static void test_its_migration(void) {}
+static void test_its_pending_migration(void) {}
+static void test_migrate_unmapped_collection(void) {}
=20
 #else /* __aarch64__ */
=20
@@ -792,6 +811,109 @@ static void test_its_migration(void)
 	its_send_int(dev7, 255);
 	check_lpi_stats("dev7/eventid=3D255 triggers LPI 8196 on PE #2 after mi=
gration");
 }
+
+static void test_migrate_unmapped_collection(void)
+{
+	struct its_collection *col;
+	struct its_device *dev2, *dev7;
+	int pe0 =3D 0;
+	u8 config;
+
+	if (its_setup1())
+		return;
+
+	col =3D its_create_collection(pe0, pe0);
+	dev2 =3D its_get_device(2);
+	dev7 =3D its_get_device(7);
+
+	/* MAPTI with the collection unmapped */
+	its_send_mapti(dev2, 8192, 0, col);
+	gicv3_lpi_set_config(8192, LPI_PROP_DEFAULT);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report_info("Migration complete");
+
+	/* on the destination, map the collection */
+	its_send_mapc(col, true);
+	its_send_invall(col);
+
+	lpi_stats_expect(2, 8196);
+	its_send_int(dev7, 255);
+	check_lpi_stats("dev7/eventid=3D 255 triggered LPI 8196 on PE #2");
+
+	config =3D gicv3_lpi_get_config(8192);
+	report(config =3D=3D LPI_PROP_DEFAULT,
+	       "Config of LPI 8192 was properly migrated");
+
+	lpi_stats_expect(pe0, 8192);
+	its_send_int(dev2, 0);
+	check_lpi_stats("dev2/eventid =3D 0 triggered LPI 8192 on PE0");
+}
+
+static void test_its_pending_migration(void)
+{
+	struct its_device *dev;
+	struct its_collection *collection[2];
+	int *expected =3D calloc(nr_cpus, sizeof(int));
+	int pe0 =3D nr_cpus - 1, pe1 =3D nr_cpus - 2;
+	u64 pendbaser;
+	void *ptr;
+	int i;
+
+	if (its_prerequisites(4))
+		return;
+
+	dev =3D its_create_device(2 /* dev id */, 8 /* nb_ites */);
+	its_send_mapd(dev, true);
+
+	collection[0] =3D its_create_collection(pe0, pe0);
+	collection[1] =3D its_create_collection(pe1, pe1);
+	its_send_mapc(collection[0], true);
+	its_send_mapc(collection[1], true);
+
+	/* disable lpi at redist level */
+	gicv3_lpi_rdist_disable(pe0);
+	gicv3_lpi_rdist_disable(pe1);
+
+	/* lpis are interleaved inbetween the 2 PEs */
+	for (i =3D 0; i < 256; i++) {
+		struct its_collection *col =3D i % 2 ? collection[0] :
+						     collection[1];
+		int vcpu =3D col->target_address >> 16;
+
+		its_send_mapti(dev, LPI(i), i, col);
+		gicv3_lpi_set_config(LPI(i), LPI_PROP_DEFAULT);
+		gicv3_lpi_set_clr_pending(vcpu, LPI(i), true);
+	}
+	its_send_invall(collection[0]);
+	its_send_invall(collection[1]);
+
+	/* Clear the PTZ bit on each pendbaser */
+
+	expected[pe0] =3D 128;
+	expected[pe1] =3D 128;
+
+	ptr =3D gicv3_data.redist_base[pe0] + GICR_PENDBASER;
+	pendbaser =3D readq(ptr);
+	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
+
+	ptr =3D gicv3_data.redist_base[pe1] + GICR_PENDBASER;
+	pendbaser =3D readq(ptr);
+	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
+
+	gicv3_lpi_rdist_enable(pe0);
+	gicv3_lpi_rdist_enable(pe1);
+
+	puts("Now migrate the VM, then press a key to continue...\n");
+	(void)getchar();
+	report_info("Migration complete");
+
+	/* let's wait for the 256 LPIs to be handled */
+	mdelay(1000);
+
+	check_lpi_hits(expected, "128 LPIs on both PE0 and PE1 after migration"=
);
+}
 #endif
=20
 int main(int argc, char **argv)
@@ -833,6 +955,14 @@ int main(int argc, char **argv)
 		report_prefix_push(argv[1]);
 		test_its_migration();
 		report_prefix_pop();
+	} else if (!strcmp(argv[1], "its-pending-migration")) {
+		report_prefix_push(argv[1]);
+		test_its_pending_migration();
+		report_prefix_pop();
+	} else if (!strcmp(argv[1], "its-migrate-unmapped-collection")) {
+		report_prefix_push(argv[1]);
+		test_migrate_unmapped_collection();
+		report_prefix_pop();
 	} else if (strcmp(argv[1], "its-introspection") =3D=3D 0) {
 		report_prefix_push(argv[1]);
 		test_its_introspection();
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 480adec..b96f0a1 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -144,6 +144,22 @@ extra_params =3D -machine gic-version=3D3 -append 'i=
ts-migration'
 groups =3D its migration
 arch =3D arm64
=20
+[its-pending-migration]
+file =3D gic.flat
+smp =3D $MAX_SMP
+accel =3D kvm
+extra_params =3D -machine gic-version=3D3 -append 'its-pending-migration=
'
+groups =3D its migration
+arch =3D arm64
+
+[its-migrate-unmapped-collection]
+file =3D gic.flat
+smp =3D $MAX_SMP
+accel =3D kvm
+extra_params =3D -machine gic-version=3D3 -append 'its-migrate-unmapped-=
collection'
+groups =3D its migration
+arch =3D arm64
+
 # Test PSCI emulation
 [psci]
 file =3D psci.flat
--=20
2.20.1


