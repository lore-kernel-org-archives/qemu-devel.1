Received: from eggs.gnu.org ([2001:4830:134:3::10]:45230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duFhr-00043M-VC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duFhq-0004Ye-W6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:24:43 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 12:24:30 +0200
Message-Id: <20170919102434.21147-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] scsi,
 block: introduce persistent reservation managers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

SCSI persistent Reservations allow restricting access to block devices
to specific initiators in a shared storage setup.  When implementing
clustering of virtual machines, it is a common requirement for virtual
machines to send persistent reservation SCSI commands.  However,
the operating system restricts sending these commands to unprivileged
programs because incorrect usage can disrupt regular operation of the
storage fabric.

With these patches, the scsi-block and scsi-generic SCSI passthrough
devices learn to delegate the implementation of persistent reservations to
a separate object, the "persistent reservation manager".  The persistent
reservation manager talks to a separate privileged program, with a very
simple protocol based on SCM_RIGHTS.  In addition to invoking PERSISTENT
RESERVATION OUT and PERSISTENT RESERVATION IN commands, the privileged
component can also use libmpathpersist so that persistent reservations
are applied to all paths in a multipath setting.

Patch 1 defines the abstract QOM class and plugs it into block/file-posix.c.

Patch 2 and 3 introduce the privileged helper program, while patch 4
defines the concrete QOM class that talks to it.

Paolo

v1->v2: removed scsi/ patches which were all reviewed
        removed man page (requires .texi while I used .rst for docs)
        qio_channel_read/write_all also went in independently
        fix installation of qemu-pr-helper man page
        fixes to documentation
        added BSD license to protocol header
        added handling of residual (buffer underrun)
        fixed closing of file descriptors on error
        block PERSISTENT RESERVE OUT for read-only file descriptors
        do not use g_assert
        use EXIT_SUCCESS/EXIT_FAILURE consistently
        moved all CONFIG_MPATH usage to the right patch
        drop CAP_SYS_ADMIN if multipath not compiled in
        simplify buffer size handling in multipath PERSISTENT RESERVE IN
        block REGISTER AND MOVE operation for multipath PERSISTENT RESERVE OUT
        fixed transport id handling in multipath PERSISTENT RESERVE OUT
        fixed string property double-free in pr-manager-helper
        fixed/cleaned up error handling in pr-manager-helper
        
Paolo Bonzini (9):
  scsi, file-posix: add support for persistent reservation management
  scsi: build qemu-pr-helper
  scsi: add multipath support to qemu-pr-helper
  scsi: add persistent reservation manager using qemu-pr-helper

 Makefile                   |   14 +-
 configure                  |   59 ++-
 docs/interop/pr-helper.rst |   83 ++++
 docs/pr-manager.rst        |   60 +++
 include/scsi/utils.h       |    4 +
 scsi/Makefile.objs         |    2 +-
 scsi/pr-helper.h           |   41 ++
 scsi/pr-manager-helper.c   |  302 +++++++++++++
 scsi/qemu-pr-helper.c      | 1038 ++++++++++++++++++++++++++++++++++++++++++++
 scsi/utils.c               |   10 +
 10 files changed, 1607 insertions(+), 6 deletions(-)

-- 
2.13.5
