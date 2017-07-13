Received: from eggs.gnu.org ([2001:4830:134:3::10]:46539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVg33-0008HN-H1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVg30-0004W5-74
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:29:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVg2z-0004Vo-Tm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3DA13345BE
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 15:28:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 17:28:52 +0200
Message-ID: <87o9so1hl7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <cleber@redhat.com>, Amador Pahim <apahim@redhat.com>, =?utf-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

I've seen enough QMP-related bugs that should've been caught in basic
testing to know we need to become better at testing this stuff.  That
means investing into tests/.

QMP is now almost eight years old, but its test coverage has always been
spotty.  We don't even really know where the holes are.

The tried-and-true approach to get such a problem under control is to
require new code to come with tests, and buckle down to write the
missing tests for old code.  This is more difficult for QMP than for
other things, because QMP is in so many places.  The QMP core is a
proper subsystem[*], but many of the 150+ commands are parts of other
subsystems.

Let's review tests we already have.

Two unit tests have been around since "forever": test-qmp-commands.c
exercises QMP command dispatch, and test-qmp-event.c exercises QMP event
sending.  The former also has a few tests of qapi_free_FOO(), but they
should really be somewhere else.  Perhaps they can even be deleted.

We additionally have quite a few tests that play with a real QEMU's QMP
monitor, using libqtest or qtest.py.

Many of them use QMP to test something else; they are not necessarily
comprehensive tests for the QMP commands they use.  For instance,
numa-test.c uses QMP command query-cpus to check command line options
have the expected effect.  It's not a comprehensive test of query-cpus.
qemu-iotests/030 uses QMP to exercise image streaming.  Uses QMP command
block-stream a lot, but whether it is a comprehensive test for it I
can't say without careful review of both the command and the test.

What do I mean by "comprehensive"?  A comprehensive test exercises the
command systematically, including its failure modes (testing how things
fail is important, because that's where we often screw up).

There's just one test dedicated to QMP: qmp-test.c.  It's quite new, and
doesn't do much, yet.  It mostly checks QMP protocol implementation,
i.e. aspects of QMP that are independent of specific commands.  For
instance, it tests QEMU cleanly rejects a command object with an
"arguments" member that isn't an object.  It also tests query-version.
It can serve as a relatively uncluttered example of how to test QMP
commands.

What can we do to improve QMP testing?  Sadly, I don't have the master
plan ready.  I can tell people their new code needs to come with tests,
but that won't help much unless subsystem maintainers pick up the habit,
too.  There are a few obvious tests to write for old code, such as a
generic test of query-like commands without arguments and without side
effects, similar to what test-hmp.c does for HMP command info (I hope to
get around to that one).  But for much of the old code, we don't even
know where the test coverage holes are.

Ideas anyone?


[*] Or could be, if we repaid technical debt in the monitor.
