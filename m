Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUxVq-0003JP-Hp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUxVp-0007DM-PT
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:55:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 16:53:25 +0100
Message-Id: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Allow int props with no default,
 use them in ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This patchset follows up on a suggestion by Markus for
allowing devices to implement integer properties which
don't have a default value specified in their Property
struct.

My use case for this is ARM, where we have a property
pmsav7-dregion whose correct default value depends on
which exact ARM CPU this is. That means we can't have
a single constant default value specified in the
DEFINE_PROP_UINT32(), but on the other hand if we just
prevent the qdev prop system from setting a default itself
we can naturally get the right default value by having
the structure field be correctly set to the default for
the CPU in the first place.

Patch 1 cleans up a corner case where we had just one
Property struct which was using the default value
(because it has a PropertyInfo with a non-NULL set_default_value
field) but not explicitly setting .defval.[ui].

Patch 2 adds .set_default to Property, uses it as the gate
on calling .set_default_value rather than just whether
.set_default_value is non-NULL, and adds some macros
so that devices can use the new no-default-value int props.

Patch 3 uses this so M3 and M4 have the right default
for the number of PMSA regions rather than getting the
different R7 default.

thanks
-- PMM

Peter Maydell (3):
  qdev-properties.h: Explicitly set the default value for arraylen
    properties
  qdev: support properties which don't set a default value
  target/arm: Make Cortex-M3 and M4 default to 8 PMSA regions

 include/hw/qdev-core.h       |  1 +
 include/hw/qdev-properties.h | 21 +++++++++++++++++++++
 hw/core/qdev.c               |  2 +-
 target/arm/cpu.c             | 12 +++++++++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.7.4
