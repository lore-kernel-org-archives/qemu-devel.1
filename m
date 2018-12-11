Received: from eggs.gnu.org ([2001:4830:134:3::10]:35649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gWful-0003IM-OC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gWfuh-0002Rt-ON
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:09:23 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gWfuf-0002OV-Hn
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:09:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20181211110913euoutp02c0c7754ce21d84e5adb2334d6649e8d3~vQresLvOe2344023440euoutp028
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:09:13 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
Date: Tue, 11 Dec 2018 14:09:11 +0300
MIME-Version: 1.0
In-Reply-To: <20181211105329.GE921@redhat.com>
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181211105329.GE921@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11.12.2018 13:53, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Nov 27, 2018 at 04:50:27PM +0300, Ilya Maximets wrote:
>> If seals are not supported, memfd_create() will fail.
>> Furthermore, there is no way to disable it in this case because
>> '.seal' property is not registered.
>=20
> Isn't the real problem here that memfd_backend_instance_init() has
> unconditionally set  "m->seal =3D true"
>=20
> Surely, if we don't register the '.seal' property, we should default
> that flag to false.
>=20
>>
>> This issue leads to vhost-user-test failures on RHEL 7.2:
>>
>>   qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=3D2M,=
: \
>>                       failed to create memfd: Invalid argument
>>
>> and actually breaks the feature on such systems.
>>
>> Let's restrict memfd backend to systems with sealing support.
>=20
> I don't think we need todo that - sealing is optional in the QEMU code,
> we simply have it set to the wrong default when sealing is not availabl=
e.

That was literally what I've fixed in v1:
    https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg05483.htm=
l

but 2 people suggested me to disable memfd entirely for this case.
Do you think I need to get patch from v1 back ?

Gerd, Marc-Andr=C3=A9, what do you think?

>=20
>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>=20
>=20
> Regards,
> Daniel
>=20
