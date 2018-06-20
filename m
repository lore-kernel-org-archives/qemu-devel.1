Received: from eggs.gnu.org ([2001:4830:134:3::10]:48357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVmX8-0001a0-Jv
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fVmX5-0007Au-G1
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:29:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fVmX5-0007AK-9l
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 19:28:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1668E68802
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:28:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 21 Jun 2018 01:28:39 +0200
Message-Id: <20180620232851.7152-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v15 00/12] Multifd
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

This is v15 of multifd patches.  Changes from previous version:
- fix compilation on 32bit (weird) platforms.  Move from uint64_t to
  long for atomics.
- use shutdown for comunication close instead of object_unref().
  (david suggestion)

I took some performance numbers (not the most scientifc approach).  I
tested on localhost (so I can have fast networking), a guest with:
- iddle
- stress --vm 4 --vm-bytss 500M
- stress --vm 4 --vm-bytss 700M

Setup time for multifd is higher (around 1s).  In idle difference is
smaall, but precopy wins (we are not able to setup the setup consts).
On 500MB multifd is cleary faster (2/3 of the time and much less
downtime).  With 700MB guests, normal procopy does not converge.  It
calculates a 4second downtime.  Multifd ends without problems.

Yes, I know that throughput of multifd is not writen correctly.  That
is only for printing stats, the ones that are used to calculate
convergence work as expected.  Will fix the transef speed later.

Please, review the missing patch.

Later, Juan.


idle: precopy

Migration status: completed
total time: 1085 milliseconds
downtime: 276 milliseconds
setup: 20 milliseconds
transferred ram: 243676 kbytes
throughput: 1841.41 mbps
remaining ram: 0 kbytes
total ram: 3150664 kbytes
duplicate: 728780 pages
normal: 59202 pages
normal bytes: 236808 kbytes
dirty sync count: 3

idle: multifd

Migration status: completed
total time: 1799 milliseconds
downtime: 251 milliseconds
setup: 1051 milliseconds
transferred ram: 6431 kbytes
throughput: 30.25 mbps
remaining ram: 0 kbytes
total ram: 3150664 kbytes
duplicate: 731745 pages
skipped: 0 pages
normal: 56596 pages
normal bytes: 226384 kbytes
dirty sync count: 3
page size: 4 kbytes

stress --vm 4 --vm-bytes 500M: precopy

total time: 9477 milliseconds
downtime: 270 milliseconds
setup: 33 milliseconds
transferred ram: 6270075 kbytes
throughput: 5420.09 mbps
remaining ram: 0 kbytes
total ram: 3150664 kbytes
duplicate: 232478 pages
skipped: 0 pages
normal: 1563953 pages
normal bytes: 6255812 kbytes
dirty sync count: 10


stress --vm 4 --vm-bytes 500M: multifd

total time: 6168 milliseconds
downtime: 173 milliseconds
setup: 1005 milliseconds
transferred ram: 1984 kbytes
throughput: 2.92 mbps
remaining ram: 0 kbytes
total ram: 3150664 kbytes
duplicate: 225682 pages
skipped: 0 pages
normal: 1428939 pages
normal bytes: 5715756 kbytes
dirty sync count: 11

stress --vm 4 --vm-bytes 700M: precopy

   I stopped affter 87 seconds, notice that expected downtime is
   around 4 seconds, not changing at all.


Migration status: active
total time: 87026 milliseconds
expected downtime: 4126 milliseconds
setup: 18 milliseconds
transferred ram: 50056699 kbytes
throughput: 4835.55 mbps
remaining ram: 2335628 kbytes
total ram: 3150664 kbytes
duplicate: 107856 pages
skipped: 0 pages
normal: 12489541 pages
normal bytes: 49958164 kbytes
dirty sync count: 23
page size: 4 kbytes
dirty pages rate: 186814 pages


stress --vm 4 --vm-bytes 700M: multifd

total time: 40971 milliseconds
downtime: 192 milliseconds
setup: 1017 milliseconds
transferred ram: 1144 kbytes
throughput: 0.28 mbps
remaining ram: 0 kbytes
total ram: 3150664 kbytes
duplicate: 129472 pages
skipped: 0 pages
normal: 11959938 pages
normal bytes: 47839752 kbytes
dirty sync count: 49
page size: 4 kbytes



