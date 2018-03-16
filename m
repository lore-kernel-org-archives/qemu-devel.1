Received: from eggs.gnu.org ([2001:4830:134:3::10]:37079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewt6c-0006kD-OU
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewt6b-0000AP-Dl
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:25:26 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:38368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewt6b-00009K-6p
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:25:25 -0400
Received: by mail-oi0-x22b.google.com with SMTP id 20so2148693oiq.5
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:25:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315041903.10046-1-david@gibson.dropbear.id.au>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 17:25:04 +0000
Message-ID: <CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] ppc-for-2.12 queue 20180315
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org

On 15 March 2018 at 04:18, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180315
>
> for you to fetch changes up to a9ab8cc157054ea6941fb849c78d9e6c515a7730:
>
>   target/ppc: fix tlbsync to check privilege level depending on GTSE (2018-03-15 11:18:31 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2018-03-15
>
> Here's the set of accumulated patches now that we're into soft freeze.
> I've split new functionality into a ppc-for-2.13 branch, so this only
> has bugfixes.  Well.. and a couple of simple cleanups to make bugfixes
> easier, some test improvements and a trivial change to make command
> line options more obvious.  I think those are all acceptable for soft
> freeze.
>

Hi -- this looks like it provokes new runtime error warnings from the
clang sanitizer:

TEST: tests/boot-serial-test... (pid=926)
  /ppc/boot-serial/ppce500:                                            OK
  /ppc/boot-serial/prep:                                               OK
  /ppc/boot-serial/40p:                                                OK
  /ppc/boot-serial/g3beige:                                            OK
  /ppc/boot-serial/mac99:                                              OK
  /ppc/boot-serial/sam460ex:
/home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
runtime error: load of value 142, which is not a valid value for type
'bool'
OK

TEST: tests/boot-serial-test... (pid=1016)
  /ppc64/boot-serial/ppce500:                                          OK
  /ppc64/boot-serial/prep:                                             OK
  /ppc64/boot-serial/40p:                                              OK
  /ppc64/boot-serial/mac99:                                            OK
  /ppc64/boot-serial/pseries:                                          OK
  /ppc64/boot-serial/powernv:                                          OK
  /ppc64/boot-serial/sam460ex:
/home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
runtime error: load of value 85, which is not a valid value for type
'bool'
OK

Looks like you're not initializing ctx->lazy_tlb_flush for all configs:
    if (env->mmu_model == POWERPC_MMU_32B ||
        env->mmu_model == POWERPC_MMU_601 ||
        (env->mmu_model & POWERPC_MMU_64B))
            ctx->lazy_tlb_flush = true;

should perhaps be
    ctx->lazy_tlb_flush =
        env->mmu_model == POWERPC_MMU_32B ||
        env->mmu_model == POWERPC_MMU_601 ||
        (env->mmu_model & POWERPC_MMU_64B);

?

thanks
-- PMM
