Received: from eggs.gnu.org ([2001:4830:134:3::10]:33003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkim-0002tL-9v
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZkil-0001D6-Gh
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:16:56 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZkil-0001CT-A4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:16:55 -0400
Received: by mail-wm0-x22f.google.com with SMTP id c184so36133880wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:16:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-4-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:16:33 +0100
Message-ID: <CAFEAcA8QspP_PEaWBKVt7QWOpwHjJNav3x9yy9D-hX5D8_QzUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 03/35] thunk: check nb_fields is
 valid before continuing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> thunk.c:91:32: warning: Call to 'malloc' has an allocation size of 0 byte=
s
>         se->field_offsets[i] =3D malloc(nb_fields * sizeof(int));
>                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  thunk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/thunk.c b/thunk.c
> index 2dac36666d..d1c5e221f5 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -67,7 +67,6 @@ void thunk_register_struct(int id, const char *name, co=
nst argtype *types)
>      int nb_fields, offset, max_align, align, size, i, j;
>
>      assert(id < max_struct_entries);
> -    se =3D struct_entries + id;
>
>      /* first we count the number of fields */
>      type_ptr =3D types;
> @@ -76,6 +75,10 @@ void thunk_register_struct(int id, const char *name, c=
onst argtype *types)
>          type_ptr =3D thunk_type_next(type_ptr);
>          nb_fields++;
>      }
> +    if (!nb_fields) {
> +        return;
> +    }

Can this ever actually happen? We only call this function
for a fixed set of known-at-compile-time data (it's invoked
by all the STRUCT() macro uses). It seems likely that it
would be better to make this an assert() and check that none
of our uses of STRUCT() cause it to fire.

> +    se =3D struct_entries + id;
>      se->field_types =3D types;
>      se->nb_fields =3D nb_fields;
>      se->name =3D name;
> --
> 2.13.3
>

thanks
-- PMM
