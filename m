Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47FBC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEDC2173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm+IWp6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEDC2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoP1d-0005bW-Sv
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoP1R-0005Ct-As
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoP1P-0007ox-6S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:17:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hoP1O-0007l5-T4
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:17:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id z23so3735739ote.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UE5oAHUOyOrNsNfBqp4uXqCFwN9kq+qwNEZmKvBho5M=;
 b=lm+IWp6NOqhIAquCvmibz07ZvgE3KdxVy6GpY6dzwyVYMjWL8gyihnvLwEA5IsYPQK
 ff7I+e5brIksMPbyzs7dyWvLh3UIMYiklvdtcO/pTu543T9srZn2MFKc13ybPh8IXqfQ
 1HaNhf8ePgl/Gy3QJFDerDz06q/AufjJK8PIMFse+KZlZi0SIm7aWIMu6xEY+LSJbWON
 KUvV1U8Wp/COx4XpQ4bEX40nw2t5Xz8M5rXRttMppk3cIoaBfu7nTxtwq7J1o1UmlQhU
 hgrb6ZkVnxitAb/o1GpllOhagBGv9ZeqclC6a33c3VL0Ae8OfHtwNSAoj9t0N3q8xRYh
 UwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UE5oAHUOyOrNsNfBqp4uXqCFwN9kq+qwNEZmKvBho5M=;
 b=AMv7SN1poNR/4707I7LWx0KKS9iQndMF/C2HHC8iA6xuA0j0DjDZr0OvI7Ub3Q3yqS
 yrwJdpUVD7V4RBIOAyyf4IqV7IOMtc0jtIFRChc9/bgL6+QAY0CRfHtJX1XZwlvhcpPi
 8pQuXD2sK9J3OlZa6KPQmVIRq4YKgvBaTJDwV9C8JuURQDarCvJJ5S0w3UMVK1xjtGld
 xPBqIyr2SnsiuhGgPvqVcYjMO7ArQDMGkTaGT8nOP8liOBMfc4/FzqLNDUoZinjg00z6
 +NBFr948yB/qPIukwgsZAO9PFzabaolSjTvAbCrx1A6BigKOlUFPD3Oz1v+ZHZz3Tvp3
 lYpQ==
X-Gm-Message-State: APjAAAUlkq+c3kdwpzfn2yNrasTp66ukLw8hWhNyVRb8NCzZC1TNStc1
 T7hR6eXunw8XiMHDwKJncmTW9ovILt4RCawxgWY=
X-Google-Smtp-Source: APXvYqytgcgWJlFdx6xuvvAECmk4UnteHWkPBiFiJEyOktbKG/kLHaLH0OxZ06qAPeyTBkMg+YJLhY/4QT7q6u988A4=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr31520482oti.341.1563527865934; 
 Fri, 19 Jul 2019 02:17:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 02:17:45
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 02:17:45
 -0700 (PDT)
In-Reply-To: <8c3440d1-7333-5b0c-2271-450c555e9f52@redhat.com>
References: <11e818d38ebc40e986cfa62dd7d0afdc@tpw09926dag18e.domain1.systemhost.net>
 <8c3440d1-7333-5b0c-2271-450c555e9f52@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 19 Jul 2019 11:17:45 +0200
