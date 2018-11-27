Received: from eggs.gnu.org ([2001:4830:134:3::10]:37412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbvk-0006wP-IN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:53:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gRbvg-0001Hh-JR
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:53:28 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gRbvg-0001HB-6h
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:53:24 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181127115322euoutp01bd0b3efb2c25732b4aff560f6cf5f438~q_QBhaYKV2357823578euoutp01H
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 11:53:22 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <78f31962-8d54-19c1-e8fb-c21f95a491f0@samsung.com>
Date: Tue, 27 Nov 2018 14:53:15 +0300
MIME-Version: 1.0
In-Reply-To: <CAMxuvay-6X2g1k8TbJR1NAW=Gb_tARb-wbr7H2RRoF9x+-F+aw@mail.gmail.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
References: <CGME20181127111109eucas1p2b1eae35e38e46c3f76c86a350ed41926@eucas1p2.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-2-i.maximets@samsung.com>
	<CAMxuvay-6X2g1k8TbJR1NAW=Gb_tARb-wbr7H2RRoF9x+-F+aw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] hostmem-memfd: enable seals only if
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 27.11.2018 14:49, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Tue, Nov 27, 2018 at 3:11 PM Ilya Maximets <i.maximets@samsung.com> =
wrote:
>>
>> If seals are not supported, memfd_create() will fail.
>> Furthermore, there is no way to disable it in this case because
>> '.seal' property is not registered.
>>
>> This issue leads to vhost-user-test failures on RHEL 7.2:
>>
>>   qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=3D2M,=
: \
>>                       failed to create memfd: Invalid argument
>>
>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>=20
>=20
> This will change the default behaviour of memfd backend, and may thus
> me considered a break.

This will change the default behaviour only on systems without sealing
support. But current implementation is broken there anyway and does not
work.

>=20
> Instead, memfd vhost-user-test should skipped (or tuned with
> sealed=3Dfalse if unsupported)

vhost-user-test is just an example here. In fact memfd could not be
used at all on system without sealing support. And there is no way
to disable seals.

>=20
>> ---
>>  backends/hostmem-memfd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
>> index b6836b28e5..ee39bdbde6 100644
>> --- a/backends/hostmem-memfd.c
>> +++ b/backends/hostmem-memfd.c
>> @@ -129,8 +129,8 @@ memfd_backend_instance_init(Object *obj)
>>  {
>>      HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
>>
>> -    /* default to sealed file */
>> -    m->seal =3D true;
>> +    /* default to sealed file if supported */
>> +    m->seal =3D qemu_memfd_check(MFD_ALLOW_SEALING);
>>  }
>>
>>  static void
>> --
>> 2.17.1
>>
>=20
>=20
