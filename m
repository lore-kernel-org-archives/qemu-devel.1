Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B0DC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A72206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxK3372j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A72206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7y1-0005eL-Iw
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ix7wy-0004Eh-Fv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ix7wx-0003jV-HD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:25:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ix7wx-0003hI-DR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580383530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QgGQR5lmCzHdU2tw8u26Dp0LVz138MaKuXfv7AyzLc=;
 b=IxK3372jjIT44H9oQ/ZeKfZ4p6iyhzQZ8Xqx9qNkUzoV8DcTqE61E+xVU/0HYRaEamhb7t
 wT10g7wJ8BDrSMlu6p6eT9EuGvjL/BZSUk49uSehAcmwQZ5Wh6l2xGqZnTK2/AjPiRsr8B
 2vpDGLr9d1vQP7OUPovCPSrNyMADw4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-cMBhXBiuMBGb8VIjkEFuNw-1; Thu, 30 Jan 2020 06:25:28 -0500
X-MC-Unique: cMBhXBiuMBGb8VIjkEFuNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35C8210054E3;
 Thu, 30 Jan 2020 11:25:27 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 715341001B05;
 Thu, 30 Jan 2020 11:25:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v2 1/9] arm64: Provide read/write_sysreg_s
Date: Thu, 30 Jan 2020 12:25:02 +0100
Message-Id: <20200130112510.15154-2-eric.auger@redhat.com>
In-Reply-To: <20200130112510.15154-1-eric.auger@redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Sometimes we need to test access to system registers which are
missing assembler mnemonics.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 lib/arm64/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index a03830b..a45eebd 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -38,6 +38,17 @@
 	asm volatile("msr " xstr(r) ", %x0" : : "rZ" (__val));	\
 } while (0)
=20
+#define read_sysreg_s(r) ({					\
+	u64 __val;						\
+	asm volatile("mrs_s %0, " xstr(r) : "=3Dr" (__val));	\
+	__val;							\
+})
+
+#define write_sysreg_s(v, r) do {				\
+	u64 __val =3D (u64)v;					\
+	asm volatile("msr_s " xstr(r) ", %x0" : : "rZ" (__val));\
+} while (0)
+
 asm(
 "	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23=
,24,25,26,27,28,29,30\n"
 "	.equ	.L__reg_num_x\\num, \\num\n"
--=20
2.20.1


