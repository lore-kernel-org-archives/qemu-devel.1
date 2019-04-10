Received: from eggs.gnu.org ([209.51.188.92]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hEBz0-0007hB-Ds
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hEByz-0002kL-6Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:05:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hEByy-0002iy-SH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:05:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id 4so2332693wmf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 05:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
	<20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
In-Reply-To: <20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Wed, 10 Apr 2019 17:35:23 +0530
Message-ID: <CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move
 hvf_cpu_synchronize* calls to cpu_synchronize* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 10 Apr 2019 at 17:20, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
>
> On Sun, Apr 07, 2019 at 05:28:39PM +0530, Sukrit Bhatnagar wrote:
> > Keep the calls made to synchronize cpu by all hypervisors in one place
> > inside cpu_synchronize_* functions in include/sysemu/hw_accel.h
> >
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >  cpus.c                    | 12 ------------
> >  include/sysemu/hw_accel.h | 10 ++++++++++
> >  2 files changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/cpus.c b/cpus.c
> > index e83f72b48b..026df0dc5f 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1021,10 +1021,6 @@ void cpu_synchronize_all_states(void)
> >
> >      CPU_FOREACH(cpu) {
> >          cpu_synchronize_state(cpu);
> > -        /* TODO: move to cpu_synchronize_state() */
> > -        if (hvf_enabled()) {
> > -            hvf_cpu_synchronize_state(cpu);
> > -        }
> >      }
> >  }
> >
> > @@ -1034,10 +1030,6 @@ void cpu_synchronize_all_post_reset(void)
> >
> >      CPU_FOREACH(cpu) {
> >          cpu_synchronize_post_reset(cpu);
> > -        /* TODO: move to cpu_synchronize_post_reset() */
> > -        if (hvf_enabled()) {
> > -            hvf_cpu_synchronize_post_reset(cpu);
> > -        }
> >      }
> >  }
> >
> > @@ -1047,10 +1039,6 @@ void cpu_synchronize_all_post_init(void)
> >
> >      CPU_FOREACH(cpu) {
> >          cpu_synchronize_post_init(cpu);
> > -        /* TODO: move to cpu_synchronize_post_init() */
> > -        if (hvf_enabled()) {
> > -            hvf_cpu_synchronize_post_init(cpu);
> > -        }
> >      }
> >  }
> >
> > diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> > index d2ddfb5ad0..bf081b4026 100644
> > --- a/include/sysemu/hw_accel.h
> > +++ b/include/sysemu/hw_accel.h
> > @@ -15,6 +15,7 @@
> >  #include "sysemu/hax.h"
> >  #include "sysemu/kvm.h"
> >  #include "sysemu/whpx.h"
> > +#include "sysemu/hvf.h"
> >
> >  static inline void cpu_synchronize_state(CPUState *cpu)
> >  {
> > @@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
> >      if (whpx_enabled()) {
> >          whpx_cpu_synchronize_state(cpu);
> >      }
> > +    if (hvf_enabled()) {
> > +        hvf_cpu_synchronize_state(cpu);
> > +    }
> >  }
> >
> >  static inline void cpu_synchronize_post_reset(CPUState *cpu)
> > @@ -40,6 +44,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
> >      if (whpx_enabled()) {
> >          whpx_cpu_synchronize_post_reset(cpu);
> >      }
> > +    if (hvf_enabled()) {
> > +        hvf_cpu_synchronize_post_reset(cpu);
> > +    }
> >  }
> >
> >  static inline void cpu_synchronize_post_init(CPUState *cpu)
> > @@ -53,6 +60,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
> >      if (whpx_enabled()) {
> >          whpx_cpu_synchronize_post_init(cpu);
> >      }
> > +    if (hvf_enabled()) {
> > +        hvf_cpu_synchronize_post_init(cpu);
> > +    }
> >  }
> >
> >  static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> > --
> > 2.20.1
> >
> >
>
> Hi Sukrit,
>
> The commit itself looks sane but qemu starts to hang during BIOS boot
> after I've applied it if I run it with hvf accel.

Hi Roman,
Thanks for reviewing the patches.
If this is happening, then I assume patches are not ready
to be merged into qemu-stable.
Do you have any idea why the problem is not detected
during tests, but rather at runtime?
I am not really sure if this patch (2/2) has anything to do with
the problem but the previous patch (1/2) might.

> Thanks,
> Roman
