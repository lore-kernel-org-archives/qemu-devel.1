Received: from eggs.gnu.org ([209.51.188.92]:46629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2JuF-0005BP-1x
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:07:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2JuD-00058u-4M
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:07:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2JuB-0004zC-7l
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:07:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id a188so13075847wmf.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 10:07:31 -0800 (PST)
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-14-philmd@redhat.com>
	<0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
	<40319ac6-4545-4e7b-0339-8229727355e3@redhat.com>
	<a3c759a5-73df-f481-ba21-48ece92f1185@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f1cdb48-3262-de5e-a500-1dfb3d6372e5@redhat.com>
Date: Fri, 8 Mar 2019 19:07:28 +0100
MIME-Version: 1.0
In-Reply-To: <a3c759a5-73df-f481-ba21-48ece92f1185@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 3/8/19 6:31 PM, Eric Blake wrote:
> On 3/8/19 5:08 AM, Philippe Mathieu-Daudé wrote:
> 
>>>> {
>>>>     "return": [
>>>>         {
>>>>             "architecture_specific": false,
>>>>             "key": 0,
>>>>             "writeable": false,
>>>>             "size": 4,
>>>>             "keyname": "signature"
>>>
>>> You could return a base64-encoded representation of the field (we do
>>> that in other interfaces where raw binary can't be passed reliably over
>>> JSON).  For 4 bytes, that makes sense,
>>>
>>>
>>>>         {
>>>>             "architecture_specific": true,
>>>>             "key": 3,
>>>>             "writeable": false,
>>>>             "size": 324,
>>>>             "keyname": "e820_tables"
>>>
>>> for 324 bytes, it gets a bit long. Still, may be worth it for the added
>>> debug visibility.
>>
>> Until you see values in the next patch...:
>>
>> $ (echo info fw_cfg; echo q) | qemu-system-x86_64 -S -monitor stdio
>> Selector  Well-Known Key  Pathname ArchSpec Perm   Size Order Hex Data
>> [...]
>>  0x0019   file_dir                           RO    2052       0000000b..
>>  0x0022   file: etc/acpi/tables              RO  131072  130  46414353..
> 
> Yeah, that's a no-go.
>>
>> What about using a 512B limit on this QMP answer?
> 
> Seems reasonable. Either omit the field when its size exceeds the limit,
> or use the field to give a truncated version (where the size field still
> shows the full length, either way).

OK.

>>>> +# @path: If the key is a 'file', the named file path.
>>>> +# @order: If the key is a 'file', the named file order.
>>>> +#
>>>> +# Since 4.0
>>>> +##
>>>> +{ 'struct': 'FirmwareConfigurationItem',
>>>> +  'data': { 'key': 'uint16',
>>>> +            '*keyname': 'str',
>>>> +            'architecture_specific': 'bool',
>>>> +            'writeable': 'bool',
>>>> +            '*data': 'str',
>>>> +            'size': 'int',
>>>> +            '*path': 'str',
>>>> +            '*order': 'int' } }
>>>
>>> Is it worth making 'keyname' an enum type, and turning this into a flat
>>> union where 'path' and 'order' appear on the branch associated with
>>> 'file', and where all other well-known keynames have smaller branches?
>>
>> I have no idea about that, I will have a look at QMP flat unions.
> 
> Markus can help if you get stuck on what it might look like. But by now,
> there are several examples in .qapi files to copy from (look for
> 'discriminator').

OK.

>>
>>>> +
>>>> +
>>>> +##
>>>> +# @query-fw_cfg-items:
>>>
>>> That looks weird to mix - and _. Any reason we can't just go with
>>> query-firmware-config?
>>
>> Way better! I'll use query-firmware-config-items.
> 
> Do we need the -items suffix? Also, is there a chance that we might ever
> want to extend the command to return more information that is global to
> firmware-config rather than per-item?

Laszlo suggested it could be useful to ask for a specific item (with the
full data encoded?).

>>>> +{ 'command': 'query-fw_cfg-items', 'returns': ['FirmwareConfigurationItem']}
> 
> As written, this results in:
> 
> { "return": [ { ... }, { ... } ] }
> 
> but if you add a layer of nesting, you could have easier extensions:
> 
> { "return": { "global": {}, "items": [ { ... }, { ... } ] } }
> 

Oh I guess I got it, I'll try it.

Thanks!

Phil.
