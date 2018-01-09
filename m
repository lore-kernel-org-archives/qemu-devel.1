Received: from eggs.gnu.org ([2001:4830:134:3::10]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYu4g-00026b-1c
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYu4a-0004VV-7c
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:36:18 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20180108215007.46471-1-marcel@redhat.com>
	<3ea6176b-01a4-8f5a-81fc-3e9a8c846dc7@redhat.com>
	<cc65bb42-df0c-227f-5708-8a17b1ae0b22@redhat.com>
	<2b536f93-4f84-c09d-2a65-a6c653999be3@redhat.com>
	<15eabb6d-0199-5bf3-678e-ffa97c352c72@redhat.com>
Message-ID: <d6489aea-8b33-ba07-bfbe-a0edc6aeb5b8@redhat.com>
Date: Tue, 9 Jan 2018 14:36:02 +0100
MIME-Version: 1.0
In-Reply-To: <15eabb6d-0199-5bf3-678e-ffa97c352c72@redhat.com>
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
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-stable@nongnu.org, kraxel@redhat.com

On 01/09/18 14:35, Laszlo Ersek wrote:
> On 01/09/18 14:33, Laszlo Ersek wrote:
>> On 01/09/18 14:18, Marcel Apfelbaum wrote:
>>> On 09/01/2018 15:09, Laszlo Ersek wrote:
>>>
>>> Hi Laszlo,
>>>
>>> I'll respond first to this mail' I'll take my time with the rest :)
>>>
>>>> On 01/08/18 22:50, Marcel Apfelbaum wrote:
>>>>> When all the fw_cfg slots are used, a write is made outside the
>>>>> bounds of the fw_cfg files array as part of the sort algorithm.
>>>>>
>>>>> Fix it by avoiding an unnecessary array element move.
>>>>> Fix also an assert while at it.
>>>>>
>>>>> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
>>>>> ---
>>>>> =C2=A0 hw/nvram/fw_cfg.c | 6 ++++--
>>>>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>>>> index 753ac0e4ea..4313484b21 100644
>>>>> --- a/hw/nvram/fw_cfg.c
>>>>> +++ b/hw/nvram/fw_cfg.c
>>>>> @@ -784,7 +784,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,=C2=
=A0
>>>>> const char *filename,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * index and "i - 1" is the one=
 being copied from, thus the
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unusual start and end in the=
 for statement.
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> -=C2=A0=C2=A0=C2=A0 for (i =3D count + 1; i > index; i--) {
>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D count; i > index; i--) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->files->f[=
i] =3D s->files->f[i - 1];
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->files->f[=
i].select =3D cpu_to_be16(FW_CFG_FILE_FIRST + i);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->entries[0=
][FW_CFG_FILE_FIRST + i] =3D
>>>>
>>>> This hunk looks correct to me.
>>>
>>> After my change or before?
>>
>> Well, the source code doesn't have "hunks", patches have hunks. :)
>>
>> So, I meant, this part of your patch was correct, IMO.
>>
>>>
>>> I think I am right.
>>> At this point we have "count" elements in the array.
>>> That means the last element in the array is at arr[count - 1].
>>> We want to make room for the new element at index, so we move
>>> all the elements from index to index + 1.
>>>
>>> The first element we should move is arr[count - 1] to arr[count].
>>> But the code moved arr[count] to arr [count + 1].
>>> This move is not needed.
>>>
>>>
>>> =C2=A0We currently have count elements in the
>>>> array, so we cannot normally access the element *at* count. However,=
 we
>>>> are extending the array right now, therefore we can assign (store) t=
he
>>>> element at count (and then we'll increment count later). But accessi=
ng
>>>> an element at (count+1) is wrong.
>>>>
>>>>> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const
>>>>> char *filename,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(s->files);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index =3D be32_to_cpu(s->file=
s->count);
>>>>> -=C2=A0=C2=A0=C2=A0 assert(index < fw_cfg_file_slots(s));
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < index; i++)=
 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(f=
ilename, s->files->f[i].name) =3D=3D 0) {
>>>>> @@ -843,6 +842,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const
>>>>> char *filename,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ptr;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 assert(index < fw_cfg_file_slots(s));
>>>>> +
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* add new one */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fw_cfg_add_file_callback(s, filename=
, NULL, NULL, NULL, data,
>>>>> len, true);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>>>>
>>>>
>>>> I think I agree with Marc-Andr=C3=A9 here, when I say, replace the a=
ssert
>>>> with a comment instead? (About the fact that fw_cfg_add_file_callbac=
k()
>>>> will assert(), *if* we reach that far.)
>>>
>>> Hmm, what should we add to the comment? "We lost, brace for impact :)=
"
>>>
>>> My point, if we are going to abort, let's abort as early as we can.
>>> But if is a consensus, I'll get rid of it.
>>
>> No, it's going to be another assert, just later. Assume that at this
>> point we have (index =3D=3D fw_cfg_file_slots(s)), because the functio=
n
>> didn't find the element to modify, so it decides to add a new one, but
>> also we do not have room for the new one. So, with the suggested remov=
al
>> of the assert, we call fw_cfg_add_file_callback().
>>
>> Then, fw_cfg_add_file_callback() does:
>>
>>     if (!s->files) {
>>         dsize =3D sizeof(uint32_t) + sizeof(FWCfgFile) * fw_cfg_file_s=
lots(s);
>>         s->files =3D g_malloc0(dsize);
>>         fw_cfg_add_bytes(s, FW_CFG_FILE_DIR, s->files, dsize);
>>     }
>>
>>     count =3D be32_to_cpu(s->files->count);
>>     assert(count < fw_cfg_file_slots(s));
>>
>> The (!s->files) condition is expected to eval to false (our table is
>> full, so we do have a table).
>>
>> And then, the assert() below the "if" will fire.
>>
>> Am I missing something?
>=20
> Hm, OK, your point was, abort as *early* as we can.
>=20
> I guess you are not wrong :) I'm fine either way, then.

... which means:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

(sorry, need more sleep)
