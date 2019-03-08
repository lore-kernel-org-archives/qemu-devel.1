Received: from eggs.gnu.org ([209.51.188.92]:33745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2DMM-0004ns-2i
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2DML-0008Vs-1l
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:08:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2DMK-0008U8-Pm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:08:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id g12so20905174wrm.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 03:08:12 -0800 (PST)
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-14-philmd@redhat.com>
	<0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <40319ac6-4545-4e7b-0339-8229727355e3@redhat.com>
Date: Fri, 8 Mar 2019 12:08:09 +0100
MIME-Version: 1.0
In-Reply-To: <0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
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

Hi Eric,

On 3/8/19 3:04 AM, Eric Blake wrote:
> On 3/7/19 7:32 PM, Philippe Mathieu-Daudé wrote:
>> When debugging a paravirtualized guest firmware, it results very
>> useful to dump the fw_cfg table.
>> Add a QMP command which returns the most useful fields.
>> Since the QMP protocol is not designed for passing stream data,
>> we don't display a fw_cfg item data, only it's size:
>>
>> { "execute": "query-fw_cfg-items" }
>> {
>>     "return": [
>>         {
>>             "architecture_specific": false,
>>             "key": 0,
>>             "writeable": false,
>>             "size": 4,
>>             "keyname": "signature"
> 
> You could return a base64-encoded representation of the field (we do
> that in other interfaces where raw binary can't be passed reliably over
> JSON).  For 4 bytes, that makes sense,
> 
> 
>>         {
>>             "architecture_specific": true,
>>             "key": 3,
>>             "writeable": false,
>>             "size": 324,
>>             "keyname": "e820_tables"
> 
> for 324 bytes, it gets a bit long. Still, may be worth it for the added
> debug visibility.

Until you see values in the next patch...:

$ (echo info fw_cfg; echo q) | qemu-system-x86_64 -S -monitor stdio
Selector  Well-Known Key  Pathname ArchSpec Perm   Size Order Hex Data
[...]
 0x0019   file_dir                           RO    2052       0000000b..
 0x0022   file: etc/acpi/tables              RO  131072  130  46414353..
 0x0028   file: etc/table-loader             RO    4096  140  01000000..

What about using a 512B limit on this QMP answer?

>> +++ b/qapi/misc.json
>> @@ -3051,3 +3051,47 @@
>>    'data': 'NumaOptions',
>>    'allow-preconfig': true
>>  }
>> +
>> +##
>> +# @FirmwareConfigurationItem:
>> +#
>> +# Firmware Configuration (fw_cfg) item.
>> +#
>> +# @key: The uint16 selector key.
>> +# @keyname: The stringified name if the selector refers to a well-known
>> +#           numerically defined item.
>> +# @architecture_specific: Indicates whether the configuration setting is
> 
> Prefer '-' over '_' in new interfaces.

OK!

> 
>> +#                         architecture specific.
>> +#                  false: The item is a generic configuration item.
>> +#                  true:  The item is specific to a particular architecture.
>> +# @writeable: Indicates whether the configuration setting is writeable by
>> +#             the guest.
> 
> writable
> 
>> +# @size: The length of @data associated with the item.
>> +# @data: A string representating the firmware configuration data.
> 
> representing
> 
>> +#        Note: This field is currently not used.
> 
> Either drop the field until it has a use, or let it be the base64
> encoding and use it now.

Well, it is used by the HMP command, to pass the hexdump.
I'm rather fine using the base64 encoding.

>> +# @path: If the key is a 'file', the named file path.
>> +# @order: If the key is a 'file', the named file order.
>> +#
>> +# Since 4.0
>> +##
>> +{ 'struct': 'FirmwareConfigurationItem',
>> +  'data': { 'key': 'uint16',
>> +            '*keyname': 'str',
>> +            'architecture_specific': 'bool',
>> +            'writeable': 'bool',
>> +            '*data': 'str',
>> +            'size': 'int',
>> +            '*path': 'str',
>> +            '*order': 'int' } }
> 
> Is it worth making 'keyname' an enum type, and turning this into a flat
> union where 'path' and 'order' appear on the branch associated with
> 'file', and where all other well-known keynames have smaller branches?

I have no idea about that, I will have a look at QMP flat unions.

>> +
>> +
>> +##
>> +# @query-fw_cfg-items:
> 
> That looks weird to mix - and _. Any reason we can't just go with
> query-firmware-config?

Way better! I'll use query-firmware-config-items.

Thanks for the review,

Phil.

>> +#
>> +# Returns the list of Firmware Configuration items.
>> +#
>> +# Returns: A list of @FirmwareConfigurationItem for each entry.
>> +#
>> +# Since 4.0
>> +##
>> +{ 'command': 'query-fw_cfg-items', 'returns': ['FirmwareConfigurationItem']}
>>
