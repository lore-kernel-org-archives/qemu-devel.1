Received: from eggs.gnu.org ([209.51.188.92]:51033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghVjb-0004Yl-Fu
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ghVja-0006GU-Gj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:30:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ghVjY-00065f-MD
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:30:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so12772490wmd.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 00:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-2-ehabkost@redhat.com>
In-Reply-To: <20190110020259.8492-2-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 10 Jan 2019 12:30:18 +0400
Message-ID: <CAJ+F1CLZu1tnWc047xEBLT-K2LAwHL2+6TvS+UGuzGEBpHVRFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qom: Don't keep error value between
 object_property_parse() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jan 10, 2019 at 6:04 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> When handling errp=3D=3DNULL at object_apply_global_props(), we are
> leaving the old error value in `err` after printing a warning.
> This makes QEMU crash if two global properties generate warnings:
>
>   $ echo device_add rtl8139 | qemu-system-x86_64 -monitor stdio -global r=
tl8139.xxx=3Dyyy -global rtl8139.xxx=3Dzzz
>   warning: can't apply global rtl8139.xxx=3Dyyy: Property '.xxx' not foun=
d
>   qemu-system-x86_64: util/error.c:57: error_setv: Assertion `*errp =3D=
=3D NULL' failed.
>   Aborted (core dumped)
>
> Fix that by making `err` go out of scope immediately after the
> warn_report_err() call.
>
> Fixes: 50545b2cc029 "qdev-props: call object_apply_global_props()"
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index aa6f3a2a71..4e5226ca12 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -372,7 +372,6 @@ static void object_post_init_with_type(Object *obj, T=
ypeImpl *ti)
>
>  void object_apply_global_props(Object *obj, const GPtrArray *props, Erro=
r **errp)
>  {
> -    Error *err =3D NULL;
>      int i;
>
>      if (!props) {
> @@ -381,6 +380,7 @@ void object_apply_global_props(Object *obj, const GPt=
rArray *props, Error **errp
>
>      for (i =3D 0; i < props->len; i++) {
>          GlobalProperty *p =3D g_ptr_array_index(props, i);
> +        Error *err =3D NULL;
>
>          if (object_dynamic_cast(obj, p->driver) =3D=3D NULL) {
>              continue;
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>


--=20
Marc-Andr=C3=A9 Lureau
