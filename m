Received: from eggs.gnu.org ([2001:4830:134:3::10]:46077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYtnt-0001Dx-Al
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eYtnq-0005v9-75
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:18:57 -0500
References: <20180108215007.46471-1-marcel@redhat.com>
	<3ea6176b-01a4-8f5a-81fc-3e9a8c846dc7@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <cc65bb42-df0c-227f-5708-8a17b1ae0b22@redhat.com>
Date: Tue, 9 Jan 2018 15:18:45 +0200
MIME-Version: 1.0
In-Reply-To: <3ea6176b-01a4-8f5a-81fc-3e9a8c846dc7@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-stable@nongnu.org, kraxel@redhat.com

On 09/01/2018 15:09, Laszlo Ersek wrote:

Hi Laszlo,

I'll respond first to this mail' I'll take my time with the rest :)

> On 01/08/18 22:50, Marcel Apfelbaum wrote:
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
>>           s->files->f[i] =3D s->files->f[i - 1];
>>           s->files->f[i].select =3D cpu_to_be16(FW_CFG_FILE_FIRST + i)=
;
>>           s->entries[0][FW_CFG_FILE_FIRST + i] =3D
>=20
> This hunk looks correct to me.

After my change or before?

I think I am right.
At this point we have "count" elements in the array.
That means the last element in the array is at arr[count - 1].
We want to make room for the new element at index, so we move
all the elements from index to index + 1.

The first element we should move is arr[count - 1] to arr[count].
But the code moved arr[count] to arr [count + 1].
This move is not needed.


  We currently have count elements in the
> array, so we cannot normally access the element *at* count. However, we
> are extending the array right now, therefore we can assign (store) the
> element at count (and then we'll increment count later). But accessing
> an element at (count+1) is wrong.
>=20
>> @@ -833,7 +833,6 @@ void *fw_cfg_modify_file(FWCfgState *s, const char=
 *filename,
>>       assert(s->files);
>>  =20
>>       index =3D be32_to_cpu(s->files->count);
>> -    assert(index < fw_cfg_file_slots(s));
>>  =20
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
>>       /* add new one */
>>       fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, le=
n, true);
>>       return NULL;
>>
>=20
> I think I agree with Marc-Andr=C3=A9 here, when I say, replace the asse=
rt
> with a comment instead? (About the fact that fw_cfg_add_file_callback()
> will assert(), *if* we reach that far.)

Hmm, what should we add to the comment? "We lost, brace for impact :)"

My point, if we are going to abort, let's abort as early as we can.
But if is a consensus, I'll get rid of it.

Thanks,
Marcel

>=20
> Thanks
> Laszlo
>=20
