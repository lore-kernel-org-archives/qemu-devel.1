Received: from eggs.gnu.org ([2001:4830:134:3::10]:53406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fxsCB-0007E4-C7
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fxsC9-0001lx-5R
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:11:30 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:38484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fxsC8-0001jU-M5
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 07:11:28 -0400
Received: by mail-qt0-x229.google.com with SMTP id x7-v6so11708769qtk.5
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 04:11:27 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu,  6 Sep 2018 08:11:04 -0300
Message-Id: <20180906111107.30684-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

changes in v2:
- removed the "RFC" marker;
- added a new patch (patch 2) that removes
bdrv_snapshot_delete_by_id_or_name from the code;
- made changes in patch 1 as suggested by Murilo;
- previous patch set link:
https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html


It is not uncommon to see bugs being opened by testers that attempt to
create VM snapshots using HMP. It turns out that "0" and "1" are quite
common snapshot names and they trigger a lot of bugs. I gave an example
in the commit message of patch 1, but to sum up here: QEMU treats the
input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
is documented as such, but this can lead to strange situations.

Given that it is strange for an API to consider a parameter to be 2 fields
at the same time, and inadvently treating them as one or the other, and
that removing the ID field is too drastic, my idea here is to keep the
ID field for internal control, but do not let the user set it.

I guess there's room for discussion about considering this change an API
change or not. It doesn't affect users of HMP and it doesn't affect Libvirt,
but simplifying the meaning of the parameters of savevm/loadvm/delvm.


Daniel Henrique Barboza (3):
  block/snapshot.c: eliminate use of ID input in snapshot operations
  block/snapshot: remove bdrv_snapshot_delete_by_id_or_name
  qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call

 block/qcow2-snapshot.c   |  5 -----
 block/snapshot.c         | 25 +++----------------------
 hmp-commands.hx          | 24 ++++++++++++------------
 include/block/snapshot.h |  3 ---
 qemu-img.c               | 15 +++++++++++----
 5 files changed, 26 insertions(+), 46 deletions(-)

-- 
2.17.1
