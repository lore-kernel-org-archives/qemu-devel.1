Received: from eggs.gnu.org ([209.51.188.92]:59023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeWg-0003S1-KK
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hBeWe-0001ku-Oy
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hBeWc-0001fs-Qd
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:57:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63AB4368E7
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 11:51:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Apr 2019 13:49:50 +0200
Message-Id: <20190403114958.3705-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/8] WIP: Multifd compression support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

v2:
- improve the code left and right
- Split better the zlib code
- rename everything to v4.1
- Add tests for multifd-compress zlib
- Parameter is now an enum (soon will see sztd)

ToDo:
- Make operations for diferent methods:
  * multifd_prepare_send_none/zlib
  * multifd_send_none/zlib
  * multifd_recv_none/zlib
- Use the MULTIFD_FLAG_ZLIB (it is unused so far).

Please review and comment.

v1:

This series create compression code on top of multifd.  It is still
WIP, but it is already:
- faster that current compression code
- it does the minimum amount of copies possible
- we allow support for other compression codes
- it pass the multifd test sent in my previous series

Test for existing code didn't work because code is too slow, I need to
make downtime 10 times bigger to make it to converge on my test
machine.  This code works with same limits that multifd no-

ToDo:
- move printf's  to traces
- move code to a struct instead of if (zlib) inside the main threads.
- improve error handling.

Please, review and coment.

Juan Quintela (8):
  migration: Fix migrate_set_parameter
  migration: fix multifd_recv event typo
  migration-test: rename parameter to parameter_int
  tests: Add migration multifd test
  migration-test: introduce functions to handle string parameters
  migration: Add multifd-compress parameter
  multifd: Add zlib compression support
  multifd: rest of zlib compression (WIP)

 hmp.c                        |  23 +++++-
 hw/core/qdev-properties.c    |  11 +++
 include/hw/qdev-properties.h |   1 +
 migration/migration.c        |  25 ++++++
 migration/migration.h        |   1 +
 migration/ram.c              | 140 +++++++++++++++++++++++++++++++--
 migration/trace-events       |   2 +-
 qapi/common.json             |  15 ++++
 qapi/migration.json          |  19 ++++-
 tests/migration-test.c       | 147 +++++++++++++++++++++++++++++------
 10 files changed, 348 insertions(+), 36 deletions(-)

--=20
2.20.1
