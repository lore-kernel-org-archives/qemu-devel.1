Received: from eggs.gnu.org ([2001:4830:134:3::10]:47461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHYS-0004iw-MY
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHYR-0005YT-JD
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:13:40 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:13:26 +0100
Message-Id: <20171110221329.24176-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/3] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Currently, we try to rewrite every occurrence of "backing": null into
"backing": "" in qmp_blockdev_add().  However, that breaks using the
same "backing": null construction in json:{} file names (which do not go
through qmp_blockdev_add()).  Currently, these then just behave as if
the option has not been specified.

Since there is actually only one place where we evaluate the @backing
option to find out whether not to use a backing file, we can instead
just check for null there.  It doesn't matter that this changes the
runtime state of the option from "" to null, because nobody really does
anything with that runtime state anyway (except put it into qemu again,
but qemu doesn't care whether it's "" or null).

And in the future, it's much better if we get it to be null in that
runtime state sooner than later -- see patch 3. :-)


Max Reitz (3):
  qapi: Add qdict_is_null()
  block: Handle null backing link
  block: Deprecate "backing": ""

 qapi/block-core.json       |  4 ++--
 include/qapi/qmp/qdict.h   |  1 +
 block.c                    |  6 +++++-
 blockdev.c                 | 14 --------------
 qobject/qdict.c            | 10 ++++++++++
 qemu-doc.texi              |  7 +++++++
 qemu-options.hx            |  4 ++--
 tests/qemu-iotests/089     | 20 ++++++++++++++++++++
 tests/qemu-iotests/089.out |  8 ++++++++
 9 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.13.6
