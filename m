Received: from eggs.gnu.org ([2001:4830:134:3::10]:59533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7L6-0001aN-2Z
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df7L4-0007Vz-D9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df7L4-0007V3-46
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:26:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1062461488
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:26:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue,  8 Aug 2017 18:26:10 +0200
Message-Id: <20170808162629.32493-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v6 00/19] Multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com


Hi

Things NOT done yet:

- still uses error_abort/fail.  I need to redo all the error pages to
  be able to return with errors from other threads.
- still connects synchronusly.  I need to redo the other changes to fix this.
- have to change the tests as danp wanted, I still don't undertand them.

Done:
- Improve migration_ioc_porcess_incoming
- teach about G_SOURCE_REMOVE/CONTINUE
- Add test for migration_has_all_channels
- use DEFIN_PROP*
- change recv_state to use pointers to parameters
  make easier to receive channels out of order
- use g_strdup_printf()
- improve count of threads to know when we have to finish
- report channel id's on errors
- Use last_page parameter for multifd_send_page() sooner
- Improve commets for address
- use g_new0() instead of g_malloc()
- create MULTIFD_CONTINUE instead of using UINT16_MAX
- clear memory used by group of pages
  once there, pass everything to the global state variables instead of being
  local to the function.  This way it works if we cancel migration and start
  a new one
- Really wait to create the migration_thread until all channels are created
- split initial_bytes setup to make clearer following patches.
- createRAM_SAVE_FLAG_MULTIFD_SYNC macro, to make clear what we are doing
- move setting of need_flush to inside bitmap_sync
- Lots of other small changes & reorderings

Please, comment.


[v5]

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

Juan Quintela (19):
  migration: Create migration_ioc_process_incoming()
  migration: Teach it about G_SOURCE_REMOVE
  migration: Add comments to channel functions
  migration: Create migration_has_all_channels
  qio: Create new qio_channel_{readv,writev}_all
  migration: Add multifd capability
  migration: Create x-multifd-threads parameter
  migration: Create x-multifd-group parameter
  migration: Create multifd migration threads
  migration: Split migration_fd_process_incoming
  migration: Start of multiple fd work
  migration: Create ram_multifd_page
  migration: Really use multiple pages at a time
  migration: Send the fd number which we are going to use for this page
  migration: Create thread infrastructure for multifd recv side
  migration: Test new fd infrastructure
  migration: Rename initial_bytes
  migration: Transfer pages over new channels
  migration: Flush receive queue

 hmp.c                          |  16 ++
 include/glib-compat.h          |   2 +
 include/io/channel.h           |  46 ++++
 io/channel.c                   |  77 ++++++
 migration/channel.c            |  18 +-
 migration/exec.c               |   2 +-
 migration/fd.c                 |   2 +-
 migration/migration.c          | 143 ++++++++++-
 migration/migration.h          |   8 +
 migration/qemu-file-channel.c  |  29 +--
 migration/ram.c                | 537 ++++++++++++++++++++++++++++++++++++++++-
 migration/ram.h                |   8 +
 migration/socket.c             |  48 +++-
 migration/socket.h             |  10 +
 qapi-schema.json               |  44 +++-
 tests/io-channel-helpers.c     |  55 +++++
 tests/io-channel-helpers.h     |   4 +
 tests/test-io-channel-buffer.c |  55 ++++-
 18 files changed, 1049 insertions(+), 55 deletions(-)

-- 
2.9.4
