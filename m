Received: from eggs.gnu.org ([2001:4830:134:3::10]:59101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fudtd-0001EL-5k
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fudtZ-0000ar-5d
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:19:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45432 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fudtZ-0000aO-08
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:18:57 -0400
Date: Tue, 28 Aug 2018 15:18:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180828151848.3d09ca06@redhat.com>
In-Reply-To: <20180828005237.GC2222@umbus.fritz.box>
References: <1535368030-214556-1-git-send-email-imammedo@redhat.com>
	<20180827160239.54cc993a@bahia.lan>
	<20180828005237.GC2222@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: make sure that guest isn't able to
 unplug the first cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com

On Tue, 28 Aug 2018 10:52:37 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Aug 27, 2018 at 04:02:39PM +0200, Greg Kurz wrote:
> > On Mon, 27 Aug 2018 13:07:10 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > The first cpu unplug wasn't ever supported and corresponding
> > > monitor/qmp commands refuse to unplug it. However guest is able
> > > to issue eject request either using following command:
> > >   # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject  
> > 
> > I can't reproduce the issue with a pc guest and current master...
> > 
> > All I seem to get is an error in dmesg:
> > 
> > [   97.435446] processor cpu0: Offline failed.
> >   
> > > or directly writing to cpu hotplug registers, which makes
> > > qemu crash with SIGSEGV following back trace:
> > > 
> > >    kvm_flush_coalesced_mmio_buffer ()
> > >        while (ring->first != ring->last)
> > >    ...
> > >    qemu_flush_coalesced_mmio_buffer
> > >    prepare_mmio_access
> > >    flatview_read_continue
> > >    flatview_read
> > >    address_space_read_full
> > >    address_space_rw
> > >    kvm_cpu_exec(cpu!0)
> > >    qemu_kvm_cpu_thread_fn
> > > 
> > > the reason for which is that ring == KVMState::coalesced_mmio_ring
> > > happens to be a part of 1st CPU that was uplugged by guest.
> > > 
> > > Fix it by forbidding 1st cpu unplug from guest side and in addition
> > > remove CPU0._EJ0 ACPI method to make clear that unplug of the first
> > > CPU is not supported.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > CCing spapr and s390x folks in case targets need to prevent 1st CPU unplug as well
> > >   
> > 
> > A spapr guest can _release_ the first cpu by doing something like:
> > 
> > # echo -n "/cpus/PowerPC,POWER8@0" > /sys/devices/system/cpu/release
> > 
> > But AFAIK, this doesn't unplug the cpu from a QEMU standpoint.  
> 
> Unplugging CPU 0 with device_del should be ok too.
Do you mean real unplugging (cpu0 object freed) or just remove request?
