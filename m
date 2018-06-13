Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fT4ee-0006ES-U2
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1fT4ed-0004r7-OI
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:13:36 -0400
Message-Id: <5B210A66020000480007D5B8@prv-mh.provo.novell.com>
Date: Wed, 13 Jun 2018 06:13:26 -0600
From: "Bruce Rogers" <brogers@suse.com>
References: <20180612235103.12633-1-brogers@suse.com>
	<20180612235103.12633-2-brogers@suse.com>
	<20180613114602.GC2165@perard.uk.xensource.com>
In-Reply-To: <20180613114602.GC2165@perard.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH 1/2] xen: add xen disk naming for use in
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anthony.perard@citrix.com
Cc: sstabellini@kernel.org, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>

>>> On 6/13/2018 at 5:46 AM, Anthony PERARD <anthony.perard@citrix.com> =
wrote:
> On Tue, Jun 12, 2018 at 05:51:02PM =E2=80=910600, Bruce Rogers wrote:
>> Provide monitor naming of xen disks, including associating an
>> attached dev_id for a BlockBackend which has legacy_dev set.
>> Currently, only xen disks have legacy_dev set to true.
>>=20
>> Signed=E2=80=91off=E2=80=91by: Bruce Rogers <brogers@suse.com>
>> =E2=80=91=E2=80=91=E2=80=91
>>  block/block=E2=80=91backend.c |  5 ++++=E2=80=91
>>  hw/block/xen_disk.c   | 15 +++++++++++++++
>>  include/hw/xen/xen.h  |  2 ++
>>  stubs/xen=E2=80=91common.c    |  5 +++++
>>  4 files changed, 26 insertions(+), 1 deletion(=E2=80=91)
>>=20
>> diff =E2=80=91=E2=80=91git a/block/block=E2=80=91backend.c b/block/block=
=E2=80=91backend.c
>> index d55c328736..db39dfe867 100644
>> =E2=80=91=E2=80=91=E2=80=91 a/block/block=E2=80=91backend.c
>> +++ b/block/block=E2=80=91backend.c
>> @@ =E2=80=9123,6 +23,7 @@
>>  #include "qemu/option.h"
>>  #include "trace.h"
>>  #include "migration/misc.h"
>> +#include "hw/xen/xen.h"
>> =20
>>  /* Number of coroutines to reserve per attached device model */
>>  #define COROUTINE_POOL_RESERVATION 64
>> @@ =E2=80=91895,7 +896,9 @@ char *blk_get_attached_dev_id(BlockBackend =
*blk)
>>  {
>>      DeviceState *dev;
>> =20
>> =E2=80=91    assert(!blk=E2=80=91>legacy_dev);
>> +    if (blk=E2=80=91>legacy_dev) {
>> +        return xen_blk_get_attached_dev_id(blk=E2=80=91>dev);
>> +    }
>>      dev =3D blk=E2=80=91>dev;
>> =20
>>      if (!dev) {
>=20
> Hi Bruce,
>=20
> Thanks for your patches!
>=20
> But I don't think that the right way to go. We probably needs to
> qdevifie xen_disk instead. This is point out by the numerous TODO about
> "qdevified", and this very old mail:
> https://lists.nongnu.org/archive/html/qemu=E2=80=91devel/2016=E2=80=9109/=
msg07902.html=20

Understood. These patches come from an effort to provide this functionality=

to older qemu releases that SUSE supports. I didn't try to work on a =
qdevify type
solution, as I figured if the block experts hadn't done that yet, I would =
probably
not be too successful myself.
>From what I can see, the xen support in qemu is not well integrated in =
general,
so my patches here are implemented in that "spirit" - not elegant, but =
getting the
job done. I'd certainly rather see good integration of the xen model into =
qemu,
and if that is the right way forward to get this type of functionality, =
I'd be happy
with that approach as well.

Bruce
