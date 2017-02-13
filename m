Received: from eggs.gnu.org ([2001:4830:134:3::10]:60565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcJ-0008Hp-R0
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cdHcI-0005IY-Nx
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:35 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 14:28:15 +0000
Message-Id: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] cpu: Implement cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>

This patchset adds a new function cpu_generic_new()
which is similar to cpu_generic_init() except that it
does not realize the created CPU object. This means that
board code can do a "new cpu; set QOM properties; realize"
sequence without having to do all the work of splitting
the CPU model string and calling parse_features by hand.

Patch 2 clarifies a TODO comment, hopefully correctly,
based on an email conversation I had with Eduardo a
little while back.

Patches 3 and 4 change the ARM boards which currently
call parse_features by hand to use the new function.


If there's consensus that this is the right general
direction to go in, then I think that some other
architectures could also make cleanups to use this:
 * cpu_s390x_create() is almost exactly this function,
   give or take some fine detail of error handling
 * ppc_cpu_parse_features is almost the same thing,
   except that it doesn't actually create the CPU object,
   it only calls parse_features
 * hw/i386/pc.c does a manual parse_features

I'm not strongly attached to this particular approach
(though it seems like a reasonable one, especially given
the proliferation of different arch-specific helpers
listed above and the bugs in boards which don't call
parse_features when they should), but I would like us to
figure out and document what the right way for a board
to create and configure its CPU objects is...


Michael Davidsaver (1):
  cpu: add cpu_generic_new()

Peter Maydell (3):
  cpu: Clarify TODO comment in cpu_generic_new()
  hw/arm/integrator: Use new cpu_generic_new()
  hw/arm/virt: Use new cpu_generic_new()

 include/qom/cpu.h     | 17 +++++++++++++++++
 hw/arm/integratorcp.c | 22 ++--------------------
 hw/arm/virt.c         | 24 ++----------------------
 qom/cpu.c             | 37 ++++++++++++++++++++++++++-----------
 4 files changed, 47 insertions(+), 53 deletions(-)

-- 
2.7.4
