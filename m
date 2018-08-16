Received: from eggs.gnu.org ([2001:4830:134:3::10]:59681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqCYP-0000XQ-Gs
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqCYM-0004j9-DC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqCYL-0004fj-Kv
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09D20C057F87
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:18:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180815195051.24586-1-marcandre.lureau@redhat.com>
Date: Thu, 16 Aug 2018 09:18:36 +0200
In-Reply-To: <20180815195051.24586-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 15 Aug 2018 21:50:50 +0200")
Message-ID: <87pnyieq43.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-option: add help fallback to
 print the list of options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> QDev options accept '?' or 'help' in the list of parameters, which is
> really handy to list the available options.
>
> Unfortunately, this isn't built in QemuOpts. qemu_opts_parse_noisily()
> seems to be the common path for command line options, so place a
> fallback to check for '?' and print help listing available options.

My immediate reaction was "how come this doesn't break -device help"?
It doesn't, because...

> This is very handy, for example with qemu "-spice ?".
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  util/qemu-option.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 01886efe90..8839ee6523 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -889,7 +889,12 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list=
, const char *params,
>=20=20
>      opts =3D opts_parse(list, params, permit_abbrev, false, &err);
>      if (err) {
> -        error_report_err(err);
> +        if (has_help_option(params)) {
> +            qemu_opts_print_help(list);
> +            error_free(err);
> +        } else {
> +            error_report_err(err);
> +        }
>      }
>      return opts;
>  }

... it only kicks in when parsing failed, and it doesn't for option
argument "help".

However, it *can* break for some option arguments:

    $ upstream-qemu -device e1000,id=3D@
    upstream-qemu: -device e1000,id=3D@: Parameter 'id' expects an identifi=
er
    Identifiers consist of letters, digits, '-', '.', '_', starting with a =
letter.
    [Exit 1 ]
    $ upstream-qemu -device e1000,id=3D@,help
    [Exit 1 ]

In the second test case, the error message gets replaced by (empty)
help.

I love patches improving help, but I can't immediately see how to
salvage this one.
