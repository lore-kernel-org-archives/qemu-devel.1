Received: from eggs.gnu.org ([2001:4830:134:3::10]:40835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7Dp4-0007q4-Uu
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d7Dp1-0006ak-Ji
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:29:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:55426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d7Dp1-0006Zd-Ep
	for qemu-devel@nongnu.org; Sun, 07 May 2017 00:29:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d7Doz-0003dK-6H
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 04:29:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AB2742E80CF
	for <qemu-devel@nongnu.org>; Sun,  7 May 2017 04:29:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 May 2017 04:17:41 -0000
From: Launchpad Bug Tracker <795866@bugs.launchpad.net>
Reply-To: Bug 795866 <795866@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20110611090523.29022.40154.malonedeb@soybean.canonical.com>
Message-Id: <20170507041741.15918.32152.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] =?utf-8?q?=5BBug_795866=5D_Re=3A_pci_passthrough_doe?=
 =?utf-8?q?sn=C2=B4t_work?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/795866

Title:
  pci passthrough doesn=C2=B4t work

Status in QEMU:
  Expired

Bug description:
  Hi all,

  I have some problems passing through a pci device to kvm guest.
  First I have to say that I=C2=B4m using the latest kvm-kernel und qemu-kv=
m from git-tree (Date 11.06.2011).

  I want=C2=B4t to passthrough this device to guest:

  lspci-output:

  02:00.0 Multimedia video controller: Micronas Semiconductor Holding AG
  Device 0720 (rev 01)

  So at first I have bind the driver to psi-stub:

  modprobe -r kvm-intel
  modprobe -r kvm
  echo "18c3 0720" > /sys/bus/pci/drivers/pci-stub/new_id
  echo 0000:02:00.0  > /sys/bus/pci/devices/0000:02:00.0/driver/unbind
  echo 0000:02:00.0  > /sys/bus/pci/drivers/pci-stub/bind
  modprobe kvm
  modprobe kvm-intel

  Then I have assigned device to guest:
  -device pci-assign,host=3D02:00.0

  When I start the guest. The device succesfully get=C2=B4s an msi-IRQ on
  host-system:

  cat /proc/interrupt output:

   32:          0          0          0          0   PCI-MSI-edge
  kvm_assigned_msi_device

  =

  On guest device is visibel:

  lspci output:
  00:04.0 Multimedia video controller: Micronas Semiconductor Holding AG De=
vice 0720 (rev 01)

  =

  Sometimes the device (on guest) get=C2=B4s an IRQ between 10-16:

  00:05.0 Multimedia video controller: Micronas Semiconductor Holding AG De=
vice 0720 (rev 01)
          Subsystem: Micronas Semiconductor Holding AG Device dd00
          Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx+
          Interrupt: pin A routed to IRQ 11
          Region 0: Memory at f2050000 (32-bit, non-prefetchable) [size=3D6=
4K]
          Region 1: Memory at f2060000 (32-bit, non-prefetchable) [size=3D6=
4K]
          Capabilities: [58] Express (v1) Endpoint, MSI 00
                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <6=
4ns, L1 <1us
                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                  DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Uns=
upported-
                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                          MaxPayload 128 bytes, MaxReadReq 128 bytes
                  DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- =
TransPend-
                  LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Laten=
cy L0 unlimited, L1 unlimited
                          ClockPM- Suprise- LLActRep- BwNot-
                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Co=
mmClk+
                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                  LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- D=
LActive- BWMgmt- ABWMgmt-
          Capabilities: [40] Power Management version 2
                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
                  Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
          Capabilities: [48] Message Signalled Interrupts: Mask- 64bit- Que=
ue=3D0/0 Enable-
                  Address: 00000000  Data: 0000
          Kernel modules: ngene

  =

  In this case the kernel-modul (ngene) can not access the device:

  dmesg | grep ngene

  [   69.977900] ngene 0000:00:05.0: PCI INT A -> Link[LNKA] -> GSI 11 (lev=
el, high) -> IRQ 11
  [   69.977909] ngene: Found Linux4Media cineS2 DVB-S2 Twin Tuner (v5)
  [   69.978962] ngene 0000:00:05.0: setting latency timer to 64
  [   69.979118] ngene: Device version 1
  [   69.979129] ngene 0000:00:05.0: firmware: requesting ngene_18.fw
  [   69.980884] ngene: Loading firmware file ngene_18.fw.
  [   71.981052] ngene: Command timeout cmd=3D01 prev=3D00
  [   71.981205] host_to_ngene (c000): 01 00 00 00 00 00 00 00
  [   71.981457] ngene_to_host (c100): 00 00 00 00 00 00 00 00
  [   71.981704] dev->hosttongene (ec902000): 01 00 00 00 00 00 00 00
  [   71.981963] dev->ngenetohost (ec902100): 00 00 00 00 00 00 00 00
  [   73.985111] ngene: Command timeout cmd=3D02 prev=3D00
  [   73.985415] host_to_ngene (c000): 02 04 00 d0 00 04 00 00
  [   73.985684] ngene_to_host (c100): 00 00 00 00 00 00 00 00
  [   73.985931] dev->hosttongene (ec902000): 02 04 00 d0 00 04 00 00
  [   73.986191] dev->ngenetohost (ec902100): 00 00 00 00 00 00 00 00
  [   73.986568] ngene 0000:00:05.0: PCI INT A disabled
  [   73.986584] ngene: probe of 0000:00:05.0 failed with error -1

  =

  Sometimes the device (on guest) gets an msi-irq f. e. IRQ 29.
  Then kernel-modul (ngene) can succesfully load the driver and all works f=
ine.

  =

  Short to say:

  HOST 	GUEST		STATUS
  MSI-IRQ	MSI-IRQ		ALL FINE
  MSI-IRQ IOAPIC-IRQ	DOESN=C2=B4t WORK

  with modinfo I had a look at the kernel-modul if there is way to force
  msi, but without success.

  But I think IRQ between (10-16) should also work because when I load the =
kernel-modul on host with IRQ (10-16)
  it works. (Device only get=C2=B4s an MSI-IRQ If I start the vm to passthr=
ough)

  Do anyone know where can be the problem?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/795866/+subscriptions
