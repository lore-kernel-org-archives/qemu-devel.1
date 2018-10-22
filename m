Received: from eggs.gnu.org ([2001:4830:134:3::10]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gEY5c-00013J-H9
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gEY5Y-00016b-WE
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:40 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:39991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gEY5Y-0000vQ-LZ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 07:09:36 -0400
From: Fei Li <fli@suse.com>
Date: Mon, 22 Oct 2018 19:08:52 +0800
Message-Id: <20181022110854.10284-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC 0/2] Fix migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Hi,
these two patches are to fix live migration issues. The first is
about multifd, and the second is to fix some error handling.

But I have a question about using multifd migration.
In our current code, when multifd is used during migration, if there
is an error before the destination receives all new channels (I mean
multifd_recv_new_channel(ioc)), the destination does not exit but
keeps waiting (Hang in recvmsg() in qio_channel_socket_readv) until
the source exits.

My question is about the state of the destination host if fails during
this period. I did a test, after applying [1/2] patch, if
multifd_new_send_channel_async() fails, the destination host hangs for
a while then later pops up a window saying
    "'QEMU (...) [stopped]' is not responding.
    You may choose to wait a short while for it to continue or force
    the application to quit entirely."
But after closing the window by clicking, the qemu on the dest still
hangs there until I exclusively kill the qemu on the source.

The source host keeps running as expected, but I guess the hang
phenonmenon in the dest is not right.
Would someone kindly give some suggestions on this? Thanks a lot.


Fei Li (2):
  migration: fix the multifd code
  migration: fix some error handling

 migration/migration.c    |  5 +----
 migration/postcopy-ram.c |  3 +++
 migration/ram.c          | 33 +++++++++++++++++++++++----------
 migration/ram.h          |  2 +-
 4 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.13.7
