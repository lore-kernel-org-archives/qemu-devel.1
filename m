Received: from eggs.gnu.org ([2001:4830:134:3::10]:33127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT3eo-0000KD-VE
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT3en-0002R0-VL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:05:10 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dT3en-0002Po-Ms
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:05:09 -0400
Received: by mail-lf0-x242.google.com with SMTP id f28so1625976lfi.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:05:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f71401ea-2a98-5cc1-8d9f-5f2ffb683877@redhat.com>
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-6-marcandre.lureau@redhat.com>
	<f71401ea-2a98-5cc1-8d9f-5f2ffb683877@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Jul 2017 03:05:07 -0700
Message-ID: <CAJ+F1CKoEy7JfJEC25MFVuQQbknZhu7+AnY2r29_Yn2cA-OCEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] kdump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Dave Anderson <anderson@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Wed, Jul 5, 2017 at 2:07 AM, Laszlo Ersek <lersek@redhat.com> wrote:
> On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
>> kdump header provides offset and size of the vmcoreinfo ELF note,
>> append it if available.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  dump.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/dump.c b/dump.c
>> index 8fda5cc1ed..b78bc1fda7 100644
>> --- a/dump.c
>> +++ b/dump.c
>> @@ -788,8 +788,9 @@ static void create_header32(DumpState *s, Error **er=
rp)
>>      uint32_t sub_hdr_size;
>>      uint32_t bitmap_blocks;
>>      uint32_t status =3D 0;
>> -    uint64_t offset_note;
>> +    uint64_t offset_note, offset_vmcoreinfo, size_vmcoreinfo =3D 0;
>>      Error *local_err =3D NULL;
>> +    uint8_t *vmcoreinfo =3D NULL;
>>
>>      /* write common header, the version of kdump-compressed format is 6=
th */
>>      size =3D sizeof(DiskDumpHeader32);
>> @@ -838,7 +839,18 @@ static void create_header32(DumpState *s, Error **e=
rrp)
>>      kh->phys_base =3D cpu_to_dump32(s, s->dump_info.phys_base);
>>      kh->dump_level =3D cpu_to_dump32(s, DUMP_LEVEL);
>>
>> -    offset_note =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
>> +    offset_vmcoreinfo =3D DISKDUMP_HEADER_BLOCKS * block_size + size;
>> +    if (s->vmcoreinfo) {
>> +        uint64_t hsize, name_size;
>> +
>> +        get_note_sizes(s, s->vmcoreinfo, &hsize, &name_size, &size_vmco=
reinfo);
>
> Should we round up "size_vmcoreinfo" as well? (Without the rounding,
> offset_note might become unaligned, plus I simply don't know what
> alignment is expected from kh->size_vmcoreinfo.)

In the last iteration, it only sets the kh->offset/size_vmcoreinfo. I
don't see any alignment requirement in crash.
Dave, any comment?

>
>> +        vmcoreinfo =3D
>> +            s->vmcoreinfo + (DIV_ROUND_UP(hsize, 4) + DIV_ROUND_UP(name=
_size, 4)) * 4;
>> +        kh->offset_vmcoreinfo =3D cpu_to_dump64(s, offset_vmcoreinfo);
>> +        kh->size_vmcoreinfo =3D cpu_to_dump32(s, size_vmcoreinfo);
>> +    }
>> +
>> +    offset_note =3D offset_vmcoreinfo + size_vmcoreinfo;
>>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>>      kh->note_size =3D cpu_to_dump32(s, s->note_size);
>>
>> @@ -848,6 +860,14 @@ static void create_header32(DumpState *s, Error **e=
rrp)
>>          goto out;
>>      }
>>
>> +    if (vmcoreinfo) {
>> +        if (write_buffer(s->fd, offset_vmcoreinfo, vmcoreinfo,
>> +                         size_vmcoreinfo) < 0) {
>> +            error_setg(errp, "dump: failed to vmcoreinfo");
>
> The verb "write" is missing from the message.
>
> Same comments for create_header64() below.
>

gone

thanks

--=20
Marc-Andr=C3=A9 Lureau
