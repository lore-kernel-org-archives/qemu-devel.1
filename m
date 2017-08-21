Received: from eggs.gnu.org ([2001:4830:134:3::10]:36403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djmNx-0000V6-MD
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djmNt-0002BF-3i
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:04:53 -0400
References: <20170821103524.22619-1-david@gibson.dropbear.id.au>
	<20170821140919.585cdcc0.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <65cee39c-fa17-4003-af94-59b9590ca857@redhat.com>
Date: Mon, 21 Aug 2017 15:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170821140919.585cdcc0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, berrange@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 21.08.2017 14:09, Cornelia Huck wrote:
> On Mon, 21 Aug 2017 20:35:24 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> From: Thomas Huth <thuth@redhat.com>
>>
>> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
>> machine without specifying its 'memdev' property. This happens because
>> pc_dimm_get_memory_region() does not check whether the 'memdev' proper=
ty
>> has properly been set by the user. Looking closer at this function, it=
's
>> also obvious that it is using &error_abort to call another function - =
and
>> this is bad in a function that is used in the hot-plugging calling cha=
in
>> since this can also cause QEMU to exit unexpectedly.
>>
>> So let's fix these issues in a proper way now: Add a "Error **errp"
>> parameter to pc_dimm_get_memory_region() which we use in case the 'mem=
dev'
>> property has not been set by the user, and which we can use instead of
>> the &error_abort, and change the callers of get_memory_region() to mak=
e
>> use of this "errp" parameter for proper error checking.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/i386/pc.c             | 14 ++++++++++++--
>>  hw/mem/nvdimm.c          |  2 +-
>>  hw/mem/pc-dimm.c         | 14 +++++++++++---
>>  hw/ppc/spapr.c           | 42 ++++++++++++++++++++++++++++++---------=
---
>>  include/hw/mem/pc-dimm.h |  2 +-
>>  5 files changed, 55 insertions(+), 19 deletions(-)
>=20
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index ea67b461c2..bdf6649083 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -363,7 +363,10 @@ static void pc_dimm_get_size(Object *obj, Visitor=
 *v, const char *name,
>>      PCDIMMDevice *dimm =3D PC_DIMM(obj);
>>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(obj);
>> =20
>> -    mr =3D ddc->get_memory_region(dimm);
>> +    mr =3D ddc->get_memory_region(dimm, errp);
>> +    if (!mr) {
>> +        return;
>=20
> What happens if mr =3D=3D NULL, but no error was set (backend memory no=
t
> inited case)?

Looks like this currently never happens=E2=84=A2  ... otherwise someone w=
ould
have experienced a crash in memory_region_size() which derefernces mr.

Anyway, we should eventually modify host_memory_backend_get_memory() to
correctly set the errp in that case. But since this is a slightly
different issue, I think this can go into a separate patch instead... so
I'll sent a separate patch for that later...

 Thomas
