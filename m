Received: from eggs.gnu.org ([2001:4830:134:3::10]:33223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvE-0002TP-8U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dJAvB-0007Rb-6u
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dJAvB-0007Pn-00
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E1904E4D1
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 03:49:10 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Jun 2017 11:48:56 +0800
Message-Id: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

v2
- (I didn't add Juan's r-b since I touched the patches)
- remove once parameter in migrate_get_current() since not needed
- add one more patch to export register_compat_prop(), then use it in
  the following patches in xen_init().

I picked this topic out as suggested by Juan. Also I did what Juan has
suggested in previous discussions that I moved lots of global
parameters into MigrationState, and let them be properties. Then we
can use HW_COMPAT_* and "-global migration.xxx=xxx" formular.

Currently register_compat_prop() is exported to be used by xen_init().

If this can be merged and okay, we can move on to convert more things
into properties for migration.

Please review. Thanks.

Peter Xu (6):
  machine: export register_compat_prop()
  migration: let MigrationState be a qdev
  migration: move global_state.optional out
  migration: move only_migratable to MigrationState
  migration: move skip_configuration out
  migration: move skip_section_footers

 hw/core/machine.c             |  6 +--
 hw/i386/pc_piix.c             |  3 --
 hw/ppc/spapr.c                |  3 --
 hw/xen/xen-common.c           | 12 ++++--
 include/hw/boards.h           |  3 ++
 include/hw/compat.h           | 12 ++++++
 include/migration/migration.h | 36 +++++++++++++++--
 include/sysemu/sysemu.h       |  1 -
 migration/migration.c         | 92 +++++++++++++++++++++++++++++--------------
 migration/savevm.c            | 28 ++++---------
 vl.c                          |  9 ++++-
 11 files changed, 136 insertions(+), 69 deletions(-)

-- 
2.7.4
