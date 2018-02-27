Received: from eggs.gnu.org ([2001:4830:134:3::10]:44543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rpalethorpe@suse.com>) id 1eqdsr-0000OM-HW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rpalethorpe@suse.com>) id 1eqdsq-0000Bu-PG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:57:25 -0500
From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 27 Feb 2018 12:56:49 +0100
Message-Id: <20180227115651.30762-1-rpalethorpe@suse.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] Increase usability of external
 snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, quintela@redhat.com, mreitz@redhat.com, Richard Palethorpe <rpalethorpe@suse.com>

Hello,

Following on from the discussion about creating savevm/loadvm QMP
equivalents. I decided to take the advice given that we should use external
snapshots. However reverting to a snapshot currently requires QEMU to be
restarted with "-incoming". Restarting QEMU requires a fair bit of book
keeping to be done by the management application and may take measurably more
time.

Also to quote the previous discussion:
>>> > Then you could just use the regular migrate QMP commands for loading
>>> > and saving snapshots.  Might need a little extra work on the incoming
>>> > side, since we need to be able to load snapshots, despite QEMU not
>>> > being started with '-incoming defer', but might still be doable ?
>>> > This would theoretically give us progress monitoring, cancellation,
>>> > etc for free.
>>> 
>>> What actually stops this working other than the sanity check in
>>> migrate_incoming ?
>>
>> No idea really - not looked closely at the code implications.
>
> It would be a plus for migration code, right now there are _two_
> implementations, and savevm/loadvm one gets less love.
>
> And we will check "much more" the way to load migration in a
> non-pristine qemu, so ....
>
> Later, Juan.

This patch just changes a few lines which shuts down the currently running VM
and puts the QEMU instance into a state where it can accept an incoming
migration. I haven't tested it yet with more complex scenarios, but it
appears to work fine so far.

I have also started work on a new migration test, which is almost identical to
the existing post-copy test, but migrates to a non-pristine QEMU. It works on
X86, but not yet on PPC64 because the serial output is different. It needs
quite a lot more work, but before I continue, I would like to know first if
this is something people fundamentally object to?

Richard Palethorpe (2):
  migrate: Allow incoming migration without defer
  migrate: Tests for migrating to an already used QEMU

 migration/migration.c  |  12 +++---
 tests/migration-test.c | 113 +++++++++++++++++++++++++++++++++++++------------
 vl.c                   |   2 +
 3 files changed, 92 insertions(+), 35 deletions(-)

-- 
2.16.2
