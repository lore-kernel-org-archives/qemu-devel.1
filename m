Received: from eggs.gnu.org ([2001:4830:134:3::10]:40366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dsPMD-0004u7-F1
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dsPM8-0001HY-FO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:18:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dsPM8-0001FD-5k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:18:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8E8E9PW022464
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 04:18:37 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cygtme5yp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 04:18:36 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 18:18:34 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v8E8IWrJ42729632
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 18:18:32 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v8E8IVJ2015799
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 18:18:32 +1000
Date: Thu, 14 Sep 2017 13:48:26 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20170914070118.GA8181@in.ibm.com>
	<20170914100011.296185d2@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170914100011.296185d2@nial.brq.redhat.com>
Message-Id: <20170914081826.GA23373@in.ibm.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, groug@kaod.org, david@gibson.dropbear.id.au

On Thu, Sep 14, 2017 at 10:00:11AM +0200, Igor Mammedov wrote:
> On Thu, 14 Sep 2017 12:31:18 +0530
> Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> 
> > Hi,
> > 
> > QEMU hits the below assert
> > 
> > qemu-system-ppc64: used ring relocated for ring 2
> > qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion `r >= 0' failed.
> > 
> > in the following scenario:
> > 
> > 1. Boot guest with vhost=on
> >   -netdev tap,id=mynet0,script=qemu-ifup,downscript=qemu-ifdown,vhost=on -device virtio-net-pci,netdev=mynet0
> > 2. Hot add a DIMM device 
> > 3. Reboot
> >    When the guest reboots, we can see
> >    vhost_virtqueue_start:vq->used_phys getting assigned an address that
> >    falls in the hotplugged memory range.
> > 4. Remove the DIMM device
> >    Guest refuses the removal as the hotplugged memory is under use.
> > 5. Reboot
> 
> >    QEMU forces the removal of the DIMM device during reset and that's
> >    when we hit the above assert.
> I don't recall implementing forced removal om DIMM,
> could you point out to the related code, pls?

This is ppc specific. We have DR Connector objects for each LMB (multiple
LMBs make up one DIMM device) and during reset we invoke the
release routine for these LMBs which will further invoke
pc_dimm_memory_unplug().

See hw/ppc/spapr_drc.c: spapr_drc_reset()
hw/ppc/spapr.c: spapr_lmb_release()

> 
> > Any pointers on why we are hitting this assert ? Shouldn't vhost be
> > done with using the hotplugged memory when we hit reset ?
> 
> >From another point of view,
> DIMM shouldn't be removed unless guest explicitly ejects it
> (at least that should be so in x86 case).

While that is true for ppc also, shouldn't we start fresh from reset ?

Related comment from hw/ppc/spapr_drc.c: spapr_drc_reset()

    /* immediately upon reset we can safely assume DRCs whose devices
     * are pending removal can be safely removed.
     */
    if (drc->unplug_requested) {
        spapr_drc_release(drc);
    }

So essentially in the scenario I listed, the unplug request is rejected
by the guest, but during next reboot, QEMU excersies the above code
and removes any devices (memory, CPU etc) that are marked for removal.

Regards,
Bharata.
