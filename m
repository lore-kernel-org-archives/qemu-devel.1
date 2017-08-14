Received: from eggs.gnu.org ([2001:4830:134:3::10]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhBHm-00045t-5Z
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhBHh-0001Or-Nq
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhBHh-0001O5-Ev
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:03:41 -0400
Date: Mon, 14 Aug 2017 10:53:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170814105337.745899b3.cohuck@redhat.com>
In-Reply-To: <20170814100348.50fb3a96@nial.brq.redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-12-git-send-email-imammedo@redhat.com>
	<20170718143009.432250d5@gondolin>
	<20170718151721.25c3d603@nial.brq.redhat.com>
	<20170814100348.50fb3a96@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/28] s390x: replace cpu_s390x_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>

On Mon, 14 Aug 2017 10:03:48 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 18 Jul 2017 15:17:21 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue, 18 Jul 2017 14:30:09 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > On Fri, 14 Jul 2017 15:52:02 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >     
> > > > cpu_s390x_init() is used only *-user targets indirectly
> > > > via cpu_init() macro and has a hack to assign ids to created
> > > > cpus (I'm not sure if 'id' really matters to *-user emulation).
> > > > 
> > > > So to on safe side, instead of having custom wrapper to do numbering
> > > > replace it with cpu_generic_init() and use S390CPUClass::next_cpu_id
> > > > which could serve the same purpose as static variable and move cpu->id
> > > > initialization to s390_cpu_initfn for CONFIG_USER_ONLY use-case.
> > > > 
> > > > PS:
> > > > ifdef is ugly but it allows us to hide s390x detail that isn't
> > > > set by *-user targets and reuse generic cpu creation utility
> > > > for btoh machine and user emulation.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > > perhaps cpu->id isn't need by CONFIG_USER_ONLY but I'd leave to it
> > > > s390x maintainers to deal with it.
> > > > 
> > > > CC: Richard Henderson <rth@twiddle.net>
> > > > CC: Alexander Graf <agraf@suse.de>
> > > > CC: Cornelia Huck <cohuck@redhat.com>
> > > > CC: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >  target/s390x/cpu.h    |  3 +--
> > > >  target/s390x/cpu.c    |  7 +++++++
> > > >  target/s390x/helper.c | 14 --------------
> > > >  3 files changed, 8 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> > > > index bdb9bdb..b6d25c6 100644
> > > > --- a/target/s390x/cpu.h
> > > > +++ b/target/s390x/cpu.h
> > > > @@ -477,7 +477,6 @@ static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
> > > >  void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen);
> > > >  #endif
> > > >  
> > > > -S390CPU *cpu_s390x_init(const char *cpu_model);
> > > >  S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
> > > >  S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
> > > >  void s390x_translate_init(void);
> > > > @@ -641,7 +640,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
> > > >  
> > > >  extern void subsystem_reset(void);
> > > >  
> > > > -#define cpu_init(model) CPU(cpu_s390x_init(model))
> > > > +#define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
> > > >  #define cpu_signal_handler cpu_s390x_signal_handler
> > > >  
> > > >  void s390_cpu_list(FILE *f, fprintf_function cpu_fprintf);
> > > > diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> > > > index accef03..e40a26f 100644
> > > > --- a/target/s390x/cpu.c
> > > > +++ b/target/s390x/cpu.c
> > > > @@ -303,6 +303,13 @@ static void s390_cpu_initfn(Object *obj)
> > > >          inited = true;
> > > >          s390x_translate_init();
> > > >      }
> > > > +
> > > > +#if defined(CONFIG_USER_ONLY)
> > > > +    {
> > > > +        S390CPUClass *scc = S390_CPU_GET_CLASS(obj);
> > > > +        cpu->id = scc->next_cpu_id;
> > > > +    }
> > > > +#endif      
> > > 
> > > What about the null machine, which calls cpu_init() as well? Am I
> > > missing something?    
> > it creates only 1 cpu so for it following will be true:
> >  cpu->id == 0 and also scc->next_cpu_id == 0 at s390_cpu_initfn() time
> > then at realize() time scc->next_cpu_id++ happens and no more cpus could
> > be created in case of null machine.
> > 
> > Considering no -smp support for null-machine, we shouldn't care about
> > multiple instantiations with cpu_init() there. 
> > If we would ever start caring about -smp there, then we should
> > explicitly create cpus with properly set properties like other boards
> > do.  
> ping,
> 
> Cornelia,
> considering my previous reply does this patch look fine to you?

Sorry, that one fell through the cracks.

We may want to revisit this later; but for now, it should be fine.

I assume you want to merge this as a series? In that case,

Acked-by: Cornelia Huck <cohuck@redhat.com>
