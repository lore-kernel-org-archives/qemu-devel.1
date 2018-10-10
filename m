Received: from eggs.gnu.org ([2001:4830:134:3::10]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAKaO-0002ve-5G
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gAKaK-0003Sy-Ni
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:56:00 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gAKaK-0003S2-E8
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:55:56 -0400
Received: by mail-pf1-x443.google.com with SMTP id r9-v6so3143683pff.11
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 12:55:56 -0700 (PDT)
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<3F86795E-6F41-4C86-91C6-21E8312F5E4B@eideticom.com>
	<a9cf5e6c09eed752b123d5de842bdc3264e37117.camel@redhat.com>
	<5A5F4A2B-2DAF-4D70-BF1D-7ABC8461FDC8@raithlin.com>
	<63b741e2-b3e5-283a-4dfc-9c1db757c575@gmail.com>
	<C8D03A20-3B1A-4021-969F-194B14918CF2@raithlin.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <f568f334-e746-eb0c-7670-1bcccc14080f@gmail.com>
Date: Wed, 10 Oct 2018 12:55:48 -0700
MIME-Version: 1.0
In-Reply-To: <C8D03A20-3B1A-4021-969F-194B14918CF2@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Bates <sbates@raithlin.com>, Andrea Bolognani <abologna@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>
Cc: Keith Busch <keith.busch@intel.com>, "palmer@sifive.com" <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>

On 10/10/2018 12:01 PM, Stephen  Bates wrote:
>> I added e1000 and e1000e support to my kernel and changed the QEMU command to:
> 
> So using -device e1000e rather than -device e1000 seems to work. I am not sure why -device e1000 causes a kernel panic. The MSI-X message is interesting and may be related to why NVMe interrupts are not reaching the OS in the guest?

Great! I'm glad that it works.

So it looks like PCIe is working but with some limitations in the 
interrupts (as seen here and with the NVMe).

Unless anyone has any objections I still think it makes sense to merge 
the current patches as that works for a variety of PCIe devices. We can 
continue to look into the interrupt issues after that.

Do you want to add a Tested-by tag Stephen?

Alistair

> 
> [    0.216000] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    0.216000] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    0.216000] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    0.216000] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    0.220000] e1000e 0000:00:01.0: assign IRQ: got 1
> [    0.220000] e1000e 0000:00:01.0: enabling device (0000 -> 0002)
> [    0.220000] e1000e 0000:00:01.0: enabling bus mastering
> [    0.220000] e1000e 0000:00:01.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    0.220000] e1000e 0000:00:01.0 0000:00:01.0 (uninitialized): Failed to initialize MSI-X interrupts.  Falling back to MSI interrupts.
> [    0.220000] e1000e 0000:00:01.0 0000:00:01.0 (uninitialized): Failed to initialize MSI interrupts.  Falling back to legacy interrupts.
> [    0.348000] e1000e 0000:00:01.0 eth0: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:56
> [    0.356000] e1000e 0000:00:01.0 eth0: Intel(R) PRO/1000 Network Connection
> [    0.356000] e1000e 0000:00:01.0 eth0: MAC: 3, PHY: 8, PBA No: 000000-000
> 
> root@libertas:~# lspci -vvv
> 00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
> 	Subsystem: Red Hat, Inc QEMU PCIe Host bridge
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> lspci: Unable to load libkmod resources: error -12
> 
> 00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 	Subsystem: Intel Corporation 82574L Gigabit Network Connection
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 1
> 	Region 0: Memory at 40040000 (32-bit, non-prefetchable) [size=128K]
> 	Region 1: Memory at 40060000 (32-bit, non-prefetchable) [size=128K]
> 	Region 2: I/O ports at <unassigned> [disabled]
> 	Region 3: Memory at 40080000 (32-bit, non-prefetchable) [size=16K]
> 	[virtual] Expansion ROM at 40000000 [disabled] [size=256K]
> 	Capabilities: [c8] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0
> 			ExtTag- RBE+
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
> 	Capabilities: [100 v2] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
> 	Capabilities: [140 v1] Device Serial Number 52-54-00-ff-ff-12-34-56
> 	Kernel driver in use: e1000e
>      
> 
