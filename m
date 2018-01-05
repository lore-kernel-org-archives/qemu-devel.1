Received: from eggs.gnu.org ([2001:4830:134:3::10]:38335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZv5-0002H4-Nb
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eXZv2-00030a-He
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eXZv2-0002zL-3o
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 16:52:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E44008B114
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 21:52:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  5 Jan 2018 22:52:35 +0100
Message-Id: <20180105215246.908-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/11] Add make check tests for Migration
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

In v4:

Based-on: 20180105205109.683-1-quintela@redhat.com

Changes:
- rebase on top on v4 info_migrate patches
- Tune sleeps to make patches fast
- Create a deprecated test for deprecated commands (i.e. make peterxu happy)
- create migrate_start_postcopy function
- fix naming/sizes between power and x86
- cleanup comments to match code

Please, review.


[v3]

Changes:

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

Juan Quintela (11):
  tests: Remove deprecated migration tests commands
  tests: Migration ppc test was missing arguments
  tests: Consolidate accelerators declaration
  tests: Use consistent names and sizes for migration
  tests: Add deprecated commands migration test
  tests: Add migration precopy test
  tests: Add basic migration precopy tcp test
  tests: Add migration xbzrle test
  tests: Create migrate-start-postcopy command
  tests: Adjust sleeps for migration test
  [RFH] tests: Add migration compress threads tests

 tests/migration-test.c | 379 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 319 insertions(+), 60 deletions(-)

-- 
2.14.3
