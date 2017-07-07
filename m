Received: from eggs.gnu.org ([2001:4830:134:3::10]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTT37-000732-Nn
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTT32-0002iO-Kv
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTT32-0002i3-CJ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:11:52 -0400
Date: Fri, 7 Jul 2017 15:11:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170707151147.640f1e41@dhcp-192-215.str.redhat.com>
In-Reply-To: <6db8b473-7531-4684-0d6d-88a83f8420fc@de.ibm.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-3-cohuck@redhat.com>
	<6db8b473-7531-4684-0d6d-88a83f8420fc@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/7] s390x: chsc nt2 events are pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On Fri, 7 Jul 2017 15:01:59 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/07/2017 02:21 PM, Cornelia Huck wrote:
> > The nt2 event class is pci-only and therefore implemented in
> > the s390x pci code. Properly stub it out for non-pci builds.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/s390-pci-bus.c |  4 ++--
> >  hw/s390x/s390-pci-bus.h |  4 ++--
> >  target/s390x/ioinst.c   | 18 ++++++++++++++++++
> >  3 files changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> > index 5651483781..eee9a04eac 100644
> > --- a/hw/s390x/s390-pci-bus.c
> > +++ b/hw/s390x/s390-pci-bus.c
> > @@ -47,7 +47,7 @@ S390pciState *s390_get_phb(void)
> >      return phb;
> >  }
> > 
> > -int chsc_sei_nt2_get_event(void *res)
> > +int pci_chsc_sei_nt2_get_event(void *res)
> >  {
> >      ChscSeiNt2Res *nt2_res = (ChscSeiNt2Res *)res;
> >      PciCcdfAvail *accdf;
> > @@ -87,7 +87,7 @@ int chsc_sei_nt2_get_event(void *res)
> >      return rc;
> >  }
> > 
> > -int chsc_sei_nt2_have_event(void)
> > +int pci_chsc_sei_nt2_have_event(void)
> >  {
> >      S390pciState *s = s390_get_phb();
> > 
> > diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
> > index cf142a3e68..29d3da10f6 100644
> > --- a/hw/s390x/s390-pci-bus.h
> > +++ b/hw/s390x/s390-pci-bus.h
> > @@ -318,8 +318,8 @@ typedef struct S390pciState {
> >  } S390pciState;
> > 
> >  S390pciState *s390_get_phb(void);
> > -int chsc_sei_nt2_get_event(void *res);
> > -int chsc_sei_nt2_have_event(void);
> > +int pci_chsc_sei_nt2_get_event(void *res);
> > +int pci_chsc_sei_nt2_have_event(void);
> >  void s390_pci_sclp_configure(SCCB *sccb);
> >  void s390_pci_sclp_deconfigure(SCCB *sccb);
> >  void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
> > diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> > index d5e6b8066b..a552f53167 100644
> > --- a/target/s390x/ioinst.c
> > +++ b/target/s390x/ioinst.c
> > @@ -599,6 +599,24 @@ static int chsc_sei_nt0_have_event(void)
> >      return 0;
> >  }
> > 
> > +static int chsc_sei_nt2_get_event(void *res)
> > +{
> > +#ifdef CONFIG_PCI
> > +    return pci_chsc_sei_nt2_get_event(res);
> > +#else
> > +    return 1;
> > +#endif
> > +}
> > +
> > +static int chsc_sei_nt2_have_event(void)
> > +{
> > +#ifdef CONFIG_PCI
> > +    return pci_chsc_sei_nt2_have_event();
> > +#else
> > +    return 0;
> > +#endif  
> 
> I think this is similar to the io instructions. We should use the CPU
> model to decide what to return. This will then cover the 3 cases
> - CONFIG_PCI off
> - CONFIG_PCI on, but PCI disabled via cpu model
> - CONFIG_PCI on, and PCI enabled via cpu model
> 
> no?

Using the cpu model sounds good, but I think we'll really need a stub
file for non-pci...
