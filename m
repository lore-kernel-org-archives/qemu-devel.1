Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B73C38A29
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3DE2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3DE2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOWcK-0001Ht-Uu
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOz-0000wA-AS
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alazar@bitdefender.com>) id 1jOWOw-00050c-1v
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:41 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:48992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alazar@bitdefender.com>)
 id 1jOWOv-0004y0-L0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 20:59:38 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 ED486306E47C; Wed, 15 Apr 2020 03:59:33 +0300 (EEST)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 8CB213034443;
 Wed, 15 Apr 2020 03:59:33 +0300 (EEST)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 00/26] VM introspection
Date: Wed, 15 Apr 2020 03:59:12 +0300
Message-Id: <20200415005938.23895-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?q?Samuel=20Laur=C3=A9n?= <samuel.lauren@iki.fi>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Juan Quintela <quintela@redhat.com>, Patrick Colp <patrick.colp@oracle.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The KVM introspection subsystem provides a facility for applications
running on the host or in a separate VM, to control the execution of
other VMs (pause, resume, shutdown), query the state of the vCPUs (GPRs,
MSRs etc.), alter the page access bits in the shadow page tables (only
for the hardware backed ones, eg. Intel's EPT) and receive notifications
when events of interest have taken place (shadow page table level faults,
key MSR writes, hypercalls etc.).

This is the userspace part of the KVM introspection API already posted
on the KVM list[1]. Thanks to Samuel Laur=C3=A9n and Mathieu Tarral, this
new VMI API has been integrated into the KVM-VMI[2] project. The pull
request into the libVMI[3] library is under review.

As suggested by Stefan Hajnoczi and Paolo Bonzini, the connection with th=
e
introspection tool is initiated by the QEMU process of the introspected V=
M
using a socket. After the handshake, QEMU will hand over the file
descriptor to KVM. From this point, the introspection tool will use
the socket to send introspection commands (read/write guest memory, set
page access, etc.) directly to KVM and to receive introspection events
(breakpoint, page fault, etc.). However, for some user actions such
as pause, suspend, live migration, etc., we rely on QEMU to notify KVM,
that will notify the introspection tool, to remove the changes made to
the guest, so that the guest can run when the introspection channel
is disconnected.

The patches were tested with QEMU 2.12 (through libvirt 1.3.1) and
summarly tested with 5.0.0-rc2, except for the last two patches (25
and 26) which were not tested at all, but still included for the initial
feedback.

Patches 01-06 add some extensions to the current code, which may or
may not be needed for the next patches, but we're looking forward for you=
r
comments about these. Except for patch 6, all are chardev/socket related.

Patch 07 adds the KVM ioctls for VM introspection:
  - KVM_INTROSPECTION_HOOK used to hand over the file descriptor
  - KVM_INTROSPETION_PREUNHOOK used on pause/suspend/live migration
  - KVM_INTROSPECTION_UNHOOK used to clean-up the introspection structure=
s
    from KVM
  - KVM_INTROSPECTION_COMMAND and KVM_INTROSPECTION_EVENT used to mark th=
e
    the introspection commands/events that are allowed.

Patch 08 and 09 introduce the newly added introspection object. Patch 08
contains the usage documenation of this object with all the parameters
that will be added by the next patches. We've tested the creation of
this object through QMP/libvirt and we rely on this to start the VM
introspection for any running VM.

Patches 10-12 add the handshake, the authentication of the introspection
tool and the hand over to KVM.

Patches 13-15 add some safe guards (block the destruction of the
introspection object if the introspection socket is connected and
allow only one instance of the introspection object) and force the
socket reconnection on guest reset. Blocking the destruction of the
introspection object might not be enough, because we also want to block
the destruction of the introspection socket. Or it might be too much,
because this can be done through QMP, and whoever has access to it
may crash the guest in multiple ways.

Patches 16-17 add the first intercepted commands (pause/resume) and
introduce one of the method we use to delay intercepted commands
until the introspection tool has a chance to react.

Patch 18 adds the information we save with the VM snapshot,
the VM start time.

Patches 19-20 add the interception of force-reset and live migration
commands.

Patch 21 adds an workaround to block the snapshots with memory done by
libvirt until the introspection tool has a chance to react. It hasn't
been tested with 5.0.0-rc2. For 2.12 the patch is slightly bigger.

Patch 22 adds a second method of delaying the intercepted commands,
by running the main loop.

Patches 23-24 add the interception of the shutdown command, which doesn't
seems to be done right because the shutdown signal might not be delivered
to the guest, not to mention that is desirable to catch all sources that
my trigger the shudown.

Patch 25, which is not tested, extends the handshake structures to send
the e820 table (for the x86* architectures).

Patch 26, adds the properties to control what introspection commands
and what introspection events are allowed for this guest.

[1]: https://lore.kernel.org/kvm/20200330101308.21702-1-alazar@bitdefende=
r.com/
[2]: https://github.com/KVM-VMI/kvm-vmi
[3]: https://github.com/libvmi/libvmi

Adalbert Laz=C4=83r (20):
  chardev: tcp: allow to change the reconnect timer
  char-socket: allow vsock parameters (cid, port)
  char-socket: fix the client mode when created through QMP
  char-socket: add 'reconnecting' property
  char-socket: add 'fd' property
  E820: extend the table access interface
  linux-headers: update with VM introspection interface
  kvm: introduce the VM introspection object
  kvm: vmi: add the handshake with the introspection tool
  kvm: vmi: add 'handshake_timeout' property
  kvm: vmi: add 'key' property
  kvm: vmi: block the object destruction if the chardev is connected
  kvm: vmi: allow only one instance of the introspection object
  kvm: vmi: add 'unhook_timeout' property
  kvm: vmi: store/restore 'vm_start_time' on migrate/snapshot
  kvm: vmi: postpone the OK response from qmp_stop()
  kvm: vmi: add 'async_unhook' property
  kvm: vmi: add 'unhook_on_shutdown' property
  kvm: vmi: extend handshake to include the e820 table
  kvm: vmi: add 'command' and 'event' properties

Marian Rotariu (6):
  kvm: add VM introspection usage documentation
  kvm: vmi: reconnect the socket on reset
  kvm: vmi: intercept pause/resume
  kvm: vmi: intercept force-reset
  kvm: vmi: intercept live migration
  kvm: vmi: intercept shutdown

 accel/kvm/Makefile.objs        |    1 +
 accel/kvm/vmi.c                | 1091 ++++++++++++++++++++++++++++++++
 accel/stubs/Makefile.objs      |    1 +
 accel/stubs/vmi-stubs.c        |   14 +
 chardev/char-fe.c              |   11 +
 chardev/char-socket.c          |   72 ++-
 chardev/char.c                 |    3 +
 hw/i386/e820_memory_layout.c   |   12 +
 hw/i386/e820_memory_layout.h   |    2 +
 include/chardev/char-fe.h      |    7 +
 include/chardev/char.h         |    1 +
 include/monitor/monitor.h      |    1 +
 include/sysemu/vmi-handshake.h |   66 ++
 include/sysemu/vmi-intercept.h |   25 +
 linux-headers/linux/kvm.h      |   20 +
 migration/migration.c          |   18 +-
 migration/migration.h          |    2 +
 monitor/Makefile.objs          |    2 +-
 monitor/qmp-cmds.c             |   18 +
 monitor/qmp.c                  |   11 +
 monitor/stubs.c                |    9 +
 qemu-options.hx                |   76 +++
 22 files changed, 1455 insertions(+), 8 deletions(-)
 create mode 100644 accel/kvm/vmi.c
 create mode 100644 accel/stubs/vmi-stubs.c
 create mode 100644 include/sysemu/vmi-handshake.h
 create mode 100644 include/sysemu/vmi-intercept.h
 create mode 100644 monitor/stubs.c


base-commit: 14e5526b51910efd62cd31cd95b49baca975c83f
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Tamas K Lengyel <tamas@tklengyel.com>
CC: Mathieu Tarral <mathieu.tarral@protonmail.com>
CC: Samuel Laur=C3=A9n <samuel.lauren@iki.fi>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: Patrick Colp <patrick.colp@oracle.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Marian Rotariu <marian.c.rotariu@gmail.com>
CC: Mihai Don=C8=9Bu <mdontu@bitdefender.com>

