Received: from eggs.gnu.org ([2001:4830:134:3::10]:54670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cymBI-0000KH-VF
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cymBD-00053P-Tn
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:21:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cymBD-00052d-Kn
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:21:27 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3DLJYVU129698
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 17:21:26 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29t69af4sv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 17:21:26 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 13 Apr 2017 15:21:25 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170404064631.16287-2-vfeenstr@redhat.com>
References: <20170404064631.16287-1-vfeenstr@redhat.com>
	<20170404064631.16287-2-vfeenstr@redhat.com>
Date: Thu, 13 Apr 2017 16:20:58 -0500
Message-Id: <149211845808.23121.11129620924125696287@loki>
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
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org
Cc: sameeh@daynix.com

Quoting Vinzenz 'evilissimo' Feenstra (2017-04-04 01:46:31)
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
> =

> Retrieving the guest host name is a very useful feature for virtual manag=
ement
> systems. This information can help to have more user friendly VM access
> details, instead of an IP there would be the host name. Also the host name
> reported can be used to have automated checks for valid SSL certificates.
> =

> virsh # qemu-agent-command F25 '{ "execute": "guest-get-host-name" }'
> {"return":{"host-name":"F25.lab.evilissimo.net"}}
> =

> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>

Thanks, applied to qga tree with some minor whitespace fix-ups:

  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands.c       | 11 +++++++++++
>  qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> =

> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..57a31bb 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,14 @@ int ga_parse_whence(GuestFileWhence *whence, Error *=
*errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
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
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
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
> +# The returned name is not necessarily a fully-qualified domain name, or=
 even
> +# present in DNS or some other name service at all. It need not even be =
unique
> +# on your local network or site, but usually it is.
> +#
> +# Returns: the host name of the machine on success
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-host-name',
> +  'returns': 'GuestHostName' }
> +
> -- =

> 2.9.3
> =

>=20
