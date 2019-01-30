Received: from eggs.gnu.org ([209.51.188.92]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1goomk-0007AL-Tc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1goomh-0007xx-6F
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:16:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1goomf-0007t5-7L
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:16:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1C7E132699
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:07:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 30 Jan 2019 13:06:12 +0100
Message-Id: <20190130120616.5260-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 0/4] Add make check tests for Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Iv v11:
- Rebase to lastest
- Remove the compress test.  It didin't worked really.
  See my next series.
- Only patch missing review-by is the second one.

Please, consider them.

In v10:
- rebase to latest upstream
- code changed quite a bit with qmp refactorings
  apllied them
- make it work again
- compress threads test, continue working there, not trivial.

Two question-:
- should we integrate them on this cycle?
  they are tests
- should we enable them only on baremetal, and not on emulation?
  There is still a problem on TCG that sometimes fails the migration
  thread

ToDo:
- Finish debug compress test
  Still stuck why the test wonk when I launch qemu by hand but not
  trough qtest.  Creatuve uses of launching gdb through launched
  guests have not help so far.

- Finish fd transport test
  Not very difficult in principle, need more checking to see if it
  don't fail in other setups.

- Finish tl trasport test
  I already knew that I hate certificates, but this is too much.  Trying
  to understand how to use them.

Please commet, Juan.

In v9:
- Dropp Export SocketAddress_to_str
  just create the functions where I need them.
- drop precopy test and xbzrle (on pull requset)
  Use 100M for cache as dave suggests
- drop ppc improvemnet (on pull request)
- drop RFH, will work on tha later
- move socket_address to info migrate

Please, review.

Later, Juan.

v8:
- just rebase to make things continue to wonk

New in the other v7:
- SocketAddress is now a list (a.k.a make happy danp)
- Rebase on top of upstream
  network listener is *interesting*
- *HACK* to make SocketAddress list in common
  see patch: create-socket-paramenter

Please review, Juan.

CC: berrange@redhat.com

[v7]
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
  We will get better naming from David at some point, and we will use tha=
t bit
- ppc: use inline code as suggested by lvivier

Please, review.

It is based on my previous pull request

Based-on: 20180129120932.12874-1-quintela@redhat.com

[v4]
- rebase on top on v4 info_migrate patches
- Tune sleeps to make patches fast
- Create a deprecated test for deprecated commands (i.e. make peterxu hap=
py)
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
- to make review easier, I started renaming postcopy-test.c to migration-=
test.c
- Did cleanups/refactoring there
- Don't use global-qtest anymore
- check that the parameters that we sent got really set
- RFH: comrpress threads tests is not working for some weird reason.  Usi=
ng the same code on command line works.
  still investigating why.

ToDoo:

- tcp: after discussions with dave, we ended in conclusion that we
  need to use the 0 port and let the system gives us a free one

  But .... that means that we need to be able to get that port back someh=
ow.
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
  Note to myself, there is no way to set the cache size with migraton_set=
_parameters
- Add test for compress threads
  disabled on the series, right now it appears that compression is not wo=
rking at all
- Move postcopy to use new results
  Idea is to move it on top of migration-test.c, but first I want some re=
views on basic idea

Juan Quintela (4):
  tests: Add migration xbzrle test
  migration: Create socket-address parameter
  tests: Add basic migration precopy tcp test
  tests: Add migration multifd test

 hmp.c                  |  31 ++++++
 migration/migration.c  |  24 +++++
 migration/migration.h  |   4 +
 migration/socket.c     |  11 ++
 qapi/migration.json    |   6 +-
 qapi/sockets.json      |  13 +++
 tests/migration-test.c | 224 ++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 307 insertions(+), 6 deletions(-)

--=20
2.20.1
