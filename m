Received: from eggs.gnu.org ([2001:4830:134:3::10]:52721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLd6i-0002G1-0B
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 18:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLd6e-0005ET-M8
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 18:19:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLd6e-0005E9-CQ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 18:19:12 -0400
Date: Thu, 15 Jun 2017 18:19:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170615221911.GB26408@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149727924970.28532.9346819516051209538.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Some minor nits below.

On Mon, Jun 12, 2017 at 17:54:09 +0300, Lluís Vilanova wrote:
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
> +/**
> + * BreakpointHitType:
> + * @BH_MISS: No hit
> + * @BH_HIT_INSN: Hit, but continue translating instruction
> + * @BH_HIT_TB: Hit, stop translating TB
> + *
> + * How to react to a breakpoint hit.
> + */
> +typedef enum BreakpointHitType {
> +    BH_MISS,
> +    BH_HIT_INSN,
> +    BH_HIT_TB,
> +} BreakpointHitType;

BH_MISS reads out loud to "Breakpoint Hit Miss"; that's quite counterintuitive.
Similarly for the others (e.g. "breakpoint Hit Hit -- ??".

Can we just do BP_{MISS,HIT,etc}? Thinking about it, perhaps BP_NONE is
better than BP_MISS.

(snip)
> +/**
> + * DisasContextBase:
> + * @tb: Translation block for this disassembly.
> + * @pc_first: Address of first guest instruction in this TB.
> + * @pc_next: Address of next guest instruction in this TB (current during
> + *           disassembly).
> + * @num_insns: Number of translated instructions (including current).
> + * @singlestep_enabled: "Hardware" single stepping enabled.
> + *
> + * Architecture-agnostic disassembly context.
> + */
> +typedef struct DisasContextBase {
> +    TranslationBlock *tb;
> +    target_ulong pc_first;
> +    target_ulong pc_next;
> +    DisasJumpType jmp_type;
> +    unsigned int num_insns;
> +    bool singlestep_enabled;
> +} DisasContextBase;

- @pc_next: I'd stick with @pc, it's shorter, it's everywhere already, and
  with the documentation it's very clear what it is for.
- @jmp_type: missing doc :-)

Thanks,

		E.
