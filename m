Received: from eggs.gnu.org ([2001:4830:134:3::10]:46787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0I68-0007nl-9d
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g0I65-0002bs-6S
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:15:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g0I65-0002Zg-16
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 23:15:13 -0400
Date: Thu, 13 Sep 2018 11:15:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180913031503.GC10763@xz-x1>
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-3-git-send-email-brijesh.singh@amd.com>
	<20180912035214.GC3829@xz-x1>
	<9ecccc2d-9274-36c1-c0a5-56a24836d075@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ecccc2d-9274-36c1-c0a5-56a24836d075@amd.com>
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
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Richard Henderson <rth@twiddle.net>

On Wed, Sep 12, 2018 at 01:59:06PM -0500, Brijesh Singh wrote:

[...]

> > >       }
> > >       return &iommu_as[devfn]->as;
> > >   }
> > > @@ -1172,6 +1274,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
> > >           return;
> > >       }
> > > +    /* Pseudo address space under root PCI bus. */
> > > +    pcms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_SB_IOAPIC_ID);
> > > +    s->intr_enabled = x86_iommu->intr_supported;
> > 
> > So does this mean that AMD IR cannot be disabled if declared support?
> > For VT-d, IR needs to be explicitly enabled otherwise disabled (even
> > supported).
> > 
> 
> 
> Yes, once its declared as supported then it can not disabled. Its
> upto the guest OS to decide whether it want to use the intr remapping
> feature by parsing the IVRS. This also brings question, should we
> just enable it by default because its guest OS decision whether it
> wants to use it or not.

It's by default off?  I mean:

    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),

Then it's good to me, thanks.  You could add a comment there
explicitly mentioning that "IR will be enabled as long as declared
support for AMD" since it might confuse some of the people like me...
but it's optional.

Regards,

-- 
Peter Xu
