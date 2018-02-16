Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emgYI-0006DO-6e
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emgYH-00008p-BD
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:59:50 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emgYH-0008PP-3e
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:59:49 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 13:45:14 +0000
Message-Id: <20180216134516.6269-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] Reduce QOM boilerplate with
 sysbus_init_child() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

I noticed writing a new container device that the "container
inits child objects in-place in its device struct" coding
style results in a lot of boilerplate in device init:

  object_initialize() to init the child
  object_property_add_child() to make the child a child of the parent
  qdev_set_parent_bus() to put the child on the sysbus default bus

If you forget the second of these then things sort of
work but trying to add a child to the child will segfault;
if you forget the third then the device won't get reset.

Patch 1 provides a simple helper function sysbus_init_child()
which does all these things for you, reducing the boilerplate
and making it harder to get wrong.

Code that used to look like this:
    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
can now look like this:
    sysbus_init_child(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);

Patch 2 is a demonstration of it being used in bcm2835_peripherals.c.
I scripted it with a quick Coccinelle script, so there are a
couple of places where it missed opportunities to use the new
function. If people like the function we can apply it more widely,
but I didn't want to go in and hand-tweak code until we have
consensus that it's useful, has parameters in the right order, etc.

thanks
-- PMM

Peter Maydell (2):
  hw/sysbus.h: New sysbus_init_child() helper function
  hw/arm/bcm2835_peripherals: Use sysbus_init_child()

 include/hw/sysbus.h          | 12 ++++++++++++
 hw/arm/bcm2835_peripherals.c | 36 ++++++++++++------------------------
 hw/core/sysbus.c             | 14 ++++++++++++++
 3 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.16.1
