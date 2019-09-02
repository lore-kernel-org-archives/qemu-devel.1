Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3253C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6452173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTYLHez+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6452173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4nha-00070f-NY
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 10:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4ngW-0006YD-QG
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4ngU-00039h-9p
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:52:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4ngU-000371-1u
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 10:51:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id k2so13464456wmj.4
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nwBODypQlm3P/S4YKyx1IqjW2IaGiZPAWzWzzPgJUYI=;
 b=zTYLHez+f2//6J2ZTxCQwAKH98RAaYVfRhftH5E2coDuUixwY6uFIAjTNCspwYl4ai
 xGuCO3vmsHT0kZGwvXfjAMIqBx/wEpOfRmOLvZYqbCztulgsMbvXpmswaww1y2bEx77u
 hajovtDAniJxePidj7nD2eaVqj5dxMY+p5eGPhR4IsPB6TPgX2AkRiAc0CFHrkUPvppW
 /fzRW80+Tv1107+ezyyuPS8jD/l4dY8sFR4EvPlHd/6tmD+eWe3adHpn4CeKhHlgUQ3b
 z+AbxvY6t80drgEuLmaIesD0Tgn3RepJUqSyBL8ZcTosx619Gpv1bIcRz6wqVq2OqoE5
 VA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nwBODypQlm3P/S4YKyx1IqjW2IaGiZPAWzWzzPgJUYI=;
 b=cNX7fIxrEVMY7dP1iXpLSwVlVE2JucRNOP4sVF/7Gmbc5sniqujUIOue+AZRjesVFX
 IZ+HVRTC2XrUsoQE6WNvWbWRBD257UPYDW3sYFdgKCg/M8yVtUanlGMIzdjMrxRfbzmN
 kaXJfQ4zo8ZKMfwdyKBF3dY0lHlbKewP2/dh/tUW9CXHXdcbC/cXvFdRuDjjArTQmmkj
 4WXkXBs6b/3EtOKgRgrj3pk+3FX84EwRl1j/3OzzGDjKKnA6UHf2CFDH0Uc9Cff7Z8cJ
 sYxxiQfupfv2IX3AxRNaH1ZlDo/JjQEuH6LxlvkJXBjmOf2z7c7/OeTTWdagkO6RPh3m
 hSWA==
X-Gm-Message-State: APjAAAVK3BXomJdTkvRqXk68FDzpNhR0EBComHMP2ZzfwWQM7U3y0+GV
 d9PMg1lDmCo5sXCRij5RULg8JfmE8kA=
X-Google-Smtp-Source: APXvYqy2LCYemB52vntqBs7QPCPQi00Ff5QMxoTwMb/hM38RliOgU5srhE8wQfzNC5Tukvcnr4z0DQ==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr14390825wmi.91.1567435916436; 
 Mon, 02 Sep 2019 07:51:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m17sm15550687wrs.9.2019.09.02.07.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 07:51:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EDEE61FF87;
 Mon,  2 Sep 2019 15:51:54 +0100 (BST)
References: <20190807143523.15917-1-pbonzini@redhat.com>
 <20190807143523.15917-2-pbonzini@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <20190807143523.15917-2-pbonzini@redhat.com>
