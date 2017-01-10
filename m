Received: from eggs.gnu.org ([2001:4830:134:3::10]:60079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQvvX-0007cw-2l
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cQvvT-0003tY-80
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:53:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cQvvT-0003tS-1Z
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:53:19 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 10 Jan 2017 13:53:12 +0100
Message-Id: <1484052795-158195-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] fix query-memdev not repporting IDs of
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
Cc: ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, afaerber@suse.de, pbonzini@redhat.com


Changelog:
    since v1:
        * fix mistakes in commit messages/change them as suggested
        * extend 3/3 commit message to explain why it's ok to use 'id'
        * 3/3 set 'id' property directly instead of injecting it back
          into qdict.


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
CC: pbonzini@redhat.com

Igor Mammedov (3):
  qom: remove unused header
  reuse user_creatable_add_opts() instead of user_creatable_add() in
    monitor
  fix qmp/hmp query-memdev not reporting IDs of memory backends

 include/qom/object_interfaces.h | 17 ---------
 include/sysemu/hostmem.h        |  1 +
 backends/hostmem.c              | 26 ++++++++++++++
 docs/qmp-commands.txt           |  1 +
 hmp.c                           | 10 ++----
 numa.c                          |  3 ++
 qapi-schema.json                |  3 ++
 qom/object_interfaces.c         | 78 ++++++++++++-----------------------------
 8 files changed, 59 insertions(+), 80 deletions(-)

-- 
2.7.4
