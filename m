Received: from eggs.gnu.org ([2001:4830:134:3::10]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3drD-0007jn-BL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3drA-0005DX-8V
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:28:55 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 27 Apr 2017 17:28:39 +1000
Message-Id: <20170427072843.8089-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This is a rebased and revised version of my patches revising CPU
compatiblity mode handling on ppc, last posted in November.  Since
then, many of the patches have already been merged (some for 2.9, some
since).  This is what's left.

 * There was conceptual confusion about what a compatibility mode
   means, and how it interacts with the machine type.  This cleans
   that up, clarifying that a compatibility mode (as an externally set
   option) only makes sense on machine types that don't permit the
   guest hypervisor privilege (i.e. 'pseries')

 * It was previously the user's (or management layer's) responsibility
   to determine compatibility of CPUs on either end for migration.
   This uses the compatibility modes to check that properly during an
   incoming migration.

This hasn't been extensively tested yet.  There are quite a few
migration cases to consider, for example:

Basic:

1) Boot guest with -cpu host
        Should go into POWER8 compat mode after CAS
        Previously would have been raw mode

2) Boot guest with -machine pseries,max-cpu-compat=power7 -cpu host
        Should go into POWER7 compat mode

3) Boot guest with -cpu host,compat=power7
        Should act as (2), but print a warning

4) Boot guest via libvirt with power7 compat mode specified in XML
        Should act as (3), (2) once we fix libvirt

5) Hack guest to only advertise power7 compatibility, boot with -cpu host
        Should go into POWER7 compat mode after CAS

6) Hack guest to only advertise real PVRs
        Should remain in POWER8 raw mode after CAS

7) Hack guest to only advertise real PVRs
   Boot with -machine pseries,max-cpu-compat=power8
        Should fail at CAS time

8) Hack guest to only advertise power7 compatibility, boot with -cpu host
   Reboot to normal guest
        Should go to power7 compat mode after CAS of boot 1
        Should revert to raw mode on reboot
        SHould go to power8 compat mode after CAS of boot 2

Migration:

9) Boot guest with qemu-2.6 -machine pseries-2.6 -cpu host
   Migrate to qemu-2.8 -machine pseries-2.6 -cpu host
        Should work, end up running in power8 raw mode

10) Boot guest with qemu-2.7 -machine pseries-2.7 -cpu host
    Migrate to qemu-2.8 -machine pseries-2.7 -cpu host
        Should work, end up running in power8 raw mode

11) Boot guest with qemu-2.7 -machine pseries-2.7 -cpu host,compat=power7
    Migrate to qemu-2.8 -machine pseries-2.7 -cpu host,compat=power7
        Should work, be running in POWER7 compat after, but give warning like
        (3)

12) Boot guest with qemu-2.7 -machine pseries-2.7 -cpu host,compat=power7
    Migrate to qemu-2.8 -machine pseries-2.7,max-cpu-compat=power7 -cpu host
        Should work, be running in POWER7 compat after, no warning

13) Boot to SLOF with qemu-2.6 -machine pseries-2.6 -cpu host
    Migrate to qemu-2.8 -machine pseries-2.6 -cpu host

        ?

14) Boot to SLOF with qemu-2.7 -machine pseries-2.7 -cpu host
    Migrate to qemu-2.8 -machine pseries-2.7 -cpu host
        ?

15) Boot to SLOF with qemu-2.7 -machine pseries-2.7 -cpu host,compat=power7
    Migrate to qemu-2.8 -machine pseries-2.7 -cpu host,compat=power7
        ?

16) Boot to SLOF with qemu-2.7 -machine pseries-2.7 -cpu host,compat=power7
    Migrate to qemu-2.8 -machine pseries-2.7,max-cpu-compat=power7 -cpu host
        ?

17) Boot guest with qemu-2.6 -machine pseries-2.6 -cpu host
    Migrate to qemu-2.7.z -machine pseries-2.6 -cpu host
        Should work

18) Hack guest to only advertise power7 compatibility, boot with -cpu host
    Boot with qemu-2.8, migrate to qemu-2.8
        Should be in power7 compat mode after CAS on source, and still
        in power7 compat mode on destination


Changes since RFCv2:
  * Many patches dropped, since they're already merged
  * Rebased, fixed conflicts
  * Restored support for backwards migration (wasn't as complicated as
    I thought)
  * Updated final patch's description to more accurately reflect the
    logic

Changes since RFCv1:
  * Change CAS logic to prefer compatibility modes over raw mode
  * Simplified by giving up on half-hearted attempts to maintain
    backwards migration
  * Folded migration stream changes into a single patch
  * Removed some preliminary patches which are already merged



David Gibson (3):
  pseries: Move CPU compatibility property to machine
  pseries: Reset CPU compatibility mode
  ppc: Rework CPU compatibility testing across migration

Greg Kurz (1):
  qapi: add explicit null to string input and output visitors

 hw/ppc/spapr.c               |  8 ++++-
 hw/ppc/spapr_cpu_core.c      | 47 +++++++++++++++++++------
 hw/ppc/spapr_hcall.c         |  2 +-
 include/hw/ppc/spapr.h       | 12 ++++---
 qapi/string-input-visitor.c  | 11 ++++++
 qapi/string-output-visitor.c | 14 ++++++++
 target/ppc/compat.c          | 65 ++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h             |  6 ++--
 target/ppc/machine.c         | 71 +++++++++++++++++++++++++++++++++++--
 target/ppc/translate_init.c  | 84 ++++++++++++--------------------------------
 10 files changed, 238 insertions(+), 82 deletions(-)

-- 
2.9.3
