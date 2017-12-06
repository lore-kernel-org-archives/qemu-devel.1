Received: from eggs.gnu.org ([2001:4830:134:3::10]:49065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eMWI6-0008S5-Fv
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eMWI5-0003pE-Lj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:46:58 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:46375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eMWI5-0003nr-FR
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:46:57 -0500
Received: by mail-wm0-x243.google.com with SMTP id r78so6098729wme.5
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 01:46:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABkJTM4RL4cZ0euYX7d8xPd7ozrN76nr0rafut0LBJmZWFD+Vw@mail.gmail.com>
References: <CABkJTM4RL4cZ0euYX7d8xPd7ozrN76nr0rafut0LBJmZWFD+Vw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 6 Dec 2017 10:46:54 +0100
Message-ID: <CAJ+F1C+6Gt-STfZhsRsr-q9YeMOP5jyRiQ73OuhO9Uz+QE3fGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] input: free InputEvent when it can't be
 inserted into a full kdb queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?55Sw5q6/6Iej?= <dianchen.tdc@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, icymemo@gmail.com, quan.xu0@gmail.com

Hi

On Wed, Dec 6, 2017 at 3:29 AM, =E7=94=B0=E6=AE=BF=E8=87=A3 <dianchen.tdc@g=
mail.com> wrote:
> From e8c03f405c2112428e79bb82064c7b7743d0cc86 Mon Sep 17 00:00:00 2001
> From: Tian Dianchen <dianchen.tdc@gmail.com>
> Date: Tue, 5 Dec 2017 14:03:53 +0800
> Subject: [PATCH] input: free InputEvent when it can't be inserted into a
> full
>  kdb queue
>
> When the kdb queue is full, the evt can't be placed in it, so it should
> be released to free the memory.
>
> Impact: Without this limit vnc clients can exhaust host memory by keep
> sending keyboard events when kdb queue is full.

You may add "Leak introduced in commit fa18f36a461984eae50ab957e47ec78dae3c=
14fc"

>
> Reviewed-by: Zhang Chao <icymemo@gmail.com>
> Reviewed-by: Quan Xu <quan.xu0@gmail.com>
> Signed-off-by: Tian Dianchen <dianchen.tdc@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/input.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ui/input.c b/ui/input.c
> index 3e2d324..e5b78aa 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -421,6 +421,8 @@ void qemu_input_event_send_key(QemuConsole *src,
> KeyValue *key, bool down)
>      } else if (queue_count < queue_limit) {
>          qemu_input_queue_event(&kbd_queue, src, evt);
>          qemu_input_queue_sync(&kbd_queue);
> +    } else {
> +        qapi_free_InputEvent(evt);
>      }
>  }
>
> --
> 1.8.3.1



--=20
Marc-Andr=C3=A9 Lureau
