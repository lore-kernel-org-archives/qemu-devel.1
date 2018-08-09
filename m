Received: from eggs.gnu.org ([2001:4830:134:3::10]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fndo1-0001Fb-8G
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fndo0-0005OC-6b
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:48:17 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:42342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fndo0-0005Np-00
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 01:48:16 -0400
Received: by mail-qt0-x242.google.com with SMTP id z8-v6so5270148qto.9
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 22:48:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-1-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 9 Aug 2018 07:48:14 +0200
Message-ID: <CABoDooMOm=-KR-XV1eEpWCw6VtFhVHkEJgT_OPLab8SCTEFhtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/20] target/arm: sve system mode patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hello,

On Thu, Aug 9, 2018 at 6:21 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This is my current set of patches for running SVE in system mode.
>
> The first half deal with the system registers that affect SVE.
> I recall that Peter has said he'd like the first patch to be
> done a different way, but we haven't had a chance to talk about
> what form it should take.  I've left it as-is since it does what
> I need for now.
>
> The second half re-implement the SVE memory operations.
> The FF and NF loads had been stubbed out.  Getting those to work
> requires some infrastructure that can be reused to speed up normal
> loads -- one guest-to-host tlb lookup can be reused for the rest
> of the page.

I did not review every patch individually but tested the whole and
found no issue.

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

>
> r~
>
>
> Based-on: <20180809034033.10579-1-richard.henderson@linaro.org>
> Richard Henderson (20):
>   target/arm: Set ISAR bits for -cpu max
>   target/arm: Set ID_AA64PFR0 bits for SVE for -cpu max
>   target/arm: Define ID_AA64ZFR0_EL1
>   target/arm: Adjust sve_exception_el
>   target/arm: Fix arm_cpu_data_is_big_endian for aa64 user-only
>   target/arm: Fix arm_current_el for user-only
>   target/arm: Fix is_a64 for user-only
>   target/arm: Pass in current_el to fp and sve_exception_el
>   target/arm: Handle SVE vector length changes in system mode
>   target/arm: Adjust aarch64_cpu_dump_state for system mode SVE
>   target/arm: Clear unused predicate bits for LD1RQ
>   target/arm: Rewrite helper_sve_ld1*_r using pages
>   target/arm: Rewrite helper_sve_ld[234]*_r
>   target/arm: Rewrite helper_sve_st[1234]*_r
>   target/arm: Split contiguous loads for endianness
>   target/arm: Split contiguous stores for endianness
>   target/arm: Rewrite vector gather loads
>   target/arm: Rewrite vector gather stores
>   target/arm: Rewrite vector gather first-fault loads
>   target/arm: Pass TCGMemOpIdx to sve memory helpers
>
>  target/arm/cpu.h           |   47 +-
>  target/arm/helper-sve.h    |  385 +++++--
>  target/arm/internals.h     |    5 +
>  target/arm/cpu.c           |   24 +-
>  target/arm/cpu64.c         |   93 +-
>  target/arm/helper.c        |  237 +++--
>  target/arm/op_helper.c     |    1 +
>  target/arm/sve_helper.c    | 2062 +++++++++++++++++++++++++-----------
>  target/arm/translate-a64.c |    8 +-
>  target/arm/translate-sve.c |  670 ++++++++----
>  10 files changed, 2453 insertions(+), 1079 deletions(-)
>
> --
> 2.17.1
>
