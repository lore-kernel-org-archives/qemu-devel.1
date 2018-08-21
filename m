Received: from eggs.gnu.org ([2001:4830:134:3::10]:45608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsDli-0003Ca-2f
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fsDld-0005gS-02
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:00:49 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:39269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fsDlc-0005du-Cx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 17:00:44 -0400
Received: by mail-qt0-x22d.google.com with SMTP id o15-v6so15949306qtk.6
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 14:00:42 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 21 Aug 2018 18:00:22 -0300
Message-Id: <20180821210024.3587-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [RFC PATCH v1 0/2] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

I am marking the patch series as "RFC" because it was supposed to be
a discussion but, when I was investigating, it turned out to be
easier to send the patches right away.

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
but I am simplifying the meaning of the parameters of savevm/loadvm/delvm.


Daniel Henrique Barboza (2):
  block/snapshot.c: eliminate use of ID input in snapshot operations
  qcow2-snapshot: remove redundant find_snapshot_by_id_and_name call

 block/qcow2-snapshot.c |  5 -----
 block/snapshot.c       |  5 +++--
 hmp-commands.hx        | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 17 deletions(-)

-- 
2.17.1
