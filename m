Received: from eggs.gnu.org ([2001:4830:134:3::10]:52081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoGg-0002cb-68
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eKoGb-00012h-4F
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:34:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eKoGa-00011t-S9
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:34:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4EE1C01F267
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 12:58:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  1 Dec 2017 13:58:07 +0100
Message-Id: <20171201125813.1437-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] Add make check tests for Migration
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

This is on top of my info_migrate series.

CHanges:

- No more tests for deprecated parameters. Now I only use
  migrate_set_parameter.  If there is a deprecated command for that,
  we tests it there.
- free "result" string, always good to return memory (Peter found it)
- use the new tcp_port parameter from info migrate.  So we are
  handling well the tcp case.
- lots of code movement around to make everything consistent.
- Several patches already integrated upstream.

Later, Juan.


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

Juan Quintela (6):
  migration: free result string
  tests: migration test deprecated commands
  tests: Add migration precopy test
  tests: Add basic migration precopy tcp test
  tests: Add migration xbzrle test
  [RFH] tests: Add migration compress threads tests

 tests/migration-test.c | 257 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 247 insertions(+), 10 deletions(-)

-- 
2.14.3
