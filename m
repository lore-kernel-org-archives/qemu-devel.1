Received: from eggs.gnu.org ([2001:4830:134:3::10]:35175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTBrz-00017x-Hs
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTBrw-0007HH-FE
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:51:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dTBrw-0007Gd-5R
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:51:16 -0400
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-6-marcandre.lureau@redhat.com>
	<72817738-deb5-f64e-7247-89dbdf10ddbd@redhat.com>
	<CAJ+F1C+um2ep_SF-jWxmLH2PRhCQhcv9LPFW3RyXoCcs=GVh7A@mail.gmail.com>
	<850987754.33489091.1499364558887.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <be1c5e8a-d57d-cafb-b01c-dfe9eba40d7c@redhat.com>
Date: Thu, 6 Jul 2017 20:51:12 +0200
MIME-Version: 1.0
In-Reply-To: <850987754.33489091.1499364558887.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] kdump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Anderson <anderson@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 07/06/17 20:09, Dave Anderson wrote:
>=20
>=20
> ----- Original Message -----
>> Hi
>>
>> On Thu, Jul 6, 2017 at 7:13 PM, Laszlo Ersek <lersek@redhat.com> wrote=
:
>>> On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
>>>> kdump header provides offset and size of the vmcoreinfo ELF note,
>>>> append it if available.
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>  dump.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/dump.c b/dump.c
>>>> index f699198204..dd416ad271 100644
>>>> --- a/dump.c
>>>> +++ b/dump.c
>>>> @@ -839,6 +839,16 @@ static void create_header32(DumpState *s, Error
>>>> **errp)
>>>>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
>>>>
>>>>      offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
>>>> +    if (s->vmcoreinfo) {
>>>> +        uint64_t hsize, name_size, size_vmcoreinfo_desc,
>>>> offset_vmcoreinfo;
>>>> +
>>>> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size,
>>>> &size_vmcoreinfo_desc);
>>>> +        offset_vmcoreinfo =3D offset_note + s->note_size -
>>>> s->vmcoreinfo_size +
>>>> +            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) *=
 4;
>>>> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinf=
o);
>>>> +        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo_de=
sc);
>>>> +    }
>>>> +
>>>>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>>>>      kh->note_size =3D cpu_to_dump32(s, s->note_size);
>>>>
>>>> @@ -939,6 +949,16 @@ static void create_header64(DumpState *s, Error
>>>> **errp)
>>>>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
>>>>
>>>>      offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
>>>> +    if (s->vmcoreinfo) {
>>>> +        uint64_t hsize, name_size, size_vmcoreinfo_desc,
>>>> offset_vmcoreinfo;
>>>> +
>>>> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size,
>>>> &size_vmcoreinfo_desc);
>>>> +        offset_vmcoreinfo =3D offset_note + s->note_size -
>>>> s->vmcoreinfo_size +
>>>> +            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) *=
 4;
>>>> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinf=
o);
>>>> +        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo_de=
sc);
>>>> +    }
>>>> +
>>>>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>>>>      kh->note_size =3D cpu_to_dump64(s, s->note_size);
>>>>
>>>>
>>>
>>> I continue to think that this patch is unnecessary, but if you insist=
,
>=20
>>> it does look OK to me.
>>>
>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>
>> Without it, crash doesn't read the vmcoreinfo PT_NOTE. And for some
>> reason, the phys_base in the header wasn't enough (to be doubled
>> checked).
>>
>> Any comment Dave about crash handling of vmcoreinfo in kdump files?
>=20
> It just reads the kdump_sub_header's offset_vmcoreinfo and size_vmcorei=
nfo
> fields to gather the vmcoreinfo data into a local buffer of memory, and
> scans the strings for whatever it's looking for.=20
>=20
> With respect to phys_base, the only thing that might be of consequence
> is this fairly recent change that's currently only in the github repo,
> queued for crash-7.2.0:
>=20
>   commit a4a538caca140a8e948bbdae2be311168db7a1eb
>   Author: Dave Anderson <anderson@redhat.com>
>   Date:   Tue May 2 16:51:53 2017 -0400
>=20
>     Fix for Linux 4.10 and later kdump dumpfiles, or kernels that have
>     backported commit 401721ecd1dcb0a428aa5d6832ee05ffbdbffbbe, titled
>     "kexec: export the value of phys_base instead of symbol address".
>     Without the patch, if the x86_64 "phys_base" value in the VMCOREINF=
O
>     note is a negative decimal number, the crash session fails during
>     session intialization with a "page excluded" or "seek error" when
>     reading "page_offset_base".
>     (anderson@redhat.com)
>=20
> Also, crash-7.1.9 was the first version that started looking in the=20
> vmcoreinfo data for phys_base instead of in the kdump_sub_header.

OK, if crash (or earlier versions of crash) need this QEMU patch, then
I'm fine with it -- my R-b stands.

Thanks
Laszlo
