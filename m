Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F751C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089D720EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089D720EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzOA-00089r-S1
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLs-0004N2-Rx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:26:00 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:44406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLq-0003IU-Kj
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:26:00 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kJzLR-00087P-Of; Sun, 20 Sep 2020 15:25:33 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
Date: Sun, 20 Sep 2020 15:25:19 +0200
Message-Id: <cover.1600556526.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 09:25:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This series adds a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
and its protocol definitions.
Also included is a driver providing backing devices for memory hot-add
protocols ("haprots").

A haprot device works like a virtual DIMM stick: it allows inserting
extra RAM into the guest at run time.

The main differences from the ACPI-based PC DIMM hotplug are:
* Notifying the guest about the new memory range is not done via ACPI but
via a protocol handler that registers with the haprot framework.
This means that the ACPI DIMM slot limit does not apply.

* A protocol handler can prevent removal of a haprot device when it is
still in use by setting its "busy" field.

* A protocol handler can also register an "unplug" callback so it gets
notified when an user decides to remove the haprot device.
This way the protocol handler can inform the guest about this fact and / or
do its own cleanup.

The hv-balloon driver is like virtio-balloon on steroids: it allows both
changing the guest memory allocation via ballooning and inserting extra
RAM into it by adding haprot virtual DIMM sticks.
One of advantages of these over ACPI-based PC DIMM hotplug is that such
memory can be hotplugged in much smaller granularity because the ACPI DIMM
slot limit does not apply.

In contrast with ACPI DIMM hotplug where one can only request to unplug a
whole DIMM stick this driver allows removing memory from guest in single
page (4k) units via ballooning.
Then, once the guest has released the whole memory backed by a haprot
virtual DIMM stick such device is marked "unused" and can be removed from
the VM, if one wants so.
A "HV_BALLOON_HAPROT_UNUSED" QMP event is emitted in this case so the
software controlling QEMU knows that this operation is now possible.

The haprot devices are also marked unused after a VM reboot (with a
corresponding "HV_BALLOON_HAPROT_UNUSED" QMP event).
They are automatically reinserted (if still present) after the guest
reconnects to this protocol (a "HV_BALLOON_HAPROT_INUSE" QMP event is then
emitted).

For performance reasons, the guest-released memory is tracked in few range
trees, as a series of (start, count) ranges.
Each time a new page range is inserted into such tree its neighbors are
checked as candidates for possible merging with it.

Besides performance reasons, the Dynamic Memory protocol itself uses page
ranges as the data structure in its messages, so relevant pages need to be
merged into such ranges anyway.

One has to be careful when tracking the guest-released pages, since the
guest can maliciously report returning pages outside its current address
space, which later clash with the address range of newly added memory.
Similarly, the guest can report freeing the same page twice.

The above design results in much better ballooning performance than when
using virtio-balloon with the same guest: 230 GB / minute with this driver
versus 70 GB / minute with virtio-balloon.

During a ballooning operation most of time is spent waiting for the guest
to come up with newly freed page ranges, processing the received ranges on
the host side (in QEMU / KVM) is nearly instantaneous.

The unballoon operation is also pretty much instantaneous:
thanks to the merging of the ballooned out page ranges 200 GB of memory can
be returned to the guest in about 1 second.
With virtio-balloon this operation takes about 2.5 minutes.

These tests were done against a Windows Server 2019 guest running on a
Xeon E5-2699, after dirtying the whole memory inside guest before each
balloon operation.

Using a range tree instead of a bitmap to track the removed memory also
means that the solution scales well with the guest size: even a 1 TB range
takes just few bytes of memory.

The required GTree operations are available at
https://gitlab.gnome.org/maciejsszmigiero/glib/-/tree/gtree-add-iterators
Since they are not yet in the upstream Glib a check for them was added to
"configure" script, together with new "--enable-hv-balloon" and
"--disable-hv-balloon" arguments.
If these GTree operations are missing in the system Glib this driver will
be skipped during QEMU build.

An optional "status-report=on" device parameter requests memory status
events from the guest (typically sent every second), which allow the host
to learn both the guest memory available and the guest memory in use
counts.
They are emitted externally as "HV_BALLOON_STATUS_REPORT" QMP events.

The driver is named hv-balloon since the Linux kernel client driver for
the Dynamic Memory Protocol is named as such and to follow the naming
pattern established by the virtio-balloon driver.
The whole protocol runs over Hyper-V VMBus that has its implementation
recently merged in.

The driver was tested against Windows Server 2012 R2, Windows Server 2016
and Windows Server 2016 guests and obeys the guest alignment requirements
reported to the host via DM_CAPABILITIES_REPORT message.
Extensive event tracing is available under 'hv_balloon_*' prefix.

Example usage:
* Add "-device vmbus-bridge,id=vmbus-bridge -device hv-balloon,id=hvb"
  to the QEMU command line and set "maxmem" value to something large,
  like 1T.

* Use QEMU monitor commands to add a haprot virtual DIMM stick, together
  with its memory backend:
  object_add memory-backend-ram,id=mem1,size=200G
  device_add mem-haprot,id=ha1,memdev=mem1
  The first command is actually the same as for ACPI-based DIMM hotplug.

* Use the ballooning interface monitor commands to force the guest to give
  out as much memory as possible:
  balloon 1
  The ballooning interface monitor commands can also be used to resize
  the guest up and down appropriately.

* One can check the current guest size by issuing a "info balloon" command.
  This is useful to know what is happening, since large ballooning or
  unballooning operations take some time to complete.

* Once the guest releases the whole memory backed by a haprot device
  (or is restarted) a "HV_BALLOON_HAPROT_UNUSED" QMP event will be
  generated.
  The haprot device then can be removed, together with its memory backend:
  device_del ha1
  object_del mem1

Future directions:
* Allow sharing the ballooning QEMU interface between hv-balloon and
  virtio-balloon drivers.
  Currently, only one of them can be added to the VM at the same time.

* Allow new haport devices to reuse the same address range as the ones
  that were previously deleted via device_del monitor command without
  having to restart the VM.

* Add vmstate / live migration support to the hv-balloon driver.

* Use haprot device to also add memory via virtio interface (this requires
  defining a new operation in virtio-balloon protocol and appropriate
  support from the client virtio-balloon driver in the Linux kernel).

 Kconfig.host                     |    3 +
 configure                        |   35 +
 hw/hyperv/Kconfig                |    5 +
 hw/hyperv/hv-balloon.c           | 2172 ++++++++++++++++++++++++++++++
 hw/hyperv/meson.build            |    1 +
 hw/hyperv/trace-events           |   17 +
 hw/i386/Kconfig                  |    2 +
 hw/i386/pc.c                     |   18 +-
 hw/mem/Kconfig                   |    4 +
 hw/mem/haprot.c                  |  263 ++++
 hw/mem/meson.build               |    1 +
 include/hw/hyperv/dynmem-proto.h |  425 ++++++
 include/hw/mem/haprot.h          |   72 +
 meson.build                      |    2 +
 qapi/misc.json                   |   74 +
 15 files changed, 3093 insertions(+), 1 deletion(-)
 create mode 100644 hw/hyperv/hv-balloon.c
 create mode 100644 hw/mem/haprot.c
 create mode 100644 include/hw/hyperv/dynmem-proto.h
 create mode 100644 include/hw/mem/haprot.h


