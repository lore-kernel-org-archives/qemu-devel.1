Received: from eggs.gnu.org ([2001:4830:134:3::10]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eFMC9-0001S2-0U
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eFMC2-0000hO-SI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:35:13 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:40725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eFMC2-0000fv-Iw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:35:06 -0500
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B9D38CE274
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 16:35:03 +0100 (CET)
Date: Thu, 16 Nov 2017 16:34:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171116163417.1ce14bbf@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171116172602-mutt-send-email-mst@kernel.org>
References: <20171116132339.4facb858@bahia.lab.toulouse-stg.fr.ibm.com>
	<20171116172602-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, bharata@linux.vnet.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org

On Thu, 16 Nov 2017 17:28:44 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 16, 2017 at 01:23:39PM +0100, Greg Kurz wrote:
> > Hi,
> > 
> > I'm resurrecting a thread about a QEMU crash we're still hitting on ppc64. It
> > was reported to the list by Bharata 2 months ago:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03685.html
> > 
> > "Hi,
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
> >    QEMU forces the removal of the DIMM device during reset and that's
> >    when we hit the above assert.
> > 
> > Any pointers on why we are hitting this assert ? Shouldn't vhost be
> > done with using the hotplugged memory when we hit reset ?
> > 
> > Regards,
> > Bharata."
> > 
> > #0  0x00007ffff760eff0 in raise () from /lib64/libc.so.6
> > #1  0x00007ffff761136c in abort () from /lib64/libc.so.6
> > #2  0x00007ffff7604c44 in __assert_fail_base () from /lib64/libc.so.6
> > #3  0x00007ffff7604d34 in __assert_fail () from /lib64/libc.so.6
> > #4  0x0000000010161138 in vhost_commit (listener=0x11469e88) at /home/greg/Work/qemu/qemu-spapr/hw/virtio/vhost.c:650
> > #5  0x00000000100917fc in memory_region_transaction_commit () at /home/greg/Work/qemu/qemu-spapr/memory.c:1094
> > #6  0x0000000010096748 in memory_region_del_subregion (mr=0x1143eed0, subregion=0x116f1920) at /home/greg/Work/qemu/qemu-spapr/memory.c:2337
> > #7  0x00000000104a9aec in pc_dimm_memory_unplug (dev=0x11445c50, hpms=0x1143eec0, mr=0x116f1920) at /home/greg/Work/qemu/qemu-spapr/hw/mem/pc-dimm.c:126
> > #8  0x0000000010180454 in spapr_lmb_release (dev=0x11445c50) at /home/greg/Work/qemu/qemu-spapr/hw/ppc/spapr.c:3151
> > #9  0x00000000101a397c in spapr_drc_release (drc=0x116b9cc0) at /home/greg/Work/qemu/qemu-spapr/hw/ppc/spapr_drc.c:401
> > #10 0x00000000101a3ba0 in spapr_drc_reset (drc=0x116b9cc0) at /home/greg/Work/qemu/qemu-spapr/hw/ppc/spapr_drc.c:439
> > #11 0x00000000101a3c88 in drc_reset (opaque=0x116b9cc0) at /home/greg/Work/qemu/qemu-spapr/hw/ppc/spapr_drc.c:460
> > #12 0x0000000010447380 in qemu_devices_reset () at /home/greg/Work/qemu/qemu-spapr/hw/core/reset.c:69
> > #13 0x000000001017ae80 in ppc_spapr_reset () at /home/greg/Work/qemu/qemu-spapr/hw/ppc/spapr.c:1445
> > #14 0x0000000010377c60 in qemu_system_reset (reason=SHUTDOWN_CAUSE_HOST_QMP) at /home/greg/Work/qemu/qemu-spapr/vl.c:1788
> > #15 0x00000000103785ac in main_loop_should_exit () at /home/greg/Work/qemu/qemu-spapr/vl.c:1962
> > #16 0x0000000010378708 in main_loop () at /home/greg/Work/qemu/qemu-spapr/vl.c:1999
> > #17 0x0000000010382c54 in main (argc=21, argv=0x7ffffffff098, envp=0x7ffffffff148) at /home/greg/Work/qemu/qemu-spapr/vl.c:4897
> > 
> > 
> > This basically happens because on pseries, like x86, we usually wait
> > for the guest to eject the DIMM before actually removing it, BUT,
> > unlike x86, we force the removal on reset. This is handled by a DRC
> > object which registers a handler with qemu_register_reset().
> > 
> > At reset time, the machine calls qemu_devices_reset() but unfortunately,
> > the DRC reset handler gets called BEFORE the VirtIONet device one. The
> > vhost device is still active and it doesn't like the ring addresses to
> > change while in this state.
> > 
> > Michael,
> > 
> > The assert() has been around since the beginning, at a time I believe there was
> > no such thing as memory hot-unplug. Now that memory can go away at reset time,
> > is it really legitimate to crash QEMU if vhost detects a ring address change ?  
> 
> It's just a symptom of a problem though. If memory is going away
> while vhost backend is running, things are not going to
> end well. Less scary for a network device, more scary for a block
> device. VFIO probably has the same issue, it just does not
> have an assert.
> 

I agree.

> > David,
> > 
> > Depending on Michael's answer (or anyone else that knows vhost well enough),
> > I'm not sure we can fix that properly for 2.11. A possible fix/workaround
> > could be to reset DRCs (at least the LMB ones) after qemu_devices_reset(),
> > so that we're sure vhost is stopped.
> > 
> > Thoughts ?  
> 
> I think the release of DIMM on reset trick must happen after all
> devices have been reset.

I'll send a patch. Thanks for the quick answer.

> > 
> > --
> > Greg  
