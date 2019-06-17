Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B0DC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14DA2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkuFee/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14DA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsce-0006td-U9
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsMk-0007Vw-LE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsMh-0002sg-TS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:12:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsMh-0002rt-Ku
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:12:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so66406wmd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=D4UQ+UVDvwNmgQAIxA+yoX3AZOwoEgzTK41dVVTv/sI=;
 b=lkuFee/iLaxA43/PK8iU6iIh8EY1eQHIiU7zreKuuKTcMgRtECA0k25NiU6vWUrMHF
 mzMUNI7kiJnDtby5BjluQj/08Bj9ryTu5QRsrp3ni5wpFoDxbKO/hdu/qS1eqjHE8WHA
 8NsNQKOldkf5OAkqRbAtJ9ofplINyDkbnXtXayrJr/fTm2J4+/cGuqiF5z5+PuSt+lW0
 uSA3JpcQd2ACnek8yObUJNEATrAzXQ1nZXbhwnnWNL0qF/at/VfCi5O5J4BaIdsS4Hwx
 2PieVYRd35Xa0m/RBgcMmfhwvm4cCfc3qQNwx8NYEb+uvc64mIr4UFZuQGmNkus/pxtt
 4v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=D4UQ+UVDvwNmgQAIxA+yoX3AZOwoEgzTK41dVVTv/sI=;
 b=uSt2rdLv3E+njJlw8UbsD4Q9eNZC9XFkkbrOVhhzoiupoc67qihkB4qJggtob7kuT6
 ime0bNvfEMmaCO1t6uZt+WR+r56IljU8sOg2lgO9lgNdv+goe7D87CVGk8w+d42hIcGh
 OFIl9+jMEZCOXfK3/ha+6hk4E8kknvAMhbV/4Zac6aRcoq9MFFCh2fMvhBRCuh1dtdO5
 /KsPbZxsPED4EDCG40LcQIuSQ2vEUIxIVKpTvihiT0parlZ2LONcH2uqyFSIhAmyyfTk
 J1qPYhB+lbATh0DJTWryJnAnTVRvpOvIZu09sRRBZsbCMwXr7a3d5BE99TAxrWnQpB5K
 fbfA==
X-Gm-Message-State: APjAAAWZ9FAsOwbBzTMj2piLBhaITU2eXIyOrbHeJRNy0kKrQfQkCbBi
 MMYcJoW+tdz567hO4p74BkLjvQ==
X-Google-Smtp-Source: APXvYqyE89HaqEFXGi6Ae1m4wrrnWDG4Ii6KX6rk+LCK44VzgfGAyFLelpHHdll+yl9HuJqhgNC2xQ==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr19988139wmc.55.1560780726247; 
 Mon, 17 Jun 2019 07:12:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s8sm16175150wra.55.2019.06.17.07.12.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:12:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2A69C1FF87;
 Mon, 17 Jun 2019 15:12:05 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-15-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-15-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:12:05 +0100
Message-ID: <87muig9u8a.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 14/23] target/arm: Move the
 DC ZVA helper into op_helper
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Robert Bradford <robert.bradford@intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Samuel Ortiz <sameo@linux.intel.com>
>
> Those helpers are a software implementation of the ARM v8 memory zeroing
> op code. They should be moved to the op helper file, which is going to
> eventually be built only when TCG is enabled.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> [PMD: Rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c    | 92 -----------------------------------------
>  target/arm/op_helper.c | 93 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 92 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 24d88eef17..673ada1e86 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10674,98 +10674,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>  #endif
>  }
>
> -void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
> -{
> -    /*
> -     * Implement DC ZVA, which zeroes a fixed-length block of memory.
> -     * Note that we do not implement the (architecturally mandated)
> -     * alignment fault for attempts to use this on Device memory
> -     * (which matches the usual QEMU behaviour of not implementing either
> -     * alignment faults or any memory attribute handling).
> -     */
> -
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    uint64_t blocklen =3D 4 << cpu->dcz_blocksize;
> -    uint64_t vaddr =3D vaddr_in & ~(blocklen - 1);
> -
> -#ifndef CONFIG_USER_ONLY
> -    {
> -        /*
> -         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
> -         * the block size so we might have to do more than one TLB looku=
p.
> -         * We know that in fact for any v8 CPU the page size is at least=
 4K
> -         * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
> -         * 1K as an artefact of legacy v5 subpage support being present =
in the
> -         * same QEMU executable. So in practice the hostaddr[] array has
> -         * two entries, given the current setting of TARGET_PAGE_BITS_MI=
N.
> -         */
> -        int maxidx =3D DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
> -        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
> -        int try, i;
> -        unsigned mmu_idx =3D cpu_mmu_index(env, false);
> -        TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
> -
> -        assert(maxidx <=3D ARRAY_SIZE(hostaddr));
> -
> -        for (try =3D 0; try < 2; try++) {
> -
> -            for (i =3D 0; i < maxidx; i++) {
> -                hostaddr[i] =3D tlb_vaddr_to_host(env,
> -                                                vaddr + TARGET_PAGE_SIZE=
 * i,
> -                                                1, mmu_idx);
> -                if (!hostaddr[i]) {
> -                    break;
> -                }
> -            }
> -            if (i =3D=3D maxidx) {
> -                /*
> -                 * If it's all in the TLB it's fair game for just writin=
g to;
> -                 * we know we don't need to update dirty status, etc.
> -                 */
> -                for (i =3D 0; i < maxidx - 1; i++) {
> -                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
> -                }
> -                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
> -                return;
> -            }
> -            /*
> -             * OK, try a store and see if we can populate the tlb. This
> -             * might cause an exception if the memory isn't writable,
> -             * in which case we will longjmp out of here. We must for
> -             * this purpose use the actual register value passed to us
> -             * so that we get the fault address right.
> -             */
> -            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
> -            /* Now we can populate the other TLB entries, if any */
> -            for (i =3D 0; i < maxidx; i++) {
> -                uint64_t va =3D vaddr + TARGET_PAGE_SIZE * i;
> -                if (va !=3D (vaddr_in & TARGET_PAGE_MASK)) {
> -                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
> -                }
> -            }
> -        }
> -
> -        /*
> -         * Slow path (probably attempt to do this to an I/O device or
> -         * similar, or clearing of a block of code we have translations
> -         * cached for). Just do a series of byte writes as the architect=
ure
> -         * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
> -         * memset(), unmap() sequence here because:
> -         *  + we'd need to account for the blocksize being larger than a=
 page
> -         *  + the direct-RAM access case is almost always going to be de=
alt
> -         *    with in the fastpath code above, so there's no speed benef=
it
> -         *  + we would have to deal with the map returning NULL because =
the
> -         *    bounce buffer was in use
> -         */
> -        for (i =3D 0; i < blocklen; i++) {
> -            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
> -        }
> -    }
> -#else
> -    memset(g2h(vaddr), 0, blocklen);
> -#endif
> -}
> -
>  /* Note that signed overflow is undefined in C.  The following routines =
are
>     careful to use unsigned types where modulo arithmetic is required.
>     Failure to do so _will_ break on newer gcc.  */
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index db4254a67b..29b56039e5 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -17,6 +17,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/log.h"
>  #include "qemu/main-loop.h"
>  #include "cpu.h"
> @@ -1316,3 +1317,95 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t=
 x, uint32_t i)
