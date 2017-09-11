Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drTLc-0006kE-IA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drTLY-0002MS-8T
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1drTLX-0002L7-VL
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:22:12 -0400
Date: Mon, 11 Sep 2017 15:22:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170911182207.GR7570@localhost.localdomain>
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-9-david@redhat.com>
	<1603f6bf-f481-13c2-c7eb-ac155c5a14cc@redhat.com>
	<b8f78724-b6be-3e95-60fa-8c7dcafe2eec@redhat.com>
	<20170909220737.GL7570@localhost.localdomain>
	<5d20eb5c-85cd-e500-0b98-c044c5176726@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d20eb5c-85cd-e500-0b98-c044c5176726@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/21] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 11, 2017 at 04:23:09AM +0200, Thomas Huth wrote:
> On 10.09.2017 00:07, Eduardo Habkost wrote:
> > On Fri, Sep 08, 2017 at 02:46:36PM +0200, David Hildenbrand wrote:
> >> On 08.09.2017 06:21, Thomas Huth wrote:
> >>> On 07.09.2017 22:13, David Hildenbrand wrote:
> >>>> Implemented in sclp.c, so let's move it to the right include file.
> >>>> Fix up one include. Do a forward declaration of CPUS390XState to fix the
> >>>> two sclp consoles complaining.
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  include/hw/s390x/sclp.h    | 2 ++
> >>>>  target/s390x/cpu.h         | 1 -
> >>>>  target/s390x/misc_helper.c | 1 +
> >>>>  3 files changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> >>>> index a72d096081..4b86a8a293 100644
> >>>> --- a/include/hw/s390x/sclp.h
> >>>> +++ b/include/hw/s390x/sclp.h
> >>>> @@ -242,5 +242,7 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
> >>>>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
> >>>>  void sclp_service_interrupt(uint32_t sccb);
> >>>>  void raise_irq_cpu_hotplug(void);
> >>>> +typedef struct CPUS390XState CPUS390XState;
> >>>> +int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> >>>
> >>> That's dangerous and likely does not work with certain versions of GCC.
> >>> You can't do a "forward declaration" with typedef in C, I'm afraid. See
> >>> for example:
> >>>
> >>>  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01454.html
> >>>  https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03337.html
> >>>  https://stackoverflow.com/questions/8367646/redefinition-of-typedef
> >>>
> >>> All this typedef'ing in QEMU is pretty bad ... we run into this problem
> >>> again and again. include/qemu/typedefs.h is just a work-around for this.
> >>> I know people like typedefs for some reasons (I used to do that, too,
> >>> before I realized the trouble with them), but IMHO we should rather
> >>> adopt the typedef-related rules from the kernel coding conventions instead:
> >>>
> >>>  https://www.kernel.org/doc/html/v4.13/process/coding-style.html#typedefs
> >>>
> >>>   Thomas
> >>>
> >>
> >> Yes, this is really nasty. And I wasn't aware of the involved issues.
> >>
> >> This seems to be the only feasible solution (including cpu.h sounds
> >> wrong and will require a bunch of other includes):
> >>
> >>
> >> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> >> index a72d096081..ce80915a02 100644
> >> --- a/include/hw/s390x/sclp.h
> >> +++ b/include/hw/s390x/sclp.h
> >> @@ -242,5 +242,7 @@ sclpMemoryHotplugDev
> >> *init_sclp_memory_hotplug_dev(void);
> >>  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
> >>  void sclp_service_interrupt(uint32_t sccb);
> >>  void raise_irq_cpu_hotplug(void);
> >> +struct CPUS390XState;
> >> +int sclp_service_call(struct CPUS390XState *env, uint64_t sccb,
> >> uint32_t code);
> >>
> >>  #endif
> > 
> > Why not use typedefs.h?
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> > index 4b86a8a293..3512bf8283 100644
> > --- a/include/hw/s390x/sclp.h
> > +++ b/include/hw/s390x/sclp.h
> > @@ -242,7 +242,6 @@ sclpMemoryHotplugDev *init_sclp_memory_hotplug_dev(void);
> >  sclpMemoryHotplugDev *get_sclp_memory_hotplug_dev(void);
> >  void sclp_service_interrupt(uint32_t sccb);
> >  void raise_irq_cpu_hotplug(void);
> > -typedef struct CPUS390XState CPUS390XState;
> >  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> >  
> >  #endif
> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > index 39bc8351a3..9c97bffa92 100644
> > --- a/include/qemu/typedefs.h
> > +++ b/include/qemu/typedefs.h
> 
> Using include/qeemu/typedefs.h here is IMHO really ugly. Do we really
> want to pollute a common include file with target specific code? My
> preferences are first to avoid typdefs, but if we really need/want them
> (do we? There is no comment about this in our coding styles), I think we
> should rather introduce target-specific typedefs.h headers, too, for
> everything that is not part of the common code.

I don't see any advantage in splitting typedefs.h into
arch-specific files.  We don't split typedefs.h into
subsystem-specific or device-specific headers, so I don't see we
would need a per-architecture split either.  typedefs.h is just a
global collection of type identifiers that helps us reduce header
dependency hell.

(Anyway, the current problem is now going solved by using
S390CPU* instead of CPUS390XState*, so there's no need to touch
typedefs.h this time.)

About keeping using typedefs: I don't have an strong opinion
for/against them[1], but I would prefer to keep style consistent
even if it's not explicitly documented.

[1] The fact that it would make typedefs.h completely unnecessary
    makes me inclined towards the suggestion to stop using them.

-- 
Eduardo
