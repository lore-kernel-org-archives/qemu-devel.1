Received: from eggs.gnu.org ([2001:4830:134:3::10]:43404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdAlG-0001pP-W4
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cdAlD-0008GD-Ps
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:22 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:9020 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cdAlD-0008G2-E8
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 02:09:19 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 13 Feb 2017 10:08:59 +0300
Message-Id: <1486969742-16539-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH v3 0/3] kvm: report available guest crash
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Windows reports BSOD parameters through Hyper-V crash MSRs. This
information is very useful for initial crash analysis and thus
it would be nice to see it in the QEMU log file. There is suitable
log mask for the purpose.

Linux guest does not provide this information, but still it would
be nice to log that we have crashed.

Changes from v2:
- fixed PPC compilation

Changes since v1:
- patches resplit
- created property to query crash parameters
- crash parameters added to panic event

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Marcelo Tosatti <mtosatti@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>

Anton Nefedov (3):
  i386/cpu: add crash-information QOM property
  report guest crash information in GUEST_PANICKED event
  vl: log available guest crash information

 hw/misc/pvpanic.c       |  2 +-
 hw/ppc/spapr_rtas.c     |  3 ++-
 include/qom/cpu.h       | 10 +++++++++
 include/sysemu/kvm.h    |  2 ++
 include/sysemu/sysemu.h |  2 +-
 kvm-all.c               |  3 ++-
 qapi-schema.json        | 24 +++++++++++++++++++++
 qapi/event.json         |  6 ++++--
 qom/cpu.c               | 11 ++++++++++
 stubs/Makefile.objs     |  1 +
 stubs/kvm-crash.c       |  8 +++++++
 target/i386/cpu.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h       |  3 +++
 target/i386/kvm.c       | 41 ++++++++++++++++++++++++++++++++++++
 target/s390x/kvm.c      |  4 ++--
 vl.c                    | 23 ++++++++++++++++++---
 16 files changed, 187 insertions(+), 11 deletions(-)
 create mode 100644 stubs/kvm-crash.c

-- 
2.7.4
