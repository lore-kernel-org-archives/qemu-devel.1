Received: from eggs.gnu.org ([2001:4830:134:3::10]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBJSA-0005M9-8G
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBJS7-0002EX-2u
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:18:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBJS6-0002EI-Pq
	for qemu-devel@nongnu.org; Thu, 18 May 2017 07:18:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 093C9734
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 11:18:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 13:18:32 +0200
Message-Id: <20170518111837.29212-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Remove old MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com

Hi

Changes from v4:
- make suggested logic change by eric
- remove extra space in error message
- allow migrate_set_capability block off when block migration is complied off
  (eric request)

Please review

[v4]

- Address Markus review
  * better documentation messages (thanks)
  * reorganize error checking to have small data
  * Use g_new0
  * Improve commints messages

[v4]

- patch 1 included again. We have a 'block' capability and a
  'block_incremental' parameter
  Make Dave happy: rename shared into incremental
  Make Eric and Markus happy:

    block: off -> no block migration, we don't care about
                  block_incremental value
    block: on block_incremental: off -> no incremental block migration
    block: on block_incremental: on  -> incremental block migration

- Use visitors.
  You ask if there is not a better way than hand coding a boolean parser.
  QAPI people (a.k.a. Markus) answer to use a visitor.
  Once there, I used it also for integers, not only booleans.

- Use -b/-i parameters.  OK, I bit the bullet: You can't use
  capabilities/parameters and -b/-i: it gives you one error If you use
  -b/-i, capability parameter is cleanup after the migration ends (Who
  would have guessed that there are cases where we call
  migration_fd_error(), but not migration_fd_cleanup()
  I think this should make Peter and Markus and Dave happy.

- Integrate migrate block compile time disabling
  Well, it conflicted left and right, so I fixed it
  Once there, I disable setting/getting block capability if it is disabled.

[v3]

- Patch 1 included in pull request
- disable block_shared when we disable block_enable
- enable block_enabled when we enable block_shared

[v2]

- make migrate_block_set_* take a boolean
- disable block migration in colo to maintain semantics.

[v1]
Upon a time there were MigrationParms (only used for block migration)
and then MigrationParams used for everything else.  This series:

- create migration capabilities for block parameters
- make the migrate command line parameters to use capabilities
- remove MigrationParams completely


Dr. David Alan Gilbert (1):
  block migration: Allow compile time disable

Juan Quintela (4):
  hmp: Use visitor api for hmp_migrate_set_parameter()
  migration: Create block capability
  migration: Remove use of old MigrationParams
  migration: Remove old MigrationParams

 configure                     | 11 +++++
 hmp.c                         | 23 +++++++++--
 include/migration/block.h     | 24 +++++++++++
 include/migration/migration.h | 17 ++++----
 include/migration/vmstate.h   |  1 -
 include/qemu/typedefs.h       |  1 -
 include/sysemu/sysemu.h       |  3 +-
 migration/Makefile.objs       |  2 +-
 migration/block.c             | 17 +-------
 migration/colo.c              |  6 +--
 migration/migration.c         | 96 +++++++++++++++++++++++++++++++++++++++----
 migration/savevm.c            | 24 ++++-------
 qapi-schema.json              | 28 +++++++++++--
 13 files changed, 191 insertions(+), 62 deletions(-)

-- 
2.9.3
