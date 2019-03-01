Received: from eggs.gnu.org ([209.51.188.92]:50913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkN8-0004vs-0S
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzkIo-0007Yp-V9
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:42:23 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  1 Mar 2019 16:42:14 +0100
Message-Id: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] numa: deprecate -numa node,
 mem and default memory distribution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, libvir-list@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-arm@nongnu.org


 1) "I'm considering to deprecating -mem-path/prealloc CLI options and replacing
them with a single memdev Machine property to allow interested users to pick
used backend for initial RAM (fixes mixed -mem-path+hostmem backends issues)
and as a transition step to modeling initial as a Device instead of (ab)using
MemoryRegion APIs."
(for more details see: https://www.mail-archive.com/qemu-devel@nongnu.org/msg596314.html)

However there is a couple of roadblocks on the way (s390x and numa memory handling).
I think I finally thought out a way to hack s390x in migration compatible manner,
but I don't see a way to do it for -numa node,mem and default RAM assignement to
nodes. Considering both numa usecases aren't meaningfully using NUMA (aside guest
side testing), and could be replaced with explicitly used memdev parameter, I'd
like to propose removing these fake NUMA friends, hence this deprecation.

As result of removing deprecated options and replacing initial RAM allocation
with 'memdev's (1), QEMU will allocate guest RAM in consistent way, fixing mixed
use-case and allowing boards to move towards modelling initial RAM as Device(s).
Which in its own turn should allow to cleanup NUMA/HMP/memory accounting code
more by dropping ad-hoc node_mem tracking and reusing device enumeration instead.

Igor Mammedov (2):
  numa: deprecate 'mem' parameter of '-numa node' option
  numa: deprecate implict memory distribution between nodes

 numa.c               |  5 +++++
 qemu-deprecated.texi | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.7.4
