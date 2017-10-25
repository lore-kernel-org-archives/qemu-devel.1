Received: from eggs.gnu.org ([2001:4830:134:3::10]:35524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7EYe-0000sv-87
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7EYa-0004Of-BB
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7EYa-0004Nr-57
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:48:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3630883F3E
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 05:48:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 25 Oct 2017 07:48:37 +0200
Message-Id: <20171025054842.24883-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/5] Make xbzrle_cache_size a migration
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com


Hi

On v3:
- rebase on top of last migration pull requset
- improve comments (dave suggestion)
- always return 0 in case of error
- checked with ovirt/openstack/libvirt people that making value a
  power of two is not a problem.
- should I drop the last patch, or sent it?


Please revieww.

[v2]

- rebase
- fix comments about power of 2 instead of multiple of two
- minor typo on error message
- use Error * when setting values

After asking people of libvirt/ovirt/openstack, it appears that there
is no problem about restricting cache_size to real values.  We give
back one error and they had to handle errors already.

Please review, Juan.

[v1]

I started looking at xbzrle_cache_size and saw that it was not a parameter.
How difficult could it be?  HaHa

- x-multifd-page-count and x-multifd-channels were not o
  migrate_test_apply

- page_cache.c has parameters that were not used (max_item_age)

- page cache types were random.  Move almost all to int/size_t as
  appropiate

- error handling was split in three functions:
  xbzrle_cache_resize
  cache_init
  qmp_set_cache_size
  Make some sense of it and use Error*

- We pass one value to qmp_migrate_cache_size it asigned pow2log() of
  that value, and cache_init() used a power of two.  Make sure that
  the value passed is right.

- Now I am able to make xbzrle_cache_size a parameter!!!!

- Now that I have arrived here, I tried to make the json types for
  migartion parameters the real ones instead of everything is an int64.
  I will be happy if libvirt people checked this.

Please review, Juan.


*** BLURB HERE ***

Juan Quintela (5):
  migration: Make sure that we pass the right cache size
  migration: Don't play games with the requested cache size
  migration: No need to return the size of the cache
  migration: Make xbzrle_cache_size a migration parameter
  migration: [RFC] Use proper types in json

 hmp.c                  | 34 ++++++++++++------
 migration/migration.c  | 94 ++++++++++++++++++++++++++++----------------------
 migration/migration.h  |  1 -
 migration/page_cache.c | 12 ++++---
 migration/ram.c        | 20 ++++-------
 migration/ram.h        |  2 +-
 qapi/migration.json    | 44 ++++++++++++++++-------
 7 files changed, 122 insertions(+), 85 deletions(-)

-- 
2.13.6
