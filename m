Received: from eggs.gnu.org ([2001:4830:134:3::10]:40216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFn7-00064S-Lo
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eZFn5-0004NM-G3
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eZFn5-0004D0-3y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 07:47:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2ECEFC0641F2
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 12:47:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 10 Jan 2018 13:47:09 +0100
Message-Id: <20180110124723.11879-1-quintela@redhat.com>
Subject: [Qemu-devel] [RFC 00/14] Multifd
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

For V10:
- It is a request for comments

- I changed as suggested from Paolo on KVM forum to send page metadata
  over the channels

- I simplified lots of things
- Added reviews
- it is not finished, in no-particular order:
  * old code is not removed for comparison for the people that looked at
    the previous one
  * it would be removed later
  * synchronization at the end of each stage will be done with a flags field
    on the communication channel.
- Yes, there is commented code on the last patch.
- I am open to suggestion about how to call the pacet "message" with
  metadata.

Please, look at it.

Later, Juan.


On v9 series for you:
- qobject_unref() as requested by dan

  Yes he was right, I had a reference leak for _non_ multifd, I
  *thought* he mean for multifd, and that took a while to understand
  (and then find when/where).

- multifd page count: it is dropped for good
- uuid handling: we use the default qemu uuid of 0000...
- uuid handling: using and struct and sending the struct
  * idea is to add a size field and add more parameter after that
  * anyone has a good idea how to "ouptut" info
    migrate_capabilities/parameters json into a string and how to read it back?
- changed how we test that all threads/channels are already created.
  Should be more robust.
- Add tests multifd.  Still not ported on top of migration-tests series sent early
  waiting for review on the ideas there.
- Rebase and remove al the integrated patches (back at 12)

Please, review.

Later, Juan.

[v8]
Things NOT done yet:

- drop x-multifd-page-count?  We can use performance to set a default value
- paolo suggestion of not having a control channel
  needs iyet more cleanups to be able to have more than one ramstate, trying it.
- still not performance done, but it has been very stable

On v8:
- use connect_async
- rename multifd-group to multifd-page-count (danp suggestion)
- rename multifd-threads to multifd-channels (danp suggestion)
- use new qio*channel functions
- Address rest of comments left


So, please review.

My idea will be to pull this changes and continue performance changes
for inside, basically everything is already reviewed.

Thanks, Juan.

On v7:
- tests fixed as danp wanted
- have to revert danp qio_*_all patches, as they break multifd, I have to investigate why.
- error_abort is gone.  After several tries about getting errors, I ended having a single error
  proceted by a lock and first error wins.
- Addressed basically all reviews (see on ToDo)
- Pointers to struct are done now
- fix lots of leaks
- lots of small fixes


[v6]
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

Juan Quintela (14):
  migration: Make migrate_fd_error() the owner of the Error
  migration: Rename initial_bytes
  migration: Drop current address parameter from save_zero_page()
  migration: Start of multiple fd work
  migration: Create ram_multifd_page
  migration: Send the fd number which we are going to use for this page
  migration: Create thread infrastructure for multifd recv side
  migration: Transfer pages over new channels
  migration: Flush receive queue
  migration: Add multifd test
  LOCAL: use trace events for migration-test
  migration: Sent the page list over the normal thread
  migration: Add multifd_send_packet trace
  all works

 migration/channel.c    |   1 -
 migration/migration.c  |  39 ++--
 migration/migration.h  |   5 +-
 migration/ram.c        | 495 ++++++++++++++++++++++++++++++++++++++++++++++---
 migration/ram.h        |   3 +
 migration/socket.c     |  43 ++++-
 migration/socket.h     |  10 +
 migration/trace-events |   5 +
 tests/migration-test.c |  52 ++++++
 9 files changed, 614 insertions(+), 39 deletions(-)

-- 
2.14.3
