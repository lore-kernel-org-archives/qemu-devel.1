Received: from eggs.gnu.org ([209.51.188.92]:49485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1r-0001H9-D6
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1l-000061-6x
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:43 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:58902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1ghZ1k-0008SD-AS
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:37 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 10 Jan 2019 15:01:16 +0300
Message-Id: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/4] Add ignore-external migration capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: wrfsh@yandex-team.ru

Hi,

The series adds migration capability which allows to skip 'external' RAM =
blocks
during migration. External block is a RAMBlock which available from the o=
utside
of current QEMU process (e.g. file in /dev/shm). It's useful for fast loc=
al
migration to update QEMU for the running guests.

Patches:
1. Add offset validation to make sure that external RAM block has the sam=
e
   physical offset on target side,
2. Add RAM_EXTERNAL flag to determine external RAM blocks,
3. Add ignore-external migration capability,
4. Add a test.

Usage example:
1. Start source VM:
   qemu-system-x86 \
     -m 4G \
     -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem-path=3D=
/dev/shm/mem0 \
     -numa node,memdev=3Dmem0 \
     -qmp unix:/tmp/qemu-qmp-1.sock,server,nowait \

2. Start target VM:
   qemu-system-x86 \
     -m 4G \
     -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem-path=3D=
/dev/shm/mem0 \
     -numa node,memdev=3Dmem0 \
     -qmp unix:/tmp/qemu-qmp-2.sock,server,nowait \
     -incoming defer

3. Enable ignore-external capability on both VMs:
   { "execute": "migrate-set-capabilities" , "arguments":
     { "capabilities": [ { "capability": "x-ignore-external", "state": tr=
ue } ] } }

4. Start migration.

Regards,
Yury

Yury Kotov (4):
  migration: add RAMBlock's offset validation
  exec: add RAM_EXTERNAL flag to mark non-QEMU allocated blocks
  migration: introduce ignore-external capability
  tests/migration-test: Add a test for ignore-external capability

 backends/hostmem-file.c   |   3 +-
 exec.c                    |   7 ++-
 include/exec/cpu-common.h |   1 +
 include/exec/memory.h     |   3 ++
 migration/migration.c     |   9 ++++
 migration/migration.h     |   1 +
 migration/ram.c           |  52 ++++++++++++++++--
 numa.c                    |   4 +-
 qapi/migration.json       |   6 ++-
 tests/migration-test.c    | 109 +++++++++++++++++++++++++++++++-------
 10 files changed, 165 insertions(+), 30 deletions(-)

--=20
2.20.1
