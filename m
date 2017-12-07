Received: from eggs.gnu.org ([2001:4830:134:3::10]:51353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dianchen.tdc@gmail.com>) id 1eMm4h-0002Pu-F5
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 21:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dianchen.tdc@gmail.com>) id 1eMm4g-0007wQ-Is
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 21:38:11 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dianchen.tdc@gmail.com>)
	id 1eMm4g-0007w8-Bf
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 21:38:10 -0500
Received: by mail-ot0-x234.google.com with SMTP id d5so5189618oti.3
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 18:38:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+6Gt-STfZhsRsr-q9YeMOP5jyRiQ73OuhO9Uz+QE3fGQ@mail.gmail.com>
References: <CABkJTM4RL4cZ0euYX7d8xPd7ozrN76nr0rafut0LBJmZWFD+Vw@mail.gmail.com>
	<CAJ+F1C+6Gt-STfZhsRsr-q9YeMOP5jyRiQ73OuhO9Uz+QE3fGQ@mail.gmail.com>
From: Tian Dianchen <dianchen.tdc@gmail.com>
Date: Thu, 7 Dec 2017 10:38:08 +0800
Message-ID: <CABkJTM7RbX-Vt9w9eH3_unsf673uCpYf5L5OJj1S_Mx8E_=1XQ@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, =?UTF-8?B?5byg6LaF?= <icymemo@gmail.com>, quan.xu0@gmail.com, kraxel@redhat.com

Hi, Marc-Andr=C3=A9 Lureau
Thank you for your comments.

Hi,Gerd Hoffmann,
If there is no other comments,please join this note when merge this patch .


2017-12-06 17:46 GMT+08:00 Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.c=
om>:

> Hi
>
> On Wed, Dec 6, 2017 at 3:29 AM, =E7=94=B0=E6=AE=BF=E8=87=A3 <dianchen.tdc=
@gmail.com> wrote:
> > From e8c03f405c2112428e79bb82064c7b7743d0cc86 Mon Sep 17 00:00:00 2001
> > From: Tian Dianchen <dianchen.tdc@gmail.com>
> > Date: Tue, 5 Dec 2017 14:03:53 +0800
> > Subject: [PATCH] input: free InputEvent when it can't be inserted into =
a
> > full
> >  kdb queue
> >
> > When the kdb queue is full, the evt can't be placed in it, so it should
> > be released to free the memory.
> >
> > Impact: Without this limit vnc clients can exhaust host memory by keep
> > sending keyboard events when kdb queue is full.
>
> You may add "Leak introduced in commit fa18f36a461984eae50ab957e47ec7
> 8dae3c14fc"
>
> >
> > Reviewed-by: Zhang Chao <icymemo@gmail.com>
> > Reviewed-by: Quan Xu <quan.xu0@gmail.com>
> > Signed-off-by: Tian Dianchen <dianchen.tdc@gmail.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
> > ---
> >  ui/input.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/ui/input.c b/ui/input.c
> > index 3e2d324..e5b78aa 100644
> > --- a/ui/input.c
> > +++ b/ui/input.c
> > @@ -421,6 +421,8 @@ void qemu_input_event_send_key(QemuConsole *src,
> > KeyValue *key, bool down)
> >      } else if (queue_count < queue_limit) {
> >          qemu_input_queue_event(&kbd_queue, src, evt);
> >          qemu_input_queue_sync(&kbd_queue);
> > +    } else {
> > +        qapi_free_InputEvent(evt);
> >      }
> >  }
> >
> > --
> > 1.8.3.1
>
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
