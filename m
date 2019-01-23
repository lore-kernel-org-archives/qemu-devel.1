Received: from eggs.gnu.org ([209.51.188.92]:50705)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <r@hev.cc>)
	id 1gmGM3-000682-Jj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r@hev.cc>) id 1gmGM0-0000JC-JZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:05:58 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <r@hev.cc>) id 1gmGLu-0000Ge-3u
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:05:52 -0500
Received: by mail-lj1-x242.google.com with SMTP id c19-v6so1545423lja.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 03:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20190123073402.28465-1-r@hev.cc>
	<f79c9b64-5219-302e-1f0b-750e35ecb1fe@redhat.com>
In-Reply-To: <f79c9b64-5219-302e-1f0b-750e35ecb1fe@redhat.com>
From: Heiher <r@hev.cc>
Date: Wed, 23 Jan 2019 19:05:36 +0800
Message-ID: <CAHirt9h89R5gjevChbQdgcsAeFoYFfiLeHUPfYKHxLPVh62Csg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v1] i386: hvf: Fix smp boot hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Wed, Jan 23, 2019 at 5:45 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 23/01/19 08:34, Heiher wrote:
> > The machine that with hvf accelerator and smp sometimes boot hangs
> > because all processors are executing instructions at startup,
> > including early I/O emulations. We should just allow the bootstrap
> > processor to initialize the machine and then to wake up slave
> > processors by interrupt.
> >
> > Signed-off-by: Heiher <r@hev.cc>
> > ---
> >  target/i386/hvf/hvf.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> > index e193022c03..0921fcba45 100644
> > --- a/target/i386/hvf/hvf.c
> > +++ b/target/i386/hvf/hvf.c
> > @@ -499,7 +499,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
> >      }
> >
> >      hv_vm_sync_tsc(0);
> > -    cpu->halted = 0;
> >      hv_vcpu_invalidate_tlb(cpu->hvf_fd);
> >      hv_vcpu_flush(cpu->hvf_fd);
> >  }
> > @@ -582,8 +581,6 @@ int hvf_init_vcpu(CPUState *cpu)
> >
> >      wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
> >
> > -    hvf_reset_vcpu(cpu);
>
> Why this?
It looks redundant. I think it is enough to reset vcpu from
x86_cpu_reset, likes kvm.
https://git.qemu.org/?p=qemu.git;a=blob;f=target/i386/cpu.c;h=2f5412592d30ea7a24810f3bf6a8c7d4b035a0f9;hb=952bc8b3c2cbba78261923a1e8ca55cda261dee9#l4732
Do you think it is correct?
>
> >      x86cpu = X86_CPU(cpu);
> >      x86cpu->env.xsave_buf = qemu_memalign(4096, 4096);
> >
> > @@ -659,8 +656,6 @@ int hvf_vcpu_exec(CPUState *cpu)
> >      int ret = 0;
> >      uint64_t rip = 0;
> >
> > -    cpu->halted = 0;
> > -
> >      if (hvf_process_events(cpu)) {
> >          return EXCP_HLT;
> >      }
> >
>
> Looks good apart from the question above.
>
> Paoo

Thank you reply.

-- 
Best regards!
Hev
https://hev.cc
