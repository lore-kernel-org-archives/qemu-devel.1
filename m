Received: from eggs.gnu.org ([2001:4830:134:3::10]:53365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emPNt-0008My-8L
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emPNs-0005sZ-5D
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:39:57 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:47062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emPNr-0005sC-VK
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:39:56 -0500
Received: by mail-ot0-x242.google.com with SMTP id w10so747452ote.13
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 11:39:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5193436.NpsRQSl3SI@wirbelwind>
References: <5193436.NpsRQSl3SI@wirbelwind>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 19:39:34 +0000
Message-ID: <CAFEAcA_xHpd5_RVp4_Be3wOa_U6YTpN0wiKheMYApuSOkbtjHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/02] fix issue where a branch to pc+4
 confuses GDB because pc and npc are set to the same value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: steven.seeger@flightsystems.net
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 15 February 2018 at 19:15, Steven Seeger
<steven.seeger@flightsystems.net> wrote:
> From ef3183a1648f45c705b55704de3755f84e9bcf80 Mon Sep 17 00:00:00 2001
> From: Steven Seeger <steven.seeger@flightsystems.net>
> Date: Thu, 15 Feb 2018 13:20:04 -0500
> Subject: [PATCH 1/2] fix issue where a branch to pc+4 confuses GDB because pc
>  and npc are set to the same value
>
> Signed-off-by: Steven Seeger <steven.seeger@flightsystems.net>
> ---
>  target/sparc/translate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 71e0853e43..4c2272003d 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1464,6 +1464,9 @@ static void do_branch(DisasContext *dc, int32_t offset,
> uint32_t insn, int cc)
>              dc->npc = dc->pc + 4;
>          } else {
>              dc->pc = dc->npc;
> +            if (target == dc->pc) {
> +                target += 4;
> +            }
>              dc->npc = target;
>              tcg_gen_mov_tl(cpu_pc, cpu_npc);
>          }
> @@ -1504,6 +1507,9 @@ static void do_fbranch(DisasContext *dc, int32_t offset,
> uint32_t insn, int cc)
>              dc->npc = dc->pc + 4;
>          } else {
>              dc->pc = dc->npc;
> +            if (target == dc->pc) {
> +                target += 4;
> +            }
>              dc->npc = target;
>              tcg_gen_mov_tl(cpu_pc, cpu_npc);

These changes look rather odd -- are you sure they're right?
This is the code for unconditional taken branch, not annulled, and
my copy of the sparc architecture manual says that in that case
the new PC value should be the old nPC value, and the new
nPC value should be the effective address of the branch target.
There's nothing in there about branches into your own delay
slot being a special case. Adding 4 to target like this will
make the new nPC value be 4 further forward, which would mean
we'd only execute the branch target instruction once, rather
than twice (once for it being in the branch delay slot and
once as the instruction target).

It's a weird thing to do so I wouldn't be surprised if gdb
mishandled it. Have you tested against real sparc hardware?

thanks
-- PMM
