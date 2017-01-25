Received: from eggs.gnu.org ([2001:4830:134:3::10]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elayeek@gmail.com>) id 1cWJ3n-0003Yx-8Q
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elayeek@gmail.com>) id 1cWJ3l-0004tG-WC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:36:07 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elayeek@gmail.com>) id 1cWJ3l-0004s5-PK
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:36:05 -0500
Received: by mail-ua0-x229.google.com with SMTP id 35so153876018uak.1
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 00:36:04 -0800 (PST)
MIME-Version: 1.0
From: Elaye Karstadt <elayeek@gmail.com>
Date: Wed, 25 Jan 2017 08:35:53 +0000
Message-ID: <CABn57gE5rBetw0Di1a0S7M3LJOs5BWLi940a1wS+gBtVZ0z39g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu-img rebase working very slowly over NFS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Currently, qemu-img's rebase command checks if a sector is allocated in
filename and if it isn't then it reads that sector from both the
old_backing and new_backing and compares them.
It then writes the changes to filename.

This causes unnecessary reads in two easily verifiable (and important)
cases:
Case1:
Given the chain A1->...->new_backing->...->old_backing->filename, and
assume sector x is allocated in A1 but not in any subsequent file.
Rebase will see that x is not allocated in filename, hence it will read x
from both old_backing and new_backing.
Because x is actually not written in either, they will both go back to A1
and read the sector from there.
Rebase will then compare it, see it is identical and move on.

Case2:
Given the chain A1->...->new_backing->...->old_backing->filename, and
assume sector x is allocated in new_backing but not in any subsequent file.
Rebase will see that x is not allocated in filename, hence it will read x
from both old_backing and new_backing.
Because x is only allocated in new_backing, they will both read the sector
from there.
Rebase will then compare it, see it is identical and move on.

Both cases cause 2 unnecessary reads (not to mention reads of metadata as
we travel along the chain to find a file where the sector is written)
This recently became an issue for us when a machine which use a netowrk
based file system attempted to perform a rebase. The file being rebased and
the old_backing were fairly small diffs but the new_backing was much
larger. What happened was that the machine had to read most of new_backing
(twice) during rebase, an operation which takes some time on local hard
drives but quite a lot of time on network file systems.



Two suggested solutions:
1. Before reading the old_backing and new_backing, one could call
bdrv_is_allocated_above to check if a sector needs to be read (if a sector
is not allocated in any file after new_backing, it can be assumed that it
was not changed and need not be merged in the rebase?)

2. In 2014, a patch was pushed to make commit work more like the qmp
commit, citing that "qemu-img should use QMP commands whenever possible".
We would suggest a similar patch for rebase. Note that (also related to 1)
in qmp's commit (and rebase), bdrv_is_allocated_above is used in order to
avoid needless reads.
http://lists.nongnu.org/archive/html/qemu-devel/2014-10/msg03004.html
We've checked and commit does work faster (although, in our case, we seem
to need rebase. It should be fixed in general though).


Is there anything I am missing or should this be changed?
