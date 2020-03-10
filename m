Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F0424677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqC1gt8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F0424677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaLP-0006jO-Al
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaJo-000524-Nb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaJi-0004Po-GE
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaJi-0004N5-9D
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sOVMOqnxDkodmVut3xrgbX07a4xhm8JWDSSQd23JJJE=;
 b=AqC1gt8r1Q6LkKe76BkGn7G3+DV8pWkRJlEDFH365HkXi+EKgFJPPc3YAgaK4cyFt1JkqG
 7e+1ywspBoZ2BEEK7LcgxxPRV0uPbpwifElh/p8GovDXxwkqtvGlSUEQ7kLlRcT66/Hi02
 eqC9DQHaBBjTt/WpAt6PAs2ln9gw3NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-UUIK3UqRM4ioH2PfF2z8uQ-1; Tue, 10 Mar 2020 04:32:22 -0400
X-MC-Unique: UUIK3UqRM4ioH2PfF2z8uQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9828713F5;
 Tue, 10 Mar 2020 08:32:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2B0E5C1D4;
 Tue, 10 Mar 2020 08:32:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3F82F9D26; Tue, 10 Mar 2020 09:32:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tests/vm: update FreeBSD to 12.1
Date: Tue, 10 Mar 2020 09:32:17 +0100
Message-Id: <20200310083218.26355-4-kraxel@redhat.com>
In-Reply-To: <20200310083218.26355-1-kraxel@redhat.com>
References: <20200310083218.26355-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/freebsd | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 58166766d915..298967fe9cf4 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -24,8 +24,8 @@ class FreeBSDVM(basevm.BaseVM):
     name =3D "freebsd"
     arch =3D "x86_64"
=20
-    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/Fr=
eeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
-    csum =3D "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb485fb=
99db"
+    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.1/Fr=
eeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
+    csum =3D "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f26b1cf=
cd88"
     size =3D "20G"
     pkgs =3D [
         # build tools
--=20
2.18.2


