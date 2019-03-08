Received: from eggs.gnu.org ([209.51.188.92]:55192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h24s9-0001J6-LX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h24s5-0005OT-Ng
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:04:27 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-14-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e007e09-cf54-312b-9563-59f3994209bf@redhat.com>
Date: Thu, 7 Mar 2019 20:04:09 -0600
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-14-philmd@redhat.com>
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

On 3/7/19 7:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> When debugging a paravirtualized guest firmware, it results very
> useful to dump the fw_cfg table.
> Add a QMP command which returns the most useful fields.
> Since the QMP protocol is not designed for passing stream data,
> we don't display a fw_cfg item data, only it's size:
>=20
> { "execute": "query-fw_cfg-items" }
> {
>     "return": [
>         {
>             "architecture_specific": false,
>             "key": 0,
>             "writeable": false,
>             "size": 4,
>             "keyname": "signature"

You could return a base64-encoded representation of the field (we do
that in other interfaces where raw binary can't be passed reliably over
JSON).  For 4 bytes, that makes sense,


>         {
>             "architecture_specific": true,
>             "key": 3,
>             "writeable": false,
>             "size": 324,
>             "keyname": "e820_tables"

for 324 bytes, it gets a bit long. Still, may be worth it for the added
debug visibility.


> +++ b/qapi/misc.json
> @@ -3051,3 +3051,47 @@
>    'data': 'NumaOptions',
>    'allow-preconfig': true
>  }
> +
> +##
> +# @FirmwareConfigurationItem:
> +#
> +# Firmware Configuration (fw_cfg) item.
> +#
> +# @key: The uint16 selector key.
> +# @keyname: The stringified name if the selector refers to a well-know=
n
> +#           numerically defined item.
> +# @architecture_specific: Indicates whether the configuration setting =
is

Prefer '-' over '_' in new interfaces.

> +#                         architecture specific.
> +#                  false: The item is a generic configuration item.
> +#                  true:  The item is specific to a particular archite=
cture.
> +# @writeable: Indicates whether the configuration setting is writeable=
 by
> +#             the guest.

writable

> +# @size: The length of @data associated with the item.
> +# @data: A string representating the firmware configuration data.

representing

> +#        Note: This field is currently not used.

Either drop the field until it has a use, or let it be the base64
encoding and use it now.

> +# @path: If the key is a 'file', the named file path.
> +# @order: If the key is a 'file', the named file order.
> +#
> +# Since 4.0
> +##
> +{ 'struct': 'FirmwareConfigurationItem',
> +  'data': { 'key': 'uint16',
> +            '*keyname': 'str',
> +            'architecture_specific': 'bool',
> +            'writeable': 'bool',
> +            '*data': 'str',
> +            'size': 'int',
> +            '*path': 'str',
> +            '*order': 'int' } }

Is it worth making 'keyname' an enum type, and turning this into a flat
union where 'path' and 'order' appear on the branch associated with
'file', and where all other well-known keynames have smaller branches?


> +
> +
> +##
> +# @query-fw_cfg-items:

That looks weird to mix - and _. Any reason we can't just go with
query-firmware-config?

> +#
> +# Returns the list of Firmware Configuration items.
> +#
> +# Returns: A list of @FirmwareConfigurationItem for each entry.
> +#
> +# Since 4.0
> +##
> +{ 'command': 'query-fw_cfg-items', 'returns': ['FirmwareConfigurationI=
tem']}
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
