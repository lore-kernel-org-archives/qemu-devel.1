Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8430CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DCD20656
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wfws58lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DCD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUv0-00063t-Pv
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 13:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPUsb-0003mn-RT
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPUsY-0003DY-6s
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:02:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPUsU-0003C1-3J
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572368512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4TmlfB4pAD+qZ4V+NEMRHad3TLGTMEN+/rejMsbIqs=;
 b=Wfws58lWIJ7KbSrURCKdY1neeyxL18b7hooPi5smi0DXEd5xyuQLxvtnWFZUiC82TKjVph
 O0QQJEPDujmEMNADnII8UfrOBCdTrkB/1eOsZE2hUd0MB931KVBqUpOCd2m3lRULDeOR+7
 5zcrFmXnRidkaGpM7PmbcvM4Xkpw3Zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-uYM5KIXXMaSloJwgenmb5A-1; Tue, 29 Oct 2019 13:01:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D97B4180496F
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 17:01:49 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66BE760132;
 Tue, 29 Oct 2019 17:01:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 2/2] tests/fw_cfg: Test 'reboot-timeout=-1' special value
Date: Tue, 29 Oct 2019 18:01:24 +0100
Message-Id: <20191029170124.27981-3-philmd@redhat.com>
In-Reply-To: <20191029170124.27981-1-philmd@redhat.com>
References: <20191029170124.27981-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uYM5KIXXMaSloJwgenmb5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The special value -1 means "don't reboot" for QEMU/libvirt.
Add a trivial test.

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


