Received: from eggs.gnu.org ([2001:4830:134:3::10]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkoVq-0002tr-LB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkoVm-0000U6-K8
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkoVm-0000TR-CL
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:33:14 -0400
Date: Thu, 24 Aug 2017 11:33:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824113308.4188b228.cohuck@redhat.com>
In-Reply-To: <1a48b3f1-938a-fcaf-00d9-da27edfeec77@linux.vnet.ibm.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-8-cohuck@redhat.com>
	<1a48b3f1-938a-fcaf-00d9-da27edfeec77@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 7/9] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com

On Thu, 24 Aug 2017 11:29:47 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 08/23/2017 05:54 PM, Cornelia Huck wrote:
> > If we do not provide zpci, pci reconfiguration via sclp is not available
> > either. I/O adapter configuration, however, should always be present.
> > 
> > Rename the values that refer to I/O adapter configuration (instead of only
> > pci) to make things clearer.
> > 
> > Move length checking of the sccb for I/O adapter configuration into the
> > common sclp code (out of the pci code). This also fixes an issue that
> > the pci code would refer to a field in the sccb before checking whether
> > it was actually long enough.
> > 
> > Check for the adapter type in the sccb and return unrecognized adapter
> > type if the guest tries to issue I/O adapter configure/deconfigure for
> > a type other than pci or for pci if the zpci facility is not provided.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/s390-pci-bus.c  | 14 ++------------
> >  hw/s390x/s390-pci-bus.h  |  8 --------
> >  hw/s390x/s390-pci-stub.c |  2 ++
> >  hw/s390x/sclp.c          | 39 ++++++++++++++++++++++++++++++++++-----
> >  include/hw/s390x/sclp.h  | 17 +++++++++++++----
> >  5 files changed, 51 insertions(+), 29 deletions(-)

> > diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> > index 9253dbbc64..7ae6a0e37a 100644
> > --- a/hw/s390x/sclp.c
> > +++ b/hw/s390x/sclp.c
> > @@ -80,7 +80,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
> >      prepare_cpu_entries(sclp, read_info->entries, cpu_count);
> > 
> >      read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
> > -                                        SCLP_HAS_PCI_RECONFIG);
> > +                                        SCLP_HAS_IOA_RECONFIG);
> > 
> >      /* Memory Hotplug is only supported for the ccw machine type */
> >      if (mhd) {
> > @@ -354,6 +354,35 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
> >      sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_READ_COMPLETION);
> >  }
> > 
> > +static void sclp_configure_io_adapter(SCLPDevice *sclp, SCCB *sccb,
> > +                                      bool configure)  
> 
> Just an idea. This could be called reconfigure instead
> of configure (that's sclp_reconfigure_io_adapter) as the
> facility providing both conf and deconf is called reconf.
> 
> It ain't important. Patch looks good!

So I'll just keep it as-is :)

> 
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Thanks!
