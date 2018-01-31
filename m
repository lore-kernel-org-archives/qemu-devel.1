Received: from eggs.gnu.org ([2001:4830:134:3::10]:55621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1egsFm-00047p-PO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1egsFh-00020Q-4Q
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:16:42 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1egsFg-0001zw-Ul
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:16:37 -0500
Received: by mail-wm0-x242.google.com with SMTP id 141so7886579wme.3
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 05:16:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131130613.30959-1-klim.kireev@virtuozzo.com>
References: <20180131130613.30959-1-klim.kireev@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Jan 2018 14:16:34 +0100
Message-ID: <CAJ+F1C+PL8W1GosN2qrgwGRJ+kTc4nur9oZe3QCUqNqBszX6Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: fix segfault in closed connection
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Wed, Jan 31, 2018 at 2:06 PM, Klim Kireev <klim.kireev@virtuozzo.com> wr=
ote:
> On one of our client's node, due to trying to read from closed ioc,
> a segmentation fault occured. Corresponding backtrace:
>

Oops, you probably forgot an extra space before the # interpreted as commen=
t.

Do you have a reproducer?

> Having analyzed the coredump, I understood that the reason is that
> ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
> in vnc_disconnect_finish. Between these two events due to some
> reasons the ioc_tag was set again and after vnc_disconnect_finish
> the handler is running with freed ioc,
> which led to the segmentation fault.
>
> I suggest to check ioc_tag in vnc_disconnect_finish to prevent such
> an occurrence.


>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> ---
>  ui/vnc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 33b087221f..b8bf0180cb 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1270,6 +1270,10 @@ void vnc_disconnect_finish(VncState *vs)
>      }
>      g_free(vs->lossy_rect);
>
> +    if (vs->ioc_tag) {
> +        g_source_remove(vs->ioc_tag);
> +        vs->ioc_tag =3D 0;
> +    }
>      object_unref(OBJECT(vs->ioc));
>      vs->ioc =3D NULL;
>      object_unref(OBJECT(vs->sioc));
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
