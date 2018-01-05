Received: from eggs.gnu.org ([2001:4830:134:3::10]:37252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXTwZ-0005Z6-UF
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:30:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXTwX-0002YW-Eu
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:30:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXTwX-0002Wk-5n
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 10:30:01 -0500
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
Date: Fri, 5 Jan 2018 09:29:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180103214925.16677-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W4biKDCEaGqSdq1DrQTEyAlLQtS33lTdQ"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W4biKDCEaGqSdq1DrQTEyAlLQtS33lTdQ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
Subject: Re: [PATCH v2 1/4] sdbus: add a QMP command to access a SDBus
References: <20180103214925.16677-1-f4bug@amsat.org>
 <20180103214925.16677-2-f4bug@amsat.org>
In-Reply-To: <20180103214925.16677-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 03:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Use Base64 to serialize the binary blobs in JSON.
> So far at most 512 bytes will be transfered, which result

s/transfered/transferred/

> in a 684 bytes payload.
> Since this command is intented for qtesting, it is acceptable.

s/intented/intended/

Might be worth mentioning the actual command name,
x-debug-sdbus-command, in the commit message to make future git log
trawling easier.

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> +##
> +# @SDBusCommandResponse:
> +#
> +# SD Bus command response.
> +#
> +# @base64: the command response encoded as a Base64 string, if any (op=
tional)

s/ (optional)//, now that the documentation engine automatically takes
care of that.

Even if there is no response, isn't the empty string "" more accurate
than omitting the string altogether?  In other words, I'm not sure why
you made the 'base64' member optional.

> +#
> +# Since: 2.11

2.12

> +##
> +{ 'struct': 'SDBusCommandResponse', 'data': {'*base64': 'str'} }
> +
> +##
> +# @x-debug-sdbus-command:
> +#
> +# Execute a command on a SD Bus return the response (if any).
> +#

Maybe mention that this command is only intended for use during unit
testing (that information is already implicit from the x-debug prefix,
but stating it explicitly doesn't hurt).

> +# @qom-path: the SD Bus path
> +# @command: the SD protocol command to execute in the bus
> +# @arg: a 64-bit command argument (optional)
> +# @crc: the command/argument CRC (optional)
> +#
> +# Returns: the response of the command encoded as a Base64 string
> +#
> +# Since: 2.11

2.12

> +#
> +# -> { "execute": "x-debug-sdbus-command",
> +#      "arguments": { "qom-path": "/machine/unattached/device[32]/sd.0=
",
> +#                     "command": 0x01

That's invalid JSON (which does not understand hex numbers).  You need
"command": 1

> +#      }
> +#    }
> +# <- { "return": {'base64': 'A=3D'} }
> +#
> +##
> +{ 'command': 'x-debug-sdbus-command',
> +  'data': { 'qom-path': 'str',
> +            'command': 'uint8',
> +            '*arg': 'uint64',
> +            '*crc': 'uint16' },
> +  'returns': 'SDBusCommandResponse'
> +}
> diff --git a/hw/sd/sdbus-qmp.c b/hw/sd/sdbus-qmp.c
> new file mode 100644
> index 0000000000..8c4b6f2aee
> --- /dev/null
> +++ b/hw/sd/sdbus-qmp.c
> @@ -0,0 +1,65 @@
> +/*
> + * SD card bus QMP debugging interface (for QTesting).
> + *
> + * Copyright (c) 2017 ?

The question mark in a copyright line is not right.  I don't know what
you meant to use, but unless you were doing the work on behalf of an
employer, your own name is probably correct.  You could include 2018 now
if you wanted.


> +SDBusCommandResponse *qmp_x_debug_sdbus_command(const char *qom_path,
> +                                                uint8_t command,
> +                                                bool has_arg, uint64_t=
 arg,
> +                                                bool has_crc, uint16_t=
 crc,
> +                                                Error **errp)
> +{
> +    uint8_t response[16 + 1];
> +    SDBusCommandResponse *res;
> +    bool ambiguous =3D false;
> +    Object *obj;
> +    SDBus *sdbus;
> +    int sz;
> +
> +    obj =3D object_resolve_path(qom_path, &ambiguous);
> +    if (obj =3D=3D NULL) {

I don't know if the style 'if (!obj) {' is any more prevalent; but it
doesn't really matter.

> +        if (ambiguous) {
> +            error_setg(errp, "Path '%s' is ambiguous", qom_path);
> +        } else {
> +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                      "Device '%s' not found", qom_path);
> +        }
> +        return NULL;
> +    }
> +    sdbus =3D (SDBus *)object_dynamic_cast(obj, TYPE_SD_BUS);

Is the cast still necessary, or does object_dynamic_cast() return void*
so that you can omit the cast?

> +    if (sdbus =3D=3D NULL) {
> +        error_set(errp, ERROR_CLASS_GENERIC_ERROR,
> +                  "Device '%s' not a sd-bus", qom_path);
> +        return NULL;
> +    }
> +
> +    res =3D g_new0(SDBusCommandResponse, 1);
> +    sz =3D sdbus_do_command(sdbus,
> +                          &(SDRequest){ command, arg, has_crc ? crc : =
-1 },

It's probably safer to use specific initializer assignments, as in:

&(SDRequest){ .cmd =3D command, .arg =3D arg, ...


> +++ b/stubs/qmp_sdbus.c
> @@ -0,0 +1,12 @@
> +#include "qemu/osdep.h"
> +#include "qmp-commands.h"
> +#include "hw/sd/sd.h"
> +
> +SDBusCommandResponse *qmp_x_debug_sdbus_command(const char *qom_path,
> +                                                uint8_t command,
> +                                                bool has_arg, uint64_t=
 arg,
> +                                                bool has_crc, uint16_t=
 crc,
> +                                                Error **errp)
> +{
> +    return NULL;

In addition to returning NULL, the stub should set errp.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--W4biKDCEaGqSdq1DrQTEyAlLQtS33lTdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPmecACgkQp6FrSiUn
Q2r12ggArLXPQ2gRv0pr99Aou201JAZ+dZy9KB4z6rxBJk4DvDMsCowI8cScGkQ/
zDxuI4iPY2F2aUoPzhZRtSt/Rl8Gv1jEY4WSIS88BzTNN0eVXH3IFXGswUGCtFII
ifKmhCE4nIATRRC9/FUJqhour19mOI8q1a2dUFnJoUplyhQ9PaFFdXpS/Py4Vp7P
US43GHf87N5NNd3e5XESBgleFe0x7ZgwojwT29P2JCc3DS9HhsD0if8iRx5YyX4g
u8vw3Pn0p2RoqPBrXAX3LNQEzak/A61QKESyxD0uv4vlOjPV0BMRzR7bs1DaLltv
85lRlkhKl+bphAh9DRdaxFS/dtQOuQ==
=AhoN
-----END PGP SIGNATURE-----

--W4biKDCEaGqSdq1DrQTEyAlLQtS33lTdQ--
