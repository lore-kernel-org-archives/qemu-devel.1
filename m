Received: from eggs.gnu.org ([2001:4830:134:3::10]:44873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqK0K-0006Tg-4W
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqK0H-000655-1e
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqK0G-00064E-Ov
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:39:12 -0400
References: <20170316102351.25056-1-vfeenstr@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a5dab83-40ce-e747-6399-ca693ccf278e@redhat.com>
Date: Tue, 21 Mar 2017 08:39:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170316102351.25056-1-vfeenstr@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FVTjBToCtJfmpUnQU6DcQOS1sGq2VEJEE"
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add guest-get-osinfo command
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
--FVTjBToCtJfmpUnQU6DcQOS1sGq2VEJEE
From: Eric Blake <eblake@redhat.com>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com
Message-ID: <1a5dab83-40ce-e747-6399-ca693ccf278e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: add guest-get-osinfo command
References: <20170316102351.25056-1-vfeenstr@redhat.com>
In-Reply-To: <20170316102351.25056-1-vfeenstr@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 05:23 AM, Vinzenz 'evilissimo' Feenstra wrote:
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


> +static void ga_get_linux_distribution_info(GuestOSInfo *info)
> +{
> +    FILE *fp =3D NULL;
> +    fp =3D fopen("/etc/os-release", "r");

Rather than read random files, I'm thinking that the uname() syscall is
a better approach.  It is portable to more guests (since uname is a
POSIX interface), even if it is somewhat more limited on the information
it provides.

> +++ b/qga/commands-win32.c
> @@ -1536,3 +1536,108 @@ void ga_command_state_init(GAState *s, GAComman=
dState *cs)
>          ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
>      }
>  }

> +static char *ga_get_win_ver(void)
> +{
> +    OSVERSIONINFOEXW os_version;
> +    ga_get_version(&os_version);
> +    char buf[64] =3D {};
> +    int major =3D (int)os_version.dwMajorVersion;
> +    int minor =3D (int)os_version.dwMinorVersion;
> +    sprintf(buf, "%d.%d", major, minor);
> +    return strdup(buf);

Instead of using strdup() (which uses malloc()), you should be using
g_strdup_printf() (which uses g_malloc().  In general, we prefer
g_malloc/g_free over raw malloc.  And once you use g_strdup_printf, you
no longer have to worry about whether buf is allocated large enough to
avoid overflow with sprintf.


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
> +# Since: 2.8

You've missed 2.8 by a long shot. In fact, you've missed hard freeze for
2.9, so this needs to be 2.10.

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

Rather than printing an empty string, would it be better to make the
fields optional, and omit them when there is nothing useful to supply?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FVTjBToCtJfmpUnQU6DcQOS1sGq2VEJEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0Sz7AAoJEKeha0olJ0NqbmcIAIY3/LYrHUjcUXrUNN2cjD+0
Zl66k1efBNxzL6jlJyW3c7KAvavi5DX8PTdixewXk6QzywO92J9lYOhhkAu1Pi/V
xikvNV2O5IKQEp1cwZqxyVSPbtja4yTMxcI95Ycx8mAsAFpK6xxwdP7Duf3lO944
4gtwOYdC8KLocgZ+FWpntKE8SCpfTxu+JfTak2RuVufkObPmHtaqqqBfv0sjti8J
oA8qwJRMafuUQooJsu5+KVcUFFaP3Gib3iRNnDpgh3uP4g1DCRoUPrr5s52KkDS1
KQI6enearnwIr0gfUWe2tplWIvjxAMyxgwxucRqwqNomNRXvUgaeF5EJRro4PAU=
=yCDi
-----END PGP SIGNATURE-----

--FVTjBToCtJfmpUnQU6DcQOS1sGq2VEJEE--
