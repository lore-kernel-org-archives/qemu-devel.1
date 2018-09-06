Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwAg-0002Aj-FA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxwAd-00062J-8X
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:26:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxwAd-00061A-2I
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:26:11 -0400
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
	<20180906151227.25514-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <82e2a979-4f01-6ed6-a220-ccb3e8fc75a4@redhat.com>
Date: Thu, 6 Sep 2018 10:26:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180906151227.25514-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-option: add help fallback to
 print the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 09/06/2018 10:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> QDev options accept '?' or 'help' in the list of parameters, which is
> really handy to list the available options.
>=20
> Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily()
> seems to be the common path for command line options, so place a
> fallback to check for '?' and print help listing available options.
>=20
> This is very handy, for example with qemu "-spice ?".

Is that literal spelling intended (a single argument with an embedded=20
space)? Because that would result in:
qemu: -spice help: invalid option

Or did you mean "qemu -spice '?'" (with the outer quotes delimiting what=20
you type, and the inner quote properly escaping the ? to avoid=20
unintended globbing if you have a one-byte file name in the current=20
directory)?

Also, I'd rather see you favor the 'help' spelling in your text; the '?'=20
spelling should continue to work (by virtue of has_help_option), but as=20
that form requires shell quoting while 'help' does not, we should=20
minimize its use in our documentation to avoid people forgetting to=20
quote it and then hitting unintended shell globbing effects.  That would=20
make your example "qemu -spice help".

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   util/qemu-option.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>=20
> @@ -886,10 +891,16 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *l=
ist, const char *params,
>   {
>       Error *err =3D NULL;
>       QemuOpts *opts;
> +    bool invalidp =3D false;
>  =20
> -    opts =3D opts_parse(list, params, permit_abbrev, false, &err);
> +    opts =3D opts_parse(list, params, permit_abbrev, false, &invalidp,=
 &err);
>       if (err) {
> -        error_report_err(err);
> +        if (invalidp && has_help_option(params)) {
> +            qemu_opts_print_help(list);
> +            error_free(err);
> +        } else {
> +            error_report_err(err);
> +        }

This makes sense.  With a better commit message,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
