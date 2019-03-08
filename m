Received: from eggs.gnu.org ([209.51.188.92]:40722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Lfj-00038Z-S4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2LfV-0007vY-S8
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:00:39 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-14-philmd@redhat.com>
	<0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
	<40319ac6-4545-4e7b-0339-8229727355e3@redhat.com>
	<a3c759a5-73df-f481-ba21-48ece92f1185@redhat.com>
	<9f1cdb48-3262-de5e-a500-1dfb3d6372e5@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f4d5a154-0c9d-0e1c-144c-c6855dadafd6@redhat.com>
Date: Fri, 8 Mar 2019 21:00:03 +0100
MIME-Version: 1.0
In-Reply-To: <9f1cdb48-3262-de5e-a500-1dfb3d6372e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/18] hw/nvram/fw_cfg: Add QMP 'info
 fw_cfg' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 19:07, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/8/19 6:31 PM, Eric Blake wrote:
>> On 3/8/19 5:08 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>>>>> {
>>>>>     "return": [
>>>>>         {
>>>>>             "architecture_specific": false,
>>>>>             "key": 0,
>>>>>             "writeable": false,
>>>>>             "size": 4,
>>>>>             "keyname": "signature"
>>>>
>>>> You could return a base64-encoded representation of the field (we do
>>>> that in other interfaces where raw binary can't be passed reliably o=
ver
>>>> JSON).  For 4 bytes, that makes sense,
>>>>
>>>>
>>>>>         {
>>>>>             "architecture_specific": true,
>>>>>             "key": 3,
>>>>>             "writeable": false,
>>>>>             "size": 324,
>>>>>             "keyname": "e820_tables"
>>>>
>>>> for 324 bytes, it gets a bit long. Still, may be worth it for the ad=
ded
>>>> debug visibility.
>>>
>>> Until you see values in the next patch...:
>>>
>>> $ (echo info fw_cfg; echo q) | qemu-system-x86_64 -S -monitor stdio
>>> Selector  Well-Known Key  Pathname ArchSpec Perm   Size Order Hex Dat=
a
>>> [...]
>>>  0x0019   file_dir                           RO    2052       0000000=
b..
>>>  0x0022   file: etc/acpi/tables              RO  131072  130  4641435=
3..
>>
>> Yeah, that's a no-go.
>>>
>>> What about using a 512B limit on this QMP answer?
>>
>> Seems reasonable. Either omit the field when its size exceeds the limi=
t,
>> or use the field to give a truncated version (where the size field sti=
ll
>> shows the full length, either way).
>=20
> OK.
>=20
>>>>> +# @path: If the key is a 'file', the named file path.
>>>>> +# @order: If the key is a 'file', the named file order.
>>>>> +#
>>>>> +# Since 4.0
>>>>> +##
>>>>> +{ 'struct': 'FirmwareConfigurationItem',
>>>>> +  'data': { 'key': 'uint16',
>>>>> +            '*keyname': 'str',
>>>>> +            'architecture_specific': 'bool',
>>>>> +            'writeable': 'bool',
>>>>> +            '*data': 'str',
>>>>> +            'size': 'int',
>>>>> +            '*path': 'str',
>>>>> +            '*order': 'int' } }
>>>>
>>>> Is it worth making 'keyname' an enum type, and turning this into a f=
lat
>>>> union where 'path' and 'order' appear on the branch associated with
>>>> 'file', and where all other well-known keynames have smaller branche=
s?
>>>
>>> I have no idea about that, I will have a look at QMP flat unions.
>>
>> Markus can help if you get stuck on what it might look like. But by no=
w,
>> there are several examples in .qapi files to copy from (look for
>> 'discriminator').
>=20
> OK.
>=20
>>>
>>>>> +
>>>>> +
>>>>> +##
>>>>> +# @query-fw_cfg-items:
>>>>
>>>> That looks weird to mix - and _. Any reason we can't just go with
>>>> query-firmware-config?
>>>
>>> Way better! I'll use query-firmware-config-items.
>>
>> Do we need the -items suffix? Also, is there a chance that we might ev=
er
>> want to extend the command to return more information that is global t=
o
>> firmware-config rather than per-item?
>=20
> Laszlo suggested it could be useful to ask for a specific item (with th=
e
> full data encoded?).

It's possible I referred to that a long time ago, but most recently, I
think it has been raised by Dave.

Thanks
Laszlo

>=20
>>>>> +{ 'command': 'query-fw_cfg-items', 'returns': ['FirmwareConfigurat=
ionItem']}
>>
>> As written, this results in:
>>
>> { "return": [ { ... }, { ... } ] }
>>
>> but if you add a layer of nesting, you could have easier extensions:
>>
>> { "return": { "global": {}, "items": [ { ... }, { ... } ] } }
>>
>=20
> Oh I guess I got it, I'll try it.
>=20
> Thanks!
>=20
> Phil.
>=20
