Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68779C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316372072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtCCz0XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316372072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSFE-0002UR-A5
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1izSER-00025y-5s
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1izSEN-000815-7u
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:29:10 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1izSEN-0007vy-12
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:29:07 -0500
Received: by mail-pj1-x1044.google.com with SMTP id fa20so1524986pjb.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=m6mwK1jOtZGUbB7cG+JXww5JomXFyTkjdr3NffsrHko=;
 b=AtCCz0XEjldgEwJecKWSqsYdu+qyw6a3THAXY3Qqbx5vNaByAJJv+N0tXKYI/PzUfR
 /9LeGa4MpQpTWehHBUO+KmY4ptJsFoeiOTpkvfusWCJb7iMtKl03mf32xKFuYDxq6Idc
 a+V0e3k3seCgkBlNySpR+KP47E/dqy6zevuQY7TONo7Sx1q3Bbc0p/bUK7jQpZ8+/Y4x
 CDq7wNh2u6hCtCDLX51i5B58Ap8ArTS6iTAML+hqr+l7ceiwJXxVWBkltpXiWt45zDMO
 B2pKZFw3ELzYXu508f2yteXioXmmB1sVQ/Bn9io6KlyQ2rhgMaSUu+JDiA4LI/CaIOmy
 s6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=m6mwK1jOtZGUbB7cG+JXww5JomXFyTkjdr3NffsrHko=;
 b=OeycaThoAgBDKsLrZxcd3gLGbxF3JmpwLYPny7oWPjZqLQVwAJlfurw2OzAYcIYOH2
 5vsMbQByHWyy4l3fmN1uG0HQbKYnQPcCCdZnDtbm55LYLWRu5t8q+hLUA6gAqwDevQsH
 fiyJ2UsPtUPPDAeffjPdOOXPjGGPjyr3NLmFmiK2xYhDCuzxmsxlKYg0W6ojPD9SASRW
 LAo7w3Csd+hyqCIYPmOVhbO4oU8TZx4U3rwF0HzV0hKK6KqLkEnpgleNiZ65IJ2wDego
 NEtfkuyFL6CFSRE9nTOKl1Yt9RdDOehEAY69MYSeeFJxkN5I6SpYNbHPpjBD+B5bwvNY
 6V7Q==
X-Gm-Message-State: APjAAAX3yYE57eTMK2fjS7E7n7T9PLMkZiDG83VL6PsKKGRugz//NydS
 aW95/dwGdxUY/7MwtG3V5Io=
X-Google-Smtp-Source: APXvYqw26TDC3ebhpDzoEX2eb115ur2fD5uL8BXb+iGW5+UE4NdwyKZxvzMlYPgyxNtG7AX4+zFENA==
X-Received: by 2002:a17:90a:a48c:: with SMTP id
 z12mr215763pjp.38.1580938145588; 
 Wed, 05 Feb 2020 13:29:05 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
 by smtp.gmail.com with ESMTPSA id w38sm720097pgk.45.2020.02.05.13.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:29:04 -0800 (PST)
Date: Thu, 6 Feb 2020 06:29:01 +0900
From: Stafford Horne <shorne@gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH 0/9] linux-user: Update syscall numbers to kernel 5.5 level
Message-ID: <20200205212901.GA24874@lianli.shorne-pla.net>
References: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 laurent@vivier.eu, Palmer Dabbelt <palmer@dabbelt.com>, amarkovic@wavecomp.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 01:07:29PM +0100, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This series also doesn't cover following files (since I can't find
> corresponding kernel code - and I am also asking corresponding
> target maintainers or Lauren to update them, if possible, before
> our 5.0 release):

OpenRISC is in the kernel under arch/openrisc and the syscall numbers we
user are just like other architectures, it's in:

  linux/arch/openrisc/include/uapi/asm/unistd.h

This then includes the generic numbers:

  linux/include/uapi/asm-generic/unistd.h

There are other architectures in the kernel, like arm64, risvc, nios2 using the
generic syscall numbers.

Should QEMU also have linux-user/generic/syscall_nr.h that mirrors the generic
file in linux?  This way this could be maintained in just one place.

>   - linux-user/cris/cpu_loop.c
>   - linux-user/hppa/syscall_nr.h
>   - linux-user/openrisc/syscall_nr.h
>   - linux-user/tilegx/syscall_nr.h
> 
> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Stafford Horne <shorne@gmail.com>
> 
> Again, I don't plan (I am really running out of time resources) to
> work in a significant way on this issue any more, and I am asking
> you guys other maintainers to help finish updating syscall numbers
> before QEMU 5.0 release.

I actually have a patch to add syscall numbers for openrisc which I am using to
test our new glibc port right now.  I will clean if up and submit for review.

It looks like for 5.0 we would need to get changes in by March 23:

  https://wiki.qemu.org/Planning/5.0

I'll try to aim to get my change up for review soon then.

-Stafford 

