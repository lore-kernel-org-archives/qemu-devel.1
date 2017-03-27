Received: from eggs.gnu.org ([2001:4830:134:3::10]:53261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1csSgW-0002XK-2x
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1csSgR-0002UG-5v
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:19:40 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1csSgQ-0002To-RX
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:19:35 -0400
Received: by mail-wr0-f175.google.com with SMTP id w11so38431913wrc.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:19:34 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <EBAB1A85-3F82-471A-A146-DEBFF70A2E97@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Mon, 27 Mar 2017 13:19:29 +0200
In-Reply-To: <CAKPgXcFF=9Uu+-ZztMjCjpd11Y0-v67G3DKNmKgg1yV23dxGow@mail.gmail.com>
References: <20170323185107.2261-1-vfeenstr@redhat.com>
	<CAKPgXcFF=9Uu+-ZztMjCjpd11Y0-v67G3DKNmKgg1yV23dxGow@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-fqdn' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


> On Mar 27, 2017, at 12:44 PM, Sameeh Jubran <sameeh@daynix.com> wrote:
>=20
>=20
>=20
> On Thu, Mar 23, 2017 at 9:51 PM, Vinzenz 'evilissimo' Feenstra =
<vfeenstr@redhat.com <mailto:vfeenstr@redhat.com>> wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
>=20
> Retrieving the guest OS fully qualified domain name (FQDN) is a very
> useful feature for virtual management systems. This information can =
help
> to have more user friendly VM access details, instead of an IP there
> would be the FQDN. Also the FQDN reported can be used to have =
automated
> checks for valid SSL certificates.
>=20
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-fqdn" }'
> {"return":{"fqdn":"F25.lab.evilissimo.net =
<http://f25.lab.evilissimo.net/>"}}
>=20
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com =
<mailto:vfeenstr@redhat.com>>
> ---
>  qga/commands.c       | 11 +++++++++++
>  qga/qapi-schema.json | 25 +++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/qga/commands.c b/qga/commands.c
> index 4d92946..61577af 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -499,3 +499,14 @@ int ga_parse_whence(GuestFileWhence *whence, =
Error **errp)
>      error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
>      return -1;
>  }
> +
> +GuestFQDN *qmp_guest_get_fqdn(Error **err)
> +{
> +    GuestFQDN *result =3D NULL;
> +    gchar const *hostname =3D g_get_host_name();
> According to glib documentation on "g_get_host_name" function:
> "The returned name is not necessarily a fully-qualified domain name, =
or even present in DNS or some other name service at all. It need not =
even be unique on your local network or site, but usually it is."
> I think the command name should be changed to something like =
"guest_get_machine_name" and not fqdn as this is not always true!

I prefer the `guest_get_fqdn` name over the machine name, because on =
best effort this is, what
this method is trying to achieve. The machine name could be without =
domain part, and yes, this
could be what it returns, again it=E2=80=99s on best effort to get a =
FQDN.

>=20
> Moreover the documentation states that:
> "If no name can be determined, a default fixed string "localhost" is =
returned."
> I think we should handle this case and return and informative error.

Having a fallback which returns =E2=80=98localhost' is pretty much a =
good thing in my opinion.
We should document it, yes, but I wouldn=E2=80=99t report an error here. =
Especially what do you want
to report? Returning =E2=80=98localhost=E2=80=99 is a value and a report =
of an error at the same time.

I will leave this up for discussion and will follow up with an improved =
documentation of the
functionality.

> +    if (hostname !=3D NULL) {
> +        result =3D g_new0(GuestFQDN, 1);
> +        result->fqdn =3D g_strdup(hostname);
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
> +# Request the FQDN (Fully Qualified Domain Name) of the guest =
operating system
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
>=20
>=20
>=20
>=20
>=20
> --=20
> Respectfully,
> Sameeh Jubran
> Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>
> Software Engineer @ Daynix <http://www.daynix.com/>.
