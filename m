Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1D6C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA6524655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmXO31Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA6524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9rg-00065E-Ud
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9pz-0004BL-FP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9py-0007ln-6y
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9py-0007lW-3A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDntRjnqkdZXlC1JZeGY/cuEoEt7aTCjD9wGxlyp8Vo=;
 b=SmXO31Vl4fDKrsKcNV7a7mqHNOYKBmcV+izLp4vqsTjslx6UMwk0hQ1wRd9iAb3zqs+tXz
 kfL9cVBLASLFwkGJJO82POyTXHSR/AN3s5BlPlPmaKqFacoABgzpALY5mtNFqiEg6wXU/Z
 T573WsnNG/W8FaYSvCtznNzvupRuicg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-J74QtcqLM5yMbq1W3TlZRw-1; Wed, 22 Jan 2020 01:49:58 -0500
Received: by mail-wm1-f70.google.com with SMTP id y125so1198709wmg.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o0n2DkkmVlJvF/kJjOaBKtOGbZzvtHQ/1x2pWKeDMgM=;
 b=aqriCnkQKpnajKP9mXa5IYKIk2mj+WubffQh1U/9YZcPfAI6jftld5QSRsnIE+ymPY
 vACubJiPPe+Ers6oIn9OYT0ylcgSz19Z6uMRm7iBcrY47oapsINrArlW3f7ffvKoB/IN
 uBTQzL4USw53b1DFlojWc29hGPQLar9m9DPxgX3rlFAHKFkSjFP4js975itbpUFLhJlq
 nVLbmgHSEBvNFtHjy+hDGaBpC4XTjAyXFlalCwE8E9Dk8lfBueentKckhdTGgiWQf3de
 lx3HZBEEwSwYpgm0978jNr3FkcwInymh0YD5Q6Z4Wp/N73y4nvNXuv6FFZgvoQrcdM9X
 +UKw==
X-Gm-Message-State: APjAAAUxArFssmLB54ctJ1AvW4Bt46hmRI+4Ae1w3nd5VvmmYLhUerNu
 HMo/wLstL4unExxFtvHmMzzXx5cjj/HULlIkzlUHARspsHXsrwuxaY18hlaEfCcaNJ7kvWo6Y0d
 8qNyCjoxcFR1lYK8=
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr1165078wmd.187.1579675797051; 
 Tue, 21 Jan 2020 22:49:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7lNdKQRvFMYzuaNRNe5P9x+q7sqeW7xFV4t1tmTPZcMgS0CvmaoiTFVp8t3jqVRgkfhH7aw==
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr1165060wmd.187.1579675796807; 
 Tue, 21 Jan 2020 22:49:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 k11sm2542585wmc.20.2020.01.21.22.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:49:56 -0800 (PST)
Date: Wed, 22 Jan 2020 01:49:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/17] tests: q35: MCH: add default SMBASE SMRAM lock test
Message-ID: <20200122064907.512501-3-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: J74QtcqLM5yMbq1W3TlZRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

test lockable SMRAM at default SMBASE feature, introduced by
patch "q35: implement 128K SMRAM at default SMBASE address"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1575899217-333105-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/q35-test.c | 105 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index a68183d513..c922d81bc0 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
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
+    /* check that writing junk to 0x9c before before negotiating is ignore=
d */
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
+        /* RAM access should go into black hole */
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
+    /* check that RAM is accessible */
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
MST


