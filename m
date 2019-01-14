Received: from eggs.gnu.org ([209.51.188.92]:42492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gj4Cn-0006N8-DT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gj4Ci-0001lh-NC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:31:10 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:45645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gj4Ch-0001hn-TU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:31:08 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190111205516.GR4500@habkost.net>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110201124.GJ2589@work-vm>
	<2578541547221793@myt5-68ad52a76c91.qloud-c.yandex.net>
	<20190111205516.GR4500@habkost.net>
MIME-Version: 1.0
Date: Mon, 14 Jan 2019 18:31:03 +0300
Message-Id: <2934041547479863@iva5-815ce03d682b.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>

11.01.2019, 23:55, "Eduardo Habkost" <ehabkost@redhat.com>:
> On Fri, Jan 11, 2019 at 06:49:53PM +0300, Yury Kotov wrote:
>> =C2=A010.01.2019, 23:12, "Dr. David Alan Gilbert" <dgilbert@redhat.com=
>:
>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0>> Hi,
>> =C2=A0>>
>> =C2=A0>> The series adds migration capability which allows to skip 'ex=
ternal' RAM blocks
>> =C2=A0>> during migration. External block is a RAMBlock which availabl=
e from the outside
>> =C2=A0>> of current QEMU process (e.g. file in /dev/shm). It's useful =
for fast local
>> =C2=A0>> migration to update QEMU for the running guests.
>> =C2=A0>
>> =C2=A0> Hi Yury,
>> =C2=A0> There have been a few similar patch series around from people =
wanting
>> =C2=A0> to do similar things.
>> =C2=A0> In particular Lai Jiangshan's https://lists.nongnu.org/archive=
/html/qemu-devel/2018-03/msg07511.html
>> =C2=A0> and C=C3=A9dric Le Goater wanted to skip regions for a differe=
nt reason.
>> =C2=A0>
>> =C2=A0> We merged some of C=C3=A9dric's code last year so that we now
>> =C2=A0> have the qemu_ram_is_migratable() function - and we should be =
reusing
>> =C2=A0> that to skip things rather than adding a new check that we hav=
e to add
>> =C2=A0> everywhere.
>> =C2=A0>
>>
>> =C2=A0I didn't see the series, so I'll check it, thanks!
>> =C2=A0But I saw qemu_ram_is_migratable() function and corresponding pa=
tch.
>> =C2=A0It's very close to my needs, but it works a bit different IIUC:
>> =C2=A01. Not migratable blocks isn't validated (existence and size) du=
ring migration,
>> =C2=A02. "Migratable" state is determined during the block creation ti=
me.
>> =C2=A0=C2=A0=C2=A0=C2=A0Such case isn't valid because of it:
>> =C2=A0=C2=A0=C2=A0=C2=A0* Source has one migratable and one not migrat=
able RAM blocks,
>> =C2=A0=C2=A0=C2=A0=C2=A0* Target has the same (idstr) blocks, but both=
 are not migratable.
>> =C2=A0=C2=A0=C2=A0=C2=A0Thus, target will not expect pages for not mig=
ratable blocks.
>>
>> =C2=A0> Also, ypu're skipping 'external' things, I think the other sug=
gestion
>> =C2=A0> was to skip 'shared' things (i.e. anything with share=3D0); sk=
ipping
>> =C2=A0> share=3Don cases sounds easier to me.
>>
>> =C2=A0I agree that introducing new term is a complication, but 'share'=
 and 'external'
>> =C2=A0terms have important differences (I'll describe it below).
>>
>> =C2=A0Just to clarify:
>> =C2=A0* 'share' means that other processes has an access to such memor=
y,
>> =C2=A0* 'external' means file backed memory.
>
> If you use file backed memory with share=3Doff, writes are not
> propagated to the file (they are mapped with MAP_PRIVATE). Would
> you really want to skip file backed memory if it has share=3Doff?
>

Yes, you're right. I was sure it would work, but share=3Don is also neede=
d in
my case.

>> =C2=A0There is another use case I wanted to support (I had to write ab=
out it in
>> =C2=A0the cover letter, sorry..):
>> =C2=A01. Migrate source VM to file and kill source,
>> =C2=A02. Start target VM and migrate it from file.
>> =C2=A0In such case source VM may have memory-backend-ram with share=3D=
off, it's ok.
>>
>> =C2=A0Thus, in the new migration capability I want to migrate memory t=
hat meets
>> =C2=A0three conditions:
>> =C2=A01. The source will not use the memory after migration ends,
>> =C2=A02. The source may exit before target starts (migrate to file),
>> =C2=A03. The target has an access to the memory.
>>
>> =C2=A0I think 'external' fits them better than 'share'.
>
> In either case, defining "external" seems tricky. A memory
> region might be backed by a file on tmpfs or hugetlbfs that was
> deleted, which makes the file "internal" for practical purposes.
> QEMU has no way to tell if (3) is really true.
>
> --
> Eduardo

Agree. Perhaps the best is a separate flag, as suggested by Dave.

Regards,
Yury
