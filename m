Received: from eggs.gnu.org ([2001:4830:134:3::10]:50854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cxs70-0006iE-Uv
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cxs6w-0002dI-RQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:29:22 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cxs6w-0002cr-Ft
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:29:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id w64so58514949wma.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 02:29:18 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <AC129EDE-52C4-4261-B207-322B63E7FD92@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Tue, 11 Apr 2017 11:29:15 +0200
In-Reply-To: <20170404064631.16287-2-vfeenstr@redhat.com>
References: <20170404064631.16287-1-vfeenstr@redhat.com>
	<20170404064631.16287-2-vfeenstr@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qga: Add 'guest-get-host-name'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Sameeh Jubran <sameeh@daynix.com>

Ping

> On Apr 4, 2017, at 8:46 AM, Vinzenz 'evilissimo' Feenstra =
<vfeenstr@redhat.com> wrote:
>=20
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> Retrieving the guest host name is a very useful feature for virtual =
management
> systems. This information can help to have more user friendly VM =
access
> details, instead of an IP there would be the host name. Also the host =
name
> reported can be used to have automated checks for valid SSL =
certificates.
>=20
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-host-name" }'
> {"return":{"host-name":"F25.lab.evilissimo.net"}}
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
> qga/commands.c       | 11 +++++++++++
> qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
> 2 files changed, 40 insertions(+)
>=20
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..57a31bb 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,14 @@ int ga_parse_whence(GuestFileWhence *whence, =
Error **errp)
>     error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>     return -1;
> }
> +
> +GuestHostName *qmp_guest_get_host_name(Error **err)
> +{
> +    GuestHostName *result =3D NULL;
> +    gchar const *hostname =3D g_get_host_name();
> +    if (hostname !=3D NULL) {
> +        result =3D g_new0(GuestHostName, 1);
> +        result->host_name =3D g_strdup(hostname);
> +    }
> +    return result;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..b9f99ae 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,32 @@
>   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                '*input-data': 'str', '*capture-output': 'bool' },
>   'returns': 'GuestExec' }
> +
> +
> +
> +##
> +# @GuestHostName:
> +# @host-name: Fully qualified domain name of the guest OS
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestHostName',
> +  'data':   { 'host-name': 'str' } }
> +
> +
> +##
> +# @guest-get-host-name:
> +#
> +# Return a name for the machine.
> +#
> +# The returned name is not necessarily a fully-qualified domain name, =
or even
> +# present in DNS or some other name service at all. It need not even =
be unique
> +# on your local network or site, but usually it is.
> +#
> +# Returns: the host name of the machine on success
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-host-name',
> +  'returns': 'GuestHostName' }
> +
> --=20
> 2.9.3
>=20

--
Vinzenz Feenstra
Senior Software Developer
Red Hat Czech
