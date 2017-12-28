Received: from eggs.gnu.org ([2001:4830:134:3::10]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtu-0006pc-2c
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUbtq-0006QP-02
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUbtp-0006PE-Ma
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 12:23:21 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 28 Dec 2017 18:22:55 +0100
Message-Id: <1514481779-184817-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/4] enable numa configuration before machine
 is running from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com


As were suggested at (1) and at bof session where we discussed subj,
I'm posting variant with late numa 'configuration' i.e. when QEMU is
started with '-S' option in paused state and numa is configured via
monitor/QMP before machine cpus are allowed to run.

Suggested idea was to try 'late' numa configuration as it might result in
shortcut approach allowing us reuse current pause point (-S) versus adding
another preconfig option with earlier pause point.
So this series tries to show how feasible this approach.

Currently numa options mainly affect only firmware blobs (ACPI/FDT tables),
it should have been possible to regenerate those blobs right before we start
CPUs, which would allow us setup numa configuration at first pause point and
get firmware blobs with updated numa information.

Series implements idea for x86 ans spapr machines and uses machine reset,
to reconfigure firmware and other machine structures after each numa
configuration command (HMP or QMP).

It was relatively not hard to implement for above machines as they already
rebuild firmware blobs at reset time. But it still was a pain as QEMU isn't
written with dynamic reconfiguration in mind and one need to update device
state with new data (I think I've got it right but not 100% sure)

However when it comes to the last target supporting NUMA, ARM
all simplification versus v1 goes down the drain, since FDT blob is build
incrementally during machine_init(), -device, machine_done() time, and
it turns out into huge refactoring to isolate scattered FDT pieces into
single FDT build function (like we do for ACPI). It's job that we would need
to do anyways for hotplug to work properly on ARM, but I don't think it
should get in the way of numa refactoring.
So that was the point where I gave up and decided to post only x86/spapr
pieces for demo purposes.

I'm inclined towards avoiding 'v2 shortcut' and going in direction of v1,
as I didn't see v2 as the right way in general, since one would have to:
  - build machine / connect / initalize / devices one way and then find out
    devices / connections that need to be fixed/updated with new configuration,
    it's very fragile and easy break.

If I remember correctly the bof session, consensus was that we would like to have
early configuration interface (like v1) in the end, so I'd rather send time
on addressing v1 drawbacks instead of hacking machine init order to make numa work
in backwards way.

CC: eblake@redhat.com
CC: armbru@redhat.com
CC: ehabkost@redhat.com
CC: pkrempa@redhat.com
CC: david@gibson.dropbear.id.au
CC: peter.maydell@linaro.org
CC: pbonzini@redhat.com

[1]
v1 for reference:
[Qemu-devel] [RFC 0/6] enable numa configuration before machine_init() from HMP/QMP
    https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03583.html

PS:
exercise wasn't waste as it resulted in cleanups that were already merged.


Igor Mammedov (4):
  numa: split out NumaOptions parsing into parse_NumaOptions()
  HMP: add set-numa-node command
  QMP: add set-numa-node command
  numa: pc: reset machine if numa config has changed in prelaunch time

 hmp.h                 |  1 +
 include/hw/boards.h   |  1 +
 include/sysemu/numa.h |  1 +
 hmp-commands.hx       | 13 +++++++++++
 hmp.c                 | 23 +++++++++++++++++++
 hw/core/machine.c     |  3 ++-
 hw/i386/pc.c          |  1 +
 numa.c                | 63 +++++++++++++++++++++++++++++++++++----------------
 qapi-schema.json      | 13 +++++++++++
 vl.c                  |  4 ++++
 10 files changed, 102 insertions(+), 21 deletions(-)

-- 
2.7.4
