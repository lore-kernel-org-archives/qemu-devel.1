Received: from eggs.gnu.org ([209.51.188.92]:37034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUR-0006zd-Lp
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwQUP-0000hb-Qi
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwQUN-0000IY-LA
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:56:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87D5237E85
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 11:56:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 12:56:03 +0100
Message-Id: <20190220115611.3192-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] migration: Make multifd not experimental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

v2:
- Measure packet size in bytes/not pages
- Change the defalut value from 64KB to 512KB
- rename used field to pages_used
- rename size field to pages_alloc
- Create nnext_packet_size field
  Will be used on compression series later.
- Be flexible about what packet sizes we allow.

Please review,

In v1:

- Change page_count default to 128.

  16 was really small, and it makes much less contention on mutexes to
  just have bigger packets.

- Drop multifd-page_count parameter

  This parameter was useful for testing, but in all my testing 128 is
  good enough, no need to have an extra knob.  Libvirt don't want to
  expose this parameter because it is difficult to explain.

- Drop experimental "x-" from multifd

  Code is stable, nothing big is happening here.

- Multifd test

  And a test for multifd, this test has already been on other patch
  series.  But now it uses the names without "-x".

Please review.

Juan Quintela (8):
  multifd: Only send pages when packet are not empty
  multifd: Rename "size" member to pages_alloc
  multifd: Create new next_packet_size field
  multifd: Drop x-multifd-page-count parameter
  multifd: Be flexible about packet size
  multifd: Change default packet size
  multifd: Drop x-
  tests: Add migration multifd test

 hmp.c                  | 17 +++------
 migration/migration.c  | 56 +++++++-----------------------
 migration/migration.h  |  1 -
 migration/ram.c        | 79 ++++++++++++++++++++++++++++++------------
 migration/trace-events |  4 +--
 qapi/migration.json    | 45 +++++++++---------------
 tests/migration-test.c | 48 +++++++++++++++++++++++++
 7 files changed, 142 insertions(+), 108 deletions(-)

--=20
2.20.1
