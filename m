Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F36FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BDC2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi+Gq3UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BDC2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1Vp-0001kD-Mg
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT1V8-0001FA-To
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT1V7-0004UI-8M
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:28:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT1V5-0004Ta-TX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573208899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LuXOBqpoehuMmj9xNKBrxg6Q0fWKtvJkk9YW8IQisWI=;
 b=gi+Gq3UVLwpQCCq/msI3KPeDC4r/DvSkbI4AUMo9cRPKWFNrQGINkVmgpwkMkVTCcjJM+F
 +ceYfpvVznB7vNH/uStjch+ITFm/pV0EEILfjhypyr9qTZjkgJRS4uid+AuTLVNzVGt9lT
 8URW700BzG0ltUaFHoaulmF+5iOQ0MA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-L2O6izZnNoSbX2otIXfmwA-1; Fri, 08 Nov 2019 05:28:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8E991005500;
 Fri,  8 Nov 2019 10:28:16 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 610165C1BB;
 Fri,  8 Nov 2019 10:28:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] configure: Check bzip2 is available
Date: Fri,  8 Nov 2019 11:28:05 +0100
Message-Id: <20191108102805.8258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: L2O6izZnNoSbX2otIXfmwA-1
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bzip2 tool is not included in default installations.
On freshly installed systems, ./configure succeeds but 'make'
might fail later:

    BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
  /bin/sh: bzip2: command not found
  make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
  make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
  make: *** Waiting for unfinished jobs....

Add a check in ./configure to warn the user if bzip2 is missing.

Fixes: 536d2173b2b
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index efe165edf9..9957e913e8 100755
--- a/configure
+++ b/configure
@@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys; print("%d=
.%d.%d" % (sys.version_info[0]
 # Suppress writing compiled files
 python=3D"$python -B"
=20
+# Some firmware binaries are compressed with bzip2
+if has bzip2; then
+  :
+else
+  error_exit "bzip2 program not found. Please install it"
+fi
+
 # Check that the C compiler works. Doing this here before testing
 # the host CPU ensures that we had a valid CC to autodetect the
 # $cpu var (and we should bail right here if that's not the case).
--=20
2.21.0


