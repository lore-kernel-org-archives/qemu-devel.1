Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC8C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412FF2077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 17:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM1mjPza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412FF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icYSZ-0004II-CY
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 12:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1icY66-0005C7-1M
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1icY64-0003eU-AH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34712
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1icY64-0003LR-3w
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 12:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575479151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fr2KxWaxRXYFyyTmacQjYhempuw1vnJZ79bFGUkw7/w=;
 b=AM1mjPzasMAv2g2zc4Agdx4FpkDgm9RVTfhwLVsD2y5naKYEebTgOvN34awmbfLwLoye6I
 1R+JkLql8iJsrNcNfVzWoY/hIYVZ6Y4Dgm80kBziZZ9bLlQR0Sq761SuxPccaAkjaN2txt
 nKMHyz5NBue2QPMTZGiGdJckYgs+2jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-Sx1WtDh6NoCVgC_zR9ZfUg-1; Wed, 04 Dec 2019 12:05:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DA0C102313A
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 17:05:49 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1476E5D6BB;
 Wed,  4 Dec 2019 17:05:47 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 2/8] tests: q35: MCH: add default SMBASE SMRAM lock
 test
Date: Wed,  4 Dec 2019 18:05:41 +0100
Message-Id: <1575479147-6641-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Sx1WtDh6NoCVgC_zR9ZfUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

test lockable SMRAM at default SMBASE feature, introduced by
patch "q35: implement 128K SMRAM at default SMBASE address"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/q35-test.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 105 insertions(+)

diff --git a/tests/q35-test.c b/tests/q35-test.c
index a68183d..dd02660 100644
--- a/tests/q35-test.c
+++ b/tests/q35-test.c
@@ -186,6 +186,109 @@ static void test_tseg_size(const void *data)
     qtest_quit(qts);
 }
=20
+#define SMBASE 0x30000
+#define SMRAM_TEST_PATTERN 0x32
+#define SMRAM_TEST_RESET_PATTERN 0x23
+
+static void test_smram_smbase_lock(void)
+{
+    QPCIBus *pcibus;
+    QPCIDevice *pcidev;
+    QDict *response;
+    QTestState *qts;
+    int i;
+
+    qts =3D qtest_init("-M q35");
+
+    pcibus =3D qpci_new_pc(qts, NULL);
+    g_assert(pcibus !=3D NULL);
+
+    pcidev =3D qpci_device_find(pcibus, 0);
+    g_assert(pcidev !=3D NULL);
+
+    /* check that SMRAM is not enabled by default */
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=3D 0)=
;
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, SMRAM_TEST_PATTERN);
+
+    /* check that writinng junk to 0x9c before before negotiating is ignor=
red */
+    for (i =3D 0; i < 0xff; i++) {
+        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
+        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=
=3D 0);
+    }
+
+    /* enable SMRAM at SMBASE */
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0xff);
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=3D 0x=
01);
+    /* lock SMRAM at SMBASE */
+    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0x02);
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=3D 0x=
02);
+
+    /* check that SMRAM at SMBASE is locked and can't be unlocked */
+    g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, 0xff);
+    for (i =3D 0; i <=3D 0xff; i++) {
+        /* make sure register is immutable */
+        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
+        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=
=3D 0x02);
+
+        /* RAM access should go inot black hole */
+        qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
+        g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, 0xff);
+    }
+
+    /* reset */
+    response =3D qtest_qmp(qts, "{'execute': 'system_reset', 'arguments': =
{} }");
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    qobject_unref(response);
+
+    /* check RAM at SMBASE is available after reset */
+    g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, SMRAM_TEST_PATTERN);
+    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=3D 0)=
;
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_RESET_PATTERN);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, SMRAM_TEST_RESET_PAT=
TERN);
+
+    g_free(pcidev);
+    qpci_free_pc(pcibus);
+
+    qtest_quit(qts);
+}
+
+static void test_without_smram_base(void)
+{
+    QPCIBus *pcibus;
+    QPCIDevice *pcidev;
+    QTestState *qts;
+    int i;
+
+    qts =3D qtest_init("-M pc-q35-4.1");
+
+    pcibus =3D qpci_new_pc(qts, NULL);
+    g_assert(pcibus !=3D NULL);
+
+    pcidev =3D qpci_device_find(pcibus, 0);
+    g_assert(pcidev !=3D NULL);
+
+    /* check that RAM accessible */
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, SMRAM_TEST_PATTERN);
+
+    /* check that writing to 0x9c succeeds */
+    for (i =3D 0; i <=3D 0xff; i++) {
+        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
+        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) =3D=
=3D i);
+    }
+
+    /* check that RAM is still accessible */
+    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN + 1);
+    g_assert_cmpint(qtest_readb(qts, SMBASE), =3D=3D, (SMRAM_TEST_PATTERN =
+ 1));
+
+    g_free(pcidev);
+    qpci_free_pc(pcibus);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -197,5 +300,7 @@ int main(int argc, char **argv)
     qtest_add_data_func("/q35/tseg-size/8mb", &tseg_8mb, test_tseg_size);
     qtest_add_data_func("/q35/tseg-size/ext/16mb", &tseg_ext_16mb,
                         test_tseg_size);
+    qtest_add_func("/q35/smram/smbase_lock", test_smram_smbase_lock);
+    qtest_add_func("/q35/smram/legacy_smbase", test_without_smram_base);
     return g_test_run();
 }
--=20
2.7.4


