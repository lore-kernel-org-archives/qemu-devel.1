Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67084CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34ACE205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azf7Tt/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34ACE205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzgM-00071e-Uh
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzaI-0004zN-0R
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzaG-00035F-N3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzaG-00034w-Ih
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wt6QUAJAWF4zcHVQr9XC4SMX1u8xXeFPU2ITpHr4KlI=;
 b=Azf7Tt/elusGs/8Myc+voEdIMam6PZgQ02LvPUYbgXk0iBpPbSRLMxV+0Zc8UMkyGtYDAD
 aoDRWIeUw+tp1Cj2IjFl/+r5tN0gqtobvpk/m8g1IWpdbilz8jMwoCICS3gbBrec6vGtTz
 NnillVd00A2Weo9kH7dDPur1ucIqgnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-ElkhrOdrNc61VppdGp8Msg-1; Mon, 28 Oct 2019 03:36:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6606E1005510;
 Mon, 28 Oct 2019 07:36:50 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41A3E19C69;
 Mon, 28 Oct 2019 07:36:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/26] tests/acceptance: Test Open Firmware on the PReP/40p
Date: Mon, 28 Oct 2019 08:34:29 +0100
Message-Id: <20191028073441.6448-15-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ElkhrOdrNc61VppdGp8Msg-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

User case from:
https://tyom.blogspot.com/2019/04/aixprep-under-qemu-how-to.html

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v3: use avocado_qemu.wait_for_console_pattern (Cleber)
---
 tests/acceptance/ppc_prep_40p.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index 7dd90bb2bb..ebde5b7dc4 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -48,3 +48,24 @@ class IbmPrep40pMachine(MachineTest):
         os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 20=
07'
         wait_for_console_pattern(self, os_banner)
         wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
+
+    def test_openfirmware(self):
+        """
+        :avocado: tags=3Darch:ppc
+        :avocado: tags=3Dmachine:40p
+        """
+        bios_url =3D ('https://github.com/artyom-tarasenko/openfirmware/'
+                    'releases/download/40p-20190413/q40pofw-serial.rom')
+        bios_hash =3D '880c80172ea5b2247c0ac2a8bf36bbe385192c72'
+        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
+
+        self.vm.set_machine('40p')
+        self.vm.set_console()
+        self.vm.add_args('-bios', bios_path)
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU PReP/40p')
+        fw_banner =3D 'Open Firmware, built  April 13, 2019 09:29:23'
+        wait_for_console_pattern(self, fw_banner)
+        prompt_msg =3D 'Type any key to interrupt automatic startup'
+        wait_for_console_pattern(self, prompt_msg)
--=20
2.21.0