Date: Mon, 02 Sep 2019 15:51:54 +0100
Message-ID: <87imqa7nud.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 1/3] tests/tcg: use EXTRA_CFLAGS
 everywhere
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> For i386 specifically, this allows using the host GCC
> to compile the i386 tests.  But, it should really be
> done for all targets, unless we want to pass $(EXTRA_CFLAGS)
> directly as part of $(CC).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/tcg/aarch64/Makefile.softmmu-target | 4 ++--
>  tests/tcg/alpha/Makefile.softmmu-target   | 4 ++--
>  tests/tcg/arm/Makefile.softmmu-target     | 2 +-
>  tests/tcg/i386/Makefile.softmmu-target    | 4 ++--
>  tests/tcg/minilib/Makefile.target         | 2 +-
>  tests/tcg/xtensa/Makefile.softmmu-target  | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch6=
4/Makefile.softmmu-target
> index 2e560e4d08..4c4aaf61dd 100644
> --- a/tests/tcg/aarch64/Makefile.softmmu-target
> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
> @@ -22,11 +22,11 @@ LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OB=
JS) -lgcc
>  .PRECIOUS: $(CRT_OBJS)
>
>  %.o: $(CRT_PATH)/%.S
> -	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
>
>  # Build and link the tests
>  %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> -	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>
>  memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>
> diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Ma=
kefile.softmmu-target
> index 3c0f34cc69..09193a62d6 100644
> --- a/tests/tcg/alpha/Makefile.softmmu-target
> +++ b/tests/tcg/alpha/Makefile.softmmu-target
> @@ -22,11 +22,11 @@ LDFLAGS+=3D-static -nostdlib $(CRT_OBJS) $(MINILIB_OB=
JS) -lgcc
>  .PRECIOUS: $(CRT_OBJS)
>
>  %.o: $(CRT_PATH)/%.S
> -	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
>
>  # Build and link the tests
>  %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> -	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>
>  memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D0
>
> diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefi=
le.softmmu-target
> index 49d48d8a1c..2deb06e6e4 100644
> --- a/tests/tcg/arm/Makefile.softmmu-target
> +++ b/tests/tcg/arm/Makefile.softmmu-target
> @@ -18,7 +18,7 @@ CFLAGS+=3D-Wl,--build-id=3Dnone -x assembler-with-cpp
>  LDFLAGS+=3D-nostdlib -N -static
>
>  %: %.S %.ld
> -	$(CC) $(CFLAGS) $(ASFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
> +	$(CC) $(CFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM=
_SRC)/$@.ld
>
>  # Specific Test Rules
>
> diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Make=
file.softmmu-target
> index 0a4364868c..cee342017e 100644
> --- a/tests/tcg/i386/Makefile.softmmu-target
> +++ b/tests/tcg/i386/Makefile.softmmu-target
> @@ -32,11 +32,11 @@ TESTS+=3D$(MULTIARCH_TESTS)
>  .PRECIOUS: $(CRT_OBJS)
>
>  %.o: $(CRT_PATH)/%.S
> -	$(CC) $(CFLAGS) -c $< -o $@
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
>
>  # Build and link the tests
>  %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
> -	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
>
>  memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>
> diff --git a/tests/tcg/minilib/Makefile.target b/tests/tcg/minilib/Makefi=
le.target
> index 3ed8077d0f..c821d2806a 100644
> --- a/tests/tcg/minilib/Makefile.target
> +++ b/tests/tcg/minilib/Makefile.target
> @@ -18,4 +18,4 @@ MINILIB_INC=3D-isystem $(SYSTEM_MINILIB_SRC)
>  .PRECIOUS: $(MINILIB_OBJS)
>
>  %.o: $(SYSTEM_MINILIB_SRC)/%.c
> -	$(CC) $(CFLAGS) -c $< -o $@
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
> diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/=
Makefile.softmmu-target
> index 8212d96b81..9530cac2ad 100644
> --- a/tests/tcg/xtensa/Makefile.softmmu-target
> +++ b/tests/tcg/xtensa/Makefile.softmmu-target
> @@ -34,9 +34,9 @@ $(XTENSA_USABLE_TESTS): linker.ld macros.inc $(CRT) Mak=
efile.softmmu-target
>
>  # special rule for common blobs
>  %.o: %.S
> -	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) -c $< -o $@
> +	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
>
>  %: %.S
> -	$(CC) $(XTENSA_INC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
> +	$(CC) $(XTENSA_INC) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(NO=
STDFLAGS) $(CRT)
>
>  endif


--
Alex Benn=C3=A9e

