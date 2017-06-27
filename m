Received: from eggs.gnu.org ([2001:4830:134:3::10]:48567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPhph-0000xG-DA
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dPhpe-0002Tj-7I
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:10:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dPhpd-0002Ta-V5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 00:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E122180F9F
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 04:10:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 27 Jun 2017 12:10:09 +0800
Message-Id: <1498536619-14548-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 00/10] migration: objectify MigrationState
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

v6:
- patch 1: fix comment, and add more comment for
  register_compat_props() [Eduardo]
- patch 2: add more comments for register_compat_props_array() and the
  new AccelClass.global_props [Eduardo]
- patch 3: rename user_register_compat_props() into
  user_register_global_props, and some update on comments [Eduardo]
- patch 5: let xen_compat_props be static, and use a better "end of
  list" for it [Eduardo] (since the change is trivial, I didn't remove
  Juan's r-b)

v5:
- add r-b for Juan on patch 4,5,7-10
- patch 2: introduce register_compat_props_array() that may be further
  used by machine codes [Eduardo]
- patch 2: fix english error [Eduardo]

v4:
- dropped lots of patches related to AccelState.global_props. Now I am
  using AccelClass.global_props, and only use it in Xen codes.
- one patch is added to clean up the global property registerations,
  with some comment to show the ordering.
- one patch is added to dump migration globals in "info migrate"
  unconditionally (last patch).
- changed all the following xen_init() patches to use
  AccelClass.global_props.
- (since most of the patches are either touched-up again, or threw
  away, so no much r-b added, only one for Juan on the only_migratable
  patch, anyway, thanks for reviewing the old codes!)

------------

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

Please kindly review. Thanks.

Peter Xu (10):
  machine: export register_compat_prop()
  accel: introduce AccelClass.global_props
  vl: clean up global property registerations
  migration: let MigrationState be a qdev
  migration: move global_state.optional out
  migration: move only_migratable to MigrationState
  migration: move skip_configuration out
  migration: move skip_section_footers
  migration: merge enforce_config_section somewhat
  migration: hmp: dump globals

 accel/accel.c                    |   6 ++
 hmp.c                            |   3 +
 hw/core/machine.c                |  13 -----
 hw/core/qdev-properties.c        |  21 +++++++
 hw/i386/pc_piix.c                |   3 -
 hw/ppc/spapr.c                   |   3 -
 hw/xen/xen-common.c              |  25 +++++++--
 include/hw/compat.h              |  12 ++++
 include/hw/qdev-properties.h     |  29 ++++++++++
 include/migration/global_state.h |   1 -
 include/migration/misc.h         |   6 +-
 include/sysemu/accel.h           |  11 ++++
 include/sysemu/sysemu.h          |   1 -
 migration/global_state.c         |   9 +--
 migration/migration.c            | 118 +++++++++++++++++++++++++++++++--------
 migration/migration.h            |  33 +++++++++++
 migration/savevm.c               |  32 ++---------
 vl.c                             |  41 ++++++++++++--
 18 files changed, 277 insertions(+), 90 deletions(-)

-- 
2.7.4
