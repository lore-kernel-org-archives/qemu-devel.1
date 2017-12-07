Received: from eggs.gnu.org ([2001:4830:134:3::10]:39313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzQu-0004IX-Uv
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMzQt-0006vS-Fk
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:01 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Dec 2017 17:53:45 +0100
Message-Id: <20171207165355.7559-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.12 00/10] s390x/tcg: facilitites and
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Wire up some io instructions and implement new facilitites. Make sure
to take care of MTTCG when it comes to atomic operations.

As we are now able to install/boot a Fedora 26/27 as well as an upstream
kernel compiled for z12, let's bump up the QEMU cpu model to a very
stripped down version of a z12 (with missing base features). Take care
of backwards compatibility (as we defined the QEMU model as
migration-safe).

Try it yourself: https://github.com/davidhildenbrand/qemu.git s390x-queue

This branch is based on https://github.com/cohuck/qemu.git s390x-next
and contains other patches sent previously, especially
- s390x/tcg: CCW hotplug support
- cpus: make pause_all_cpus() play with SMP on single threaded TCG
- cpu-exec: fix missed CPU kick during interrupt injection

$ baseurl=https://ftp-stud.hs-esslingen.de/pub/fedora-secondary/releases/27/Server/s390x/os/
$ wget ${baseurl}/images/kernel.img
$ wget ${baseurl}/images/initrd.img
$ qemu-img create -f qcow2 guest-tcg.qcow2 8G
$ qemu-system-s390x \
    -nographic -machine s390-ccw-virtio -m 2048 \
    --accel tcg,thread=multi -smp 4,maxcpus=4 \
    -hda guest-tcg.qcow2 \
    -kernel kernel.img \
    -initrd initrd.img \
    --append "TERM=linux inst.repo=${baseurl}/ ip=dhcp inst.geoloc=0"

I was also able to install and boot Ubuntu 17.10. Enabling channel
measurements now also works.

v1 -> v2:
- rephrased/fixed some patch descriptions

David Hildenbrand (10):
  s390x/tcg: ASI/ASGI are atomic with interlocked-acccess facility 1
  s390x/tcg: ALSI/ALSGI are atomic with interlocked-acccess facility 1
  s390x/tcg: implement Interlocked-Access Facility 2
  s390x/tcg: wire up SET ADDRESS LIMIT
  s390x/tcg: wire up SET CHANNEL MONITOR
  s390x/tcg: Implement STORE CHANNEL PATH STATUS
  s390x/tcg: Implement SIGNAL ADAPTER instruction
  s390x/tcg: implement extract-CPU-time facility
  s390x/tcg: we already implement the Set-Program-Parameter facility
  s390x: change the QEMU cpu model to a stripped down z12

 hw/s390x/s390-virtio-ccw.c  |   8 ++++
 target/s390x/cpu.h          |   3 ++
 target/s390x/cpu_models.c   |  97 +++++++++++++++++----------------------
 target/s390x/cpu_models.h   |   1 +
 target/s390x/gen-features.c |  87 +++++++++++++++++++++++++++++++++++
 target/s390x/helper.h       |   2 +
 target/s390x/insn-data.def  |  26 +++++++----
 target/s390x/misc_helper.c  |  18 ++++++++
 target/s390x/translate.c    | 109 ++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 285 insertions(+), 66 deletions(-)

-- 
2.14.3
