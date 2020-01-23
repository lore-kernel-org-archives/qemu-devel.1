Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA15C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D2421D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7HWbD1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D2421D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufNP-0008V5-4f
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctD-0007tN-Qq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuctC-0007FS-N1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctC-0007EH-Jw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xU9cHAR+RtjgBQ2YG/0ukzyNIpDX3N8Gy+rv2QWJXMg=;
 b=B7HWbD1SFzZCQ3IQSC40DtBqVBFzSsoDfInNMsy38ADq98vMW5K4TU5DezwlaHwuXiUeIq
 iz211ytChDsTbEgpmxZCaieaPEYQIccmO6ujLaeNkGGQmRL8FZBjahSxJj4bAzPzzsddzW
 mIgM/u/ZUzX2hs+72yc5w13fpmO97oA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-dDMb3EyPPViZZpbD0cFe2Q-1; Thu, 23 Jan 2020 08:51:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFE218010D0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:13 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA9408575C;
 Thu, 23 Jan 2020 13:51:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/59] configure: Do not build libfdt if not required
Date: Thu, 23 Jan 2020 14:50:02 +0100
Message-Id: <1579787449-27599-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dDMb3EyPPViZZpbD0cFe2Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

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

Do not build libfdt if we did not manually specified --enable-fdt,
or have one of the platforms that require it in our target list.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20200118140619.26333-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 557e438..c67a7e7 100755
--- a/configure
+++ b/configure
@@ -4095,6 +4095,8 @@ if test "$fdt_required" =3D "yes"; then
       "targets which need it (by specifying a cut down --target-list)."
   fi
   fdt=3Dyes
+elif test "$fdt" !=3D "yes" ; then
+  fdt=3Dno
 fi
=20
 if test "$fdt" !=3D "no" ; then
--=20
1.8.3.1



