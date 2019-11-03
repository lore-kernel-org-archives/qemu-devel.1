Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB123CA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724592190F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgBnqetd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724592190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iROMK-0007ZH-Kj
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 17:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iROJS-0004VB-G7
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iROJQ-0002ZX-GT
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iROJQ-0002Yo-DK
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572819931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkafGVidG9zgHVqptL7Xr8/hhEFRnCpiTju5lPVbzBA=;
 b=WgBnqetdtpMl9s/7pl2fIGApKR9Ba/yY9J4ufhCp9n3dZMcR0Ziv+9p+X2oPrZmLSesgD/
 //qfs3PR3jJTB1zxkIr1/x4C4YI2VVjePsbbuI1oBZWr73g8YK+6TXY3fr17EQlXg2Eipe
 8mUkysU6ALKMoH5Tc6ebxOH+A7eiih8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-2diVFgdLPD6UXkzJtpl0fQ-1; Sun, 03 Nov 2019 17:25:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC45477
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 22:25:28 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-75.brq.redhat.com [10.40.204.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57DD1600C1;
 Sun,  3 Nov 2019 22:25:25 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] tests/fw_cfg: Test 'reboot-timeout=-1' special value
Date: Sun,  3 Nov 2019 23:25:11 +0100
Message-Id: <20191103222511.17478-3-philmd@redhat.com>
In-Reply-To: <20191103222511.17478-1-philmd@redhat.com>
References: <20191103222511.17478-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2diVFgdLPD6UXkzJtpl0fQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The special value -1 means "don't reboot" for QEMU/libvirt.
Add a trivial test.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/fw_cfg-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
index 1d3147f821..5dc807ba23 100644
--- a/tests/fw_cfg-test.c
+++ b/tests/fw_cfg-test.c
@@ -194,6 +194,26 @@ static void test_fw_cfg_reboot_timeout(void)
     qtest_quit(s);
 }
=20
+static void test_fw_cfg_no_reboot_timeout(void)
+{
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    uint32_t reboot_timeout =3D 0;
+    size_t filesize;
+
+    /* Special value -1 means "don't reboot" */
+    s =3D qtest_init("-boot reboot-timeout=3D-1");
+    fw_cfg =3D pc_fw_cfg_init(s);
+
+    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
+                                &reboot_timeout, sizeof(reboot_timeout));
+    g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
+    reboot_timeout =3D le32_to_cpu(reboot_timeout);
+    g_assert_cmpint(reboot_timeout, =3D=3D, UINT32_MAX);
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 static void test_fw_cfg_splash_time(void)
 {
     QFWCFG *fw_cfg;
@@ -233,6 +253,7 @@ int main(int argc, char **argv)
     qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
     qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
     qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
+    qtest_add_func("fw_cfg/no_reboot_timeout", test_fw_cfg_no_reboot_timeo=
ut);
     qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
=20
     return g_test_run();
--=20
2.21.0


