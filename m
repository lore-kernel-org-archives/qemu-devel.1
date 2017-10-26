Received: from eggs.gnu.org ([2001:4830:134:3::10]:46877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cxt-0004eZ-6A
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cxo-0007vT-97
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7cxo-0007uf-2g
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02534C047B75
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:52:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 26 Oct 2017 09:52:12 +0200
Message-Id: <20171026075222.27798-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/10] Add make check tests for Migration
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

This is on top of my set_cache_size series.

big changes is this v2:
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

Please review,.

Later, Juan.

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

Please, review.

Juan.



*** BLURB HERE ***

Juan Quintela (10):
  tests: rename postcopy-test to migration-test
  tests: Refactor setting of parameters/capabilities
  tests: Factorize out migrate_test_start/end
  tests: Don't abuse global_qtest
  tests: check that migration parameters are really assigned
  tests: Add migration precopy test
  tests: Add basic migration precopy tcp test
  tests: Add precopy test using deprecated commands
  tests: Add migration xbzrle test
  [RFH] tests: Add migration compress threads tests

 MAINTAINERS                                 |   1 +
 tests/Makefile.include                      |   6 +-
 tests/{postcopy-test.c => migration-test.c} | 492 ++++++++++++++++++++++------
 3 files changed, 394 insertions(+), 105 deletions(-)
 rename tests/{postcopy-test.c => migration-test.c} (59%)

-- 
2.13.6
