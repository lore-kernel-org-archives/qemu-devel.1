Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27224CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF10120880
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 23:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH84qZt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF10120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPEum-0004Sq-RB
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 19:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPEn1-00030D-24
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPEmp-00046t-Hc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:51:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPEmp-00046d-Cv
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 19:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572306658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBeA289qT+sjtgs24ntjHLcpADDOYxYMpDL3O+R7zjU=;
 b=UH84qZt1OWKqN4ONbXuE4D0bHVrGDqLu6ycZzzg8NBo4CwEyWgP+9Ja6q0dGG9eMD3ohFJ
 owlAAH+qCNcacW2gfvtk/B34UuJIA/94SRMNn0VydoYQXeGNWRygWfh30g8Z7qRFqF6lS5
 JRF930cvbyi9ib+w1K7zNN+jjGdM3P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Qk6WEPk2PAyIO6o0jWdbHg-1; Mon, 28 Oct 2019 19:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E76107AD29;
 Mon, 28 Oct 2019 23:50:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9D645C1B2;
 Mon, 28 Oct 2019 23:50:48 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PULL 11/16] tests/acceptance: Test OpenBIOS on the PReP/40p
Date: Mon, 28 Oct 2019 19:49:57 -0400
Message-Id: <20191028235002.17691-12-crosa@redhat.com>
In-Reply-To: <20191028235002.17691-1-crosa@redhat.com>
References: <20191028235002.17691-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Qk6WEPk2PAyIO6o0jWdbHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

User case from:
https://mail.coreboot.org/pipermail/openbios/2018-May/010360.html

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20191028073441.6448-16-philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
[Cleber: added skip conditional for Travis]
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index 9d95e18fcb..6f507fb0a6 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -47,3 +47,36 @@ class IbmPrep40pMachine(Test):
         os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 20=
07'
         wait_for_console_pattern(self, os_banner)
         wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
+
+    def test_openbios_192m(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:40p
+        """
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-m', '192') # test fw_cfg
+
+        self.vm.launch()
+        wait_for_console_pattern(self, '>> OpenBIOS')
+        wait_for_console_pattern(self, '>> Memory: 192M')
+        wait_for_console_pattern(self, '>> CPU type PowerPC,604')
+
+    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
+    def test_openbios_and_netbsd(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:40p
+        """
+        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+                     'NetBSD-7.1.2-prep.iso')
+        drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
+        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
,
+                                      algorithm=3D'md5')
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
--=20
2.21.0


