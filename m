Received: from eggs.gnu.org ([2001:4830:134:3::10]:60994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cpG32-0002jl-L0
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cpG2z-0000MG-G4
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:40 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:57687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cpG2z-0000Jv-AI
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 11:13:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ON000FM4NMIC360@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Sat, 18 Mar 2017 15:13:30 +0000 (GMT)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Sat, 18 Mar 2017 18:13:21 +0300
Message-id: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170318151328eucas1p24d754940723a0e777a2096a678a2094d@eucas1p2.samsung.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] Calcuate downtime for postcopy live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: i.maximets@samsung.com, a.perevalov@samsung.com

Hi David,

I already asked you about downtime calculation for postcopy live migration.
As I remember you said it's worth not to calculate it per vCPU or maybe I
understood you incorrectly. I decided to proof it could be useful.

This patch set is based on commit 272d7dee5951f926fad1911f2f072e5915cdcba0
of QEMU master branch. It requires commit into Andreas git repository
"userfaultfd: provide pid in userfault uffd_msg"

When I tested it I found following moments are strange:
1. First userfault always occurs due to access to ram in vapic_map_rom_writable,
all vCPU are sleeping in this time
2. Latest half of all userfault was initiated by kworkers, that's why I had a doubt
about current in handle_userfault inside kernel as a proper task_struct for pagefault
initiator. All vCPU was sleeping at that moment.
3. Also there is a discrepancy, of vCPU state and real vCPU thread state.

This patch is just for showing and idea, if you ok with this idea none RFC patch will not
include proc access && a lot of traces.
Also I think it worth to guard postcopy_downtime in MigrationIncomingState and
return calculated downtime into src, where qeury-migration will be invocked.

Alexey Perevalov (2):
  userfault: add pid into uffd_msg
  migration: calculate downtime on dst side

 include/migration/migration.h     |  11 ++
 linux-headers/linux/userfaultfd.h |   1 +
 migration/migration.c             | 238 +++++++++++++++++++++++++++++++++++++-
 migration/postcopy-ram.c          |  61 +++++++++-
 migration/savevm.c                |   2 +
 migration/trace-events            |  10 +-
 6 files changed, 319 insertions(+), 4 deletions(-)

-- 
1.8.3.1
