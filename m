Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4914FC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EC620674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yyd4G2PA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EC620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHlh-0000Rw-8P
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHT8-0000hO-5G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHT2-00055d-9H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHT2-000551-5g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583756707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o80iYyi9PSaziGW4BFW5nB5KIni89LhgcEseD8RIrKM=;
 b=Yyd4G2PA5UjphzRt4KHXG3lLOgmCSv492CQEY+Gfehrs47uqEF9QmDuhAUREojJGoJDl8S
 Cn1wkiMsA6ZAeYz2DKgDLUvgki61+GxxX2kR88GV7dVAhQCu2MLDqwNA3FBH+tnwyv035v
 nbZFg6UqtdpJ4pKstnyEF3ZMHwU4168=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-esniyDiJOwaNea6WWoYsRw-1; Mon, 09 Mar 2020 08:25:05 -0400
X-MC-Unique: esniyDiJOwaNea6WWoYsRw-1
Received: by mail-wr1-f69.google.com with SMTP id c6so5099874wrm.18
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PTSezPJVmrlbvaU6EOImy8yB1mRHDHMGvBW/t0vnzrg=;
 b=lsm0WF0szUyu8neQf2+/xJdeb2imSNSIDW2YOEE5XK3K/7EKLeOOKEsBBaZGrTQsD3
 3NX7w9FNcAQx2vIddsopPOoSAfqh6m1LgNEKi1pBi7sRCjKWBG5tBSe5YGTet8USixZT
 98p6HTF2qarLz2Q5Mrc02a727hPyi6qy7LjJMFte3SW7IqoZ1vXgxCHdCODYY9IEhLt/
 bkAeU9RIR7TYsD9XYEKuw43k6azq54vJgh8K5Gt2/bD0qqSx2j2JW/T81NFobQSRJU/x
 5nw/+43WM919h8d07mCRQjM30x/8FCTVdieGdRWytxzOwJz4gWoygMjiepRs0/dg35Vy
 LJSg==
X-Gm-Message-State: ANhLgQ3p2X5K64xBnkz07AV4btshvqA6ieI48d19qkh9+wXK5KRpZMOi
 /PVAQXJvmXjWLzjBuLUGqkCKKKraSCbD7UbZOZq4Xobi3oiY+7FPQZY9eW9R07zs1KWuYM9x0zD
 jYd1aM8ENRI496rg=
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr20420963wmm.77.1583756704231; 
 Mon, 09 Mar 2020 05:25:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtWVzwuZjkDbgyyogzPL7VfBMhyabtKKq7i9IwHwdE8X5tycTeGSzqyOca3shGRFUdLc8lfVQ==
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr20420933wmm.77.1583756703970; 
 Mon, 09 Mar 2020 05:25:03 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c5sm9826379wma.3.2020.03.09.05.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:25:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] configure: Fix building with SASL on Windows
Date: Mon,  9 Mar 2020 13:24:53 +0100
Message-Id: <20200309122454.22551-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309122454.22551-1-philmd@redhat.com>
References: <20200309122454.22551-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Alexey Pavlov <alexpux@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Youry Metlitsky <winaes@yandex.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Simple Authentication and Security Layer (SASL) library
re-defines the struct iovec on Win32 [*]. QEMU also re-defines
it in "qemu/osdep.h". The two definitions then clash on a MinGW
build.
We can avoid the SASL definition by defining STRUCT_IOVEC_DEFINED.
Since QEMU already defines 'struct iovec' if it is missing, add
the definition to vnc_sasl_cflags to avoid SASL re-defining it.

[*] https://github.com/cyrusimap/cyrus-sasl/blob/cyrus-sasl-2.1.27/include/=
sasl.h#L187

Cc: Alexey Pavlov <alexpux@gmail.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>
Reported-by: Youry Metlitsky <winaes@yandex.ru>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2:
Since QEMU provides 'struct iovec' if missing, always define
STRUCT_IOVEC_DEFINED (danpb review).
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index cbf864bff1..a4cd4bccfb 100755
--- a/configure
+++ b/configure
@@ -3349,7 +3349,9 @@ if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D "no=
" ; then
 int main(void) { sasl_server_init(NULL, "qemu"); return 0; }
 EOF
   # Assuming Cyrus-SASL installed in /usr prefix
-  vnc_sasl_cflags=3D""
+  # QEMU defines struct iovec in "qemu/osdep.h",
+  # we don't want libsasl to redefine it in <sasl/sasl.h>.
+  vnc_sasl_cflags=3D"-DSTRUCT_IOVEC_DEFINED"
   vnc_sasl_libs=3D"-lsasl2"
   if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
     vnc_sasl=3Dyes
--=20
2.21.1


