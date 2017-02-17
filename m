Received: from eggs.gnu.org ([2001:4830:134:3::10]:59100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceni2-00039U-1V
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceni1-0007Sl-6u
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:56:46 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 17 Feb 2017 19:56:32 +0100
Message-Id: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


Some callers call CPUClass->parse_features manually to convert
'-cpu cpufoo,featurestr' string to cpu type and featurestr
into a set of global properties. And theni do controlled
cpu creation with setting properties and completing it with realize.
That's a lot of code duplication as they are practically
reimplement the same parsing logic.

Some don't and use cpu_generic_init() instead which does
the same parsing along with creation/realizing cpu within one
wrapper.

And some trying to switch to controlled cpu creation,
implement object_new()/set properties/realize steps
but forget feature parsing logic witch lieads to 'bugs'
commit 00909b585 (hw/arm/integratorcp: Support specifying features via -cpu)


This series moves -cpu option parsing to generic machine code
that removes a little of code duplication and makes cpus creation
process more unified.

PS:
As I don't have time to rewrite this part QEMU, being busy
rewritting yet another part of QEMU,
SERIES IS UNFINISHED AND SERVERS TO SHOW IDEA HOW IT SHOULD
BE DONE. FEEL FREE TO PICK UP AND COMPLETE THIS PATCHES
TO HANDLE ALL BOARDS (series does it only for virt-arm/spapr/pc)

It compiles and pc machine even starts but otherwise is untested.

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: patches@linaro.org
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Marcel Apfelbaum <marcel@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>

Igor Mammedov (3):
  machine: call machine init from wrapper
  machine: generalize handling of default cpu_model
  machine: generilize cpu_model parsing

 include/hw/boards.h  |  5 +++++
 include/hw/ppc/ppc.h |  2 --
 hw/arm/virt.c        | 46 ++++++++++---------------------------------
 hw/core/machine.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 42 +++++++++++++--------------------------
 hw/ppc/ppc.c         | 25 ------------------------
 hw/ppc/spapr.c       | 14 +++++++------
 vl.c                 |  2 +-
 8 files changed, 92 insertions(+), 99 deletions(-)

-- 
2.7.4
