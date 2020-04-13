Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A24C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF6320732
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdKyCcyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF6320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO0Ki-00039E-VI
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 10:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jO0Jy-000220-9T
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 10:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jO0Jx-0008CN-3C
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 10:44:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jO0Jw-0008Bq-TL
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 10:44:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id v8so10253561wma.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t9jL+pXVDX7xZZ+uitwUhh31BfVOYkFNDqkU1GTdB94=;
 b=rdKyCcyGgesiU6gE8YxKwemvM4T6/7ycGkNp6f/qo0kN5at/skVv28G5GFeiV7Yasn
 i9uT+OBltXBymfReeSQTmXfiMcE2boKpU5WFuTnnZ2nHFfNlbGkssc5LcaVkVueSo8Fz
 FW2vfludxOm5ZOu+Y8Tv6aTOlxSV+F3FWtTyUj+WqnxWnvocxg5Delo4LKp7/8iRXtNE
 OUDKqzx951kUzpVIq/oj6KKGN69OUM2uZV0p5opKfXa8PAN5EkDGw0W5Wd5PmTi2dWHK
 jNkXbx3NSxxYFWtIOOcI+7UxaRzhnLRzTX4fw5noVlugTR0UtPGE4tw09fvlU+rLSfe3
 PtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t9jL+pXVDX7xZZ+uitwUhh31BfVOYkFNDqkU1GTdB94=;
 b=ocBYFBCImkjh1I4oULZCI3e8qGyjv49kjCD92IGoaqT03jfLgnc/QYS1DEzBztJ052
 24mp4Rv++EOVjv9nC1tqu7jsXS8SHaU65kq9yaK5APG4YJulNEq03js3FpBav19cR89p
 P/hr0PXehaZpzYEWWEL7uj0tVkZyEgS7uHF8cJyw5g8DEava+MjXsXacWx7KnJpKKIXE
 wB2X0Owv+4W9IdjrKdDr7DlgCbedX6NnmHe8251QVwJau2vzqUrRQ7fSI85BuzSbcb2f
 zxD7F8wnOYO0ma2u4V/B12H8MI+75VT7b8+/sRcvgqH5AkiwGma2N8BjIIGwIFV8588W
 sASA==
X-Gm-Message-State: AGi0PuaM5PeFmwz2Wz0ApPz9JKqGF9XYtNoeEd+cI8zS+qyX6cgRkqlF
 ULUaOfizeT0mo7jEdfuC2i582A==
X-Google-Smtp-Source: APiQypIX2VhMvHujNMRt+f7vkC/luXwHgLlBiaFVY4Zabwr4W/he5ZXsIwCqNQUxZZeB1B+zJDhdRA==
X-Received: by 2002:a1c:e444:: with SMTP id b65mr19602884wmh.6.1586789059189; 
 Mon, 13 Apr 2020 07:44:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm15082639wmg.2.2020.04.13.07.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 07:44:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 452C91FF7E;
 Mon, 13 Apr 2020 15:44:17 +0100 (BST)
References: <20200412233246.4212-1-changbin.du@gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] gdbstub: Fix segment fault for i386 target
In-reply-to: <20200412233246.4212-1-changbin.du@gmail.com>
Date: Mon, 13 Apr 2020 15:44:17 +0100
Message-ID: <87lfmz8mym.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Changbin Du <changbin.du@gmail.com> writes:

> With GByteArray, we should pass the object itself but not to plus an offs=
et.
>
> gdb log:
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-ve=
c-unaligned-erms.S:384
> 384	../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: No such fil=
e or directory.
>
> Fixes: a010bdbe71 ("gdbstub: extend GByteArray to read register helpers")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> ---
> v2: remove m68k fix since it's already queued.

I also have Peter Xu's fix for i386:

  https://patchew.org/QEMU/20200409211529.5269-1-alex.bennee@linaro.org/202=
00409211529.5269-10-alex.bennee@linaro.org/

But I'll happily add your Reported-by credit to that patch.

> ---
>  target/i386/gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index f3d23b614e..b98a99500a 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArra=
y *mem_buf, int n)
>      } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>          floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>          int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>          return len;
>      } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>          n -=3D IDX_XMM_REGS;


--=20
Alex Benn=C3=A9e

