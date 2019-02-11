Received: from eggs.gnu.org ([209.51.188.92]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gt9hy-0007eW-4p
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gt9hw-0002Ph-0C
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:25:06 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:40059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gt9hv-0002L6-1s
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:25:03 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Date: Mon, 11 Feb 2019 14:24:53 +0300
Message-Id: <2060301549884293@sas2-76706d252d16.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

Ping

04.02.2019, 16:27, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Hi,
>
> The series adds a migration capability, which allows to skip shared RAM=
 blocks
> during the migration. It's useful for fast local migration. E.g. to upd=
ate QEMU
> for the running guests.
>
> Usage example:
> 1. Start source VM:
> =C2=A0=C2=A0=C2=A0qemu-system-x86 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-m 4G \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-object memory-backend-file,id=3Dmem0,siz=
e=3D4G,share=3Don,mem-path=3D/dev/shm/mem0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-qmp unix:/tmp/qemu-qmp-1.sock,server,now=
ait \
>
> 2. Start target VM:
> =C2=A0=C2=A0=C2=A0qemu-system-x86 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-m 4G \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-object memory-backend-file,id=3Dmem0,siz=
e=3D4G,share=3Don,mem-path=3D/dev/shm/mem0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,memdev=3Dmem0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-qmp unix:/tmp/qemu-qmp-2.sock,server,now=
ait \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-incoming defer
>
> 3. Enable ignore-external capability on both VMs:
> =C2=A0=C2=A0=C2=A0{ "execute": "migrate-set-capabilities" , "arguments"=
:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "capabilities": [ { "capability": "x-ig=
nore-external", "state": true } ] } }
>
> 4. Start migration.
>
> Another use case I keep in mind is to migrate to file. Usage is very si=
milar.
>
> V1 to V2:
> * Keep migration stream compatibility
> * Reuse the existing code to ignore unwanted RAMBlocks
> * Add capability validation feature
> * ignore-external -> ignore-shared
>
> Regards,
> Yury
>
> Yury Kotov (5):
> =C2=A0=C2=A0exec: Change RAMBlockIterFunc definition
> =C2=A0=C2=A0migration: Move qemu_ram_foreach_migratable_block to migrat=
ion code
> =C2=A0=C2=A0migration: Introduce ignore-shared capability
> =C2=A0=C2=A0tests/migration-test: Add a test for ignore-shared capabili=
ty
> =C2=A0=C2=A0migration: Add capabilities validation
>
> =C2=A0exec.c | 38 ++++++-------
> =C2=A0include/exec/cpu-common.h | 7 +--
> =C2=A0migration/migration.c | 9 ++++
> =C2=A0migration/migration.h | 11 +++-
> =C2=A0migration/postcopy-ram.c | 48 +++++++++--------
> =C2=A0migration/ram.c | 86 ++++++++++++++++++++++++++----
> =C2=A0migration/rdma.c | 9 ++--
> =C2=A0migration/savevm.c | 101 +++++++++++++++++++++++++++++++++++
> =C2=A0qapi/migration.json | 5 +-
> =C2=A0stubs/ram-block.c | 15 ++++++
> =C2=A0tests/migration-test.c | 109 +++++++++++++++++++++++++++++++-----=
--
> =C2=A0util/vfio-helpers.c | 6 +--
> =C2=A012 files changed, 361 insertions(+), 83 deletions(-)
>
> --
> 2.20.1
