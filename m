Received: from eggs.gnu.org ([209.51.188.92]:45883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hL7KD-0003Pw-OI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hL7KC-0001CT-Pv
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hL7KB-0001B2-Ef
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:32:07 -0400
Date: Mon, 29 Apr 2019 16:32:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190429143202.bo5kx3p73xim75z2@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
	<20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
	<CAJ+F1CLE-iwZu4oX69P3r0v_94L+gJEhZH0-U0iYag=oYNN4pg@mail.gmail.com>
	<20190429071243.icqw3qbzcxbcz7ph@sirius.home.kraxel.org>
	<CAJ+F1CJx3qTNGL4u+pMHFC-LRhfPtn8WF3O=i2nW25dbgcV7tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJx3qTNGL4u+pMHFC-LRhfPtn8WF3O=i2nW25dbgcV7tQ@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

  Hi,

> > > and complicates both sides unnecessarily.
> >
> > Having headers in the reply allows it to process them in generic code.
> > There is a size header for the reply, so you can parse the stream
> > without knowing what replay to expect.  You can use the status field to
> > indicate the payload, simliar to virtio-gpu which has response code
> > OK_NODATA, some OK_$whatpayload and some ERR_$failure codes.
> >
> > You can dispatch based on the response/status code and run *fully*
> > asynchronous without too much trouble.
> 
> It's really a different level of complexity than what I needed so far.

That is a bit overboard, no?

All I'm asking for is:

  (a) A header field telling what kind of payload has been sent,
      for both requests and replies.
  (b) A header field telling what size the payload has.

That hardly is a different level of complexity.  And that isn't up for
negotiation.

If you absolutely don't want ack all requests, ok.  Not sending a reply
in case there is no payload to send back and no error to report is
something I can live with.

> > A properly structed reply allows a different approach in reply
> > processing (see above).  But that only works if it is in the protocol
> > right from the start.  As add-on feature it can't provide the benefits
> > because the reply parser must be able to handle both protocol variants.
> 
> You are asking for a full-blown protocol... could we take DBus as an
> alternative instead?

May I suggest QMP instead?

Seriously:  If you want reuse something, just use the vhost-user wire
format.  Which is essentially what I'm asking for, plus an additional
flags field in the header.

cheers,
  Gerd
