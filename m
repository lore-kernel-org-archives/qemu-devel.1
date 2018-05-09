Received: from eggs.gnu.org ([2001:4830:134:3::10]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCp-0004Fn-JM
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNCm-0000Tq-Fd
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNCm-0000SQ-BC
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBD6D4068027
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:25 +0200
Message-Id: <20180509112406.6183-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/41] Migration queue
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

this includes the reviewed patches for migration:
- update docs (dave)
- fixes for blocktime (text cleatups) (dave)
- migration+tls (dave)
- rdma index fix (lidong)
- Postcopy recovery (peterx)
- Parts reviewed of multifd and tests (me)

There are missing parts of RDMA, will be sent after this is in.  This got=
 already too big.

Please, apply.

The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d45=
44:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-05-08 17:05:58 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180509

for you to fetch changes up to c14eb5ac63b0d2cd146ca004daaeaf56677b7ed1:

  Migration+TLS: Fix crash due to double cleanup (2018-05-09 12:17:22 +02=
00)

----------------------------------------------------------------
migration/next for 20180509

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      migration: update docs
      migration: Textual fixups for blocktime
      Migration+TLS: Fix crash due to double cleanup

Juan Quintela (12):
      tests: Add migration precopy test
      tests: Add migration xbzrle test
      tests: Migration ppc now inlines its program
      migration: Set error state in case of error
      migration: Introduce multifd_recv_new_channel()
      migration: terminate_* can be called for other threads
      migration: Be sure all recv channels are created
      migration: Export functions to create send channels
      migration: Create multifd channels
      migration: Delay start of migration main routines
      migration: Transmit initial package through the multifd channels
      migration: Define MultifdRecvParams sooner

Lidong Chen (1):
      migration: update index field when delete or qsort RDMALocalBlock

Peter Xu (24):
      migration: let incoming side use thread context
      migration: new postcopy-pause state
      migration: implement "postcopy-pause" src logic
      migration: allow dst vm pause on postcopy
      migration: allow src return path to pause
      migration: allow fault thread to pause
      qmp: hmp: add migrate "resume" option
      migration: rebuild channel on source
      migration: new state "postcopy-recover"
      migration: wakeup dst ram-load-thread for recover
      migration: new cmd MIG_CMD_RECV_BITMAP
      migration: new message MIG_RP_MSG_RECV_BITMAP
      migration: new cmd MIG_CMD_POSTCOPY_RESUME
      migration: new message MIG_RP_MSG_RESUME_ACK
      migration: introduce SaveVMHandlers.resume_prepare
      migration: synchronize dirty bitmap for resume
      migration: setup ramstate for resume
      migration: final handshake for the resume
      migration: init dst in migration_object_init too
      qmp/migration: new command migrate-recover
      hmp/migration: add migrate_recover command
      migration: introduce lock for to_dst_file
      migration/qmp: add command migrate-pause
      migration/hmp: add migrate_pause command

Xiao Guangrong (1):
      migration: fix saving normal page even if it's been compressed

 docs/devel/migration.rst     | 532 ++++++++++++++++++++++++++++---------=
---
 hmp-commands.hx              |  34 ++-
 hmp.c                        |  23 +-
 hmp.h                        |   2 +
 include/migration/register.h |   2 +
 migration/channel.c          |  12 +-
 migration/exec.c             |   9 +-
 migration/fd.c               |   9 +-
 migration/migration.c        | 559 +++++++++++++++++++++++++++++++++++++=
++----
 migration/migration.h        |  22 ++
 migration/postcopy-ram.c     |  54 ++++-
 migration/ram.c              | 500 +++++++++++++++++++++++++++++++++++--=
-
 migration/ram.h              |   6 +
 migration/rdma.c             |   7 +
 migration/savevm.c           | 191 ++++++++++++++-
 migration/savevm.h           |   3 +
 migration/socket.c           |  39 ++-
 migration/socket.h           |   7 +
 migration/trace-events       |  21 ++
 qapi/migration.json          |  57 ++++-
 tests/migration-test.c       | 149 +++++++++---
 21 files changed, 1928 insertions(+), 310 deletions(-)
