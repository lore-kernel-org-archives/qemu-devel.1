Received: from eggs.gnu.org ([2001:4830:134:3::10]:35866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eszym-0006HL-7k
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 18:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eszyk-0006CT-Jw
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 18:57:16 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:40017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eszyk-0006CB-CG
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 18:57:14 -0500
Received: by mail-ot0-x235.google.com with SMTP id l12so16711584otj.7
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 15:57:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519944838-12430-1-git-send-email-cota@braap.org>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 6 Mar 2018 12:57:13 +1300
Message-ID: <CAHNT7NusFbz=Dt0TGEWKFyJjDDpF3zjGmfkKw4w9thBOFzHb6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv1 00/14] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Mar 2, 2018 at 11:53 AM, Emilio G. Cota <cota@braap.org> wrote:

> [ What is this all about? See this message:
>   http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04785.html ]
>
> Merged the separate patchsets I sent in the last couple of weeks into
> one set. This will be easier to merge since it will avoid potential
> merge conflicts due to adding max_insns to dc->base.
>
> Changes since sending the separate series for
> sh4/sparc/mips/s390x/openrisc:
> - Rebased on top of master (669743979)
> - Added R-b's
> - sh4: no changes since v3
> - mips: no changes (no reviews yet!)
> - sparc:
>   + Use base.singlestep_enabled and singlestep like in other targets,
>     e.g. Alpha.
>   + Remove the unnecessary
>      (dc.pc - pc_start) < (TARGET_PAGE_SIZE - 32))
>     check.
> - s390x:
>   + Remove dc->pc, use pc_next instead as David suggested.
>   + Use dc for DisasContext instead of s.
>   + Compute next_page in translate_insn instead of keeping it in dc.
>   + Looked into dropping dc->do_debug, but don't see an easy way to do so.
> - openrisc:
>   + Consistently use DISAS_NORETURN after generating an
>     exception; fixed the two call sites that Richard pointed out,
>     plus a couple of others that weren't visible in the previous patch.
>   + Remove the dc->next_page_start field; instead, set the max_insn
>     bound in translate_insn.
>
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/trloop-conv-v1


Curious to know what we would need to change in RISC-V translate.c:

-
https://github.com/riscv/riscv-qemu/blob/qemu-upstream-v8/target/riscv/translate.c

I'm going to make a v8.1 branch and tag that is a rebase of the v8 patch
series against current QEMU master, and hopefully we get the RISC-V port
merged before the soft-freeze. Fingers crossed.

Diffstat below.
>
> Thanks,
>
>                 Emilio
>
>  accel/tcg/translator.c      |   21 +-
>  include/exec/translator.h   |    8 +-
>  target/alpha/translate.c    |    6 +-
>  target/arm/translate-a64.c  |    8 +-
>  target/arm/translate.c      |    9 +-
>  target/hppa/translate.c     |    7 +-
>  target/i386/translate.c     |    5 +-
>  target/mips/translate.c     |  623 +++++------
>  target/openrisc/translate.c |  226 ++--
>  target/ppc/translate.c      |    5 +-
>  target/s390x/translate.c    | 1527 +++++++++++++--------------
>  target/sh4/translate.c      |  171 +--
>  target/sparc/translate.c    |  207 ++--
>  13 files changed, 1401 insertions(+), 1422 deletions(-)
>
>
