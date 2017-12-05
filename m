Received: from eggs.gnu.org ([2001:4830:134:3::10]:45935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMAKi-0003Nl-B1
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMAKf-0001NY-0V
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:20:12 -0500
Date: Tue, 5 Dec 2017 11:20:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171205112001.2fb7ec1e.cohuck@redhat.com>
In-Reply-To: <10941b30-4fa9-37e6-7d25-f3423282f5b0@redhat.com>
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-2-david@redhat.com>
	<20171204180349.379dd02e.cohuck@redhat.com>
	<10941b30-4fa9-37e6-7d25-f3423282f5b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 1/5] s390x/kvm: factor out
 build_channel_report_mcic() into cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon, 4 Dec 2017 18:16:15 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.12.2017 18:03, Cornelia Huck wrote:
> > On Mon,  4 Dec 2017 13:55:01 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> We'll need it later on in two places. Refactor it to just indicate the
> >> valid bit. While at it, introduce a define for the used CR14 bit (we'll  
> > 
> > s/valid bit/validity bits/  
> 
> In the PoP they are defined as "validity" (e.g. 11-15)
> 
> Vector-register validity (VR)
> External-damage-code validity (EC)
> Floating-point-register validity (FP)
> General-register validity (GR)
> Control-register validity (CR)
> 
> So I am not sure if using a slightly different terminology here helps.

I don't know, "validity" seems to be more in line with the doc?

> 
> >   
> >> also need later on).
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/cpu.h | 20 ++++++++++++++++++++
> >>  target/s390x/kvm.c | 25 ++-----------------------
> >>  2 files changed, 22 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> >> index 9cfbbbac04..4d3e7920f5 100644
> >> --- a/target/s390x/cpu.h
> >> +++ b/target/s390x/cpu.h
> >> @@ -351,6 +351,9 @@ extern const struct VMStateDescription vmstate_s390_cpu;
> >>  #define CR0_CPU_TIMER_SC        0x0000000000000400ULL
> >>  #define CR0_SERVICE_SC          0x0000000000000200ULL
> >>  
> >> +/* Control register 14 bits */
> >> +#define CR14_CHANNEL_REPORT_SC  0x0000000010000000ULL
> >> +
> >>  /* MMU */
> >>  #define MMU_PRIMARY_IDX         0
> >>  #define MMU_SECONDARY_IDX       1
> >> @@ -674,6 +677,23 @@ struct sysib_322 {
> >>  #define MCIC_VB_CT 0x0000000000020000ULL
> >>  #define MCIC_VB_CC 0x0000000000010000ULL
> >>  
> >> +static inline uint64_t s390_build_validity_mcic(void)
> >> +{
> >> +    uint64_t mcic;
> >> +
> >> +    /* indicate all valid bits (no damage) */  
> > 
> > s/valid/validity/  
> 
> dito

dito :)

> 
> >   
> >> +    mcic = MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_FP |
> >> +           MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_PR |
> >> +           MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
> >> +    if (s390_has_feat(S390_FEAT_VECTOR)) {
> >> +        mcic |= MCIC_VB_VR;
> >> +    }
> >> +    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
> >> +        mcic |= MCIC_VB_GS;
> >> +    }
> >> +    return mcic;
> >> +}
> >> +  
> > 
> > Not sure why this should go into cpu.h - isn't there a better header
> > for it?  
> 
> internal.h maybe, but we also have the MCIC_* defines in cpu.h (esp.
> direct above this function :) ). So I guess this is best kept here.
> Opinions?

Let's keep it there for now. It's not like it has to stay there for all
eternity.

> 
> >   
> >>  
> >>  /* cpu.c */
> >>  int s390_get_clock(uint8_t *tod_high, uint64_t *tod_low);
> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index 97c45d5537..9b8b59f2a2 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -1852,33 +1852,12 @@ void kvm_s390_io_interrupt(uint16_t subchannel_id,
> >>      kvm_s390_floating_interrupt(&irq);
> >>  }
> >>  
> >> -static uint64_t build_channel_report_mcic(void)
> >> -{
> >> -    uint64_t mcic;
> >> -
> >> -    /* subclass: indicate channel report pending */
> >> -    mcic = MCIC_SC_CP |
> >> -    /* subclass modifiers: none */
> >> -    /* storage errors: none */  
> > 
> > I find these additional comments quite useful - can they be preserved
> > in any way?  
> 
> With the new abstraction ("validity" only) / function name most of them
> don't make sense anymore (esp. to be handled by the caller) in the
> context of this function. All other bits would be special for other
> machine check types we want to inject.

OK, as it seems we have #defines for all bits, I think we can live with
that.

> 
> >   
> >> -    /* validity bits: no damage */
> >> -        MCIC_VB_WP | MCIC_VB_MS | MCIC_VB_PM | MCIC_VB_IA | MCIC_VB_FP |
> >> -        MCIC_VB_GR | MCIC_VB_CR | MCIC_VB_ST | MCIC_VB_AR | MCIC_VB_PR |
> >> -        MCIC_VB_FC | MCIC_VB_CT | MCIC_VB_CC;
> >> -    if (s390_has_feat(S390_FEAT_VECTOR)) {
> >> -        mcic |= MCIC_VB_VR;
> >> -    }
> >> -    if (s390_has_feat(S390_FEAT_GUARDED_STORAGE)) {
> >> -        mcic |= MCIC_VB_GS;
> >> -    }
> >> -    return mcic;
> >> -}  
> 
> 
> 
