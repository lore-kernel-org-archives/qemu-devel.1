Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCB4C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D241D2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuA40D2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D241D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIXh-0001Nl-V1
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkk-0000pJ-7z
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkh-00061X-51
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkg-0005zl-Vh
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id s3so6017565wms.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lELKDL0Qi4GxKG0TXKbAlktFhWCNneWOViNCGmw6D1c=;
 b=HuA40D2jrvC8pxF9AE6mX0sBKns0bDMZLTDVjtqhrEER1p1KPdnAucWv3FfGIEDWr3
 GQ/c5nG6v0Ygoi3QzYBbwwleuD9EJQtdd+5f9TDvlIOf1eJn+7IbaaKlg6Sfwb6esC7D
 AKBG82ScRZO9OthnPFM/yL6Dud0KOOcRH5sypjnqpAp6Psc40NGCQB7swoscZoLE+Gqo
 mDQ8oaVm/HajGwdXXB0IBy7/tYSGsdjcBgC0/iyPEJvzVcMdZ/24I8m8EZI83EjVCPGE
 LAgnOhnYAA31arxY/yENbegKWUcfSn7jo1IamDe0pehar4bD7X+rzunPC+amK0aHrlQP
 tVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=lELKDL0Qi4GxKG0TXKbAlktFhWCNneWOViNCGmw6D1c=;
 b=NIVreFodUTbeR87+wp64zqLvhy4ns1H1OZzc7R4RBHK1fMkuBc8bEwsyOwJaT/YeEw
 xjIIOk+wsDiCPwkiWBf18SEx6MFB6Uox/QwM1rWYFXx7pyYOFQmd/l2lEkl4VvE2RnbL
 Yy4mzulkocI1aBkKmSagKne7kEeW8Z1+kn7Zk0+awdlq+i9bHm1aMAvakgxmaZbKag9K
 qx174TpYijkvYhBgZp0D+25HiAvxFR64Fk4s/UmmirlwAnTqB/sOlVG/91uU4af44hrK
 ZPNNlsRbrtVkOwcgHqHMkk9cjAN389OQbTz3I/P6xdJnHHa51ymYXi3Gw3mj+c8P9CMG
 y8gQ==
X-Gm-Message-State: APjAAAUJeGuByrhNysIqVb86bcqhPgJHB7vX7TlmqOr2SCTe/koNQfEh
 DDZybQvH9YUL/+jJXSUErdz6GPzn
X-Google-Smtp-Source: APXvYqxA8xjTQiPYUSJ9Zz0SXFptQJuYwpnjp+BVAzx36+NTWZdIBTFtJuTxrrNtiohfv7DrzffkRQ==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr3872338wmk.84.1561116641763; 
 Fri, 21 Jun 2019 04:30:41 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:14 +0200
Message-Id: <1561116620-22245-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 19/25] vmstate: Add support for kernel integer
 types
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
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190619162140.133674-8-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/migration/vmstate.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 9224370..ca68584 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -797,6 +797,19 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
     VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
 
+#ifdef CONFIG_LINUX
+
+#define VMSTATE_U8_V(_f, _s, _v)                                   \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint8, __u8)
+#define VMSTATE_U16_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16, __u16)
+#define VMSTATE_U32_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32, __u32)
+#define VMSTATE_U64_V(_f, _s, _v)                                  \
+    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, __u64)
+
+#endif
+
 #define VMSTATE_BOOL(_f, _s)                                          \
     VMSTATE_BOOL_V(_f, _s, 0)
 
@@ -818,6 +831,19 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
+#ifdef CONFIG_LINUX
+
+#define VMSTATE_U8(_f, _s)                                         \
+    VMSTATE_U8_V(_f, _s, 0)
+#define VMSTATE_U16(_f, _s)                                        \
+    VMSTATE_U16_V(_f, _s, 0)
+#define VMSTATE_U32(_f, _s)                                        \
+    VMSTATE_U32_V(_f, _s, 0)
+#define VMSTATE_U64(_f, _s)                                        \
+    VMSTATE_U64_V(_f, _s, 0)
+
+#endif
+
 #define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
                         vmstate_info_uint8_equal, uint8_t, _err_hint)
-- 
1.8.3.1