>          return ((uint32_t)x >> shift) | (x << (32 - shift));
>      }
>  }
> +
> +void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
> +{
> +    /*
> +     * Implement DC ZVA, which zeroes a fixed-length block of memory.
> +     * Note that we do not implement the (architecturally mandated)
> +     * alignment fault for attempts to use this on Device memory
> +     * (which matches the usual QEMU behaviour of not implementing either
> +     * alignment faults or any memory attribute handling).
> +     */
> +
> +    ARMCPU *cpu =3D env_archcpu(env);
> +    uint64_t blocklen =3D 4 << cpu->dcz_blocksize;
> +    uint64_t vaddr =3D vaddr_in & ~(blocklen - 1);
> +
> +#ifndef CONFIG_USER_ONLY
> +    {
> +        /*
> +         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
> +         * the block size so we might have to do more than one TLB looku=
p.
> +         * We know that in fact for any v8 CPU the page size is at least=
 4K
> +         * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
> +         * 1K as an artefact of legacy v5 subpage support being present =
in the
> +         * same QEMU executable. So in practice the hostaddr[] array has
> +         * two entries, given the current setting of TARGET_PAGE_BITS_MI=
N.
> +         */
> +        int maxidx =3D DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
> +        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)];
> +        int try, i;
> +        unsigned mmu_idx =3D cpu_mmu_index(env, false);
> +        TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
> +
> +        assert(maxidx <=3D ARRAY_SIZE(hostaddr));
> +
> +        for (try =3D 0; try < 2; try++) {
> +
> +            for (i =3D 0; i < maxidx; i++) {
> +                hostaddr[i] =3D tlb_vaddr_to_host(env,
> +                                                vaddr + TARGET_PAGE_SIZE=
 * i,
> +                                                1, mmu_idx);
> +                if (!hostaddr[i]) {
> +                    break;
> +                }
> +            }
> +            if (i =3D=3D maxidx) {
> +                /*
> +                 * If it's all in the TLB it's fair game for just writin=
g to;
> +                 * we know we don't need to update dirty status, etc.
> +                 */
> +                for (i =3D 0; i < maxidx - 1; i++) {
> +                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
> +                }
> +                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
> +                return;
> +            }
> +            /*
> +             * OK, try a store and see if we can populate the tlb. This
> +             * might cause an exception if the memory isn't writable,
> +             * in which case we will longjmp out of here. We must for
> +             * this purpose use the actual register value passed to us
> +             * so that we get the fault address right.
> +             */
> +            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
> +            /* Now we can populate the other TLB entries, if any */
> +            for (i =3D 0; i < maxidx; i++) {
> +                uint64_t va =3D vaddr + TARGET_PAGE_SIZE * i;
> +                if (va !=3D (vaddr_in & TARGET_PAGE_MASK)) {
> +                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
> +                }
> +            }
> +        }
> +
> +        /*
> +         * Slow path (probably attempt to do this to an I/O device or
> +         * similar, or clearing of a block of code we have translations
> +         * cached for). Just do a series of byte writes as the architect=
ure
> +         * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
> +         * memset(), unmap() sequence here because:
> +         *  + we'd need to account for the blocksize being larger than a=
 page
> +         *  + the direct-RAM access case is almost always going to be de=
alt
> +         *    with in the fastpath code above, so there's no speed benef=
it
> +         *  + we would have to deal with the map returning NULL because =
the
> +         *    bounce buffer was in use
> +         */
> +        for (i =3D 0; i < blocklen; i++) {
> +            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
> +        }
> +    }
> +#else
> +    memset(g2h(vaddr), 0, blocklen);
> +#endif
> +}


--
Alex Benn=C3=A9e

