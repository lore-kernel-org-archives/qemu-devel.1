Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZhhy-0001Vq-BG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZhhv-0002gg-MS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:03:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dZhhv-0002gI-CU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:03:51 -0400
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<150091841019.30739.3661641061220051037.stgit@frigg.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com>
Date: Mon, 24 Jul 2017 13:03:46 -0500
MIME-Version: 1.0
In-Reply-To: <150091841019.30739.3661641061220051037.stgit@frigg.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gcd7u9ifMfTQoJinu0RH782WbaJf63Ou1"
Subject: Re: [Qemu-devel] [PATCH 11/13] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gcd7u9ifMfTQoJinu0RH782WbaJf63Ou1
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com>
Subject: Re: [PATCH 11/13] instrument: [qapi] Add library loader
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
 <150091841019.30739.3661641061220051037.stgit@frigg.lan>
In-Reply-To: <150091841019.30739.3661641061220051037.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 12:46 PM, Llu=C3=ADs Vilanova wrote:
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> ---
>  instrument/Makefile.objs |    1 +
>  instrument/qmp.c         |   71 ++++++++++++++++++++++++++++++++++++
>  qapi-schema.json         |    3 ++
>  qapi/instrument.json     |   92 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 167 insertions(+)
>  create mode 100644 instrument/qmp.c
>  create mode 100644 qapi/instrument.json

Adding new files; but I don't see a patch to MAINTAINERS to cover
instrument/*.

> +++ b/qapi/instrument.json
> @@ -0,0 +1,92 @@
> +# *-*- Mode: Python -*-*
> +#
> +# QAPI trace instrumentation control commands.
> +#
> +# Copyright (C) 2012-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> +# See the COPYING file in the top-level directory.
> +
> +##
> +# @InstrLoadCode:
> +#
> +# Result code of an 'instr-load' command.
> +#
> +# @ok: Correctly loaded.
> +# @unavailable: Service not available.
> +# @error: Error with libdl (see 'msg').
> +#
> +# Since: 2.10

This is a new feature, and you've missed soft freeze.  You'll want to
use 2.11 throughout the file.

> +##
> +{ 'enum': 'InstrLoadCode',
> +  'data': [ 'ok', 'unavailable', 'error' ] }
> +
> +##
> +# @InstrLoadResult:
> +#
> +# Result of an 'instr-load' command.
> +#
> +# @code: Result code.
> +# @msg: Additional error message.

Worth a comment that the message is for human consumption, and should
not be further parsed by machine?

Should msg be optional, present only when there is an error?

> +# @handle: Instrumentation library identifier (undefined in case of er=
ror).

Should it be an optional member, omitted when there is an error?

> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'InstrLoadResult',
> +  'data': { 'code': 'InstrLoadCode', 'msg': 'str', 'handle': 'int' } }=

> +
> +##
> +# @instr-load:
> +#
> +# Load an instrumentation library.
> +#
> +# @path: path to the dynamic instrumentation library
> +# @args: arguments to the dynamic instrumentation library
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'instr-load',
> +  'data':    { 'path': 'str', '*args': ['String'] },

Why are you double-nesting things?  It's a lot nicer to use ['str']
(that is, your way requires
 "arguments":{"path":"/some/path",
   "args": [ { "str": "string1" }, { "str": "string2" } ] }

whereas mine only needs:
 "arguments":{"path":"/some/path", "args":[ "string1", "string2" ]}


> +  'returns': 'InstrLoadResult' }
> +
> +
> +##
> +# @InstrUnloadCode:
> +#
> +# Result code of an 'instr-unload' command.
> +#
> +# @ok: Correctly unloaded.
> +# @unavailable: Service not available.
> +# @invalid: Invalid handle.
> +# @error: Error with libdl (see 'msg').
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'InstrUnloadCode',
> +  'data': [ 'ok', 'unavailable', 'invalid', 'error' ] }
> +
> +##
> +# @InstrUnloadResult:
> +#
> +# Result of an 'instr-unload' command.
> +#
> +# @code: Result code.
> +# @msg: Additional error message.

Again, should msg be optional?  Document that it is only for human
consumption.

> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'InstrUnloadResult',
> +  'data': { 'code': 'InstrUnloadCode', 'msg': 'str' } }
> +
> +##
> +# @instr-unload:
> +#
> +# Unload an instrumentation library.
> +#
> +# @handle: Instrumentation library identifier (see #InstrLoadResult).
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'instr-unload',
> +  'data': { 'handle': 'int' },
> +  'returns': 'InstrUnloadResult' }
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gcd7u9ifMfTQoJinu0RH782WbaJf63Ou1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2NoIACgkQp6FrSiUn
Q2rPCAgAl05Cn+ctfcjgwxiyxrHRKgypLUw/shKPVrEIlEV7eBMgmrIOY2KvdX5P
fhygF9qaj5sVPIXiQfaDyN+hJrvab6DI5rTE1vCO9nokk60wpaHPElCcZ1bTTQw0
Hzbby7Uj6T4uer2sOhswRKKOD010m3PN7DeG8+AGjbWB+BOz2i2a0eN2bdYjkQYO
dqVYxqk0fDAm84Gs0qeN+BHguF4uXLgQsKZxMgr1xCegH+A6jFBFTjM1isr9NYyn
pf15fWt/+GnZs7XtTPPZKgk16sv9oZSK/7/0q9BXa//N9FtytNcWtWUcRtO9tUmA
cNKHyKBnjYOxXdpqz2qv9PnPCr/Hrg==
=z9xT
-----END PGP SIGNATURE-----

--gcd7u9ifMfTQoJinu0RH782WbaJf63Ou1--
