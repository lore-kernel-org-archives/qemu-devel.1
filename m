Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D1EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A012067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 15:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0wPHgy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A012067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZwP-0008GJ-9E
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 10:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipZuh-0006VW-4u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipZuf-00025u-U7
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:39:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58001
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipZuf-00021x-GJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 10:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578584396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HO//71iXE8OmCJAAIB/90n/Er377gGIQDqUFgv6iRs=;
 b=Q0wPHgy+2o4acOi6Wum/K0jJ0GaQf/drdf25TsOSW5gZ2gXgPem+4Ir7zsLtxsksTUzEg3
 9Y9xDQJIOzgtrgzednj54nodxqVo5n7HEbIYwmP0aCyEf8rt6Sx9vJL3z6kk6g/kXsZ2y7
 3app9xiH2pUcQ8LyRwtUPXxvS2ioE0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-MXzn9x3rPEax8bXZYCLLaA-1; Thu, 09 Jan 2020 10:39:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E366F8E9DC4;
 Thu,  9 Jan 2020 15:39:53 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-180.brq.redhat.com [10.40.204.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DD8086CB5;
 Thu,  9 Jan 2020 15:39:48 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] configure: Do not build libfdt is not required
Date: Thu,  9 Jan 2020 16:39:36 +0100
Message-Id: <20200109153939.27173-2-philmd@redhat.com>
In-Reply-To: <20200109153939.27173-1-philmd@redhat.com>
References: <20200109153939.27173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MXzn9x3rPEax8bXZYCLLaA-1
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only require libfdt for system emulation, in a small set
of architecture:

4077  # fdt support is mandatory for at least some target architectures,
4078  # so insist on it if we're building those system emulators.
4079  fdt_required=3Dno
4080  for target in $target_list; do
4081    case $target in
4082      aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mi=
ps64el-softmmu|riscv*-softmmu)
4083        fdt_required=3Dyes

Do not build libfdt if we did not manually specified --enable-fdt.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 0ce2c0354a..266a8386d1 100755
--- a/configure
+++ b/configure
@@ -4092,6 +4092,8 @@ if test "$fdt_required" =3D "yes"; then
       "targets which need it (by specifying a cut down --target-list)."
   fi
   fdt=3Dyes
+elif test "$fdt" !=3D "yes" ; then
+  fdt=3Dno
 fi
=20
 if test "$fdt" !=3D "no" ; then
--=20
2.21.1


