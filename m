Received: from eggs.gnu.org ([2001:4830:134:3::10]:36286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYtQI-0006vG-QK
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYtQF-0006zl-MI
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:54:34 -0500
References: <20180108215007.46471-1-marcel@redhat.com>
	<CAJ+F1CLGi6bSMuafc7J1kzxAPHGErWfdKDmjbDX=H5WtK8YL0Q@mail.gmail.com>
	<dcbbc162-1dd3-8efb-a41e-22bb2f2a823d@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1157dd72-3e9d-f16e-0eb2-c27377f3e01f@redhat.com>
Date: Tue, 9 Jan 2018 13:54:07 +0100
MIME-Version: 1.0
In-Reply-To: <dcbbc162-1dd3-8efb-a41e-22bb2f2a823d@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 01/09/18 13:36, Marcel Apfelbaum wrote:
> On 09/01/2018 13:15, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>=20
> Hi Marc-Andr=C3=A9,
>=20
>> On Mon, Jan 8, 2018 at 10:50 PM, Marcel Apfelbaum <marcel@redhat.com>
>> wrote:
>>> When all the fw_cfg slots are used, a write is made outside the
>>> bounds of the fw_cfg files array as part of the sort algorithm.
>>>
>>> Fix it by avoiding an unnecessary array element move.
>>> Fix also an assert while at it.
>>>
>>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>> ---
>>> =C2=A0 hw/nvram/fw_cfg.c | 6 ++++--
>>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 753ac0e4ea..4313484b21 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,=C2=A0
>>> const char *filename,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * index and "i - 1" is the one b=
eing copied from, thus the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unusual start and end in the f=
or statement.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 for (i =3D count + 1; i > index; i--) {
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D count; i > index; i--) {
>>
>> Good catch (could be worth a test in fw_cfg-test.c for ASAN check?)
>>
>> Just some thought, I wonder if the sorting should be done once after
>> all entries are added, with some higher function like g_array_sort().
>>
>=20
> I personally have nothing against this kind of insertion sort.
>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->files->f[i]=
 =3D s->files->f[i - 1];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->files->f[i]=
.select =3D cpu_to_be16(FW_CFG_FILE_FIRST + i);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->entries[0][=
FW_CFG_FILE_FIRST + i] =3D
>>> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const
>>> char *filename,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(s->files);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index =3D be32_to_cpu(s->files->count)=
;
>>> -=C2=A0=C2=A0=C2=A0 assert(index < fw_cfg_file_slots(s));
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < index; i++) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(fil=
ename, s->files->f[i].name) =3D=3D 0) {
>>> @@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const
>>> char *filename,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ptr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 assert(index < fw_cfg_file_slots(s));
>>> +
>>
>> Well, the assert is redundant with the one in
>> fw_cfg_add_file_callback() at this point. I think the original assert
>> is there for sanity check only, before iterating over files.
>=20
> Is not in fw_cfg_add_file_callback(), is in fw_cfg_modify_file()
> which strangely can decide to add a file if is not there already.
>=20
> The previous place of the assert was not good since it checked to see
> if there is enough room to add a file, but most of the times,
> as the function name suggests, we only modify one.
>=20
> Let's say we have all the slots full and we want to modify an existing
> file.
> The assert triggers abort even if is not needed.
> However, if the file is not there the assert checks we have room before
> it adds
> the file.

I think Marc-Andr=C3=A9 agrees, but his point seems to be that you could
simply remove the assert from the top of fw_cfg_modify_file() --
because, if we reach the fw_cfg_add_file_callback() call at the end of
the function, then fw_cfg_add_file_callback() will verify the same
assert almost immediately.

I'm still staring at the other half of the patch.

Thanks
Laszlo

>=20
> Thanks for reviewing the patch!
> Marcel
>=20
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* add new one */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file_callback(s, filename, =
NULL, NULL, NULL, data,
>>> len, true);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> --=20
>>> 2.13.5
>>>
>>>
>>
>>
>>
>>
>>
>=20
>=20
