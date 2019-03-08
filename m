Received: from eggs.gnu.org ([209.51.188.92]:39412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JL5-0005vH-Lw
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h2JL4-0004bJ-TX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:31:19 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-14-philmd@redhat.com>
	<0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
	<40319ac6-4545-4e7b-0339-8229727355e3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3c759a5-73df-f481-ba21-48ece92f1185@redhat.com>
Date: Fri, 8 Mar 2019 11:31:01 -0600
MIME-Version: 1.0
In-Reply-To: <40319ac6-4545-4e7b-0339-8229727355e3@redhat.com>
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 3/8/19 5:08 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>> {
>>>     "return": [
>>>         {
>>>             "architecture_specific": false,
>>>             "key": 0,
>>>             "writeable": false,
>>>             "size": 4,
>>>             "keyname": "signature"
>>
>> You could return a base64-encoded representation of the field (we do
>> that in other interfaces where raw binary can't be passed reliably ove=
r
>> JSON).  For 4 bytes, that makes sense,
>>
>>
>>>         {
>>>             "architecture_specific": true,
>>>             "key": 3,
>>>             "writeable": false,
>>>             "size": 324,
>>>             "keyname": "e820_tables"
>>
>> for 324 bytes, it gets a bit long. Still, may be worth it for the adde=
d
>> debug visibility.
>=20
> Until you see values in the next patch...:
>=20
> $ (echo info fw_cfg; echo q) | qemu-system-x86_64 -S -monitor stdio
> Selector  Well-Known Key  Pathname ArchSpec Perm   Size Order Hex Data
> [...]
>  0x0019   file_dir                           RO    2052       0000000b.=
.
>  0x0022   file: etc/acpi/tables              RO  131072  130  46414353.=
.

Yeah, that's a no-go.
>=20
> What about using a 512B limit on this QMP answer?

Seems reasonable. Either omit the field when its size exceeds the limit,
or use the field to give a truncated version (where the size field still
shows the full length, either way).


>>> +# @path: If the key is a 'file', the named file path.
>>> +# @order: If the key is a 'file', the named file order.
>>> +#
>>> +# Since 4.0
>>> +##
>>> +{ 'struct': 'FirmwareConfigurationItem',
>>> +  'data': { 'key': 'uint16',
>>> +            '*keyname': 'str',
>>> +            'architecture_specific': 'bool',
>>> +            'writeable': 'bool',
>>> +            '*data': 'str',
>>> +            'size': 'int',
>>> +            '*path': 'str',
>>> +            '*order': 'int' } }
>>
>> Is it worth making 'keyname' an enum type, and turning this into a fla=
t
>> union where 'path' and 'order' appear on the branch associated with
>> 'file', and where all other well-known keynames have smaller branches?
>=20
> I have no idea about that, I will have a look at QMP flat unions.

Markus can help if you get stuck on what it might look like. But by now,
there are several examples in .qapi files to copy from (look for
'discriminator').

>=20
>>> +
>>> +
>>> +##
>>> +# @query-fw_cfg-items:
>>
>> That looks weird to mix - and _. Any reason we can't just go with
>> query-firmware-config?
>=20
> Way better! I'll use query-firmware-config-items.

Do we need the -items suffix? Also, is there a chance that we might ever
want to extend the command to return more information that is global to
firmware-config rather than per-item?

>>> +{ 'command': 'query-fw_cfg-items', 'returns': ['FirmwareConfiguratio=
nItem']}

As written, this results in:

{ "return": [ { ... }, { ... } ] }

but if you add a layer of nesting, you could have easier extensions:

{ "return": { "global": {}, "items": [ { ... }, { ... } ] } }

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
