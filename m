Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8AFC28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083A320866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083A320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57713 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpPJ-0001Rp-9Q
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:14:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hYpOQ-0000yl-8r
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hYpON-0007wJ-Sf
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:13:09 -0400
Received: from foss.arm.com ([217.140.101.70]:41330)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>)
	id 1hYpOK-0007ml-LU; Thu, 06 Jun 2019 06:13:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8CDD341;
	Thu,  6 Jun 2019 03:13:02 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BACDF3F690;
	Thu,  6 Jun 2019 03:13:01 -0700 (PDT)
Date: Thu, 6 Jun 2019 11:12:59 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190606101258.GA28398@e103592.cambridge.arm.com>
References: <20190605205706.569-1-richard.henderson@linaro.org>
	<20190605205706.569-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605205706.569-6-richard.henderson@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] [PATCH v6 5/6] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 09:57:05PM +0100, Richard Henderson wrote:
> For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
> which indicates that the image should be mapped with guarded pages.

Heads-up: for arm64 I plan to move to making PT_GNU_PROPERTY
authoritiative for ELF on linux: if this is present, we use it to find
the note directly and ignore any other notes; if there is no
PT_GNU_PROPERTY entry then we assume there is no NT_GNU_PROPERTY_TYPE_0
note.

This is not quite decided yet, but to avoid fragmentation I'd prefer
qemu and Linux apply the same policy -- I'll keep you in the loop about
the decision.

I think you can reasonable upstream this patch in qemu and then
subsequently make it stricter without an ABI break.  Upstream GNU ld
generates this entry today.

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 83 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index a57b7049dd..1a12c60a33 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2253,7 +2253,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>      struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
>      struct elf_phdr *phdr;
>      abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
> -    int i, retval;
> +    int i, retval, prot_exec = PROT_EXEC;
>      const char *errmsg;
>  
>      /* First of all, some simple consistency checks */
> @@ -2288,17 +2288,78 @@ static void load_elf_image(const char *image_name, int image_fd,
>      loaddr = -1, hiaddr = 0;
>      info->alignment = 0;
>      for (i = 0; i < ehdr->e_phnum; ++i) {
> -        if (phdr[i].p_type == PT_LOAD) {
> -            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
> +        struct elf_phdr *eppnt = phdr + i;
> +
> +        if (eppnt->p_type == PT_LOAD) {
> +            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
>              if (a < loaddr) {
>                  loaddr = a;
>              }
> -            a = phdr[i].p_vaddr + phdr[i].p_memsz;
> +            a = eppnt->p_vaddr + eppnt->p_memsz;
>              if (a > hiaddr) {
>                  hiaddr = a;
>              }
>              ++info->nsegs;
> -            info->alignment |= phdr[i].p_align;
> +            info->alignment |= eppnt->p_align;
> +        } else if (eppnt->p_type == PT_NOTE) {
> +#ifdef TARGET_AARCH64
> +            /*
> +             * Process NT_GNU_PROPERTY_TYPE_0.
> +             *
> +             * TODO: The only item that is AArch64 specific is the
> +             * GNU_PROPERTY_AARCH64_FEATURE_1_AND processing at the end.
> +             * If we were to ever process GNU_PROPERTY_X86_*, all of the
> +             * code through checking the gnu0 magic number is sharable.
> +             * But for now, since this *is* only used by AArch64, don't
> +             * process the note elsewhere.
> +             */
> +            const uint32_t gnu0_magic = const_le32('G' | 'N' << 8 | 'U' << 16);
> +            uint32_t note[7];
> +
> +            /*
> +             * The note contents are 7 words, but depending on LP64 vs ILP32
> +             * there may be an 8th padding word at the end.  Check for and
> +             * read the minimum size.  Further checks below will validate
> +             * that the sizes of everything involved are as we expect.
> +             */
> +            if (eppnt->p_filesz < sizeof(note)) {
> +                continue;
> +            }
> +            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
> +                memcpy(note, bprm_buf + eppnt->p_offset, sizeof(note));
> +            } else {
> +                retval = pread(image_fd, note, sizeof(note), eppnt->p_offset);
> +                if (retval != sizeof(note)) {
> +                    goto exit_perror;
> +                }
> +            }

Can we police that the segment alignment matches the ELF class (i.e., 8
for 64-bit, 4 for 32-bit)?

hjl specifies this, but it's controversial and sometimes missed --
there's a bug right now in GNU ld where --force-bti generates a note
with alignment 1.

Due to the high chance of screwing this up, it'd be good to police it
wherever appropriate.

> +#ifdef BSWAP_NEEDED
> +            for (i = 0; i < ARRAY_SIZE(note); ++i) {
> +                bswap32s(note + i);
> +            }
> +#endif
> +            /*
> +             * Check that this is a NT_GNU_PROPERTY_TYPE_0 note.
> +             * Again, descsz includes padding.  Full size validation
> +             * awaits checking the final payload.
> +             */
> +            if (note[0] != 4 ||                       /* namesz */
> +                note[1] < 12 ||                       /* descsz */
> +                note[2] != NT_GNU_PROPERTY_TYPE_0 ||  /* type */
> +                note[3] != gnu0_magic) {              /* name */
> +                continue;
> +            }
> +            /*
> +             * Check for the BTI feature.  If present, this indicates
> +             * that all the executable pages of the binary should be
> +             * mapped with PROT_BTI, so that branch targets are enforced.
> +             */
> +            if (note[4] == GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
> +                note[5] == 4 &&
> +                (note[6] & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> +                prot_exec |= TARGET_PROT_BTI;
> +            }
> +#endif /* TARGET_AARCH64 */
>          }
>      }
>  
> @@ -2358,9 +2419,15 @@ static void load_elf_image(const char *image_name, int image_fd,
>              abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
>              int elf_prot = 0;
>  
> -            if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
> -            if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
> -            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
> +            if (eppnt->p_flags & PF_R) {
> +                elf_prot |= PROT_READ;
> +            }
> +            if (eppnt->p_flags & PF_W) {
> +                elf_prot |= PROT_WRITE;
> +            }
> +            if (eppnt->p_flags & PF_X) {
> +                elf_prot |= prot_exec;
> +            }

Ack.

There are interesting subtleties with segment alignments here: the prot
flags on each segment "bleed" to an adjacent boundary.  I'm not sure
that behaviour is well specified, but we at least get away with it due
to conventions regarding the ordering of segments.

I still have to think about whether this works right for PROT_BTI, which
is a prohibition rather than a permission, suggesting that the bleed
rules might need to be inverted for it.

My current policy is that because and ELF is all-BTI if any page is BTI,
we probably get away with it, without having to do anything special.

[...]

Cheers
---Dave

