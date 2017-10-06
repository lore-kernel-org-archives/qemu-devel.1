Received: from eggs.gnu.org ([2001:4830:134:3::10]:58539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQU-0005X0-2m
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQK-00072M-7S
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQJ-00070H-V2
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:04 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:23 +0200
Message-Id: <20171006095956.27534-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/33] next batch of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit d8f932cc696250cb740240d668b39df5fbb2d5=
a0:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-10-05 16:54:29 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20171006

for you to fetch changes up to b923ab3112ed5ab47c2ff35776f17ab54c60d651:

  hw/s390x: Mark the "sclpquiesce" device with user_creatable =3D false (=
2017-10-06 10:53:02 +0200)

----------------------------------------------------------------
s390x changes:
- support for IDA (indirect addressing in ccws) via ccw data stream
- support for extended TOD-Clock (z14 feature)
- various fixes and improvements all over the place

----------------------------------------------------------------

Christian Borntraeger (1):
  Revert "s390x/ccw: create s390 phb conditionally"

Collin L. Walling (2):
  s390/kvm: Support for get/set of extended TOD-Clock for guest
  s390/kvm: make TOD setting failures fatal for migration

Cornelia Huck (3):
  s390x: sort some devices into categories
  s390x/sclp: mark sclp-cpu-hotplug as non-usercreatable
  s390x/tcg: initialize machine check queue

David Hildenbrand (16):
  s390x/tcg: implement spm (SET PROGRAM MASK)
  s390x/tcg: move wrap_address() to internal.h
  s390x/tcg: add basic MSA features
  s390x/kvm: fix and cleanup storing CPU status
  s390x/tcg: fix checking for invalid memory check
  s390x/tcg: add MMU for real addresses
  s390x/tcg: make lura(g) use the new _real mmu.
  s390x/tcg: make stora(g) use the new _real mmu
  s390x/tcg: make testblock use the new _real mmu
  s390x/tcg: make idte/ipte use the new _real mmu
  MAINTAINERS: use KVM s390x maintainers for kvm-stubs.c and kvm_s390x.h
  s390x: raise CPU hotplug irq after really hotplugged
  s390x/cpumodel: fix max STFL(E) bit number
  target/s390x: get rid of next_core_id
  s390x: introduce and use S390_MAX_CPUS
  s390x/tcg: make STFL store into the lowcore

Halil Pasic (8):
  s390x/css: introduce css data stream
  s390x/css: use ccw data stream
  virtio-ccw: use ccw data stream
  390x/css: introduce maximum data address checking
  s390x/css: support ccw IDA
  s390x/3270: IDA support for 3270 via CcwDataStream
  s390x/3270: handle writes of arbitrary length
  s390x/css: fix css migration compat handling

Igor Mammedov (1):
  s390x: use generic cpu_model parsing

Thomas Huth (2):
  s390x/sclp: Mark the sclp device with user_creatable =3D false
  hw/s390x: Mark the "sclpquiesce" device with user_creatable =3D false

 MAINTAINERS                  |   2 +
 hw/char/terminal3270.c       |  46 ++++++-----
 hw/s390x/3270-ccw.c          |   5 +-
 hw/s390x/css.c               | 186 +++++++++++++++++++++++++++++++++++++=
+++++-
 hw/s390x/s390-pci-bus.c      |   1 +
 hw/s390x/s390-virtio-ccw.c   |  63 +++++----------
 hw/s390x/sclp.c              |   5 ++
 hw/s390x/sclpcpu.c           |   6 ++
 hw/s390x/sclpquiesce.c       |   7 +-
 hw/s390x/virtio-ccw.c        | 155 +++++++++++-------------------------
 hw/vfio/ccw.c                |   1 +
 include/hw/s390x/3270-ccw.h  |   5 +-
 include/hw/s390x/css.h       |  68 ++++++++++++++++
 target/s390x/Makefile.objs   |   2 +-
 target/s390x/cpu-qom.h       |   2 -
 target/s390x/cpu.c           |  50 +++++++-----
 target/s390x/cpu.h           |  16 +++-
 target/s390x/cpu_features.c  |   2 +-
 target/s390x/cpu_models.c    |  17 ++--
 target/s390x/crypto_helper.c |  65 +++++++++++++++
 target/s390x/excp_helper.c   |  29 ++++---
 target/s390x/helper.h        |   3 +-
 target/s390x/insn-data.def   |  15 ++++
 target/s390x/internal.h      |  16 ++++
 target/s390x/kvm-stub.c      |  10 +++
 target/s390x/kvm.c           |  98 ++++++++++++++++++-----
 target/s390x/kvm_s390x.h     |   2 +
 target/s390x/mem_helper.c    |  51 +++---------
 target/s390x/misc_helper.c   |   7 +-
 target/s390x/mmu_helper.c    |  19 +++++
 target/s390x/translate.c     |  71 ++++++++++++++++-
 31 files changed, 730 insertions(+), 295 deletions(-)
 create mode 100644 target/s390x/crypto_helper.c

--=20
2.13.6
