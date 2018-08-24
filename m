Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft3A8-0006P0-DO
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 23:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft32M-0004jU-CI
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 23:45:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ft32M-0004io-7R
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 23:45:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6510140241E7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 03:45:24 +0000 (UTC)
Date: Fri, 24 Aug 2018 11:45:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180824034517.GF24044@xz-x1>
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823143125.16767-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Fix socket chardev regression
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

On Thu, Aug 23, 2018 at 04:31:20PM +0200, Marc-Andr=C3=A9 Lureau wrote:
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
> function will be called in general, so we can't delay connection until
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
>=20
> v2:
> - fix a random socket chardev test failure

I have no problem on patch 3-5, but aren't patch 1-2 still breaking
the context switch of chardev?  Or did I misunderstood?

Regards,

--=20
Peter Xu
