Received: from eggs.gnu.org ([2001:4830:134:3::10]:60483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr4CU-0001Nl-VK
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr4CR-00074D-L7
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr4CR-000747-BX
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:58:51 -0400
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
	<20170316145045.10840-1-vfeenstr@redhat.com>
	<20170316145045.10840-2-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05ad6588-58c5-796c-48b5-05bb6c2dc612@redhat.com>
Date: Thu, 23 Mar 2017 09:58:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170316145045.10840-2-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="64UL2OFumHQpt9lDeqekoqRjV5735X3Jx"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-ga: add guest-get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--64UL2OFumHQpt9lDeqekoqRjV5735X3Jx
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <05ad6588-58c5-796c-48b5-05bb6c2dc612@redhat.com>
Subject: Re: [PATCH v2] qemu-ga: add guest-get-osinfo command
References: <0342808A-63C6-40BE-91AB-B6088AD62CD2@redhat.com>
 <20170316145045.10840-1-vfeenstr@redhat.com>
 <20170316145045.10840-2-vfeenstr@redhat.com>
In-Reply-To: <20170316145045.10840-2-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 09:50 AM, Vinzenz 'evilissimo' Feenstra wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> Add a new 'guest-get-osinfo' command for reporting basic information of=

> the guest operating system (hereafter just 'OS'). This information
> includes the type of the OS, the version, and the architecture.
> Additionally reported would be a name, distribution type and kernel
> version where applicable.
>=20
> Here an example for a Fedora 25 VM:
>=20
> $ virsh -c qemu:////system qemu-agent-command F25 \
>     '{ "execute": "guest-get-osinfo" }'
>   {"return":{"arch":"x86_64","codename":"Server Edition","version":"25"=
,
>    "kernel":"4.8.6-300.fc25.x86_64","type":"linux","distribution":"Fedo=
ra"}}
>=20
> And an example for a Windows 2012 R2 VM:
>=20
> $ virsh -c qemu:////system qemu-agent-command Win2k12R2 \
>     '{ "execute": "guest-get-osinfo" }'
>   {"return":{"arch":"x86_64","codename":"Win 2012 R2",
>    "version":"6.3","kernel":"","type":"windows","distribution":""}}
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---

Let's make sure we get the interface right, before I even bother looking
at the code.

> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,43 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +##
> +# @GuestOSType:
> +#
> +# @linux:    Indicator for linux distributions
> +# @windows:  Indicator for windows versions
> +# @other:    Indicator for any other operating system that is not yet
> +#            explicitly supported
> +#
> +# Since: 2.10
> +##
> +{ 'enum': 'GuestOSType', 'data': ['linux', 'windows', 'other'] }
> +
> +##
> +# @GuestOSInfo:
> +#
> +# @version:      OS version, e.g. 25 for FC25 etc.
> +# @distribution: Fedora, Ubuntu, Debian, CentOS...
> +# @codename:     Code name of the OS. e.g. Ubuntu has Xenial Xerus etc=
=2E
> +# @arch:         Architecture of the OS e.g. x86, x86_64, ppc64, aarch=
64...
> +# @type:         Specifies the type of the OS.
> +# @kernel:       Linux kernel version (Might be used by other OS types=
 too).
> +#                May be empty.

Why would it be empty, instead of just omitted?

> +# Since: 2.10
> +##
> +{ 'struct': 'GuestOSInfo',
> +  'data': { '*version': 'str', '*distribution': 'str', '*codename': 's=
tr',
> +            '*arch': 'str', 'type': 'GuestOSType', '*kernel': 'str'} }=


So everything except 'type' is optional?  Is there anything a client can
actually rely on being always present?

uname() is probably the lowest-common-denominator interface for
describing a system (in that it is implemented on more OSs than anything
else, and Windows information can be mapped to uname concepts).  Let's
compare:

POSIX says:
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/sys_utsname.h.ht=
ml#tag_13_70

    The <sys/utsname.h> header shall define the structure utsname which
shall include at least the following members:

    char  sysname[]  Name of this implementation of the operating system.=

    char  nodename[] Name of this node within the communications
                     network to which this node is attached, if any.
    char  release[]  Current release level of this implementation.
    char  version[]  Current version level of this release.
    char  machine[]  Name of the hardware type on which the system is
running.

So you both have version; your 'arch' maps somewhat to machine, your
'type' maps somewhat to sysname, your 'kernel' probably matches release,
and then you are adding 'distribution' and 'codename' which don't appear
in uname output.  Is it worth naming your members after the uname()
names, for less confusion?

> +
> +##
> +# @guest-get-osinfo:
> +#
> +# Retrieve guest operating system information
> +#
> +# Returns: operating system information on success
> +#
> +# Since 2.10
> +##
> +{ 'command': 'guest-get-osinfo',
> +  'returns': 'GuestOSInfo' }
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--64UL2OFumHQpt9lDeqekoqRjV5735X3Jx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0+KoAAoJEKeha0olJ0NqpCAH/3+9/Snl1+HIsFZvQxRzy4e4
jzst7I7ZN90QwYE82zYcahvtMsN8JuRH90o+P/TARwSNU8ugU0TI4GyE4s3pqtKw
JW5EWdLAox+WL2E014r3DF5i9dcQ9PagI2lPtIhi9a1DcWWTg2kx7Uwww49LUbUY
mkly13ri+KxU+DCh8b1xvMnAwTT5hs/M5MB7NpHtORrdElhrXK3Z7u77gqSP3mdq
S8pVAz0n+uvQBOA3Olx9ExhIBEwpGFUCjEUYss9/pQdt/YFIhlg7i9Tcp64laeGu
0M7IiKQpeGybvbNtZKoLW4rtFlLVqm9WdodLVpFZ4nFJkuP55kbHvoEwfrQOQBw=
=ewvC
-----END PGP SIGNATURE-----

--64UL2OFumHQpt9lDeqekoqRjV5735X3Jx--
