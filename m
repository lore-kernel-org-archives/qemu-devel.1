Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2ADC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA66424656
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 05:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APXTYwC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA66424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu8xB-0000Od-7N
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 00:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu8vo-0007Gr-6Q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu8vl-0004Xo-Tn
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:52:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu8vl-0004Xf-P9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 00:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579672317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDntRjnqkdZXlC1JZeGY/cuEoEt7aTCjD9wGxlyp8Vo=;
 b=APXTYwC7+cG4Ic9MydL0E5wqGsuk60UHwXQ4wU4//MwuBBBHMMZr1NBGaty3xUT4HQm6/R
 15D01A8dbuJ3KUoXPdeDzZvhYvnfpEGaKNWCLCpZSmxhBcHZvY4DH4l6+cKsOF36veBxBi
 ruvuSAdbrZ0xVFOck9uglxw4i1NoiUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Y4MyzhiYP0a2KJ-HMvrfFA-1; Wed, 22 Jan 2020 00:51:55 -0500
Received: by mail-wr1-f69.google.com with SMTP id r2so2531533wrp.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 21:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o0n2DkkmVlJvF/kJjOaBKtOGbZzvtHQ/1x2pWKeDMgM=;
 b=nSTfZBeZagk6C23PK8USzO+/vMM8WqfCupxEuasGfOf/+0M5N+VQ74lAV1izxsWozb
 pVy3O1ED/T/Uio3MockqoecYsaFZoM5nIIlOgw8plENJWb3yjjwox9AjsEfEaujsnb68
 IOVqMTy9fnN3g6wXaxfM6RbIvDPE7mCao1FXRj8A/TSQY/MqMupMbZKKUH4BbqRsbYhL
 A5l4/VKV8+PWbuTgXkCsolfEfDvijTz2PZA6VqkhVOnK+y69s5Fgeb0wQIIsJ8rKEgdj
 SujkYF5ty2fp54rgCNUf+CATc00ZmHz3PsiUjJRW/fiU0iySevaD7OgC+1UDg94qcwOe
 2R2g==
X-Gm-Message-State: APjAAAV76OPTsQnNeq9q758+lToP4CyFMPf9oJ3GQl6BBYDz5nxnIkUR
 j87s5nZ3l8nqt5gtvpQa2cT/h0BHm5o7pn4jB1cdr8Nh/NpmPJJtgay0c+l5l5kWOM1T358/jFr
 Gl4t/kdsU7wzjg8o=
X-Received: by 2002:a5d:5403:: with SMTP id g3mr9473767wrv.302.1579672313859; 
 Tue, 21 Jan 2020 21:51:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvx0uKCo55rq2HdAY+SbjrOUciEbpwTLVJa0S4GTS06RZxuNbtBc1q3p6A0GNMp5BlcyJJWA==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr9473745wrv.302.1579672313657; 
 Tue, 21 Jan 2020 21:51:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 n28sm11105341wra.48.2020.01.21.21.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 21:51:53 -0800 (PST)
Date: Wed, 22 Jan 2020 00:51:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] tests: q35: MCH: add default SMBASE SMRAM lock test
Message-ID: <20200122055115.429945-3-mst@redhat.com>
References: <20200122055115.429945-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Y4MyzhiYP0a2KJ-HMvrfFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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


