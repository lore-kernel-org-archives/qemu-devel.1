Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDBC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDFD208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5KYQgdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDFD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58ee-0002yD-I0
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j58cJ-00005S-0P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j58cH-00067v-Pp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:45:18 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j58cG-00067X-KR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:45:17 -0500
Received: by mail-oi1-x243.google.com with SMTP id z2so1597447oih.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eOupqd6YXJtD+YxBCsZKyOzpLNDW0wdwI/Ic5Znl4YQ=;
 b=y5KYQgdMDGOgzQMnuPj+LH1umqjrmhglkP/iWiJcoDVYJsQ6wetqLcs4490fHv6vuZ
 I26MLh1iMOGhpmaDHs7W52Votxum1VxcJkT5YxKUXYj67Nw+mZvtL/VCwW0aSe5zeaTj
 lCsJYD4oEZAJ1xbbk4YyoAvU2i5S2rXx4Fwjr4LT3XVl+d15A4wc2Ja6Z8xnXBuQbA4a
 REMI4olTrJUEUVqeNhqvC5/I8YUMyeTJtMJuukWUHe+6gkaZ/RcrfJl5rmm/A8shEGPm
 uDshkmz44qPVBdL6+Ae9J9BPmgaEoeteUXCs8kUu9VL6/wUpiHVXN7I0D4sDpHMB1s5S
 ju3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eOupqd6YXJtD+YxBCsZKyOzpLNDW0wdwI/Ic5Znl4YQ=;
 b=dt00PdsjtowwlUjfcoOA58IRYE6i7ou27FSyw+j4GdGcQvuYL0wQAMZ+uhe/dvXcCO
 AafqZ/SqIQcEVChM6se+zlQFRVuxjx8nGn/kiPCKP5PJ+N2trLk25/6HailjK40r+aL3
 uK+RAd/8CbGCweARM8kFqoEH1swTtNxP+CJ1SjnxI+NO3Qsc1GsH9feoJvwX31WLbykz
 hYH1+VAvIZ6Idm+EANe3/0FLNHcBJ4FTCHWA6nBO/38FGfi7yh0eE2Ipfyis/mQqcqYO
 NJKdSM3LZy5Jw1DG2x15YcWHkjdDm2ru427K79JJRpDHcPlvwKgDUEUL7SNiy5Gq14F0
 8DVQ==
X-Gm-Message-State: APjAAAUKbnF9mvXPHgVXo9d9pTnww+Mg9Aj/u8i2xxHp1p5RfgbENXRk
 N4uRnp9N5kYGaxYF221aUjefOK11QZZoRA7QLbabTw==
X-Google-Smtp-Source: APXvYqzi/K5dRZXhjHqEJ8PRb7I8Z4uvk4RQ0B4XG3fqEJq2AM/8MZ4HW2bo7VUZIYImrdPa5JuTC9X4c++e/6y6afM=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2015776oic.48.1582292715712; 
 Fri, 21 Feb 2020 05:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20200219220333.1411905-1-laurent@vivier.eu>
In-Reply-To: <20200219220333.1411905-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 13:45:04 +0000
Message-ID: <CAFEAcA8g+uRrGuNLdURegmpjRLtk=vVC9zUE1+QVKRitPjJy7A@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] linux-user: generate syscall_nr.sh
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Feb 2020 at 22:07, Laurent Vivier <laurent@vivier.eu> wrote:
>
> This series copies the files syscall.tbl from linux v5.5 and generates
> the file syscall_nr.h from them.
>
> This is done for all the QEMU targets that have a syscall.tbl
> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>
> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
>
> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.

Is it the case that all our architectures either:
 (1) have a syscall.tbl
 (2) are using the asm-generic common numbering system ?

Though even if they do use asm-generic there's awkwardness
still around whether they have extra arch-specific syscalls
and what features of the asm-generic/unistd.h they select,
so I'm not sure whether it helps us much to know that they're
sharing a basically common numbering system.

It does suggest that future architectures are unlikely to have
a syscall.tbl unless somebody pushes for one to be generated
for asm-generic users.

> It seems there is a bug in QEMU that forces to disable manually arch_prctl
> with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
> TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).

TARGET_ABI32 for x86 would mean the x32 "32-bit APIs
on a 64-bit CPU", which we don't implement. But the
guards on do_arch_prctl() are
#if defined(TARGET_I386) && !defined(TARGET_ABI32)

where the !TARGET_ABI32 check seems like it's unnecessary but
harmless (we never define it for x86), so what causes a problem?

thanks
-- PMM

