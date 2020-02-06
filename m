Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1153C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3DB21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKtKrlJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3DB21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izocc-0004UI-H1
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoZy-00083y-QX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoZx-0002zG-Ll
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22245)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoZv-0002rZ-MB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+PCkhIdpqz/m8hRF4VAgSvss5F+i1qpNMW8GEe55Fk=;
 b=EKtKrlJElAAO6sdVIdHwzKNlpd71EO71smeeVXqwKJtKuKDJHUy42bUCNYUFTNB5+U1Sx5
 CSVkBhl813hLfp0Az9coTCOQXkNTAuYjRx6RyauJxTEoqG5l5DYVifTSZlwc9G8UxUEBZ0
 ewLMm58/GFzmhPjbXT0vr8l15FccfdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-wid9fEhJMQS_1K42h82wVg-1; Thu, 06 Feb 2020 16:20:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 074451007276;
 Thu,  6 Feb 2020 21:20:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FEEE60BEC;
 Thu,  6 Feb 2020 21:20:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/46] tests/boot_linux_console: add extract_from_rpm method
Date: Thu,  6 Feb 2020 22:19:03 +0100
Message-Id: <20200206211936.17098-14-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: wid9fEhJMQS_1K42h82wVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liam Merwick <liam.merwick@oracle.com>

Add a method to extract a specified file from an RPM to the test's
working directory and return the path to the extracted file.

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <1580914565-19675-5-git-send-email-liam.merwick@oracle.com>
[PMD: Rebased]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index e40b84651b..16b7503b5f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -51,6 +51,22 @@ class BootLinuxConsole(Test):
         os.chdir(cwd)
         return self.workdir + path
=20
+    def extract_from_rpm(self, rpm, path):
+        """
+        Extracts a file from an RPM package into the test workdir.
+
+        :param rpm: path to the rpm archive
+        :param path: path within the rpm archive of the file to be extract=
ed
+                     needs to be a relative path (starting with './') beca=
use
+                     cpio(1), which is used to extract the file, expects t=
hat.
+        :returns: path of the extracted file
+        """
+        cwd =3D os.getcwd()
+        os.chdir(self.workdir)
+        process.run("rpm2cpio %s | cpio -id %s" % (rpm, path), shell=3DTru=
e)
+        os.chdir(cwd)
+        return os.path.normpath(os.path.join(self.workdir, path))
+
     def test_x86_64_pc(self):
         """
         :avocado: tags=3Darch:x86_64
--=20
2.21.1


