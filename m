Received: from eggs.gnu.org ([2001:4830:134:3::10]:45015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0NJ5-0005ya-Io
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0NJ2-00050X-BG
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g0NJ1-0004ul-U5
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:48:56 -0400
Date: Thu, 13 Sep 2018 16:48:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180913084844.GH10763@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
	<20180912035214.GC3829@xz-x1>
	<9ecccc2d-9274-36c1-c0a5-56a24836d075@amd.com>
	<20180913031503.GC10763@xz-x1>
	<c6d1e6be-18ba-a078-3464-2f7f539dc626@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6d1e6be-18ba-a078-3464-2f7f539dc626@amd.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] x86_iommu/amd: Prepare for interrupt
 remap support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Sep 13, 2018 at 03:15:27PM +0700, Suravee Suthikulpanit wrote:
> Brijesh / Peter,
> 
> On 9/13/18 10:15 AM, Peter Xu wrote:
> > On Wed, Sep 12, 2018 at 01:59:06PM -0500, Brijesh Singh wrote:
> > 
> > [...]
> > 
> > > > >        }
> > > > >        return &iommu_as[devfn]->as;
> > > > >    }
> > > > > @@ -1172,6 +1274,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
> > > > >            return;
> > > > >        }
> > > > > +    /* Pseudo address space under root PCI bus. */
> > > > > +    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_SB_IOAPIC_ID);
> > > > > +    s->intr_enabled = x86_iommu->intr_supported;
> > > > 
> > > > So does this mean that AMD IR cannot be disabled if declared support?
> > > > For VT-d, IR needs to be explicitly enabled otherwise disabled (even
> > > > supported).
> > > > 
> > > 
> > > 
> > > Yes, once its declared as supported then it can not disabled. Its
> > > upto the guest OS to decide whether it want to use the intr remapping
> > > feature by parsing the IVRS. This also brings question, should we
> > > just enable it by default because its guest OS decision whether it
> > > wants to use it or not.
> > 
> > It's by default off?  I mean:
> > 
> >      DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
> > 
> > Then it's good to me, thanks.  You could add a comment there
> > explicitly mentioning that "IR will be enabled as long as declared
> > support for AMD" since it might confuse some of the people like me...
> > but it's optional.
> > 
> > Regards,
> > 
> 
> Actually, there are two separate knobs here:
> 
> * This option basically means the interrupt remapping support is available/unavailable,
>   which should default to available unless specified to unavailable at the QEMU command line.
>   For example, the AMD IOMMU v1 does not have interrupt remapping support, which means
>   the interrupt remapping bit fields in DTE (e.g. IV, IntCtl, EIntPass, INITPass, NMIPass,
>   Lint0Pass, Lint1Pass) are ignored.
> 
> * If interrupt remapping support is available, the guest OS can decide to enable or disable the feature
>   using DTE bit fileds (e.g. Linux option intremap=off would disable interrupt remapping
>   by not setting DTE[IV] bit). For Linux AMD IOMMU driver, the default is to enable the interrupt remapping.
> 
> In facts, we should not need this option. However, if you prefer to keep this option,
> we probably should rename this to "intremap_sup", in which if the default value should be 1.

I see, thanks.  For me I don't yet see a reason for that intremap_sup
since AFAIU that's exactly what current QEMU's intremap parameter do.

I think Intel is having the similar knobs:

* The "intremap" in QEMU decides whether the hardware we emulate
  supports interrupt remapping, and

* The "intremap" in the guest decides whether the guest kernel will
  use the interrupt remapping feature

Though IMHO the only difference is that Intel has another global knob
to turn that on/off in the GCMD register (VT-d spec 10.4.4, GCMD bit
25) depending on whether the 2nd knob is on, while for AMD it's just
per-device rather than per-iommu.

Regards,

-- 
Peter Xu
