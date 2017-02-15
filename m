Received: from eggs.gnu.org ([2001:4830:134:3::10]:38461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cdpi9-0005bR-LX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cdpi6-0002HG-Il
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:52:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cdpi6-0002HC-Ai
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:52:50 -0500
Date: Wed, 15 Feb 2017 10:52:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170215025243.GA3988@pxdev.xzpeter.org>
References: <CAHyh4xiVKjd+D=qaizUZ02O8xLYhpoVKOqC9cR0ZWWyLq9HtbQ@mail.gmail.com>
	<20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
	<CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
	<20170214073551.GA9055@pxdev.xzpeter.org>
	<CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: mst@redhat.com, Alex Williamson <alex.williamson@redhat.com>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Tue, Feb 14, 2017 at 07:50:39AM -0500, Jintack Lim wrote:

[...]

> > > >> > I misunderstood what you said?
> > > >
> > > > I failed to understand why an vIOMMU could help boost performance. :(
> > > > Could you provide your command line here so that I can try to
> > > > reproduce?
> > >
> > > Sure. This is the command line to launch L1 VM
> > >
> > > qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
> > > -m 12G -device intel-iommu,intremap=on,eim=off,caching-mode=on \
> > > -drive file=/mydata/guest0.img,format=raw --nographic -cpu host \
> > > -smp 4,sockets=4,cores=1,threads=1 \
> > > -device vfio-pci,host=08:00.0,id=net0
> > >
> > > And this is for L2 VM.
> > >
> > > ./qemu-system-x86_64 -M q35,accel=kvm \
> > > -m 8G \
> > > -drive file=/vm/l2guest.img,format=raw --nographic -cpu host \
> > > -device vfio-pci,host=00:03.0,id=net0
> >
> > ... here looks like these are command lines for L1/L2 guest, rather
> > than L1 guest with/without vIOMMU?
> >
> 
> That's right. I thought you were asking about command lines for L1/L2 guest
> :(.
> I think I made the confusion, and as I said above, I didn't mean to talk
> about the performance of L1 guest with/without vIOMMO.
> We can move on!

I see. Sure! :-)

[...]

> >
> > Then, I *think* above assertion you encountered would fail only if
> > prev == 0 here, but I still don't quite sure why was that happening.
> > Btw, could you paste me your "lspci -vvv -s 00:03.0" result in your L1
> > guest?
> >
> 
> Sure. This is from my L1 guest.

Hmm... I think I found the problem...

> 
> root@guest0:~# lspci -vvv -s 00:03.0
> 00:03.0 Network controller: Mellanox Technologies MT27500 Family
> [ConnectX-3]
> Subsystem: Mellanox Technologies Device 0050
> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 23
> Region 0: Memory at fe900000 (64-bit, non-prefetchable) [size=1M]
> Region 2: Memory at fe000000 (64-bit, prefetchable) [size=8M]
> Expansion ROM at fea00000 [disabled] [size=1M]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [48] Vital Product Data
> Product Name: CX354A - ConnectX-3 QSFP
> Read-only fields:
> [PN] Part number: MCX354A-FCBT
> [EC] Engineering changes: A4
> [SN] Serial number: MT1346X00791
> [V0] Vendor specific: PCIe Gen3 x8
> [RV] Reserved: checksum good, 0 byte(s) reserved
> Read/write fields:
> [V1] Vendor specific: N/A
> [YA] Asset tag: N/A
> [RW] Read-write area: 105 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 253 byte(s) free
> [RW] Read-write area: 252 byte(s) free
> End
> Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
> Vector table: BAR=0 offset=0007c000
> PBA: BAR=0 offset=0007d000
> Capabilities: [60] Express (v2) Root Complex Integrated Endpoint, MSI 00
> DevCap: MaxPayload 256 bytes, PhantFunc 0
> ExtTag- RBE+
> DevCtl: Report errors: Correctable- Non-Fatal+ Fatal+ Unsupported+
> RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 256 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not
> Supported
> DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF Disabled
> Capabilities: [100 v0] #00

Here we have the head of ecap capability as cap_id==0, then when we
boot the l2 guest with the same device, we'll first copy this
cap_id==0 cap, then when adding the 2nd ecap, we'll probably encounter
problem since pcie_find_capability_list() will thought there is no cap
at all (cap_id==0 is skipped).

Do you want to try this "hacky patch" to see whether it works for you?

------8<-------
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 332f41d..bacd302 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1925,11 +1925,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 
     }
 
-    /* Cleanup chain head ID if necessary */
-    if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
-        pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
-    }
-
     g_free(config);
     return;
 }
------>8-------

I don't think it's a good solution (it just used 0xffff instead of 0x0
for the masked cap_id, then l2 guest would like to co-op with it), but
it should workaround this temporarily. I'll try to think of a better
one later and post when proper.

(Alex, please leave comment if you have any better suggestion before
 mine :)

Thanks,

-- peterx
