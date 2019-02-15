Received: from eggs.gnu.org ([209.51.188.92]:44063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYy-000646-Su
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYx-0002Gz-VN
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:12 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:40724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1guhYx-0002En-2a
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:11 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 15 Feb 2019 20:45:43 +0300
Message-Id: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] Add ignore-external migration capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

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

3. Enable ignore-shared capability on both VMs:
   { "execute": "migrate-set-capabilities" , "arguments":
     { "capabilities": [ { "capability": "x-ignore-shared", "state": true=
 } ] } }

4. Start migration.

Another use case I keep in mind is to migrate to file. Usage is very simi=
lar.

V2 to V3:
* Split "migration: Introduce ignore-shared capability"
* Serialize the capabilities as strings rather than as indexes
* Don't allow to enable postcopy and ignore-shared together
* Skip the test for OSs which don't have /dev/shm
* Add a check whether shared RAM has been really skipped

V1 to V2:
* Keep migration stream compatibility
* Reuse the existing code to ignore unwanted RAMBlocks
* Add capability validation feature
* ignore-external -> ignore-shared

Regards,
Yury

Yury Kotov (5):
  exec: Change RAMBlockIterFunc definition
  migration: Introduce ignore-shared capability
  migration: Add an ability to ignore shared RAM blocks
  tests/migration-test: Add a test for ignore-shared capability
  migration: Add capabilities validation

 exec.c                    |  38 +++++------
 include/exec/cpu-common.h |   7 +-
 migration/migration.c     |  14 ++++
 migration/migration.h     |   5 +-
 migration/postcopy-ram.c  |  48 +++++++------
 migration/ram.c           | 110 ++++++++++++++++++++++--------
 migration/rdma.c          |   9 ++-
 migration/savevm.c        | 137 ++++++++++++++++++++++++++++++++++++++
 qapi/migration.json       |   5 +-
 stubs/ram-block.c         |  15 +++++
 tests/migration-test.c    | 131 +++++++++++++++++++++++++++++-------
 util/vfio-helpers.c       |   6 +-
 12 files changed, 420 insertions(+), 105 deletions(-)

--=20
2.20.1
