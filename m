Received: from eggs.gnu.org ([2001:4830:134:3::10]:43189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1essBA-0006G7-EV
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1essB7-0004Qw-O8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:37:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55304 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1essB7-0004QF-I8
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23AE7400187D
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 15:37:24 +0000 (UTC)
References: <1520248105-10053-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5483b6f9-32ac-4d20-9e21-c784a639c62c@redhat.com>
Date: Mon, 5 Mar 2018 09:37:18 -0600
MIME-Version: 1.0
In-Reply-To: <1520248105-10053-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] Allow to specify a display device ID
 and head whith the screendump command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On 03/05/2018 05:08 AM, Thomas Huth wrote:

In the subject line: s/whith/with/

Also, it's rather long (over 75 characters, while typical messages are=20
under 65, since it is nice to still fit in 80 columns even when 'git=20
log' adds indentation), better might be:

qapi: Add parameters to screendump

then go into details about the parameters in the commit body

> QEMU's screendump command can only take dumps from the primary display.
> When using multiple VGA cards, there is no way to get a dump from a
> secondary card or other display heads yet. So let's add an 'device' and
> a 'head' parameter to the HMP and QMP commands to be able to specify
> alternative devices and heads with the screendump command, too.
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v3:
>   - Drop redundant qemu_console_lookup_by_index(0);
>   - Remove trailing "." from error message
>=20

> +++ b/qapi/ui.json
> @@ -77,6 +77,10 @@
>   #
>   # @filename: the path of a new PPM file to store the image
>   #
> +# @device: ID of the display device that should be used (since 2.12)

Worth mentioning how the default value is computed?

> +#
> +# @head: head to use in case the device supports multiple heads (since=
 2.12)
> +#
>   # Returns: Nothing on success
>   #
>   # Since: 0.14.0
> @@ -88,7 +92,8 @@
>   # <- { "return": {} }
>   #
>   ##
> -{ 'command': 'screendump', 'data': {'filename': 'str'} }
> +{ 'command': 'screendump',
> +  'data': {'filename': 'str', '*device': 'str', '*head': 'int'} }
>  =20

QAPI changes are reasonable from a UI point of view.

> +    } else {
> +        if (has_head) {
> +            error_setg(errp, "'head' must be specified together with '=
device'");

This isn't documented.

> +            return;
> +        }
> +        con =3D qemu_console_lookup_by_index(0);
> +        if (!con) {
> +            error_setg(errp, "There is no console to take a screendump=
 from");
> +            return;
> +        }
>       }
>  =20
>       graphic_hw_update(con);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
