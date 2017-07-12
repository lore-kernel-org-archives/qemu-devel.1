Received: from eggs.gnu.org ([2001:4830:134:3::10]:60400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVBX4-00040I-De
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVBWz-0005Ht-JS
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVBWz-0005H0-DR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:53:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDA5A267C0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 06:53:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 12 Jul 2017 14:53:40 +0800
Message-Id: <1499842423-21101-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] migration: export cap/params to qdev props
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

Peter Xu (3):
  qdev: provide DEFINE_PROP_INT64()
  migration: export parameters to props
  migration: export capabilities to props

 hw/core/qdev-properties.c    | 32 +++++++++++++++++++++++++++
 include/hw/qdev-properties.h |  3 +++
 migration/migration.c        | 52 +++++++++++++++++++++++++++++++++++---=
------
 3 files changed, 77 insertions(+), 10 deletions(-)

--=20
2.7.4
