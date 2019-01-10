Received: from eggs.gnu.org ([209.51.188.92]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghgg0-0001i8-2L
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghgfy-0005lT-Qj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ghgfy-0005ej-JJ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:11:38 -0500
Date: Thu, 10 Jan 2019 20:11:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190110201124.GJ2589@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, wrfsh@yandex-team.ru

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi,
>=20
> The series adds migration capability which allows to skip 'external' RA=
M blocks
> during migration. External block is a RAMBlock which available from the=
 outside
> of current QEMU process (e.g. file in /dev/shm). It's useful for fast l=
ocal
> migration to update QEMU for the running guests.

Hi Yury,
  There have been a few similar patch series around from people wanting
to do similar things.
  In particular Lai Jiangshan's https://lists.nongnu.org/archive/html/qem=
u-devel/2018-03/msg07511.html
and C=E9dric Le Goater wanted to skip regions for a different reason.

  We merged some of C=E9dric's code last year so that we now
have the qemu_ram_is_migratable() function - and we should be reusing
that to skip things rather than adding a new check that we have to add
everywhere.

  Also, ypu're skipping 'external' things, I think the other suggestion
was to skip 'shared' things (i.e. anything with share=3D0); skipping
share=3Don cases sounds easier to me.

Dave

> Patches:
> 1. Add offset validation to make sure that external RAM block has the s=
ame
>    physical offset on target side,
> 2. Add RAM_EXTERNAL flag to determine external RAM blocks,
> 3. Add ignore-external migration capability,
> 4. Add a test.
>=20
> Usage example:
> 1. Start source VM:
>    qemu-system-x86 \
>      -m 4G \
>      -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem-pat=
h=3D/dev/shm/mem0 \
>      -numa node,memdev=3Dmem0 \
>      -qmp unix:/tmp/qemu-qmp-1.sock,server,nowait \
>=20
> 2. Start target VM:
>    qemu-system-x86 \
>      -m 4G \
>      -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem-pat=
h=3D/dev/shm/mem0 \
>      -numa node,memdev=3Dmem0 \
>      -qmp unix:/tmp/qemu-qmp-2.sock,server,nowait \
>      -incoming defer
>=20
> 3. Enable ignore-external capability on both VMs:
>    { "execute": "migrate-set-capabilities" , "arguments":
>      { "capabilities": [ { "capability": "x-ignore-external", "state": =
true } ] } }
>=20
> 4. Start migration.
>=20
> Regards,
> Yury
>=20
> Yury Kotov (4):
>   migration: add RAMBlock's offset validation
>   exec: add RAM_EXTERNAL flag to mark non-QEMU allocated blocks
>   migration: introduce ignore-external capability
>   tests/migration-test: Add a test for ignore-external capability
>=20
>  backends/hostmem-file.c   |   3 +-
>  exec.c                    |   7 ++-
>  include/exec/cpu-common.h |   1 +
>  include/exec/memory.h     |   3 ++
>  migration/migration.c     |   9 ++++
>  migration/migration.h     |   1 +
>  migration/ram.c           |  52 ++++++++++++++++--
>  numa.c                    |   4 +-
>  qapi/migration.json       |   6 ++-
>  tests/migration-test.c    | 109 +++++++++++++++++++++++++++++++-------
>  10 files changed, 165 insertions(+), 30 deletions(-)
>=20
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
