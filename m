Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYt8z-0000y7-NO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYt8v-0000PU-P0
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:36:41 -0500
References: <20180108215007.46471-1-marcel@redhat.com>
	<CAJ+F1CLGi6bSMuafc7J1kzxAPHGErWfdKDmjbDX=H5WtK8YL0Q@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <dcbbc162-1dd3-8efb-a41e-22bb2f2a823d@redhat.com>
Date: Tue, 9 Jan 2018 14:36:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLGi6bSMuafc7J1kzxAPHGErWfdKDmjbDX=H5WtK8YL0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix memory corruption when all
 fw_cfg slots are used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 09/01/2018 13:15, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20

Hi Marc-Andr=C3=A9,

> On Mon, Jan 8, 2018 at 10:50 PM, Marcel Apfelbaum <marcel@redhat.com> w=
rote:
>> When all the fw_cfg slots are used, a write is made outside the
>> bounds of the fw_cfg files array as part of the sort algorithm.
>>
>> Fix it by avoiding an unnecessary array element move.
>> Fix also an assert while at it.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>   hw/nvram/fw_cfg.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 753ac0e4ea..4313484b21 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  cons=
t char *filename,
>>        * index and "i - 1" is the one being copied from, thus the
>>        * unusual start and end in the for statement.
>>        */
>> -    for (i =3D count + 1; i > index; i--) {
>> +    for (i =3D count; i > index; i--) {
>=20
> Good catch (could be worth a test in fw_cfg-test.c for ASAN check?)
>=20
> Just some thought, I wonder if the sorting should be done once after
> all entries are added, with some higher function like g_array_sort().
>=20

I personally have nothing against this kind of insertion sort.

>>           s->files->f[i] =3D s->files->f[i - 1];
>>           s->files->f[i].select =3D cpu_to_be16(FW_CFG_FILE_FIRST + i)=
;
>>           s->entries[0][FW_CFG_FILE_FIRST + i] =3D
>> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char=
 *filename,
>>       assert(s->files);
>>
>>       index =3D be32_to_cpu(s->files->count);
>> -    assert(index < fw_cfg_file_slots(s));
>>
>>       for (i =3D 0; i < index; i++) {
>>           if (strcmp(filename, s->files->f[i].name) =3D=3D 0) {
>> @@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char=
 *filename,
>>               return ptr;
>>           }
>>       }
>> +
>> +    assert(index < fw_cfg_file_slots(s));
>> +
>=20
> Well, the assert is redundant with the one in
> fw_cfg_add_file_callback() at this point. I think the original assert
> is there for sanity check only, before iterating over files.

Is not in fw_cfg_add_file_callback(), is in fw_cfg_modify_file()
which strangely can decide to add a file if is not there already.

The previous place of the assert was not good since it checked to see
if there is enough room to add a file, but most of the times,
as the function name suggests, we only modify one.

Let's say we have all the slots full and we want to modify an existing fi=
le.
The assert triggers abort even if is not needed.
However, if the file is not there the assert checks we have room before i=
t adds
the file.

Thanks for reviewing the patch!
Marcel


>=20
>>       /* add new one */
>>       fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, le=
n, true);
>>       return NULL;
>> --
>> 2.13.5
>>
>>
>=20
>=20
>=20
>=20
>=20
