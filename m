Received: from eggs.gnu.org ([209.51.188.92]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dp-0004fe-0f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dm-00053W-PQ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:20 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 15 Apr 2019 15:27:17 +0200
Message-Id: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 0/5] Fix misuses of
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org


memory_region_allocate_system_memory() is supposed to be called only once=
,
but due to lack of the check some boards abused it by  calling it multipl=
e times.
So here goes fixes that replace it with  memory_region_init_ram() in most=
 of
the cases.
However s390 case a bit convolted as we have to keep cross version migrat=
ion
working and need -mem-path to work there as well. To make it happen I hac=
ked
MemoryRegion aliases to work with migration by allocating 'fake' RAMBlock=
 that
aliases original RAM pointer (asking for comments on approach since I hav=
e no
idea how migration works really). It is one way to fix s390 while not abu=
sing
memory_region_allocate_system_memory() and making it work with -mem-path
correctly.
(another a bit more dirty way would be adding machine callback to handle
 -mem-path and overiding it in s390, but migratable aliases approach look=
s more
cleaner to me API wise and have potential to be reused if we would need t=
o
fix up RAM layout but keep migration stream compatible).

CC: Paolo Bonzini <pbonzini@redhat.com>=20
CC: Richard Henderson <rth@twiddle.net>=20
CC: Helge Deller <deller@gmx.de>=20
CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>=20
CC: David Gibson <david@gibson.dropbear.id.au>=20
CC: Cornelia Huck <cohuck@redhat.com>=20
CC: Halil Pasic <pasic@linux.ibm.com>=20
CC: Christian Borntraeger <borntraeger@de.ibm.com>=20
CC: David Hildenbrand <david@redhat.com>=20
CC: Artyom Tarasenko <atar4qemu@gmail.com>=20
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=20
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org

Igor Mammedov (5):
  sparc64: use memory_region_allocate_system_memory() only for '-m'
    specified RAM
  ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
  hppa: drop usage of memory_region_allocate_system_memory() for ROM
  memory: make MemoryRegion alias migratable
  s390: do not call memory_region_allocate_system_memory() multiple
    times

 exec.c                     |  7 ++++---
 hw/hppa/machine.c          |  5 ++---
 hw/ppc/rs6000_mc.c         | 15 ++++++++++-----
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
 hw/sparc64/niagara.c       | 25 +++++++++++++------------
 memory.c                   |  5 +++++
 6 files changed, 49 insertions(+), 28 deletions(-)

--=20
2.7.4
