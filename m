Received: from eggs.gnu.org ([2001:4830:134:3::10]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1csS8S-00011N-Uc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1csS8O-0005zf-Rw
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:44:28 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:35617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1csS8O-0005zH-LE
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:44:24 -0400
Received: by mail-vk0-x242.google.com with SMTP id z204so7363394vkd.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 03:44:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323185107.2261-1-vfeenstr@redhat.com>
References: <20170323185107.2261-1-vfeenstr@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 27 Mar 2017 13:44:23 +0300
Message-ID: <CAKPgXcFF=9Uu+-ZztMjCjpd11Y0-v67G3DKNmKgg1yV23dxGow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-fqdn' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Thu, Mar 23, 2017 at 9:51 PM, Vinzenz 'evilissimo' Feenstra <
vfeenstr@redhat.com> wrote:

> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>
> Retrieving the guest OS fully qualified domain name (FQDN) is a very
> useful feature for virtual management systems. This information can help
> to have more user friendly VM access details, instead of an IP there
> would be the FQDN. Also the FQDN reported can be used to have automated
> checks for valid SSL certificates.
>
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-fqdn" }'
> {"return":{"fqdn":"F25.lab.evilissimo.net"}}
>
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> ---
>  qga/commands.c       | 11 +++++++++++
>  qga/qapi-schema.json | 25 +++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..61577af 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,14 @@ int ga_parse_whence(GuestFileWhence *whence, Error
> **errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestFQDN *qmp_guest_get_fqdn(Error **err)
> +{
> +    GuestFQDN *result = NULL;
> +    gchar const *hostname = g_get_host_name();
>
According to glib documentation on "g_get_host_name" function:
"The returned name is not necessarily a fully-qualified domain name, or
even present in DNS or some other name service at all. It need not even be
unique on your local network or site, but usually it is."
I think the command name should be changed to something like
"guest_get_machine_name" and not fqdn as this is not always true!

Moreover the documentation states that:
"If no name can be determined, a default fixed string "localhost" is
returned."
I think we should handle this case and return and informative error.

> +    if (hostname != NULL) {
> +        result = g_new0(GuestFQDN, 1);
> +        result->fqdn = g_strdup(hostname);
> +    }
> +    return result;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..0a2c0a4 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1042,3 +1042,28 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +
> +
> +##
> +# @GuestFQDN:
> +# @fqdn: Fully qualified domain name of the guest OS
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestFQDN',
> +  'data':   { 'fqdn': 'str' } }
> +
> +
> +##
> +# @guest-get-fqdn:
> +#
> +# Request the FQDN (Fully Qualified Domain Name) of the guest operating
> system
> +#
> +# Returns: FQDN on success
> +#
> +# Since: 2.10
> +##
> +{ 'command': 'guest-get-fqdn',
> +  'returns': 'GuestFQDN' }
> +
> --
> 2.9.3
>
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
