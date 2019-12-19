Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68A624672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68A624672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihpyV-0000fU-RA
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 02:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <emacsray@gmail.com>) id 1ihpxp-0000Do-Gf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <emacsray@gmail.com>) id 1ihpxn-0005jW-GW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:11:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <emacsray@gmail.com>) id 1ihpxl-0005fq-QZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:11:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so2114719pls.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 23:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5WZZ5NLRZqu8+2CTFjFkXJeX9hvXXo7z+9b4TUPa5Mk=;
 b=fU/NkPufRJwSPTrQHZAnnEsnvOaz8rXGbBztb75Y0FxeVkCl4kMKpyXlWBboTM2s6M
 1O6U4MO5xymbN5DirZnJQqvwjN5jugmEmTQfpc4Mp4s61Gax/SBao0dUThKq2OSfsUcm
 jzljb0B9VCTXPadJ00Wd28GmafuZJuGTEY4cL/NZ9eJBE74tg4HkBQS1raaDtR0+OQJc
 AOvPZWTK2qXrbBaLCUbBpX/qlPwD4Mo+n9vpUBtZd6crXYTKcAw5rlf5VGm1qlyZGZQZ
 vmacHUPM7LDgC98i7kI2I7xxQoe9U7MiVqpO8twkzUJhtTxBTtWKgkEm5LRe0PY662gY
 Dt1g==
X-Gm-Message-State: APjAAAXu1tLSb7ZcPYme9B3aYbxBQ4DSnfEUdZfiL4JthKZM7wEXquvt
 d7X5xJYPnD6aSX+f012n39g=
X-Google-Smtp-Source: APXvYqyvH9CR6EtLSvG34irKr9bhXLpR9DsU5Ma3aKTrq2H+jcFOfTLWAvIb/9Me2NnV4NSGEClc5Q==
X-Received: by 2002:a17:90a:d801:: with SMTP id
 a1mr8077258pjv.34.1576739468171; 
 Wed, 18 Dec 2019 23:11:08 -0800 (PST)
Received: from localhost (c-71-204-169-238.hsd1.ca.comcast.net.
 [71.204.169.238])
 by smtp.gmail.com with ESMTPSA id h26sm6865035pfr.9.2019.12.18.23.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 23:11:07 -0800 (PST)
Date: Wed, 18 Dec 2019 23:11:05 -0800
From: Fangrui Song <i@maskray.me>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 5/7] configure: Unnest detection of -z, relro and -z,
 now
Message-ID: <20191219071105.5zbgczhqla44kdci@gmail.com>
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-6-richard.henderson@linaro.org>
 <d6e9a554-cd86-fbe0-deea-2e7c4ad38ac2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6e9a554-cd86-fbe0-deea-2e7c4ad38ac2@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
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
Cc: berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-12-18, Philippe Mathieu-Daudé wrote:
>On 12/18/19 11:34 PM, Richard Henderson wrote:
>>There is nothing about these options that is related to PIE.
>>Use them unconditionally.
>>
>>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>---
>>v2: Do not split into two tests.
>>---
>>  configure | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>>diff --git a/configure b/configure
>>index 7a646ec007..2503288654 100755
>>--- a/configure
>>+++ b/configure
>>@@ -2040,9 +2040,6 @@ if test "$pie" != "no" ; then
>>      QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
>>      LDFLAGS="-pie $LDFLAGS"
>>      pie="yes"
>>-    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
>>-      LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
>>-    fi
>>    else
>>      if test "$pie" = "yes"; then
>>        error_exit "PIE not available due to missing toolchain support"
>>@@ -2053,6 +2050,12 @@ if test "$pie" != "no" ; then
>>    fi
>>  fi
>>+# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
>>+# The combination is known as "full relro", because .got is read-only too.
>>+if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
>>+  LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
>>+fi
>>+
>>  ##########################################
>>  # __sync_fetch_and_and requires at least -march=i486. Many toolchains
>>  # use i686 as default anyway, but for those that don't, an explicit
>>
>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

One nit, .got is also read-only in partial relro. Full relro makes .got.plt
read-only. (On EM_PPC and EM_PPC64, .got.plt is named .plt (yes,
misnomer)).

Reviewed-by: Fangrui Song <i@maskray.me>

