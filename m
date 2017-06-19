Received: from eggs.gnu.org ([2001:4830:134:3::10]:42324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw86-0002hQ-Cg
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw83-000494-8E
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw82-00048i-VM
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D075661D3B
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:01 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:35 +0800
Message-Id: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/13] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

v3 contains too much new things. So here comes a new cover letter with
richer information.

The main goal of this series is to let MigrationState be a QDev.

It helps in many use cases.

First of all, we can remove many legacy tricky functions. To name
some: savevm_skip_section_footers(), savevm_skip_configuration(), etc.
They didn't do much thing but setup a bool value. If MigrationState
can be a QDev, then these things can be setup by the HW_COMPAT_* magic
with some lines like:

{
    .driver   = "migration",
    .property = "send-configuration",
    .value    = "off",
}

Next, if this can be merged and okay, we can move on to convert more
things into properties for migration. A very attractive use case of it
is, we will be able to do this for migration:

  -global migration.postcopy=on

Then we don't need to use either HMP/QMP interface to enable it. It
greatly simplifies the migration test scripts.

Why QDev not QObject? The answer is simple: all the magic that we want
for migration is bound to QDev (HW_COMPAT, "-global"). If one day we
want to move these features from QDev to QObject, that'll be fine and
easy for MigrationState. But before that, let's have MigrationState a
QDev. :-)

Here's what individual patch does:

patch 1-8: introduce AccelState.global_props list.

      This is an idea suggested by Eduardo in general, it is just more
      complicated than I thought. Here each patch has rich commit
      message to read (especially patch 6). Things to mention:
      - patch 5 fixes a test break
      - patch 8 added a trace so that I can verify all the x86 cpu
        properties are applied correctly on tcg/x86/pc-i440fx-*.

patch 9-13: the original patches for the objectify of MigrationState.

Please kindly review. Thanks.

Peter Xu (13):
  machine: export register_compat_prop()
  qdev: enhance global_prop_list_add()
  qdev: remove qdev_prop_register_global()
  accel: introduce AccelState.global_props
  tests: avoid check GlobalProperty.used
  kvm: let kvm use AccelState.global_props
  tcg: use AccelState.global_props
  trace: add qdev_global_prop_apply
  migration: let MigrationState be a qdev
  migration: move global_state.optional out
  migration: move only_migratable to MigrationState
  migration: move skip_configuration out
  migration: move skip_section_footers

 Makefile.objs                    |  1 +
 accel.c                          | 50 +++++++++++++++++++++++
 hw/core/machine.c                | 20 +++------
 hw/core/qdev-properties.c        | 56 +++++++++++++++++++++++--
 hw/core/trace-events             |  2 +
 hw/i386/pc_piix.c                | 11 +++--
 hw/ppc/spapr.c                   |  3 --
 hw/xen/xen-common.c              |  9 ++--
 include/hw/compat.h              | 12 ++++++
 include/hw/qdev-properties.h     | 17 +++++++-
 include/migration/global_state.h |  1 -
 include/migration/misc.h         |  4 +-
 include/sysemu/accel.h           | 20 +++++++++
 include/sysemu/sysemu.h          |  1 -
 kvm-all.c                        | 30 ++++++++++++++
 migration/global_state.c         |  9 +---
 migration/migration.c            | 88 ++++++++++++++++++++++++++++++----------
 migration/migration.h            | 33 +++++++++++++++
 migration/savevm.c               | 28 ++++---------
 qom/cpu.c                        |  8 +---
 target/i386/cpu.c                | 77 +----------------------------------
 target/i386/cpu.h                | 11 -----
 tests/test-qdev-global-props.c   | 12 ------
 vl.c                             | 54 ++++++++++--------------
 24 files changed, 339 insertions(+), 218 deletions(-)
 create mode 100644 hw/core/trace-events

-- 
2.7.4
