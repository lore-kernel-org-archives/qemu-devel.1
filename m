Received: from eggs.gnu.org ([2001:4830:134:3::10]:60726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3Zz4-0003yi-Ml
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3Zz3-0006Np-Rm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:20:46 -0400
Date: Wed, 26 Apr 2017 23:20:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170427032038.GA5078@flamenco>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
	<1493187803-4510-7-git-send-email-cota@braap.org>
	<9ed31413-ddd8-b229-9731-a0433f8fbcde@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed31413-ddd8-b229-9731-a0433f8fbcde@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 06/10] target/arm: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On Wed, Apr 26, 2017 at 09:54:07 +0200, Richard Henderson wrote:
> On 04/26/2017 08:23 AM, Emilio G. Cota wrote:
> >+static bool gen_jr;...
> >         case DISAS_JUMP:
> >+            if (gen_jr) {
> 
> Why the variable?  Why not just try the goto_ptr for any DISAS_JUMP?

We have code that assumes DISAS_JUMP implies "go to exec loop", e.g.:
            case 6: /* isb */
                /* We need to break the TB after this insn to execute
                 * self-modifying code correctly and also to take
                 * any pending interrupts immediately.
                 */
                gen_lookup_tb(s);
where gen_lookup_tb does:

/* Force a TB lookup after an instruction that changes the CPU state.  */
static inline void gen_lookup_tb(DisasContext *s)
{
    tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
    s->is_jmp = DISAS_JUMP;
}

Also, the gen_exception_* functions set DISAS_JUMP. I suspect we want to go
to the exec loop with those as well.

Testing shows that I'm onto something; if I remove the variable,
and note that I make sure DISAS_UPDATE is not falling through, I get
easily reproducible (~1 out of 5) freezes and other instability
(e.g. RCU lockup warnings) when booting + shutting down debian jessie
in the guest.

In v4 I've added a comment about this.

Thanks,

		E.
