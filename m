Received: from eggs.gnu.org ([2001:4830:134:3::10]:34089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cyTqZ-0007fL-M6
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cyTqY-0003Xb-Gj
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:46:55 -0400
Date: Wed, 12 Apr 2017 21:46:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170413014646.GA1474@flamenco>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-10-git-send-email-cota@braap.org>
	<2ede0852-6888-8bcb-ac5a-363478841bc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ede0852-6888-8bcb-ac5a-363478841bc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] target/i386: optimize indirect
 branches with TCG's jr op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

On Wed, Apr 12, 2017 at 11:43:45 +0800, Paolo Bonzini wrote:
> 
> 
> On 12/04/2017 09:17, Emilio G. Cota wrote:
> > 
> > The fact that NBench is not very sensitive to changes here is a
> > little surprising, especially given the significant improvements for
> > ARM shown in the previous commit. I wonder whether the compiler is doing
> > a better job compiling the x86_64 version (I'm using gcc 5.4.0), or I'm simply
> > missing some i386 instructions to which the jr optimization should
> > be applied.
> 
> Maybe it is "ret"?  That would be a straightforward "bx lr" on ARM, but
> it is missing in your i386 patch.

Yes I missed that. I added this fix-up:

diff --git a/target/i386/translate.c b/target/i386/translate.c
index aab5c13..f2b5a0f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6430,7 +6430,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xc3: /* ret */
         ot = gen_pop_T0(s);
@@ -6438,7 +6438,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xca: /* lret im */
         val = cpu_ldsw_code(env, s->pc);

Any other instructions I should look into? Perhaps lret/lret im?

Anyway, nbench does not improve much with the above. The reason seems to be
that it's full of direct jumps (visible with -d in_asm). Also tried softmmu
to see whether these jumps are in-page or not: peak improvement is ~8%, so
I guess most of them are in-page. See http://imgur.com/EKRrYUz

I'm running new tests on a server with no other users and which has
frequency scaling disabled. This should help get less noisy numbers,
since I'm having trouble replicating my own results :> (I used my desktop
machine until now). Will post these numbers tomorrow (running overnight
SPECint both train and set sizes).

Thanks,

		Emilio
