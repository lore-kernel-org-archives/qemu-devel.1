Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B20C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D8720656
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaD9RS/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D8720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdD1-0001K2-7n
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAd9r-0005jW-Pt
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAd9q-0005QO-Kh
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAd9q-0005Q6-H0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583601758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7T7L99OQDVbIxCTEB+jIvaqywtD0ZftuDW6r9s/Hf0=;
 b=LaD9RS/TI+u42zbfNdAGHZWsckk8ZDRVcXu0VVIoEDJAEj5NxEyRKB2cLPmnnVBYztymou
 MrgOOO8fJIwLGiqxP/b1O1DQOLmHcVPyNKcJ/rDYlKnwxzbQKBPD1Z8RIcxG0lk1UFGJwS
 NpmkJFokk/GwcQJISZK+KnhY1CTHG0Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-TOvEIdJSNI23YAd9C8GNBg-1; Sat, 07 Mar 2020 12:22:35 -0500
X-MC-Unique: TOvEIdJSNI23YAd9C8GNBg-1
Received: by mail-wr1-f71.google.com with SMTP id w11so2605729wrp.20
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iKSYfxKjMD7Cb1qgoag60tedE3tMw/hvzBypcSrEkXA=;
 b=gK2By/XmtnR4cFazYNFsTaLjbREagPfMHq3QREzcpOjV75aDwK492Gb2tnwnY5n0hU
 YNFFTfUhdwp5X4//jZ36BoxraUYYXILQ8rXDNDUvHZ+L6LluJsyXI5ow8kw6StyYNhf6
 MA7Re9q+gOE+Ep7oLkxYPYzsWtq4npz40UTaG2DUvxv1XW0aViDXHayVFpA+aYMLias6
 u4yGeJ6TFDRc0fcpfGHLw8gzRpWe/+NW5Iem57mgdSumxXHCt6mOM1q/K7dwMO8jGgd1
 i9ucAFAatidLV8xwUQjPbOyypcmuGekdhXa/6gssCd+ctVb+EhYMdVNkH4gallMmGpsP
 UBFA==
X-Gm-Message-State: ANhLgQ3qJTO9hdfLA6vbRWE4Uxz0QoXUrBtvnrb39wxUY+0b3W5KffLl
 pOdgb+CLj+4xWvEpjwExKyiIC/WJN47sQlO3ApfxL5WmZh9LdItVRdcVxJoVYGfOv1uQZvFGjGS
 ti6MIMZ8078rJLlo=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr10512317wmh.22.1583601754228; 
 Sat, 07 Mar 2020 09:22:34 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvWrC2cd3D+wn8unY4UnsfDnUISFeshpqpt2X7p1OHittKMLP9otmBPzOdrQ3XnDr61wZZEjg==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr10512292wmh.22.1583601753976; 
 Sat, 07 Mar 2020 09:22:33 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d15sm52096074wrp.37.2020.03.07.09.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 09:22:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] configure: Fix building with SASL on Windows
Date: Sat,  7 Mar 2020 18:22:21 +0100
Message-Id: <20200307172222.14764-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200307172222.14764-1-philmd@redhat.com>
References: <20200307172222.14764-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Fam Zheng <fam@euphon.net>, Alexey Pavlov <alexpux@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Youry Metlitsky <winaes@yandex.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Simple Authentication and Security Layer (SASL) library
re-defines the struct iovec on Win32 [*]. QEMU also re-defines
it in "qemu/osdep.h". The two definitions then clash on a MinGW
build.
We can avoid the SASL definition by defining STRUCT_IOVEC_DEFINED.
Add the definition to vnc_sasl_cflags if we are uing MinGW.

[*] https://github.com/cyrusimap/cyrus-sasl/blob/cyrus-sasl-2.1.27/include/=
sasl.h#L187

Cc: Alexey Pavlov <alexpux@gmail.com>
Cc: Biswapriyo Nath <nathbappai@gmail.com>
Cc: Youry Metlitsky <winaes@yandex.ru>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 0c2dd1eb08..0bc87ce42a 100755
--- a/configure
+++ b/configure
@@ -3375,7 +3375,13 @@ if test "$vnc" =3D "yes" && test "$vnc_sasl" !=3D "n=
o" ; then
 int main(void) { sasl_server_init(NULL, "qemu"); return 0; }
 EOF
   # Assuming Cyrus-SASL installed in /usr prefix
-  vnc_sasl_cflags=3D""
+  if test "$mingw32" =3D "yes" && test "$iovec" !=3D "yes"; then
+    # QEMU defines struct iovec in "qemu/osdep.h",
+    # we don't want libsasl to redefine it in <sasl/sasl.h>.
+    vnc_sasl_cflags=3D"-DSTRUCT_IOVEC_DEFINED"
+  else
+    vnc_sasl_cflags=3D""
+  fi
   vnc_sasl_libs=3D"-lsasl2"
   if compile_prog "$vnc_sasl_cflags" "$vnc_sasl_libs" ; then
     vnc_sasl=3Dyes
--=20
2.21.1


