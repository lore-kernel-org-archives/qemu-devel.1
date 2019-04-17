Received: from eggs.gnu.org ([209.51.188.92]:59874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinF-0001Ax-GF
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGinE-0001of-AT
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:31:57 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Apr 2019 13:31:41 +0200
Message-Id: <20190417113143.5551-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] s390x/kvm: Properly detect page size of
 initial memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>

While the detection on s390x of the maximum ram pagesize works by pure lu=
ck,
we should try to do better. Especially, once "-mem-path" is replaced
by memory backends, the current approach will break.

Configure the maximum page size after configuring initital memory. Provid=
e
a function to detect the maximum ram pagesize

I think this can be deferred to 4.1 as I don't think anything is actually
broken right now.

v2 -> v3:
- Fix compile error
- Tested that hugepages correctly result in an error with
  "modprobe kvm hpage=3D0", but not with "modprobe kvm hpage=3D1".

v1 -> v2:
- Add a better comment describing that only initial memory is considered
- Add "exec: Introduce qemu_getmaxrampagesize() and rename
  qemu_getrampagesize()"

David Hildenbrand (2):
  s390x/kvm: Configure page size after memory has actually been
    initialized
  exec: Introduce qemu_maxrampagesize() and rename qemu_getrampagesize()

 exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
 hw/ppc/spapr_caps.c        |  4 ++--
 hw/s390x/s390-virtio-ccw.c | 12 +++++++++++
 hw/vfio/spapr.c            |  2 +-
 include/exec/ram_addr.h    |  3 ++-
 target/ppc/kvm.c           |  2 +-
 target/s390x/cpu.c         |  7 ++++++
 target/s390x/cpu.h         |  1 +
 target/s390x/kvm-stub.c    |  4 ++++
 target/s390x/kvm.c         | 35 ++++++++++++------------------
 target/s390x/kvm_s390x.h   |  1 +
 11 files changed, 85 insertions(+), 30 deletions(-)

--=20
2.20.1
