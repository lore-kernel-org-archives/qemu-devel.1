Received: from eggs.gnu.org ([2001:4830:134:3::10]:60318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1MB-0006Lw-Ok
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1M6-0001hh-SD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1M6-0001hZ-M5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0F74356C2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:26:13 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:00 +0800
Message-Id: <1500279971-13875-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/11] migration: export cap/params to qdev
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

Peter Xu (11):
  qdev: provide DEFINE_PROP_INT64()
  migration: export parameters to props
  migration: export capabilities to props
  qom: call parent first on post_init()
  migration: introduce migrate_params_check()
  migration: provide migrate_params_apply()
  migration: check global params for validity
  migration: remove check against colo support
  migration: provide migrate_caps_check()
  migration: provide migrate_cap_add()
  migration: check global caps for validity

 hw/core/qdev-properties.c    |  32 +++++
 include/hw/qdev-properties.h |   3 +
 include/migration/colo.h     |   1 -
 migration/colo.c             |   5 -
 migration/migration.c        | 272 ++++++++++++++++++++++++++++++++++---=
------
 qom/object.c                 |   8 +-
 6 files changed, 253 insertions(+), 68 deletions(-)

--=20
2.7.4
