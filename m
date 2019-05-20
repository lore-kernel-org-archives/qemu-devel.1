Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC7C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619D72173E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckRMBdU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619D72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34653 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShFW-0007nI-LO
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:18:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShEJ-0007Qr-7w
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShEH-0006md-Vl
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:17:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShEH-0006lm-OK
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:17:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so14300395wrr.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=AWCG6+6D4CsP2vXTHl5m8yFJSXHrZ5Pet4AOzhWi8gs=;
	b=ckRMBdU2N32OyWuhQ53NMsv4WcQNdL31xFqdC8GWk5cw990rY8r67ro673c4Wo8YLx
	5w/8CH7xJi4enM/lC07NQaCuQ9VUxkuA7Kzeftgv6sJWzG8cF/j4BxBSimAonXdfkoKs
	EBx+2KSe+Q5QjtXVi1cbiCUvJTmbBm2pSiHdgkVxKfIeW1t9Uo6BUCxkurOJ7xe7LbsR
	LiOLrEYCGlKObYvE7RFFrhr1c58Mk/4K7yw+Z7fNSFuuVZPrxj794ffqkUJpimcM6El4
	r18xagmtSgHjl90b8+G9XkpsSM9MNFtRZpueAT+lgdUl6CY9fjmtRXuXCMdUVZGkvjsn
	kybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=AWCG6+6D4CsP2vXTHl5m8yFJSXHrZ5Pet4AOzhWi8gs=;
	b=cNISL1Ezc8HbtasMl8eATwPFmabZz/o3H6j990XL+/WKiaQ+fhCTiUUAY1SNbLWLgB
	xcc/Indo9BcYDcRUS3zs5T5Ct9pq1Dw86c64KuZkEQfHF8ujBJJy9JvxLkaJO+hR6dJD
	Of68QjjS5eLJGiwXVZCv7l3LENMCLokDf7Qk3UdxgBh9ELdnYJG+mpVCMh0heSf/cMbc
	mDeqQ8T4YNeRa9n7pfse0KrAfMoe1enlj+H6w58vkA7swZsbMnTCv5rBFcrdxNMpqOt4
	2NxYHjFgi2Cewg1YUIYhQogzAtpzeSbVSYz1jQKhMtRE3lBWu0VuHFhbNf9OtFqqI0Pc
	uMIw==
X-Gm-Message-State: APjAAAWq/3C5cmZpJ6/BCWCsjU7EWdaM7ubB/G1p4Xm5pahdiUxZY3WI
	u5rkmqF+c9F1pda+qX/EE+qpcQ==
X-Google-Smtp-Source: APXvYqyLJ0iRwrlRo6Yon1hEvRIbMQJ+eXft/I8h6MgUVf47XKK8lvKn5uA578e8piyPMGcf6D3mFw==
X-Received: by 2002:adf:f788:: with SMTP id q8mr46362422wrp.181.1558354640188; 
	Mon, 20 May 2019 05:17:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i18sm8830159wml.33.2019.05.20.05.17.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:17:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 278021FF87;
	Mon, 20 May 2019 13:17:19 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-8-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 13:17:19 +0100
Message-ID: <87zhnhgw1c.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> This allows us to drop dependency on NASM and build the test image
> with GCC only. Adds support for x86_64, too.

  ./risu --master -t run.out test_i386.bin

and then:

  ./risu -t run.out test_i386.bin

Gives:

  loading test image test_i386.bin...
  starting apprentice image at 0xf7f07000
  starting image
  finished early after 1 checkpoints
  match status...
  mismatch on regs!
  this reginfo:
    faulting insn fc0b90f

Because:

  Mismatch (master v apprentice):
  xmm4  : fe76ea16f7d9c58c 000006fc00000000
       v: fe76ea16f7d1a58c 000006fc00000000

We probably need to zero or reset the xmm regs both in the test and when
risugen dumps it's preamble.

>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  Makefile    |  3 +++
>  test_i386.S | 41 +++++++++++++++++++++++++++++++++++++++++
>  test_i386.s | 27 ---------------------------
>  3 files changed, 44 insertions(+), 27 deletions(-)
>  create mode 100644 test_i386.S
>  delete mode 100644 test_i386.s
>
> diff --git a/Makefile b/Makefile
> index b362dbe..6ab014a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -49,6 +49,9 @@ $(PROG): $(OBJS)
>  %_$(ARCH).elf: %_$(ARCH).s
>  	$(AS) -o $@ $<
>
> +%_$(ARCH).elf: %_$(ARCH).S
> +	$(CC) $(CPPFLAGS) -o $@ -c $<
> +
>  clean:
>  	rm -f $(PROG) $(OBJS) $(BINS)
>
> diff --git a/test_i386.S b/test_i386.S
> new file mode 100644
> index 0000000..456b99c
> --- /dev/null
> +++ b/test_i386.S
> @@ -0,0 +1,41 @@
> +/*######################################################################=
#######
> + * Copyright (c) 2010 Linaro Limited
> + * All rights reserved. This program and the accompanying materials
> + * are made available under the terms of the Eclipse Public License v1.0
> + * which accompanies this distribution, and is available at
> + * http://www.eclipse.org/legal/epl-v10.html
> + *
> + * Contributors:
> + *     Peter Maydell (Linaro) - initial implementation
> + *######################################################################=
#####*/
> +
> +/* A trivial test image for x86 */
> +
> +/* Initialise the registers to avoid spurious mismatches */
> +	xor	%eax, %eax
> +	sahf				/* init eflags */
> +
> +	mov	$0x12345678, %eax
> +	mov	$0x9abcdef0, %ebx
> +	mov	$0x97361234, %ecx
> +	mov	$0x84310284, %edx
> +	mov	$0x83624173, %edi
> +	mov	$0xfaebfaeb, %esi
> +	mov	$0x84610123, %ebp
> +
> +#ifdef __x86_64__
> +	movq	$0x123456789abcdef0, %r8
> +	movq	$0xaaaabbbbccccdddd, %r9
> +	movq	$0x1010101010101010, %r10
> +	movq	$0x1111111111111111, %r11
> +	movq	$0x1212121212121212, %r12
> +	movq	$0x1313131313131313, %r13
> +	movq	$0x1414141414141414, %r14
> +	movq	$0x1515151515151515, %r15
> +#endif
> +
> +/* do compare */
> +	ud1	%eax, %eax
> +
> +/* exit test */
> +	ud1	%ecx, %eax
> diff --git a/test_i386.s b/test_i386.s
> deleted file mode 100644
> index a2140a0..0000000
> --- a/test_i386.s
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -;#######################################################################=
########
> -;# Copyright (c) 2010 Linaro Limited
> -;# All rights reserved. This program and the accompanying materials
> -;# are made available under the terms of the Eclipse Public License v1.0
> -;# which accompanies this distribution, and is available at
> -;# http://www.eclipse.org/legal/epl-v10.html
> -;#
> -;# Contributors:
> -;#     Peter Maydell (Linaro) - initial implementation
> -;#######################################################################=
########
> -
> -; A trivial test image for x86
> -
> -BITS 32
> -; Initialise the registers to avoid spurious mismatches
> -mov eax, 0x12345678
> -mov ebx, 0x9abcdef0
> -mov ecx, 0x97361234
> -mov edx, 0x84310284
> -mov edi, 0x83624173
> -mov esi, 0xfaebfaeb
> -mov ebp, 0x84610123
> -; UD1 : do compare
> -UD1
> -
> -; UD2 : exit test
> -UD2


--
Alex Benn=C3=A9e

