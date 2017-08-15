Received: from eggs.gnu.org ([2001:4830:134:3::10]:34574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dhThj-00017h-J5
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1dhThg-0004wm-Hn
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:43:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1dhThg-0004wb-8b
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:43:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7F4herW050771
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 00:43:41 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cbfk29knf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 00:43:41 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 15 Aug 2017 14:43:35 +1000
Date: Tue, 15 Aug 2017 14:42:16 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <cover.1502771785.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v3 0/1] Exploit settable KVM_CAP_PPC_SMT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, groug@kaod.org

Hello QEMU PPC people,

This is v3, it is only a single patch now.

My core objective with this patch is to provide a way for QEMU to configure the
newly writeable KVM capability 'KVM_CAP_PPC_SMT', because without it Power 9
hosts can only run VMs with a single thread per core. (With this capability they
are able to run VMs with 1, 2, 4 or 8 threads per core.) KVM also now contains a
new read-only property ('KVM_CAP_PPC_SMT_POSSIBLE') to expose the possible
valid values of KVM_CAP_PPC_SMT, although this is only used in a hint to the
user at this stage. This new capability is already upstream and the QEMU
headers have already been updated to include it.

The new way KVM_CAP_PPC_SMT works is that, when set, it causes KVM to act as if
the host's native number of threads per core were the value of the capability.

I've implemented this by adding a new property to pseries machines, which is
stored in sPAPRMachineState as 'vsmt'. This provides a way to set it from the
command line (and a way to add it to the VMState if we later decide to do so)
and makes the property available only when using SPAPR (pseries) machines. I
use this value to call in to KVM and set the capability when necessary.

For pseries machines, the vsmt value will be a duplicate of the KVM capability
value, and in version 1 I tried to remove this duplication by replacing
cap_ppc_smt completely with references to spapr->vsmt. Unfortunately, that
forced generic code (e.g. translate_init.c) to have knowledge of the
sPAPRMachine state which didn't seem conceptually clean. In version 2, I've
left the capability on the KVM side which keeps the KVM and generic code clear
of SPAPR concepts. I think on the whole this is a better solution.

Notes/Questions:
* I've moved the code that validates smp_threads out of ppc_cpu_realizefn()
  because it only needs to be done once, not once per CPU.

Patch set changelog follows:

====== Version 2 -> version 3: ======

Patch 1/1: PPC: KVM: Support machine option to set VSMT mode
* Suggested by Greg Kurz:
    * Comment on show_vsmt_possible() converted in to an assert().
    * Better use of g_string_new().
    * Removed trailing periods from several error_report() strings.
    * Shortened overly long line.
    * Converted some helpful error_report() calls into error_printf().
    * Simplified error handling in spapr_set_vsmt().
    * Use error_abort when adding properties (instead of ignoring errors), as it's a bug if it fails.
    * Moved the explanation about KVM_CAP_PPC_SMT into the commit so that it's not lost with the cover letter.

====== Version 1 -> version 2: ======

Patch 1/1: PPC: KVM: Support machine option to set VSMT mode
* Reworked to keep SPAPR dependencies out of KVM code.


Sam Bobroff (1):
  PPC: KVM: Support machine option to set VSMT mode

 hw/ppc/spapr.c              | 96 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h      |  1 +
 target/ppc/kvm.c            | 20 +++++++++-
 target/ppc/kvm_ppc.h        | 12 ++++++
 target/ppc/translate_init.c | 14 -------
 5 files changed, 128 insertions(+), 15 deletions(-)

-- 
2.14.1.2.g4274c698f
