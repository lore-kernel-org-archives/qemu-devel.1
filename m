Received: from eggs.gnu.org ([2001:4830:134:3::10]:54448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dTASt-00079N-3P
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dTASs-0005Jk-3P
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:21:19 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dTASr-0005Ia-Ri
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:21:18 -0400
Received: by mail-lf0-x244.google.com with SMTP id z78so1285589lff.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 10:21:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <72817738-deb5-f64e-7247-89dbdf10ddbd@redhat.com>
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-6-marcandre.lureau@redhat.com>
	<72817738-deb5-f64e-7247-89dbdf10ddbd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Jul 2017 19:21:15 +0200
Message-ID: <CAJ+F1C+um2ep_SF-jWxmLH2PRhCQhcv9LPFW3RyXoCcs=GVh7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laszlo Ersek <lersek@redhat.com>, Dave Anderson <anderson@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Thu, Jul 6, 2017 at 7:13 PM, Laszlo Ersek <lersek@redhat.com> wrote:
> On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
>> kdump header provides offset and size of the vmcoreinfo ELF note,
>> append it if available.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  dump.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/dump.c b/dump.c
>> index f699198204..dd416ad271 100644
>> --- a/dump.c
>> +++ b/dump.c
>> @@ -839,6 +839,16 @@ static void create_header32(DumpState *s, Error **e=
rrp)
>>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
>>
>>      offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
>> +    if (s->vmcoreinfo) {
>> +        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcorei=
nfo;
>> +
>> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmco=
reinfo_desc);
>> +        offset_vmcoreinfo =3D offset_note + s->note_size - s->vmcoreinf=
o_size +
>> +            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
>> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
>> +        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo_desc);
>> +    }
>> +
>>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>>      kh->note_size =3D cpu_to_dump32(s, s->note_size);
>>
>> @@ -939,6 +949,16 @@ static void create_header64(DumpState *s, Error **e=
rrp)
>>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
>>
>>      offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
>> +    if (s->vmcoreinfo) {
>> +        uint64_t hsize, name_size, size_vmcoreinfo_desc, offset_vmcorei=
nfo;
>> +
>> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmco=
reinfo_desc);
>> +        offset_vmcoreinfo =3D offset_note + s->note_size - s->vmcoreinf=
o_size +
>> +            (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name_size, 4)) * 4;
>> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
>> +        kh->size_vmcoreinfo =3D cpu_to_dump64(s, size_vmcoreinfo_desc);
>> +    }
>> +
>>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>>      kh->note_size =3D cpu_to_dump64(s, s->note_size);
>>
>>
>
> I continue to think that this patch is unnecessary, but if you insist,
> it does look OK to me.
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Without it, crash doesn't read the vmcoreinfo PT_NOTE. And for some
reason, the phys_base in the header wasn't enough (to be doubled
checked).

Any comment Dave about crash handling of vmcoreinfo in kdump files?



--=20
Marc-Andr=C3=A9 Lureau
