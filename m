Received: from eggs.gnu.org ([2001:4830:134:3::10]:43400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOd-0007pd-SC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOa-0007ZN-Mo
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnQOa-0007Z7-G5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:36 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 15:24:25 +0100
Message-Id: <20170831142430.16665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] qapi: support py2 & py3 in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

Since I claimed that supporting py2 & py3 in parallel would be easy
for QEMU, I figured I ought to actually give it a try to backup that
assertion.

This small patch series is the result of that effort. I tested this
series on Fedora 26 using 2.7.13 and Python 3.6.2.

To test with py3, I hacked config-host.mak to change the PYTHON
variable to point to 'python3' binary, then compared the following
generated content for the files:

   qmp-commands.h qapi-types.h  qapi-visit.h  qapi-event.h
   qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
   qmp-introspect.c qmp-introspect.h

with that generated under py2 to see they are identical.

It is possible there's still more bugs hiding that could impact
on 2.6 or earlier versions of 3.x or 2.7.x, so this probably
needs a bit wider testing, but I think the series illustrates
the broad scope of the changes we can expect. Only the need
to adapt to different module import locations adds to the
line count, and that's fairly minimal.

Daniel P. Berrange (5):
  qapi: convert to use python print function instead of statement
  qapi: use items()/values() intead of iteritems()/itervalues()
  qapi: Use OrderedDict from standard library if available
  qapi: adapt to moved location of StringIO module in py3
  qapi: Adapt to moved location of 'maketrans' function in py3

 scripts/qapi.py      | 41 +++++++++++++++++++++++++----------------
 scripts/qapi2texi.py | 11 ++++++-----
 2 files changed, 31 insertions(+), 21 deletions(-)

-- 
2.13.5
