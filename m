Received: from eggs.gnu.org ([2001:4830:134:3::10]:49111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liP-00089k-O0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liM-0005GQ-IK
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4liM-0005G1-Bg
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28DD240244
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 10:36:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 18 Oct 2017 12:36:23 +0200
Message-Id: <20171018103633.5549-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] Make xbzrle_cache_size a migration
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


In v2

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

Juan Quintela (10):
  migration: Fix migrate_test_apply for multifd parameters
  migratiom: Remove max_item_age parameter
  migration: Make cache size elements use the right types
  migration: Move xbzrle cache resize error handling to
    xbzrle_cache_resize
  migration: Make cache_init() take an error parameter
  migration: Make sure that we pass the right cache size
  migration: Don't play games with the requested cache size
  migration: No need to return the size of the cache
  migration: Make xbzrle_cache_size a migration parameter
  migration: [RFC] Use proper types in json

 hmp.c                  |  34 ++++++++++-----
 migration/migration.c  | 116 ++++++++++++++++++++++++-------------------------
 migration/migration.h  |   1 -
 migration/page_cache.c |  41 +++++++++--------
 migration/page_cache.h |   7 ++-
 migration/ram.c        |  36 +++++++--------
 migration/ram.h        |   2 +-
 qapi/migration.json    |  44 ++++++++++++++-----
 8 files changed, 160 insertions(+), 121 deletions(-)

-- 
2.13.6
