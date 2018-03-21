Received: from eggs.gnu.org ([2001:4830:134:3::10]:58145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXed-00073N-NG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyXeb-0005iB-QE
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eyXeb-0005i3-MP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 02:55:21 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 21 Mar 2018 14:55:03 +0800
Message-Id: <20180321065506.21091-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] tests: trivial enhancements for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>

First two patches add OOB detection for current qapi-schema tests
(which I missed in the OOB series but pointed out by Eric Blake).  The
3rd patch addressed one suggestion from Eric too here:

http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03177.html

I tried to batch the commands in a single string buffer but it's not
that easy - because currently qtest_async_qmp() (and finally,
qmp_fd_sendv()) does not really support multiple qobjects in a single
command buffer.  Let's put that aside.  After all even calling
qtest_async_qmp() many times would be really fast, since we are
basically filling things to the write buffer very quickly (I believe
that's much faster than the IO really flushed to the receiver side).

But, adding the "id" field and check that would be far easier, that's
what I did in that last patch.

It's fine even for 2.12, but I'll let people decide.

Please review, thanks.

Peter Xu (3):
  tests: let qapi-schema tests detect oob
  tests: add oob-test for qapi-schema
  tests: more strict command batching test

 tests/Makefile.include                  |  1 +
 tests/qapi-schema/doc-good.out          |  4 ++--
 tests/qapi-schema/ident-with-escape.out |  2 +-
 tests/qapi-schema/indented-expr.out     |  4 ++--
 tests/qapi-schema/oob-test.err          |  0
 tests/qapi-schema/oob-test.exit         |  1 +
 tests/qapi-schema/oob-test.json         |  2 ++
 tests/qapi-schema/oob-test.out          |  6 ++++++
 tests/qapi-schema/qapi-schema-test.out  | 18 +++++++++---------
 tests/qapi-schema/test-qapi.py          |  4 ++--
 tests/qmp-test.c                        |  8 +++++++-
 11 files changed, 33 insertions(+), 17 deletions(-)
 create mode 100644 tests/qapi-schema/oob-test.err
 create mode 100644 tests/qapi-schema/oob-test.exit
 create mode 100644 tests/qapi-schema/oob-test.json
 create mode 100644 tests/qapi-schema/oob-test.out

-- 
2.14.3
