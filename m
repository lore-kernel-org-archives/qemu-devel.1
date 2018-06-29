Received: from eggs.gnu.org ([2001:4830:134:3::10]:59476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYqxh-0006rr-Gg
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYqxe-0005qa-3P
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:49:09 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:53061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYqxd-0005py-Om
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:49:06 -0400
Received: from player716.ha.ovh.net (unknown [10.109.120.118])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 262EA18520C
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 12:49:04 +0200 (CEST)
Date: Fri, 29 Jun 2018 12:48:48 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180629124848.5ad6ffe4@bahia.lan>
In-Reply-To: <8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

On Fri, 29 Jun 2018 12:35:09 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/06/2018 12:29, Greg Kurz wrote:
> > It is unsafe to rely on *_enabled() helpers before the accelerator has
> > been initialized, ie, accel_init_machine() has succeeded, because they
> > always return false. But it is still possible to end up calling them
> > indirectly by inadvertance, and cause QEMU to misbehave.
> > 
> > This patch causes QEMU to abort if we try to check for an accelerator
> > before it has been set up. This will help to catch bugs earlier.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > 
> > This patch was motivated by an regression we're currently fixing in
> > spapr because of an early use of kvm_enabled(). David suggested to
> > post this patch separately:
> > 
> > https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg01136.html
> > 
> > v2: - dropped change in qom/cpu.c (useless header inclusion)
> >     - only #include "sysemu/kvm.h" if we actually need it
> >     - added David's R-b from v1 because changes in v2 are minor  
> 
> This adds a function call on possibly hot paths.  Can you make it inline?
> 

I'll check this out.

> Also asserting current_machine != NULL is not necessary, since you're
> immediately dereferencing it.
> 

assert() is more explicit IMHO and it allows to know what's going on
without using gdb, but I can drop it if you prefer.

> Thanks,
> 
> Paolo
> 
> > ---
> >  accel/accel.c          |    7 +++++++
> >  include/qemu-common.h  |    3 ++-
> >  include/sysemu/accel.h |    1 +
> >  include/sysemu/kvm.h   |    3 ++-
> >  stubs/Makefile.objs    |    1 +
> >  stubs/accel.c          |   14 ++++++++++++++
> >  target/i386/hax-all.c  |    2 +-
> >  target/i386/whpx-all.c |    2 +-
> >  8 files changed, 29 insertions(+), 4 deletions(-)
> >  create mode 100644 stubs/accel.c
> > 
> > diff --git a/accel/accel.c b/accel/accel.c
> > index 966b2d8f536c..27900aac9cc5 100644
> > --- a/accel/accel.c
> > +++ b/accel/accel.c
> > @@ -51,6 +51,13 @@ static AccelClass *accel_find(const char *opt_name)
> >      return ac;
> >  }
> >  
> > +bool assert_accelerator_initialized(bool allowed)
> > +{
> > +    assert(current_machine != NULL);
> > +    assert(current_machine->accelerator != NULL);
> > +    return allowed;
> > +}
> > +
> >  static int accel_init_machine(AccelClass *acc, MachineState *ms)
> >  {
> >      ObjectClass *oc = OBJECT_CLASS(acc);
> > diff --git a/include/qemu-common.h b/include/qemu-common.h
> > index 85f4749aefb7..01d5e4d97dbf 100644
> > --- a/include/qemu-common.h
> > +++ b/include/qemu-common.h
> > @@ -82,7 +82,8 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
> >  extern bool tcg_allowed;
> >  void tcg_exec_init(unsigned long tb_size);
> >  #ifdef CONFIG_TCG
> > -#define tcg_enabled() (tcg_allowed)
> > +#include "sysemu/accel.h"
> > +#define tcg_enabled() (assert_accelerator_initialized(tcg_allowed))
> >  #else
> >  #define tcg_enabled() 0
> >  #endif
> > diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> > index 637358f43014..76965cb69cc9 100644
> > --- a/include/sysemu/accel.h
> > +++ b/include/sysemu/accel.h
> > @@ -71,5 +71,6 @@ void configure_accelerator(MachineState *ms);
> >  void accel_register_compat_props(AccelState *accel);
> >  /* Called just before os_setup_post (ie just before drop OS privs) */
> >  void accel_setup_post(MachineState *ms);
> > +bool assert_accelerator_initialized(bool allowed);
> >  
> >  #endif
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 0b64b8e06786..5a2e59e99128 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -46,7 +46,8 @@ extern bool kvm_direct_msi_allowed;
> >  extern bool kvm_ioeventfd_any_length_allowed;
> >  extern bool kvm_msi_use_devid;
> >  
> > -#define kvm_enabled()           (kvm_allowed)
> > +#include "sysemu/accel.h"
> > +#define kvm_enabled()           (assert_accelerator_initialized(kvm_allowed))
> >  /**
> >   * kvm_irqchip_in_kernel:
> >   *
> > diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> > index 53d3f32cb258..2d5142287525 100644
> > --- a/stubs/Makefile.objs
> > +++ b/stubs/Makefile.objs
> > @@ -43,3 +43,4 @@ stub-obj-y += xen-common.o
> >  stub-obj-y += xen-hvm.o
> >  stub-obj-y += pci-host-piix.o
> >  stub-obj-y += ram-block.o
> > +stub-obj-y += accel.o
> > diff --git a/stubs/accel.c b/stubs/accel.c
> > new file mode 100644
> > index 000000000000..4f480f2d3f29
> > --- /dev/null
> > +++ b/stubs/accel.c
> > @@ -0,0 +1,14 @@
> > +/*
> > + * accel stubs
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "sysemu/accel.h"
> > +
> > +bool assert_accelerator_initialized(bool allowed)
> > +{
> > +    return allowed;
> > +}
> > diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> > index d2e512856bb8..7c78bd7d094d 100644
> > --- a/target/i386/hax-all.c
> > +++ b/target/i386/hax-all.c
> > @@ -57,7 +57,7 @@ static int hax_arch_get_registers(CPUArchState *env);
> >  
> >  int hax_enabled(void)
> >  {
> > -    return hax_allowed;
> > +    return assert_accelerator_initialized(hax_allowed);
> >  }
> >  
> >  int valid_hax_tunnel_size(uint16_t size)
> > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
> > index 6b42096698ee..e7f6bc5958e7 100644
> > --- a/target/i386/whpx-all.c
> > +++ b/target/i386/whpx-all.c
> > @@ -1422,7 +1422,7 @@ static int whpx_accel_init(MachineState *ms)
> >  
> >  int whpx_enabled(void)
> >  {
> > -    return whpx_allowed;
> > +    return assert_accelerator_initialized(whpx_allowed);
> >  }
> >  
> >  static void whpx_accel_class_init(ObjectClass *oc, void *data)
> >   
> 
