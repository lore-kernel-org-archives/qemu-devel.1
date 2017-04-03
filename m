Received: from eggs.gnu.org ([2001:4830:134:3::10]:47547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv8Lf-00089n-0h
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv8Lb-0002r6-Rs
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv8Lb-0002qF-KL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:13:07 -0400
References: <20170403200823.7394-1-vfeenstr@redhat.com>
	<20170403200823.7394-2-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6711448f-1b5f-337e-471a-59fe56284bd1@redhat.com>
Date: Mon, 3 Apr 2017 15:13:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170403200823.7394-2-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gPKLLM0TaKIr609gW25JNFuNiLORflgcp"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gPKLLM0TaKIr609gW25JNFuNiLORflgcp
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Message-ID: <6711448f-1b5f-337e-471a-59fe56284bd1@redhat.com>
Subject: Re: [PATCH v2 1/1] qga: Add 'guest-get-users' command
References: <20170403200823.7394-1-vfeenstr@redhat.com>
 <20170403200823.7394-2-vfeenstr@redhat.com>
In-Reply-To: <20170403200823.7394-2-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 03:08 PM, Vinzenz 'evilissimo' Feenstra wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> A command that will list all currently logged in users, and the time
> since when they are logged in.
>=20
> Examples:
>=20
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
> {"return":[{"login-time":1490622289.903835,"user":"root"}]}
>=20
> virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" }'=

> {"return":[{"login-time":1490351044.670552,"domain":"LADIDA",
> "user":"Administrator"}]}
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---

I'll leave the code reviews for others (I'm not comfortable enough with
Windows API programming), but focus on the interface here:

> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,25 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +##
> +# @GuestUser:
> +# @user:       Username
> +# @domain:     Logon domain (windows only)
> +# @login-time: Unix timestamp of login

In what unit? (Fractional) seconds since 1 Jan 1970?

So this is when they connected, and not a duration of how long they have
been logged on since then.

> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestUser',
> +  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' } =
}
> +
> +##
> +# @guest-get-users:
> +# Retrieves a list of currently active users on the VM.
> +#
> +# Returns: A unique list of users.
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-users',
> +  'returns': ['GuestUser'] }
>=20

The API looks good once you add that additional documentation.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gPKLLM0TaKIr609gW25JNFuNiLORflgcp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4qzQAAoJEKeha0olJ0NqE74H/1/49OILddA7NaXTMflzxDIA
OQ5zufQgHMgl2YJyRX1mz//XWRDPCvbD0tJ3IWjFD5s43OV4uwDZ47/TkAc4cN+C
KHQoOWttWw4lSaa+Hf2j2Oue7Kqd2rdBr7xCSlIiqzebr6d720RgcbOpd/J+4Kvm
NNbJ1j1pBPNixezk+d3mrGLyHrMBLTmf2s9VuKkZqtNrJC52kMnbgkwPeihotOjs
tLaOBd+4/hMffXBPG1j5Qy6DsmtHi6CR7F7TZPRKmh3RJxqc45u06xh0NKM1bkGb
jRSLOk8n5pCqgdT+8HhP+Oo2bhfJjzFTA3n+2spN2A0+cZ62hQ+sF3NvZlFgCjA=
=Ja+Z
-----END PGP SIGNATURE-----

--gPKLLM0TaKIr609gW25JNFuNiLORflgcp--
