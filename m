Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E59C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36D22084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKLZ1nP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36D22084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUPzX-0001YS-Hq
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUPu3-0005cI-RT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUPu2-0000c2-Ot
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUPu2-0000bd-LP
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573541030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCLLqG38888t2sVO5GwFFujL32t2nwGBtSf6KfG0fDg=;
 b=MKLZ1nP+DlFL7h6a6BXZ6ddxVSqSHJiHUv27vA+s4AwaNgC+jipn+FzDdAjWK+PSTP1ElQ
 pBpVNJWIJT/tqNEQnJNXf09hGrRYrAeebNDEa9LTc1mxFeby0zpPcTgmrHkYW5vSW67Wnx
 jbmZi86JI6XFbBL5UbdLEWk0ShWjHa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-p6rp4FgGP6qciuABM-TjBA-1; Tue, 12 Nov 2019 01:43:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10DC18017E0;
 Tue, 12 Nov 2019 06:43:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04C3E5DF2A;
 Tue, 12 Nov 2019 06:43:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 6/6] configure: Check bzip2 is available
Date: Tue, 12 Nov 2019 07:43:32 +0100
Message-Id: <20191112064332.5074-7-thuth@redhat.com>
In-Reply-To: <20191112064332.5074-1-thuth@redhat.com>
References: <20191112064332.5074-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: p6rp4FgGP6qciuABM-TjBA-1
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The bzip2 tool is not included in default installations.
On freshly installed systems, ./configure succeeds but 'make'
might fail later:

    BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
  /bin/sh: bzip2: command not found
  make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
  make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
  make: *** Waiting for unfinished jobs....

Add a check in ./configure to warn the user if bzip2 is missing.

See also: 536d2173b2b ("roms: build edk2 firmware binaries ...")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191108114531.21518-3-philmd@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 9b322284c3..6099be1d84 100755
--- a/configure
+++ b/configure
@@ -2154,6 +2154,10 @@ for target in $target_list; do
       ;;
   esac
 done
+# The EDK2 binaries are compressed with bzip2
+if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
+  error_exit "The bzip2 program is required for building QEMU"
+fi
=20
 feature_not_found() {
   feature=3D$1
--=20
2.23.0


