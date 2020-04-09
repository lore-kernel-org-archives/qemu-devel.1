Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C646EC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB9F20753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jD8C0wXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB9F20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaTs-0000SE-Me
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMaNi-0004AQ-8V
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMaNX-0004I0-4t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMaNX-0004Hv-1I
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586451010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4NGfhs1HGx/KhU+MvTCQJYOweIqJyMhKQdliqlI/tvQ=;
 b=jD8C0wXclh5dj7iofZ9haF0EVTngOSA4/yb16C6Dl6//EnQKSvsPUyi0TrEJj3Bi0OgxpY
 7ak9GBlQcb17tTMqYxnZh2TGblNVPc4ZhcG12yhJvMf1gq310ygCdxf+jg9FJMw999fz7k
 j6OCFfpGaM12HRgYG9kniZbd7PCj53I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-rLRxIrbrOtGnEP3hmlyoDg-1; Thu, 09 Apr 2020 12:50:09 -0400
X-MC-Unique: rLRxIrbrOtGnEP3hmlyoDg-1
Received: by mail-wm1-f69.google.com with SMTP id 2so295884wmf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 09:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RZ7KiZLbzf6nVOm0eQ0Iw1Tt+NS2d318U/9Sx06YhPU=;
 b=IdFCdhEHKhBN1Y1xuZj1GI4ntXtVpA1p2gCSGC3PxvcdunEIiDGp4WkplkumecXo9b
 +EE5cwElYpeb9Sd538XhcIIPe0A7oE6w5pInAoPaq9n2Us9sd7N6fpAwlmyqBS7FnTgD
 ZbbVMYYRiCuyZSs6UCU8ed6EufMlcBW14OuuEJ+liLZGqkRcqw8NyG0zDau/VPuCJeKx
 3PImbiAgfU8Je3m9ZpTHZBQRlg8r8mzYy2yeLt/Y3ofd7whwagxnN5ivOIYW2sppx7Y2
 foLkMNMVCKff2ZB2cW4C7mTpn5lZ3xljMomdx46rwgaLk01RsBCRqmM6IKsrscoF5VDJ
 o0aQ==
X-Gm-Message-State: AGi0PuZYcKHlwRpnrW3+Sps2GxlTxVPAsun3CxGpMotFbF8trZJ5NT+G
 l1CT3oJ0O8MhFhUmLZYLpMoqteYG2Jh7mSgtBgRz4b6nbJpfhQrC9i4/ZIjUdlse4uxxGdJbgia
 MBFNdowUv/gkwrTU=
X-Received: by 2002:a5d:6104:: with SMTP id v4mr38737wrt.213.1586451007372;
 Thu, 09 Apr 2020 09:50:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypJK4PkSHMBI1mFhhJEoFFfcw/cqC/y7VuUAL9Nnt8mD2rDnOGL8vc11TP2hOJTKoJx3sE0Y/Q==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr38720wrt.213.1586451007186;
 Thu, 09 Apr 2020 09:50:07 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a67sm4446634wmc.30.2020.04.09.09.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 09:50:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak
 gdb
Date: Thu,  9 Apr 2020 12:49:54 -0400
Message-Id: <20200409164954.36902-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409164954.36902-1-peterx@redhat.com>
References: <20200409164954.36902-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should only pass in gdb_get_reg16() with the GByteArray* object
itself, no need to shift.  Without this patch, gdb remote attach will
crash QEMU.

Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 target/i386/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614e..b98a99500a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray =
*mem_buf, int n)
     } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
         int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
     } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -=3D IDX_XMM_REGS;
--=20
2.24.1