THis iv v14 multifd patches: Changes from previous submit:
- rename seq -> packet_num: make things easier to understand
- packet_num is now 64bit wide
- include the size of the packet headers in the transfer stats (dave noticed it)
- improve comments here and there.

All the patches except two are already reviewed-by.  And my
understanding is that I fixed last issues with two remaining ones, so
I am expect to pull this when this two patches are reviewed.

Please review.

Thanks, Juan.



This is v13 of multifd patches:

- several patches already integrated
- rebased to latests upstreams
- addressed all the reviews comments around.

Please review.

Thanks, Juan.

[v12]

Big news, it is not RFC anymore, it works reliabely for me.

Changes:
- Locknig changed completely (several times)
- We now send  all pages through the channels.  In a 2GB guest with 1 disk and a network card, the amount of data send for RAM was 80KB.
- This is not optimized yet, but it shouws clear improvements over precopy.  testing over localhost networking I can guet:
  - 2 VCPUs guest
  - 2GB RAM
  - runn stress --vm 4 --vm 500GB (i.e. dirtying 2GB or RAM each second)

  - Total time: precopy ~50seconds, multifd  around 11seconds
  - Bandwidth usage is around 273MB/s vs 71MB/s on the same hardware

This is very preleminary testing, will send more numbers when I got them.  But looks promissing.

Things that will be improved later:
- Initial synchronization is too slow (around 1s)
- We synchronize all threads after each RAM section, we can move to only
  synchronize them after we have done a bitmap syncrhronization
- We can improve bitmap walking (but that is independent of multifd)

Please review.

Later, Juan.


[v11]

Changes on top of previous sumbimission:
- Now on top of migration-tests/v6 that I sent on Wednesday
- Rebased to latest upstream
- Everything that is sent through the network should be converted correctly
  (famous last words)
- Still on RFC (sometimes it ends some packets at the end), just to
  show how things are going on.  Problems are only on the last patch.

- Redo some locking (again) Now the problem is being able te send the
  synchronization through the multifd channels.  I end the migration
  _before_ all the channels have recevied all the packets.

- Trying to get a flags argument into each packet, to be able to synchronze
  through the network, not from the "main" incoming corroutine.

- Related to the network-safe fields, now everything is in its own
  routine, it should be easier to understand/review.  Once there, I
  check that all values are inside range.

So, please comment.

Thanks, Juan.


[v10]
Lots of changes from previous versions:
a - everything is sent now through the multifd channels, nothing is sent through main channel
b - locking is band new, I was getting into a hole with the previous approach, right now, there is a single way to
    do locking (both source and destination)
       main thread : sets a ->sync variable for each thread and wakeps it
       multifd threads: clean the variable and signal (sem) back to main thread

    using this for either:
    - all threads have started
    - we need to synchronize after each round through memory
    - all threads have finished

c - I have to use a qio watcher for a thread to wait for ready data to read

d - lots of cleanups

e - to make things easier, I have included the missing tests stuff on
    this round of patches, because they build on top of them

f - lots of traces, it is now much easier to follow what is happening

Now, why it is an RFC:

- in the last patch, there is still race between the whatcher, the
  ->quit of the threads and the last synchronization.  Techinically they
  are done in oder, but in practice, they are hanging sometimes.

- I *know* I can optimize the synchronization of the threads sending
  the "we start a new round" through the multifd channels, have to add a flag here.

- Not having a thread on the incoming side  is a mess, I can't block waiting for things to happen :-(

- When doing the synchronization, I need to optimize the sending of the "not finished packet" of pages, working on that.

please, take a look and review.

Thanks, Juan.

[v9]

This series is on top of my migration test series just sent, only reject should be on the test system, though.

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

Juan Quintela (12):
  migration: Create multipage support
  migration: Create multifd packet
  migration: Add multifd traces for start/end thread
  migration: Calculate transferred ram correctly
  migration: Multifd channels always wait on the sem
  migration: Add block where to send/receive packets
  migration: Synchronize multifd threads with main thread
  migration: Create ram_save_multifd_page
  migration: Start sending messages
  migration: Wait for blocking IO
  migration: Remove not needed semaphore and quit
  migration: Stop sending whole pages through main channel

 migration/migration.c  |  12 +-
 migration/ram.c        | 498 +++++++++++++++++++++++++++++++++++++++--
 migration/ram.h        |   1 +
 migration/trace-events |  12 +
 4 files changed, 505 insertions(+), 18 deletions(-)

-- 
2.17.1
