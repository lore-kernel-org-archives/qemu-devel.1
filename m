Received: from eggs.gnu.org ([209.51.188.92]:54179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL3rc-00006l-CL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hL3rb-0003q8-8a
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:50:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hL3rb-0003pX-2i
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:50:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id a9so15321307wrp.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 03:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
	<20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
	<CAJ+F1CLE-iwZu4oX69P3r0v_94L+gJEhZH0-U0iYag=oYNN4pg@mail.gmail.com>
	<20190429071243.icqw3qbzcxbcz7ph@sirius.home.kraxel.org>
In-Reply-To: <20190429071243.icqw3qbzcxbcz7ph@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Apr 2019 12:50:09 +0200
Message-ID: <CAJ+F1CJx3qTNGL4u+pMHFC-LRhfPtn8WF3O=i2nW25dbgcV7tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Mon, Apr 29, 2019 at 9:12 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > What questions for example?
> >
> > This opens up different kind of possible replies, and error handling.
> >
> > With current proposal and needs, the reply (or absence of reply) is
> > entirely driven by the request.
> >
> > With your proposal, should all request have a reply?
>
> Yes.
>
> > which makes a lot
> > more code synchronous,
>
> Why?  You don't have to wait for the reply before sending the next
> request.
>
> Adding a request id to the messages might be useful, so it is possible
> to wait for a reply to a specific message without having to keeping
> track of all in-flight messages.
>
> > and complicates both sides unnecessarily.
>
> Having headers in the reply allows it to process them in generic code.
> There is a size header for the reply, so you can parse the stream
> without knowing what replay to expect.  You can use the status field to
> indicate the payload, simliar to virtio-gpu which has response code
> OK_NODATA, some OK_$whatpayload and some ERR_$failure codes.
>
> You can dispatch based on the response/status code and run *fully*
> asynchronous without too much trouble.

It's really a different level of complexity than what I needed so far.

>
> > > > Can we leave that for future protocol extensions negotiated with
> > > > GET/SET_PROTOCOL_FEATURES ?
> > >
> > > I don't think negotiating such a basic protocol change is a good idea=
.
> >
> > Well, then I would rather focus on improving protocol negociation,
> > rather than adding unnecessary protocol changes.
> >
> > Given that GET/SET_PROTOCOL_FEATURES is the first messages being sent,
> > why couldn't it have flags indicating new protocol revision?
>
> A properly structed reply allows a different approach in reply
> processing (see above).  But that only works if it is in the protocol
> right from the start.  As add-on feature it can't provide the benefits
> because the reply parser must be able to handle both protocol variants.

You are asking for a full-blown protocol... could we take DBus as an
alternative instead?

--=20
Marc-Andr=C3=A9 Lureau
