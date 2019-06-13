Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BBC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 06:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B0C20866
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 06:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="om3RpChN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B0C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37146 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbJ54-0003xs-OQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 02:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbJ08-0000i2-2L
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 02:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbIts-0000lb-VB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 02:07:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hbItp-0000XA-C2
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 02:07:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45PYDg5qhGz9sN4; Thu, 13 Jun 2019 16:07:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560406051;
 bh=VV/5ghX6HCg00ETVsmnfiUbadw2OSQO1ASJ7zZQcKtY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=om3RpChNCG5T+ukaqh5arKqjrXTiaul5fRc4qoVpcZW0LwAoBLKoCBVva9LoPMflA
 qp1ngUbGN6UGWpQbxRkvKQlVoDljn6E6izfc0Mi5zPczXNklbQT/fPeKL10JiLVk+s
 QyFkSx2+1U2E5Z+tZtemR9YuR9GP6xP+wk/61Hi0=
From: David Gibson <david@gibson.dropbear.id.au>
To: crosa@redhat.com, qemu-devel@nongnu.org, arikalo@wavecomp.com,
 aurelien@aurel32.net, ehabkost@redhat.com
Date: Thu, 13 Jun 2019 16:07:27 +1000
Message-Id: <20190613060728.26955-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613060728.26955-1-david@gibson.dropbear.id.au>
References: <20190613060728.26955-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 2/3] tests/acceptance: Handle ppc64le host arch
 correctly
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ppc64 and ppc64le are different archs from the host kernel point of view
and are advertised as such in uname.  But these cover the same set of CPU=
s,
just in different endianness modes.  qemu-system-ppc64 handles both modes=
,
so make sure we select the correct binary when running on ppc64le host
architecture.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/acceptance/avocado_qemu/__init__.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 2b236a1cf0..0ba9c536f4 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -39,6 +39,8 @@ def pick_default_qemu_bin(arch=3DNone):
     """
     if arch is None:
         arch =3D os.uname()[4]
+        if arch =3D=3D 'ppc64le':
+            arch =3D 'ppc64'
     qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
                                           "qemu-system-%s" % arch)
     if is_readable_executable_file(qemu_bin_relative_path):
--=20
2.21.0


