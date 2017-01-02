Received: from eggs.gnu.org ([2001:4830:134:3::10]:41679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cO4nE-0001TC-W4
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cO4n9-0001EI-OT
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cO4n9-0001Co-IJ
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:44:55 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Jan 2017 16:44:47 +0100
Message-Id: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] fix query-memdev not repporting IDs of
 memory backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, afaerber@suse.de

Series is a couple of preparratory cleanups which simplify fix
and a fix itself.

Before fix HMP 'info memdevs' for CLI:
qemu-system-x86_64 -object memory-backend-ram,id=mem0,size=1G
outputs:

  memory backend: 0
    size:  1073741824
    merge: true
    dump: true
    prealloc: false
    policy: default
    host nodes: 128

after fix:

  memory backend: mem0
    size:  1073741824
    merge: true
    dump: true
    prealloc: false
    policy: default
    host nodes: 128

it should help to avoid remembering hotplugged IDs as they
could be queried back via HMP/QMP interface.

CC: ehabkost@redhat.com
CC: armbru@redhat.com
CC: dgilbert@redhat.com
CC: eblake@redhat.com
CC: afaerber@suse.de

Igor Mammedov (3):
  cleanup: remove not used header
  reuse user_creatable_add_opts() instead of user_creatable_add() in
    monitor
  fix qmp/hmp query-memdev not repporting IDs of memory backends

 include/qom/object_interfaces.h | 19 +---------
 include/sysemu/hostmem.h        |  1 +
 backends/hostmem.c              | 26 ++++++++++++++
 docs/qmp-commands.txt           |  1 +
 hmp.c                           | 10 ++----
 numa.c                          |  3 ++
 qapi-schema.json                |  3 ++
 qom/object_interfaces.c         | 78 ++++++++++++-----------------------------
 8 files changed, 59 insertions(+), 82 deletions(-)

-- 
2.7.4
