Received: from eggs.gnu.org ([2001:4830:134:3::10]:50468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QT-0007aE-IQ
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ew9QQ-0004Ku-8N
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ew9QQ-0004K2-30
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA1D94040856
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 16:38:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Mar 2018 17:38:30 +0100
Message-Id: <20180314163838.7158-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/8] Add make check tests for Migration
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

This is v6, it differest from the patches that I sent with previous
multifd post:
- Rename x-tcp-port to x-socket-address
  This is more *complicated* that it looks as:

  * it is a pointer, so I need to use QAPI_CLONE() to make info
    migrate work

  * this is an union of structs.  In QAPI. So, a dict of strings.  The
    only way that I was able to make things work is parsing the qdict
    to a SocketAddress and then output a SocketAddress as an str.  It
    needs to be an easier way, for sure.

  * Cleanups here andthere.

Please, review, Juan.

[v5]
- Several patches moved to pull request
- merge info_migrate and migration_tests
  only missing bit is tcp_port, needed for tcp tests
- Rename tcp-port to x-tcp-port
  We will get better naming from David at some point, and we will use that bit
- ppc: use inline code as suggested by lvivier

Please, review.

It is based on my previous pull request

Based-on: 20180129120932.12874-1-quintela@redhat.com

[v4]
- rebase on top on v4 info_migrate patches
- Tune sleeps to make patches fast
- Create a deprecated test for deprecated commands (i.e. make peterxu happy)
- create migrate_start_postcopy function
- fix naming/sizes between power and x86
- cleanup comments to match code

[v3]

- No more tests for deprecated parameters. Now I only use
  migrate_set_parameter.  If there is a deprecated command for that,
  we tests it there.
- free "result" string, always good to return memory (Peter found it)
- use the new tcp_port parameter from info migrate.  So we are
  handling well the tcp case.
- lots of code movement around to make everything consistent.
- Several patches already integrated upstream.

[v2]
- to make review easier, I started renaming postcopy-test.c to migration-test.c
- Did cleanups/refactoring there
- Don't use global-qtest anymore
- check that the parameters that we sent got really set
- RFH: comrpress threads tests is not working for some weird reason.  Using the same code on command line works.
  still investigating why.

ToDoo:

- tcp: after discussions with dave, we ended in conclusion that we
  need to use the 0 port and let the system gives us a free one

  But .... that means that we need to be able to get that port back somehow.
  "info migrate" woring on destination side?

- compression threads.  There is some weird interaction with the test
  hardness and every migration thread get waiting in a different
  semaphore.  Investigating if it is a race/bug/whateverr

- deprecated commands: There was a suggestion to make
  migrate_set_parameter look at the parameter name and test old/new
  depending on something.  Not sure what to do here.

- testing commands: Is there a way to launch qemu and just sent
  qmp/hmp commands without having to really run anything else?

[v1]
- add test for precopy for unix/tcp
  exec and fd to came, don't know how to test rdma without hardware
- add tests using deprecated interfaces
- add test for xbzrle
  Note to myself, there is no way to set the cache size with migraton_set_parameters
- Add test for compress threads
  disabled on the series, right now it appears that compression is not working at all
- Move postcopy to use new results
  Idea is to move it on top of migration-test.c, but first I want some reviews on basic idea

Juan Quintela (8):
  qemu-sockets: Export SocketAddress_to_str
  tests: Add migration precopy test
  tests: Add migration xbzrle test
  migration: Create x-socket-address parameter
  tests: Migration ppc now inlines its program
  tests: Add basic migration precopy tcp test
  migration: Add multifd test
  [RFH] tests: Add migration compress threads tests

 chardev/char-socket.c  |  29 -----
 hmp.c                  |   6 +
 include/qemu/sockets.h |   3 +
 migration/migration.c  |  18 +++
 migration/migration.h  |   2 +
 migration/socket.c     |  27 +++-
 qapi/migration.json    |  14 ++-
 tests/migration-test.c | 328 ++++++++++++++++++++++++++++++++++++++++++-------
 util/qemu-sockets.c    |  29 +++++
 9 files changed, 379 insertions(+), 77 deletions(-)

-- 
2.14.3
