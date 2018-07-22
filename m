Received: from eggs.gnu.org ([2001:4830:134:3::10]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60h-0002nl-H5
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fh60e-0007G8-8l
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:49940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fh60d-0007Fh-Qt
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 00:30:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fh60d-0007P6-08
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EFF8F2E80C3
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 04:30:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Jul 2018 04:17:23 -0000
From: Launchpad Bug Tracker <1402755@bugs.launchpad.net>
Reply-To: Bug 1402755 <1402755@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20141215165955.16357.80461.malonedeb@soybean.canonical.com>
Message-Id: <153223304398.12964.13660645642683003000.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1402755] Re: qemu-kvm: e1000 RX ring is filled
 with partial-pkt of size 0
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
https://bugs.launchpad.net/bugs/1402755

Title:
  qemu-kvm: e1000 RX ring is filled with partial-pkt of size 0

Status in QEMU:
  Expired

Bug description:
  Hello,
  We are using CentOS 6.5 with qemu-kvm-0.12.1.2-2.415 as a host of or VMs.
  In the VM we use e1000 as the NIC emulation.
  We've modified the e1000 driver to our needs. This modification start the=
 RX engine while the RX ring is empty (RDH =3D=3D RDT)
  and at a later stage we fill the RX descriptors with buffers. This scheme=
 works well on intel chips and VMware.
  What we observe in this setup is that from time to time the RX ring is fi=
lled with "partial packets" of size 0 (meaning, DD bit is set,
  No other status bits are set and packet size is also 0).

  Looking at the e1000 RX routine in qemu-kvm you can observe the following=
 flow:
  1. A packet is avail for receive:
  2. The routine checks for RCTL_EN - it is enabled
  3. The routine checks that the RDH equal RDT (they are as the ring is emp=
ty) but also checks if rxov is on (it is still off) so it doesn=E2=80=99t
  Exit as it is supposed to.
  4. The routine now updates the descriptor status with the DD bit (and vla=
n which we don=E2=80=99t care)
  5. The routine checks if a buffer address is not NULL (it is as NULL sinc=
e we haven=E2=80=99t filled it yet) =E2=80=93 so is logs something.
  6. The routine now updates the guest memory with this value (DD is 1) =

  7. The routine updates the check_rxov flag in order to allow ovf check th=
e next time around. =

  (but ovf will not occur since in the next iteration RDH !=3D RDT)
  8. The routine loops over all the descriptors with the NULL buffer (which=
 is all our ring) and writes the DD bit
  9. We get this endless partial packet problem we see.

  qemu-kvm-0.12.1.2-2.415.el6_5.3/qemu-kvm-0.12.1.2/hw/e1000.c
  static ssize_t
  e1000_receive(VLANClientState *nc, const uint8_t *buf, size_t size)
  {
  : : :
  if (!(s->mac_reg[RCTL] & E1000_RCTL_EN))
  return -1;

  : : :
  do {
  if (s->mac_reg[RDH] =3D=3D s->mac_reg[RDT] && s->check_rxov) {
  set_ics(s, 0, E1000_ICS_RXO);
  return -1;
  }
  base =3D ((uint64_t)s->mac_reg[RDBAH] << 32) + s->mac_reg[RDBAL] +
  sizeof(desc) * s->mac_reg[RDH];
  cpu_physical_memory_read(base, (void *)&desc, sizeof(desc));
  desc.special =3D vlan_special;
  desc.status |=3D (vlan_status | E1000_RXD_STAT_DD);
  if (desc.buffer_addr) {
  cpu_physical_memory_write(le64_to_cpu(desc.buffer_addr),
  (void *)(buf + vlan_offset), size);
  desc.length =3D cpu_to_le16(size);
  desc.status |=3D E1000_RXD_STAT_EOP|E1000_RXD_STAT_IXSM;
  } else // as per intel docs; skip descriptors with null buf addr
  DBGOUT(RX, "Null RX descriptor!!\n");
  cpu_physical_memory_write(base, (void *)&desc, sizeof(desc));

  : : :
  if (++s->mac_reg[RDH] * sizeof(desc) >=3D s->mac_reg[RDLEN])
  s->mac_reg[RDH] =3D 0;
  s->check_rxov =3D 1;
  : : :
  } while (desc.buffer_addr =3D=3D 0);
  }

  =

  A workaround is to enable the RX machine only after the descriptor ring i=
s filled for the first time.

  Moti

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1402755/+subscriptions
