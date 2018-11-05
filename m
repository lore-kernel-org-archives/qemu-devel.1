Received: from eggs.gnu.org ([2001:4830:134:3::10]:39099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2O-0005j5-KB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2L-0006Sv-DQ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gJa2L-0006SL-90
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so13271603qkg.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 00:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20181019164929.18404-1-mreitz@redhat.com>
	<20181019164929.18404-4-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-4-mreitz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Nov 2018 12:14:53 +0400
Message-ID: <CAMxuvaxPo80xnpFNPdVnDokLvwnzERFRV+tyfWDKO_TWoyiB9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] qdev-monitor: Make device options
 help nicer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>, "Wolf, Kevin" <kwolf@redhat.com>

On Fri, Oct 19, 2018 at 8:49 PM Max Reitz <mreitz@redhat.com> wrote:
>
> Just like in qemu_opts_print_help(), print the device name as a caption
> instead of on every single line, indent all options, add angle brackets
> around types, and align the descriptions after 24 characters.  Also,
> separate the descriptions with " - " instead of putting them in
> parentheses, because that is what we do everywhere else.  This does look
> a bit funny here because basically all bits have the description
> "on/off", but funny does not mean it is less readable.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qdev-monitor.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 802c18a74e..07147c63bf 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -285,10 +285,19 @@ int qdev_device_help(QemuOpts *opts)
>          goto error;
>      }
>
> +    if (prop_list) {
> +        out_printf("%s options:\n", driver);
> +    } else {
> +        out_printf("There are no options for %s.\n", driver);
> +    }
>      for (prop =3D prop_list; prop; prop =3D prop->next) {
> -        out_printf("%s.%s=3D%s", driver, prop->value->name, prop->value-=
>type);
> +        int len;
> +        out_printf("  %s=3D<%s>%n", prop->value->name, prop->value->type=
, &len);
>          if (prop->value->has_description) {
> -            out_printf(" (%s)\n", prop->value->description);
> +            if (len < 24) {
> +                out_printf("%*s", 24 - len, "");
> +            }
> +            out_printf(" - %s\n", prop->value->description);
>          } else {
>              out_printf("\n");
>          }
> --
> 2.17.1
>
