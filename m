Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egZLY-0003Hs-Nf
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egZLF-0000bu-Mv
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:05:24 -0500
Date: Tue, 30 Jan 2018 18:04:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180130180446.3924446c.cohuck@redhat.com>
In-Reply-To: <69d20ca7-4134-4343-383e-80420225c65f@redhat.com>
References: <20180129165210.21086-1-cohuck@redhat.com>
	<20180129165210.21086-2-cohuck@redhat.com>
	<69d20ca7-4134-4343-383e-80420225c65f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de

On Tue, 30 Jan 2018 14:00:12 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 29.01.2018 17:52, Cornelia Huck wrote:
> > On s390x, pci support is implemented via a set of instructions
> > (no mmio). Unfortunately, none of them are documented in the
> > PoP; the code is based upon the existing implementation for KVM
> > and the Linux zpci driver.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/helper.h      |   9 ++++
> >  target/s390x/insn-data.def |  13 +++++
> >  target/s390x/misc_helper.c | 123 +++++++++++++++++++++++++++++++++++++++++++++
> >  target/s390x/translate.c   | 123 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 268 insertions(+)
> > 

(...)

> > diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> > index 86da6aab7e..1271106628 100644
> > --- a/target/s390x/misc_helper.c
> > +++ b/target/s390x/misc_helper.c
> > @@ -36,6 +36,7 @@
> >  #include "hw/s390x/ebcdic.h"
> >  #include "hw/s390x/s390-virtio-hcall.h"
> >  #include "hw/s390x/sclp.h"
> > +#include "hw/s390x/s390-pci-inst.h"
> >  #endif
> >  
> >  /* #define DEBUG_HELPER */
> > @@ -560,3 +561,125 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
> >      env->regs[0] = deposit64(env->regs[0], 0, 8, (max_bytes / 8) - 1);
> >      return count_bytes >= max_bytes ? 0 : 3;
> >  }
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +void HELPER(clp)(CPUS390XState *env, uint32_t r2)
> > +{
> > +    S390CPU *cpu = s390_env_get_cpu(env);
> > +    int r = -1;
> > +
> > +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> > +        qemu_mutex_lock_iothread();
> > +        r = clp_service_call(cpu, r2, GETPC());
> > +        qemu_mutex_unlock_iothread();
> > +    }
> > +    if (r) {
> > +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> > +    }  
> 
> Hmmm, this handling should not be necessary for TCG. All we should need is:
> 
> qemu_mutex_lock_iothread();
> r = clp_service_call(cpu, r2, GETPC());
> qemu_mutex_unlock_iothread();
> 
> We will handle
> 
> a) pci not configured in patch nr2 via the CPU model (will propose
> something there).
> 
> b) we will handle !s390_has_feat(S390_FEAT_ZPCI) although available
> later just as other instructions via the "PCI" flag you attached to the
> instructions (Richard once posted a patch to do that).

Even better if that works. (Although I don't quite understand how the
FAC_xxx defines interact with the facilities.)

> 
> > +}

(...)

> > diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> > index df0b41606d..b73f7143db 100644
> > --- a/target/s390x/translate.c
> > +++ b/target/s390x/translate.c
> > @@ -4777,6 +4777,128 @@ static ExitStatus op_zero2(DisasContext *s, DisasOps *o)
> >      return NO_EXIT;
> >  }
> >    
> 
> > +
> > +static ExitStatus op_stpcifc(DisasContext *s, DisasOps *o)
> > +{
> > +    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> > +    int b2 = get_field(s->fields, b2);
> > +    int d2 = get_field(s->fields, d2);
> > +    TCGv_i64 addr;
> > +    TCGv_i32 ar;
> > +  
> 
> You can simply drop b2, d2 and addr, and instead use in1_la2 for the
> input value specification:
> 
> 
> C(0xe3d4, STPCIFC, RXY_a, PCI, la2, 0, 0, 0, stpcifc, 0)
> 
> > +    check_privileged(s);
> > +    addr = get_address(s, 0, b2, d2);
> > +    ar = tcg_const_i32(b2);
> > +    gen_helper_stpcifc(cpu_env, r1, addr, ar);  
> 
> gen_helper_stpcifc(cpu_env, r1, o->addr1, ar);
> 
> > +    tcg_temp_free_i64(addr);
> > +    tcg_temp_free_i32(ar);
> > +    tcg_temp_free_i32(r1);
> > +    set_cc_static(s);
> > +    return NO_EXIT;
> > +}
> > +
> > +static ExitStatus op_sic(DisasContext *s, DisasOps *o)
> > +{
> > +    int r1 = get_field(s->fields, r1);
> > +    int r3 = get_field(s->fields, r3);
> > +  
> 
> (these two can be const)
> you could use in1_r1 and in2_r3
> 
> > +    check_privileged(s);
> > +    gen_helper_sic(cpu_env, regs[r1], regs[r3]);  
> 
> gen_helper_sic(cpu_env, o->in1, o->in2);
> 
> > +    set_cc_static(s);  
> 
> Are you sure this instruction modifies the cc? Can't spot a set_cc when
> following the kvm code.

Ah, you're right. The kernel insn agrees as well.

> 
> > +    return NO_EXIT;
> > +}
> > +
> > +static ExitStatus op_rpcit(DisasContext *s, DisasOps *o)
> > +{
> > +    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> > +    TCGv_i32 r2 = tcg_const_i32(get_field(s->fields, r2));
> > +
> > +    check_privileged(s);
> > +    gen_helper_rpcit(cpu_env, r1, r2);
> > +    tcg_temp_free_i32(r1);
> > +    tcg_temp_free_i32(r2);
> > +    set_cc_static(s);
> > +    return NO_EXIT;
> > +}
> > +
> > +static ExitStatus op_pcistb(DisasContext *s, DisasOps *o)
> > +{
> > +    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> > +    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
> > +    int b2 = get_field(s->fields, b2);
> > +    int d2 = get_field(s->fields, d2);  
> 
> Dito, use in1_la2
> 
> > +    TCGv_i64 addr;
> > +    TCGv_i32 ar;
> > +
> > +    check_privileged(s);
> > +    addr = get_address(s, 0, b2, d2);
> > +    ar = tcg_const_i32(b2);  
> 
> And you can initialize this directly then
> 
> TCGv_i32 ar = tcg_const_i32(get_field(s->fields, b2));
> 
> ... also applies to the others
> 
> > +    gen_helper_pcistb(cpu_env, r1, r3, addr, ar);
> > +    tcg_temp_free_i64(addr);
> > +    tcg_temp_free_i32(ar);
> > +    tcg_temp_free_i32(r1);
> > +    tcg_temp_free_i32(r3);
> > +    set_cc_static(s);
> > +    return NO_EXIT;
> > +}
> > +
> > +static ExitStatus op_mpcifc(DisasContext *s, DisasOps *o)
> > +{
> > +    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
> > +    int b2 = get_field(s->fields, b2);
> > +    int d2 = get_field(s->fields, d2);
> > +    TCGv_i64 addr;
> > +    TCGv_i32 ar;
> > +  
> 
> dito

OK, I'll update all these.

> 
> > +    check_privileged(s);
> > +    addr = get_address(s, 0, b2, d2);
> > +    ar = tcg_const_i32(b2);
> > +    gen_helper_mpcifc(cpu_env, r1, addr, ar);
> > +    tcg_temp_free_i64(addr);
> > +    tcg_temp_free_i32(ar);
> > +    tcg_temp_free_i32(r1);
> > +    set_cc_static(s);
> > +    return NO_EXIT;
> > +}
> > +#endif
> > +
> >  /* ====================================================================== */
> >  /* The "Cc OUTput" generators.  Given the generated output (and in some cases
> >     the original inputs), update the various cc data structures in order to
> > @@ -5708,6 +5830,7 @@ enum DisasInsnEnum {
> >  #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 facility */
> >  #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 facility */
> >  #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
> > +#define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
> >  
> >  static const DisasInsn insn_info[] = {
> >  #include "insn-data.def"
> >   
> 
> Thanks!

No, thanks from me :)
