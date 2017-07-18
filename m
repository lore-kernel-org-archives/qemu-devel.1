Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJM1-0000bs-HV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXJLy-00089h-Dv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXJLy-00088n-7m
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01091C04B92C
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:39:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 Jul 2017 11:39:00 +0800
Message-Id: <1500349150-13240-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/10] migration: export cap/params to qdev
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

v3:
- add r-b properly on each patch
- patch 1: fix commit message [Eric]
- patch 4: dropped since not used any more [Eduardo]
- patch 7 (new patch 6): move the check from post_init() into
  migration_object_init() [Eduardo]
- patch 10 (new patch 9): rename var "head" -> "list" [Juan]
- patch 11: rebased a lot due to patch 7's change, so removed Juan's r-b

v2:
- extended the series from 3 -> 11 patches
- renamed all the properties with "x-" prefix
- handled the cap/param check for these new properties (mostly patch
  4-11, but it contains lots of refactorings in general)

We have the MigrationState as QDev now (which seems crazy). Let's
continue to benefit.

This series is exporting all migration capabilities/params as global
parameters. Then we can do something like this:

  qemu -global migration.postcopy-ram=3Dtrue \
       -global migration.max-bandwidth=3D4096

The values will be inited just like we typed these values into HMP
monitor. It'll simplify lots of migration scripts.

The changes are fairly straightforward. One tiny loss is that we still
don't support:

  -global migration.max-bandwidth=3D1g

...just like what we did in HMP:

  migrate_set_speed 1g

...while we need to use:

  -global migration.max-bandwidth=3D1073741824

However that should only be used in scripts, and that's good enough
imho.

These properties should only be used for debugging/testing purpose,
and we should not guarantee any interface compatibility for them (just
like HMP).

Please review. Thanks.

Peter Xu (10):
  qdev: provide DEFINE_PROP_INT64()
  migration: export parameters to props
  migration: export capabilities to props
  migration: introduce migrate_params_check()
  migration: provide migrate_params_apply()
  migration: check global params for validity
  migration: remove check against colo support
  migration: provide migrate_caps_check()
  migration: provide migrate_cap_add()
  migration: check global caps for validity

 hw/core/qdev-properties.c    |  32 ++++++
 include/hw/qdev-properties.h |   3 +
 include/migration/colo.h     |   1 -
 migration/colo.c             |   5 -
 migration/migration.c        | 267 +++++++++++++++++++++++++++++++++----=
------
 5 files changed, 242 insertions(+), 66 deletions(-)

--=20
2.7.4
