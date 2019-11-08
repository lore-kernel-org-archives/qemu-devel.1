Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F8C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00F9222D1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWbJC8BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00F9222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2kN-0001fK-9w
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT2iA-0000OR-SJ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT2i9-0005TM-PN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:45:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT2i9-0005Sn-LW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573213552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYk861gpC556EgkJCnEz6rjQ4KpNOr1kPb/DgPho6tQ=;
 b=bWbJC8BHqAwx2yIOAHKe0onT5yc8eNsHqgJ2c6RNwf/MbMe5ZFSj10Tz5TAq2Rx8v56820
 keZs+L2AFxT3qUMB+yoh+I6jSg8zkRklJKRHV7m7hwN+NTHcHbcspbJwNS/c6cfEsENGTk
 +9Oo3h2bnDnfZdxp+04cPeHNQFz0E0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-uFJ5HhKZPMGOmmm9K39daw-1; Fri, 08 Nov 2019 06:45:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82CE0800A1A;
 Fri,  8 Nov 2019 11:45:50 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE22D600C9;
 Fri,  8 Nov 2019 11:45:47 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH v2 2/2] configure: Check bzip2 is available
Date: Fri,  8 Nov 2019 12:45:31 +0100
Message-Id: <20191108114531.21518-3-philmd@redhat.com>
In-Reply-To: <20191108114531.21518-1-philmd@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uFJ5HhKZPMGOmmm9K39daw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
v2: use better English (Daniel)
(Not taking Daniel Reviewed-by because logic changed)
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 9b322284c3..2b419a8039 100755
--- a/configure
+++ b/configure
@@ -2147,6 +2147,7 @@ case " $target_list " in
   ;;
 esac
=20
+# Some firmware binaries are compressed with bzip2
 for target in $target_list; do
   case "$target" in
     arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
@@ -2154,6 +2155,9 @@ for target in $target_list; do
       ;;
   esac
 done
+if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
+  error_exit "The bzip2 program is required for building QEMU"
+fi
=20
 feature_not_found() {
   feature=3D$1
--=20
2.21.0


