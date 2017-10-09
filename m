Received: from eggs.gnu.org ([2001:4830:134:3::10]:55096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1U3Y-0004hG-IX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1U3V-0003xI-Dj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1U3V-0003ww-7J
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 05:08:57 -0400
Date: Mon, 9 Oct 2017 11:08:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009110852.2dcf0c55.cohuck@redhat.com>
In-Reply-To: <20171009104244.02d60070.cohuck@redhat.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-4-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009104244.02d60070.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 3/5] s390x/intc: Emulate Adapter
 Interrupt Suppression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Mon, 9 Oct 2017 10:42:44 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed,  4 Oct 2017 15:49:37 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> 
> > Emulate the Adapter Interrupt Suppression in the KVM FLIC interface when
> > the kernel does not support AIS.
> > 
> > When the kernel KVM does not support AIS, we can not support VFIO PCI
> > devices but we still can support emulated devices if we emulate AIS
> > inside QEMU.
> > Let's emulate AIS, allowing to use emulated PCI devices without KVM AIS
> > support.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > ---
> >  hw/intc/s390_flic.c     |  3 +-
> >  hw/intc/s390_flic_kvm.c | 76 ++++++++++++++++++++++++++++++++++++++++---------
> >  2 files changed, 64 insertions(+), 15 deletions(-)
> > 
> > diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> > index 6eaf178..33a7cde 100644
> > --- a/hw/intc/s390_flic.c
> > +++ b/hw/intc/s390_flic.c
> > @@ -185,8 +185,7 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
> >                     " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
> >          return;
> >      }
> > -
> > -    fs->ais_supported = s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESSION);
> > +    fs->ais_supported = false;
> >  }
> >  
> >  static void s390_flic_class_init(ObjectClass *oc, void *data)
> > diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> > index 7ead17a..fd1aa22 100644
> > --- a/hw/intc/s390_flic_kvm.c
> > +++ b/hw/intc/s390_flic_kvm.c
> > @@ -33,6 +33,8 @@ typedef struct KVMS390FLICState {
> >  
> >      uint32_t fd;
> >      bool clear_io_supported;
> > +    uint8_t simm;
> > +    uint8_t nimm;
> >  } KVMS390FLICState;  
> 
> Instead of duplicating this, move simm/nimm into the common flic state?

Also, simm/nimm need to be reset (done for the qemu flic, but not for
the kvm flic). Doing that in common flic code would take care of that
as well.
