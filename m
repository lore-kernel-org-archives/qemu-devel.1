Received: from eggs.gnu.org ([209.51.188.92]:51512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gqeC6-00011N-EQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gqe1K-00052B-HB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:10:44 -0500
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:35515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gqe1G-00046v-Lr
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:10:40 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Mon,  4 Feb 2019 16:09:54 +0300
Message-Id: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/5] Add ignore-external migration capability
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

The series adds a migration capability, which allows to skip shared RAM b=
locks
during the migration. It's useful for fast local migration. E.g. to updat=
e QEMU
for the running guests.

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

Another use case I keep in mind is to migrate to file. Usage is very simi=
lar.

V1 to V2:
* Keep migration stream compatibility
* Reuse the existing code to ignore unwanted RAMBlocks
* Add capability validation feature
* ignore-external -> ignore-shared

Regards,
Yury

Yury Kotov (5):
  exec: Change RAMBlockIterFunc definition
  migration: Move qemu_ram_foreach_migratable_block to migration code
  migration: Introduce ignore-shared capability
  tests/migration-test: Add a test for ignore-shared capability
  migration: Add capabilities validation

 exec.c                    |  38 ++++++-------
 include/exec/cpu-common.h |   7 +--
 migration/migration.c     |   9 ++++
 migration/migration.h     |  11 +++-
 migration/postcopy-ram.c  |  48 +++++++++--------
 migration/ram.c           |  86 ++++++++++++++++++++++++++----
 migration/rdma.c          |   9 ++--
 migration/savevm.c        | 101 +++++++++++++++++++++++++++++++++++
 qapi/migration.json       |   5 +-
 stubs/ram-block.c         |  15 ++++++
 tests/migration-test.c    | 109 +++++++++++++++++++++++++++++++-------
 util/vfio-helpers.c       |   6 +--
 12 files changed, 361 insertions(+), 83 deletions(-)

--=20
2.20.1