Message-ID: <CAL1e-=hhhcScoKS55MVzuSYsPJ7_v+khm00sChVt9SSmcgfc7g@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] configure: Define target access alignment
 in configure
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
Cc: tony.nguyen@bt.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 18, 2019 11:55 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:
>
> On 18/07/19 08:01, tony.nguyen@bt.com wrote:
> > This patch moves the define of target access alignment earlier from
> > target/foo/cpu.h to configure.
> >
> > Suggested in Richard Henderson's reply to "[PATCH 1/4] tcg: TCGMemOp is
now
> > accelerator independent MemOp"
> >
> > Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> > ---
> >  configure             | 12 ++++++++++--
> >  include/exec/poison.h |  1 +
> >  include/qom/cpu.h     |  2 +-
> >  target/alpha/cpu.h    |  2 --
> >  target/hppa/cpu.h     |  1 -
> >  target/mips/cpu.h     |  2 --
> >  target/sh4/cpu.h      |  2 --
> >  target/sparc/cpu.h    |  2 --
> >  target/xtensa/cpu.h   |  2 --
> >  tcg/tcg.c             |  2 +-
> >  tcg/tcg.h             |  8 +++++---
> >  11 files changed, 18 insertions(+), 18 deletions(-)
> >
> > diff --git a/configure b/configure
> > index eb635c3b9a..c07687c656 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7424,11 +7424,16 @@ for target in $target_list; do
> >  target_dir="$target"
> >  config_target_mak=$target_dir/config-target.mak
> >  target_name=$(echo $target | cut -d '-' -f 1)
> > +target_aligned_only="no"
> > +case "$target_name" in
> > +
alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|sparc64|sparc32plus|xtensa|xtensaeb)
> > +  target_aligned_only="yes"
> > +  ;;
> > +esac
> >  target_bigendian="no"
> > -
> >  case "$target_name" in
> >
armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
> > -  target_bigendian=yes
> > +  target_bigendian="yes"
> >    ;;
> >  esac
> >  target_softmmu="no"
> > @@ -7710,6 +7715,9 @@ fi
> >  if supported_whpx_target $target; then
> >      echo "CONFIG_WHPX=y" >> $config_target_mak
> >  fi
> > +if test "$target_aligned_only" = "yes" ; then
> > +  echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
> > +fi
> >  if test "$target_bigendian" = "yes" ; then
> >    echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
> >  fi
> > diff --git a/include/exec/poison.h b/include/exec/poison.h
> > index b862320fa6..955eb863ab 100644
> > --- a/include/exec/poison.h
> > +++ b/include/exec/poison.h
> > @@ -35,6 +35,7 @@
> >  #pragma GCC poison TARGET_UNICORE32
> >  #pragma GCC poison TARGET_XTENSA
> >
> > +#pragma GCC poison TARGET_ALIGNED_ONLY
> >  #pragma GCC poison TARGET_HAS_BFLT
> >  #pragma GCC poison TARGET_NAME
> >  #pragma GCC poison TARGET_SUPPORTS_MTTCG
> > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > index 5ee0046b62..9b50b73339 100644
> > --- a/include/qom/cpu.h
> > +++ b/include/qom/cpu.h
> > @@ -89,7 +89,7 @@ struct TranslationBlock;
> >   * @do_unassigned_access: Callback for unassigned access handling.
> >   * (this is deprecated: new targets should use do_transaction_failed
instead)
> >   * @do_unaligned_access: Callback for unaligned access handling, if
> > - * the target defines #ALIGNED_ONLY.
> > + * the target defines #TARGET_ALIGNED_ONLY.
> >   * @do_transaction_failed: Callback for handling failed memory
transactions
> >   * (ie bus faults or external aborts; not MMU faults)
> >   * @virtio_is_big_endian: Callback to return %true if a CPU which
supports
> > diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> > index b3e8a823e1..16eb8047cf 100644
> > --- a/target/alpha/cpu.h
> > +++ b/target/alpha/cpu.h
> > @@ -23,8 +23,6 @@
> >  #include "cpu-qom.h"
> >  #include "exec/cpu-defs.h"
> >
> > -#define ALIGNED_ONLY
> > -
> >  /* Alpha processors have a weak memory model */
> >  #define TCG_GUEST_DEFAULT_MO      (0)
> >
> > diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> > index aab251bc4b..2be67c289a 100644
> > --- a/target/hppa/cpu.h
> > +++ b/target/hppa/cpu.h
> > @@ -30,7 +30,6 @@
> >     basis.  It's probably easier to fall back to a strong memory
model.  */
> >  #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
> >
> > -#define ALIGNED_ONLY
> >  #define MMU_KERNEL_IDX   0
> >  #define MMU_USER_IDX     3
> >  #define MMU_PHYS_IDX     4
> > diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> > index 21c0615e02..c13cd4eb31 100644
> > --- a/target/mips/cpu.h
> > +++ b/target/mips/cpu.h
> > @@ -1,8 +1,6 @@
> >  #ifndef MIPS_CPU_H
> >  #define MIPS_CPU_H
> >
> > -#define ALIGNED_ONLY
> > -
> >  #include "cpu-qom.h"
> >  #include "exec/cpu-defs.h"
> >  #include "fpu/softfloat.h"
> > diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
> > index aee733eaaa..ecaa7a18a9 100644
> > --- a/target/sh4/cpu.h
> > +++ b/target/sh4/cpu.h
> > @@ -23,8 +23,6 @@
> >  #include "cpu-qom.h"
> >  #include "exec/cpu-defs.h"
> >
> > -#define ALIGNED_ONLY
> > -
> >  /* CPU Subtypes */
> >  #define SH_CPU_SH7750  (1 << 0)
> >  #define SH_CPU_SH7750S (1 << 1)
> > diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> > index 8ed2250cd0..1406f0ba2e 100644
> > --- a/target/sparc/cpu.h
> > +++ b/target/sparc/cpu.h
> > @@ -5,8 +5,6 @@
> >  #include "cpu-qom.h"
> >  #include "exec/cpu-defs.h"
> >
> > -#define ALIGNED_ONLY
> > -
> >  #if !defined(TARGET_SPARC64)
> >  #define TARGET_DPREGS 16
> >  #else
> > diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> > index 2c277134f1..0459243e6b 100644
> > --- a/target/xtensa/cpu.h
> > +++ b/target/xtensa/cpu.h
> > @@ -32,8 +32,6 @@
> >  #include "exec/cpu-defs.h"
> >  #include "xtensa-isa.h"
> >
> > -#define ALIGNED_ONLY
> > -
> >  /* Xtensa processors have a weak memory model */
> >  #define TCG_GUEST_DEFAULT_MO      (0)
> >
> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index be2c33c400..8d23fb0592 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -1926,7 +1926,7 @@ static const char * const ldst_name[] =
> >  };
> >
> >  static const char * const alignment_name[(MO_AMASK >> MO_ASHIFT) + 1]
= {
> > -#ifdef ALIGNED_ONLY
> > +#ifdef TARGET_ALIGNED_ONLY
> >      [MO_UNALN >> MO_ASHIFT]    = "un+",
> >      [MO_ALIGN >> MO_ASHIFT]    = "",
> >  #else
> > diff --git a/tcg/tcg.h b/tcg/tcg.h
> > index b411e17a28..529acb2ed8 100644
> > --- a/tcg/tcg.h
> > +++ b/tcg/tcg.h
> > @@ -333,10 +333,12 @@ typedef enum TCGMemOp {
> >      MO_TE    = MO_LE,
> >  #endif
> >
> > -    /* MO_UNALN accesses are never checked for alignment.
> > +    /*
> > +     * MO_UNALN accesses are never checked for alignment.
> >       * MO_ALIGN accesses will result in a call to the CPU's
> >       * do_unaligned_access hook if the guest address is not aligned.
> > -     * The default depends on whether the target CPU defines
ALIGNED_ONLY.
> > +     * The default depends on whether the target CPU defines
> > +     * TARGET_ALIGNED_ONLY.
> >       *
> >       * Some architectures (e.g. ARMv8) need the address which is
aligned
> >       * to a size more than the size of the memory access.
> > @@ -353,7 +355,7 @@ typedef enum TCGMemOp {
> >       */
> >      MO_ASHIFT = 4,
> >      MO_AMASK = 7 << MO_ASHIFT,
> > -#ifdef ALIGNED_ONLY
> > +#ifdef TARGET_ALIGNED_ONLY
> >      MO_ALIGN = 0,
> >      MO_UNALN = MO_AMASK,
> >  #else
> >
>
> Queued for 4.2, thanks.
>

Paolo, your queueing was premature, just hours after the submission,
practically not allowing review to happen.

Please have some time cushion, and especially for the changes that affect
multiple targets.

Thanks, Aleksandar

> Paolo
>
