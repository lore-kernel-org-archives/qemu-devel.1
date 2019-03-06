Received: from eggs.gnu.org ([209.51.188.92]:59432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1h1U5g-0002rk-Lu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1h1U5e-0003ik-3n
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:48:00 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:56692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1h1U5d-0003dT-CB
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:47:58 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190305180635.GA3803@work-vm>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
	<20190305140536.GD9811@work-vm> <20190305180635.GA3803@work-vm>
MIME-Version: 1.0
Date: Wed, 06 Mar 2019 13:47:53 +0300
Message-Id: <1110151551869273@myt5-68ad52a76c91.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Add ignore-external migration
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>, "qemu-devel@lists.ewheeler.net" <qemu-devel@lists.ewheeler.net>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

05.03.2019, 21:06, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> =C2=A0* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0> Hi,
>> =C2=A0>
>> =C2=A0> The series adds a migration capability, which allows to skip s=
hared RAM blocks
>> =C2=A0> during the migration. It's useful for fast local migration. E.=
g. to update QEMU
>> =C2=A0> for the running guests.
>>
>> =C2=A0Queued
>
> Hi Yury,
> =C2=A0=C2=A0The test is failing badly on aarch64 tcg for me (i.e. aarch=
64 tcg on
> x86); I'm going to keep it merged but keep the test disabled for now.
> Can you have a look to see if you can see what's going wrong?
>
> Dave
>

Hi,

Yes, of course. I'll look at this.

Regards,
Yury

>> =C2=A0>
>> =C2=A0> Usage example:
>> =C2=A0> 1. Start source VM:
>> =C2=A0> qemu-system-x86 \
>> =C2=A0> -m 4G \
>> =C2=A0> -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem=
-path=3D/dev/shm/mem0 \
>> =C2=A0> -numa node,memdev=3Dmem0 \
>> =C2=A0> -qmp unix:/tmp/qemu-qmp-1.sock,server,nowait \
>> =C2=A0>
>> =C2=A0> 2. Start target VM:
>> =C2=A0> qemu-system-x86 \
>> =C2=A0> -m 4G \
>> =C2=A0> -object memory-backend-file,id=3Dmem0,size=3D4G,share=3Don,mem=
-path=3D/dev/shm/mem0 \
>> =C2=A0> -numa node,memdev=3Dmem0 \
>> =C2=A0> -qmp unix:/tmp/qemu-qmp-2.sock,server,nowait \
>> =C2=A0> -incoming defer
>> =C2=A0>
>> =C2=A0> 3. Enable ignore-shared capability on both VMs:
>> =C2=A0> { "execute": "migrate-set-capabilities" , "arguments":
>> =C2=A0> { "capabilities": [ { "capability": "x-ignore-shared", "state"=
: true } ] } }
>> =C2=A0>
>> =C2=A0> 4. Start migration.
>> =C2=A0>
>> =C2=A0> Another use case I keep in mind is to migrate to file. Usage i=
s very similar.
>> =C2=A0>
>> =C2=A0> V2 to V3:
>> =C2=A0> * Split "migration: Introduce ignore-shared capability"
>> =C2=A0> * Serialize the capabilities as strings rather than as indexes
>> =C2=A0> * Don't allow to enable postcopy and ignore-shared together
>> =C2=A0> * Skip the test for OSs which don't have /dev/shm
>> =C2=A0> * Add a check whether shared RAM has been really skipped
>> =C2=A0>
>> =C2=A0> V1 to V2:
>> =C2=A0> * Keep migration stream compatibility
>> =C2=A0> * Reuse the existing code to ignore unwanted RAMBlocks
>> =C2=A0> * Add capability validation feature
>> =C2=A0> * ignore-external -> ignore-shared
>> =C2=A0>
>> =C2=A0> Regards,
>> =C2=A0> Yury
>> =C2=A0>
>> =C2=A0> Yury Kotov (5):
>> =C2=A0> exec: Change RAMBlockIterFunc definition
>> =C2=A0> migration: Introduce ignore-shared capability
>> =C2=A0> migration: Add an ability to ignore shared RAM blocks
>> =C2=A0> tests/migration-test: Add a test for ignore-shared capability
>> =C2=A0> migration: Add capabilities validation
>> =C2=A0>
>> =C2=A0> exec.c | 38 +++++------
>> =C2=A0> include/exec/cpu-common.h | 7 +-
>> =C2=A0> migration/migration.c | 14 ++++
>> =C2=A0> migration/migration.h | 5 +-
>> =C2=A0> migration/postcopy-ram.c | 48 +++++++------
>> =C2=A0> migration/ram.c | 110 ++++++++++++++++++++++--------
>> =C2=A0> migration/rdma.c | 9 ++-
>> =C2=A0> migration/savevm.c | 137 +++++++++++++++++++++++++++++++++++++=
+
>> =C2=A0> qapi/migration.json | 5 +-
>> =C2=A0> stubs/ram-block.c | 15 +++++
>> =C2=A0> tests/migration-test.c | 131 +++++++++++++++++++++++++++++----=
---
>> =C2=A0> util/vfio-helpers.c | 6 +-
>> =C2=A0> 12 files changed, 420 insertions(+), 105 deletions(-)
>> =C2=A0>
>> =C2=A0> --
>> =C2=A0> 2.20.1
>> =C2=A0>
>> =C2=A0>
>> =C2=A0--
>> =C2=A0Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
