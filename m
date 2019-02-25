Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyJ2D-0000oU-B6
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyJ2C-000287-Bt
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:17 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyJ2C-0001xW-2P
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:16 -0500
Received: by mail-wr1-x444.google.com with SMTP id i16so10580554wrs.13
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:22:54 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-8-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-8-cota@braap.org>
Date: Mon, 25 Feb 2019 16:22:52 +0000
Message-ID: <875zt7n8gz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 07/38] queue: add QTAILQ_REMOVE_SEVERAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> This is faster than removing elements one by one.
>
> Will gain a user soon.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qemu/queue.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index ac418efc43..0283c2dd7d 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -419,6 +419,16 @@ struct {                                            =
                    \
>          (elm)->field.tqe_prev =3D NULL;                                 =
  \
>  } while (/*CONSTCOND*/0)
>
> +/* remove @left, @right and all elements in between from @head */
> +#define QTAILQ_REMOVE_SEVERAL(head, left, right, field) do {    \
> +        if (((right)->field.tqe_next) !=3D NULL)                  \
> +            (right)->field.tqe_next->field.tqe_prev =3D           \
> +                (left)->field.tqe_prev;                         \
> +        else                                                    \
> +            (head)->tqh_last =3D (left)->field.tqe_prev;          \
> +        *(left)->field.tqe_prev =3D (right)->field.tqe_next;      \

This seems wrong, shouldn't it be:

  (left)->field.tqe_prev->field.tqe_next =3D (right)->field.tqe_next;

Although to be honest every time I read the QUEUE macros I end up with a he=
adache...

> +    } while (/*CONSTCOND*/0)
> +
>  #define QTAILQ_FOREACH(var, head, field)                                \
>          for ((var) =3D ((head)->tqh_first);                             =
  \
>                  (var);                                                  \


--
Alex Benn=C3=A9e
