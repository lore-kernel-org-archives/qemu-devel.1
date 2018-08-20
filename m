Received: from eggs.gnu.org ([2001:4830:134:3::10]:48379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fraF3-0007Jn-BK
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fraBt-00009W-Ms
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:45:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fraBt-000079-I3
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 22:45:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3354087903
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 02:45:11 +0000 (UTC)
Date: Mon, 20 Aug 2018 10:45:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180820024504.GA7953@xz-mi>
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817135224.22971-1-marcandre.lureau@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com

On Fri, Aug 17, 2018 at 03:52:20PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> In commit 25679e5d58e "chardev: tcp: postpone async connection setup"
> (and its follow up 99f2f54174a59), Peter moved chardev socket
> connection to machine_done event. However, chardev created later will
> no longer attempt to connect, and chardev created in tests do not have
> machine_done event (breaking some of vhost-user-test).
>=20
> The goal was to move the "connect" source to the chardev frontend
> context (the monitor thread context in his case). chr->gcontext is set
> with qemu_chr_fe_set_handlers(). But there is no guarantee that the
> function will be called in general,

Could you hint a case where we didn't use qemu_chr_fe_set_handlers()
upon a chardev backend?  I thought it was always used in chardev
frontends, and what the backend could do if without a frontend?

[1]

> so we can't delay connection until
> then: the chardev should still attempt to connect during open(), using
> the main context.
>=20
> An alternative would be to specify the iothread during chardev
> creation. Setting up monitor OOB would be quite different too, it
> would take the same iothread as argument.
>=20
> 99f2f54174a595e is also a bit problematic, since it will behave
> differently before and after machine_done (the first case gives a
> chance to use a different context reliably, the second looks racy)
>=20
> In the end, I am not sure this is all necessary, as chardev callbacks
> are called after qemu_chr_fe_set_handlers(), at which point the
> context of sources are updated. In "char-socket: update all ioc
> handlers when changing context", I moved also the hup handler to the
> updated context. So unless the main thread is already stuck, we can
> setup a different context for the chardev at that time. Or not?

IMHO the two patches that you reverted are special-cases for reasons.

The TLS handshake is carried out with an TLS internal GSource which is
not owned by the chardev code, so the qemu_chr_fe_set_handlers() won't
update that GSource (please refer to qio_channel_tls_handshake_task).

The async connection is carried out in a standalone thread that calls
connect().  IMHO we'd better not update the gcontext bound to the
async task since otherwise there'll be a race (IIRC I proposed
something before using a mutex to update the gcontext, but Dan would
prefer not to, and I followed with the suggestion which makes sense to
me).

Could we just postpone these machine done tasks into
qemu_chr_fe_set_handlers() (or say, chr_update_read_handler() hook,
just like what I mentioned in the other thread)?  Though we'll be sure
qemu_chr_fe_set_handlers() will be called for all chardev backends
hence I asked question [1] above.

Regards,

--=20
Peter Xu
