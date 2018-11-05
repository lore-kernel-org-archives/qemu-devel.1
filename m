Received: from eggs.gnu.org ([2001:4830:134:3::10]:39155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2c-0005xf-OW
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2W-0006lT-Lq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gJa2W-0006kf-Ch
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so13203416qkg.5
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 00:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20181019164929.18404-1-mreitz@redhat.com>
	<20181019164929.18404-5-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-5-mreitz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Nov 2018 12:15:04 +0400
Message-ID: <CAMxuvax7sACRkitJDbewzwG2OB3tySPaJCGHPE9JkDiyr-r5eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] object: Make option help nicer to
 read
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
> Just like in qemu_opts_print_help(), print the object name as a caption
> instead of on every single line, indent all options, add angle brackets
> around types, and align the descriptions after 24 characters.
>
> Also, indent every object name in the list of available objects.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index ac3ed17de4..ecddbb6b8e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2707,7 +2707,7 @@ static bool object_create_initial(const char *type,=
 QemuOpts *opts)
>          list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, false=
);
>          for (l =3D list; l !=3D NULL; l =3D l->next) {
>              ObjectClass *oc =3D OBJECT_CLASS(l->data);
> -            printf("%s\n", object_class_get_name(oc));
> +            printf("  %s\n", object_class_get_name(oc));
>          }
>          g_slist_free(list);
>          exit(0);
> @@ -2729,14 +2729,21 @@ static bool object_create_initial(const char *typ=
e, QemuOpts *opts)
>              }
>
>              str =3D g_string_new(NULL);
> -            g_string_append_printf(str, "%s.%s=3D%s", type,
> -                                   prop->name, prop->type);
> +            g_string_append_printf(str, "  %s=3D<%s>", prop->name, prop-=
>type);
>              if (prop->description) {
> +                if (str->len < 24) {
> +                    g_string_append_printf(str, "%*s", 24 - (int)str->le=
n, "");
> +                }
>                  g_string_append_printf(str, " - %s", prop->description);
>              }
>              g_ptr_array_add(array, g_string_free(str, false));
>          }
>          g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
> +        if (array->len > 0) {
> +            printf("%s options:\n", type);
> +        } else {
> +            printf("There are no options for %s.\n", type);
> +        }
>          for (i =3D 0; i < array->len; i++) {
>              printf("%s\n", (char *)array->pdata[i]);
>          }
> --
> 2.17.1
>
