Received: from eggs.gnu.org ([2001:4830:134:3::10]:47718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frmFu-00032H-0j
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frmFt-0000iO-1P
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:38:09 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1frmFs-0000h8-On
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:38:08 -0400
Received: by mail-wm0-x244.google.com with SMTP id y9-v6so14393787wma.5
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 08:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
	<20180820024504.GA7953@xz-mi>
In-Reply-To: <20180820024504.GA7953@xz-mi>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Aug 2018 17:37:55 +0200
Message-ID: <CAJ+F1C+J1mUeP8YbsCg=-VU15adxKZoM2acxEJUVtEBUTJsuBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Mon, Aug 20, 2018 at 4:48 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 17, 2018 at 03:52:20PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > In commit 25679e5d58e "chardev: tcp: postpone async connection setup"
> > (and its follow up 99f2f54174a59), Peter moved chardev socket
> > connection to machine_done event. However, chardev created later will
> > no longer attempt to connect, and chardev created in tests do not have
> > machine_done event (breaking some of vhost-user-test).
> >
> > The goal was to move the "connect" source to the chardev frontend
> > context (the monitor thread context in his case). chr->gcontext is set
> > with qemu_chr_fe_set_handlers(). But there is no guarantee that the
> > function will be called in general,
>
> Could you hint a case where we didn't use qemu_chr_fe_set_handlers()
> upon a chardev backend?  I thought it was always used in chardev
> frontends, and what the backend could do if without a frontend?

Well, you don't have to have a front-end to have side effects. Connect
will be attempted even without frontend. We may have users expecting
that behaviour, that might be considered a break if we change it.

(and unlikely, there might be frontends that are write only)

>
> [1]
>
> > so we can't delay connection until
> > then: the chardev should still attempt to connect during open(), using
> > the main context.
> >
> > An alternative would be to specify the iothread during chardev
> > creation. Setting up monitor OOB would be quite different too, it
> > would take the same iothread as argument.
> >
> > 99f2f54174a595e is also a bit problematic, since it will behave
> > differently before and after machine_done (the first case gives a
> > chance to use a different context reliably, the second looks racy)
> >
> > In the end, I am not sure this is all necessary, as chardev callbacks
> > are called after qemu_chr_fe_set_handlers(), at which point the
> > context of sources are updated. In "char-socket: update all ioc
> > handlers when changing context", I moved also the hup handler to the
> > updated context. So unless the main thread is already stuck, we can
> > setup a different context for the chardev at that time. Or not?
>
> IMHO the two patches that you reverted are special-cases for reasons.
>
> The TLS handshake is carried out with an TLS internal GSource which is
> not owned by the chardev code, so the qemu_chr_fe_set_handlers() won't
> update that GSource (please refer to qio_channel_tls_handshake_task).

What can go wrong by using the default context for initial connection
and TLS handshake?

Presumably, you have a case where the mainloop is no longer processed
and that will hang the chardev?

> The async connection is carried out in a standalone thread that calls
> connect().  IMHO we'd better not update the gcontext bound to the
> async task since otherwise there'll be a race (IIRC I proposed
> something before using a mutex to update the gcontext, but Dan would
> prefer not to, and I followed with the suggestion which makes sense to
> me).
>
> Could we just postpone these machine done tasks into
> qemu_chr_fe_set_handlers() (or say, chr_update_read_handler() hook,
> just like what I mentioned in the other thread)?  Though we'll be sure
> qemu_chr_fe_set_handlers() will be called for all chardev backends
> hence I asked question [1] above.

I would rather not to, if possible. unless we take the risk of
breaking current behaviour and review chardev usage in qemu.


--=20
Marc-Andr=C3=A9 Lureau
