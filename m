Received: from eggs.gnu.org ([2001:4830:134:3::10]:57465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsPzS-0007LP-P6
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsPzN-0002ei-Q0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:59:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsPzN-0002dD-Gb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:59:13 -0400
Date: Thu, 14 Sep 2017 10:59:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170914105905.7e509ef4@nial.brq.redhat.com>
In-Reply-To: <20170914081826.GA23373@in.ibm.com>
References: <20170914070118.GA8181@in.ibm.com>
	<20170914100011.296185d2@nial.brq.redhat.com>
	<20170914081826.GA23373@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU terminates during reboot after memory unplug
 with vhost=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, groug@kaod.org, david@gibson.dropbear.id.au

On Thu, 14 Sep 2017 13:48:26 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> On Thu, Sep 14, 2017 at 10:00:11AM +0200, Igor Mammedov wrote:
> > On Thu, 14 Sep 2017 12:31:18 +0530
> > Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> >   
> > > Hi,
> > > 
> > > QEMU hits the below assert
> > > 
> > > qemu-system-ppc64: used ring relocated for ring 2
> > > qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion `r >= 0' failed.
> > > 
> > > in the following scenario:
> > > 
> > > 1. Boot guest with vhost=on
> > >   -netdev tap,id=mynet0,script=qemu-ifup,downscript=qemu-ifdown,vhost=on -device virtio-net-pci,netdev=mynet0
> > > 2. Hot add a DIMM device 
> > > 3. Reboot
> > >    When the guest reboots, we can see
> > >    vhost_virtqueue_start:vq->used_phys getting assigned an address that
> > >    falls in the hotplugged memory range.
> > > 4. Remove the DIMM device
> > >    Guest refuses the removal as the hotplugged memory is under use.
> > > 5. Reboot  
> >   
> > >    QEMU forces the removal of the DIMM device during reset and that's
> > >    when we hit the above assert.  
> > I don't recall implementing forced removal om DIMM,
> > could you point out to the related code, pls?  
> 
> This is ppc specific. We have DR Connector objects for each LMB (multiple
> LMBs make up one DIMM device) and during reset we invoke the
> release routine for these LMBs which will further invoke
> pc_dimm_memory_unplug().
> 
> See hw/ppc/spapr_drc.c: spapr_drc_reset()
> hw/ppc/spapr.c: spapr_lmb_release()
> 
> >   
> > > Any pointers on why we are hitting this assert ? Shouldn't vhost be
> > > done with using the hotplugged memory when we hit reset ?  
> >   
> > >From another point of view,  
> > DIMM shouldn't be removed unless guest explicitly ejects it
> > (at least that should be so in x86 case).  
> 
> While that is true for ppc also, shouldn't we start fresh from reset ?
we should.

when it aborts vhost should print out error from vhost_verify_ring_mappings()

   if (r == -ENOMEM) {
       error_report("Unable to map %s for ring %d", part_name[j], i);           
   } else if (r == -EBUSY) {                                                    
       error_report("%s relocated for ring %d", part_name[j], i);    

that might give a clue where that memory stuck in.

Michael might point out where to start look at, but he's on vacation
so ...

> Related comment from hw/ppc/spapr_drc.c: spapr_drc_reset()
> 
>     /* immediately upon reset we can safely assume DRCs whose devices
>      * are pending removal can be safely removed.
>      */
>     if (drc->unplug_requested) {
>         spapr_drc_release(drc);
>     }
> 
> So essentially in the scenario I listed, the unplug request is rejected
> by the guest, but during next reboot, QEMU excersies the above code
> and removes any devices (memory, CPU etc) that are marked for removal.
I'd remove pending removal on reset for DIMM/CPU if it's acceptable from
PPC HW pov.

> 
> Regards,
> Bharata.
> 
