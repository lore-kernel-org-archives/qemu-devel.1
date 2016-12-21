Received: from eggs.gnu.org ([2001:4830:134:3::10]:46278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJhQu-0002Rd-Vn
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cJhQr-00080z-TH
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:59:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cJhQr-0007zm-Kj
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:59:49 -0500
Date: Wed, 21 Dec 2016 14:59:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161221145934.219d73fd@nial.brq.redhat.com>
In-Reply-To: <20161221123509.GC16872@bivouac.eciton.net>
References: <20161216152319.12494-1-leif.lindholm@linaro.org>
	<20161221115102.251224b8@nial.brq.redhat.com>
	<20161221123509.GC16872@bivouac.eciton.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] smbios: stop ignoring command line options
 for TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 21 Dec 2016 12:35:09 +0000
Leif Lindholm <leif.lindholm@linaro.org> wrote:

> On Wed, Dec 21, 2016 at 11:51:02AM +0100, Igor Mammedov wrote:
> > On Fri, 16 Dec 2016 15:23:19 +0000  
> > > Verified on ARM mach-virt with UEFI shell "smbiosview" command and QEMU
> > > command line parameter -smbios type=0,version=foobar.
> > > 
> > >  arch_init.c                | 6 +++---
> > >  include/hw/smbios/smbios.h | 2 ++
> > >  vl.c                       | 2 ++
> > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch_init.c b/arch_init.c
> > > index 5cc58b2..d4e28c0 100644
> > > --- a/arch_init.c
> > > +++ b/arch_init.c
> > > @@ -250,9 +250,9 @@ void do_acpitable_option(const QemuOpts *opts)
> > >  
> > >  void do_smbios_option(QemuOpts *opts)
> > >  {
> > > -#ifdef TARGET_I386  
> > extending above condition to make it compiled for ARM
> > would do what you need  
> 
> Yes, but given how tedious that was to track down without a decent
> grasp of the source tree structure I had hoped to improve the
> experience for future newcomers.
> 
> If that's not considered important, sure, I could hack together a v2
> consisting only of that.
> 
> > > -    smbios_entry_add(opts);
> > > -#endif
> > > +    if (smbios_override) {
> > > +        smbios_entry_add(opts);
> > > +    }
> > >  }
> > >  
> > >  int kvm_available(void)
> > > diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
> > > index 1cd53cc..2a3dca2 100644
> > > --- a/include/hw/smbios/smbios.h
> > > +++ b/include/hw/smbios/smbios.h
> > > @@ -267,4 +267,6 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
> > >                         const unsigned int mem_array_size,
> > >                         uint8_t **tables, size_t *tables_len,
> > >                         uint8_t **anchor, size_t *anchor_len);
> > > +
> > > +extern int smbios_override;  
> > Adding global variables generally is not welcomed and one
> > should try to avoid it if it could be helped.  
> 
> That is certainly a fair comment. Not being too familiar with the
> codebase I was slavishly trying to follow the style of the surrounding
> code. Will avoid that in future.
> 
> > >  #endif /* QEMU_SMBIOS_H */
> > > diff --git a/vl.c b/vl.c
> > > index d77dd86..8e71b06 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -159,6 +159,7 @@ int smp_cpus = 1;
> > >  int max_cpus = 1;
> > >  int smp_cores = 1;
> > >  int smp_threads = 1;
> > > +int smbios_override = 0;
> > >  int acpi_enabled = 1;
> > >  int no_hpet = 0;
> > >  int fd_bootchk = 1;
> > > @@ -3711,6 +3712,7 @@ int main(int argc, char **argv, char **envp)
> > >                  if (!opts) {
> > >                      exit(1);
> > >                  }
> > > +                smbios_override = 1;  
> >                    ^^^ practically turns follow up call into unconditional
> > smbios_entry_add(opts) call,  
> 
> Which is what it already is for TARGET_I386.
> 
> > so what's the point for adding 'smbios_override' at all?  
> 
> Apparently a misunderstanding of the underlying command line handling
> mechanics.
> 
> > Also this patch would break build for targets that don't link smbios.c
> > (i.e. which don't have CONFIG_SMBIOS=y)  
> 
> Ah, I hadn't spotted that - apologies.
Just do 1 build for all targets before posting patches to avoid
such kind of errors.


> 
> So a simpler, and more correct fix would rather be to change the
> #ifdef TARGET_I386
> in arch_init.c to
> #ifdef CONFIG_SMBIOS
it looks better to me than enumerating targets explicitly,
CCing Paolo for another opinion


> ... if there had been a conveniently available CONFIG_SMBIOS.
> Would it be acceptable to add one to config-target.h or is that
> reserved for host-specific options?

> 
> Regards,
> 
> Leif
> 
> > >                  do_smbios_option(opts);
> > >                  break;
> > >              case QEMU_OPTION_fwcfg:  
> >   
> 
