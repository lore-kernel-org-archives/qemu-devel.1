Received: from eggs.gnu.org ([2001:4830:134:3::10]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cZh9Z-0006Bh-7C
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cZh9V-0005n9-9n
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:56:05 -0500
Received: from mail-db5eur01on0096.outbound.protection.outlook.com
	([104.47.2.96]:16320
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1cZh9U-0005mT-O4
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:56:01 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 3 Feb 2017 18:23:18 +0300
Message-ID: <20170203152321.19739-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/3] migration capability to discard the
 migrated ram pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

This feature frees the migrated memory on the source during postcopy-ram
migration. In the second step of postcopy-ram migration when the source vm
is put on pause we can free unnecessary memory. It will allow, in particular,
to start relaxing the memory stress on the source host in a load-balancing
scenario.

Changes from v1:
- changed name of the interfaces (discard to release)
- fix make check error
- add more comments to qemu_iovec_release_ram()
- rebase on "Postcopy: Hugepage support" (David's patch series)
- removed ram_discard_page for xbzrle 
- fix erroneous release memory in complete precopy (tie release-ram to postcopy)

Pavel Butsykin (3):
  migration: add MigrationState arg for ram_save_/compressed_/page()
  add 'release-ram' migrate capability
  migration: discard non-dirty ram pages after the start of postcopy

 include/migration/migration.h |  2 ++
 include/migration/qemu-file.h |  3 ++-
 migration/migration.c         | 13 ++++++++++
 migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
 migration/ram.c               | 56 ++++++++++++++++++++++++++++++++++------
 qapi-schema.json              |  5 +++-
 6 files changed, 121 insertions(+), 17 deletions(-)

-- 
2.11.0
