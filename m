Received: from eggs.gnu.org ([2001:4830:134:3::10]:45957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IX-0003mT-UJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6IS-0005Iq-Sy
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6IS-0005IP-J2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:42:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7CC87F3F2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:42:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:21 +0200
Message-Id: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 00/17] Multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com


Hi

This is a new version from the multifd series, changes since last version:

- tests from qio functions (a.k.a. make danp happy)
- 1st message from one channel to the other contains:
   <uuid> multifd <channel number>
   This would allow us to create more channels as we want them.
   a.k.a. Making dave happy
- Waiting in reception for new channels using qio listeners
  Getting threads, qio and reference counters working at the same time
  was interesing.
  Another make danp happy.

- Lots and lots of small changes and fixes.  Notice that the last 70 patches
  that I merged or so what to make this series easier/smaller.

- NOT DONE: I haven't been woring on measuring performance
  differences, this was about getting the creation of the
  threads/channels right.

So, what I want:

- Are people happy with how I have (ab)used qio channels? (yes danp,
  that is you).
- My understanding is th

ToDo:

- Make paolo happy: He wanted to test using control information
  through each channel, not only pages.  This requires yet more
  cleanups to be able to have more than one QEMUFile/RAMState open at
  the same time.

- How I create multiple channels.  Things I know:
  * with current changes, it should work with fd/channels (the multifd bits),
    but we don;t have a way to pass multiple fd;s or exec files.
    Danp, any idea about how to create an UI for it?
  * My idea is that we would split current code to be:
    + channel creation at migration.c
    + rest of bits at ram.c
    + change format to:
      <uuid> main <rest of migration capabilities/paramentes> so we can check
      <uuid> postcopy <no clue what parameters are needed>
          Dave wanted a way to create a new fd for postcopy for some time
    + Adding new channels is easy

- Performance data/numbers: Yes, I wanted to get this out at once, I
  would continue with this.


Please, review.


[v4]
This is the 4th version of multifd. Changes:
- XBZRLE don't need to be checked for
- Documentation and defaults are consistent
- split socketArgs
- use iovec instead of creating something similar.
- We use now the exported size of target page (another HACK removal)
- created qio_chanel_{wirtev,readv}_all functions.  the _full() name
  was already taken.
  What they do is the same that the without _all() function, but if it
  returns due to blocking it redo the call.
- it is checkpatch.pl clean now.

Please comment, Juan.




[v3]

- comments for previous verion addressed
- lots of bugs fixed
- remove DPRINTF from ram.c

- add multifd-group parameter, it gives how many pages we sent each
  time to the worker threads.  I am open to better names.
- Better flush support.
- with migration_set_speed 2G it is able to migrate "stress -vm 2
  -vm-bytes 512M" over loopback.

Please review.

Thanks, Juan.

[v2]

This is a version against current code.  It is based on top of QIO
work. It improves the thread synchronization and fixes the problem
when we could have two threads handing the same page.

Please comment, Juan.




Juan Quintela (17):
  migrate: Add gboolean return type to migrate_channel_process_incoming
  migration: Create migration_ioc_process_incoming()
  qio: Create new qio_channel_{readv,writev}_all
  migration: Add multifd capability
  migration: Create x-multifd-threads parameter
  migration: Create x-multifd-group parameter
  migration: Create multifd migration threads
  migration: Split migration_fd_process_incomming
  migration: Start of multiple fd work
  migration: Create ram_multifd_page
  migration: Really use multiple pages at a time
  migration: Send the fd number which we are going to use for this page
  migration: Create thread infrastructure for multifd recv side
  migration: Delay the start of reception on main channel
  migration: Test new fd infrastructure
  migration: Transfer pages over new channels
  migration: Flush receive queue

 hmp.c                          |  17 ++
 include/io/channel.h           |  46 ++++
 io/channel.c                   |  76 ++++++
 migration/channel.c            |   6 +-
 migration/channel.h            |   2 +-
 migration/exec.c               |   6 +-
 migration/migration.c          | 128 +++++++++-
 migration/migration.h          |   5 +
 migration/qemu-file-channel.c  |  29 +--
 migration/ram.c                | 541 ++++++++++++++++++++++++++++++++++++++++-
 migration/ram.h                |   7 +
 migration/socket.c             |  50 +++-
 migration/socket.h             |  10 +
 qapi-schema.json               |  32 ++-
 tests/io-channel-helpers.c     |  55 +++++
 tests/io-channel-helpers.h     |   4 +
 tests/test-io-channel-buffer.c |  55 ++++-
 17 files changed, 1010 insertions(+), 59 deletions(-)

-- 
2.9.4
