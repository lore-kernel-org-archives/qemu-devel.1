Received: from eggs.gnu.org ([209.51.188.92]:32794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx4ml-0004fX-Ii
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx4mk-0008Qj-LU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:58:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx4mk-00089n-Bx
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:58:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29D50309D554
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:57:39 +0000 (UTC)
Date: Fri, 22 Feb 2019 14:57:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190222065724.GH8904@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-5-peterx@redhat.com>
	<CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvax9+NNe6Mh3TnFgt6p+q=kcgR1tEiQNr+be8bJRDUPCJw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] iothread: push gcontext earlier in the
 thread_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Feb 22, 2019 at 07:37:02AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Feb 22, 2019 at 4:14 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > We were pushing the context until right before running the gmainloop.
> > Now since we have everything unconditionally, we can move this
> > earlier.
> >
> > One benefit is that now it's done even before init_done_sem, so as
> > long as the iothread user calls iothread_create() and completes, we
> > know that the thread stack is ready.
> >
>=20
> This will change the default context in the iothread, for code running
> there. This may not be a good idea. Until now, only sources dispatched
> from iothread_get_g_main_context() would have default context
> associated to it.
>=20
> I don't know if the current behaviour is intentional, but it has some
> logic. With this change, you may create hidden races, by changing the
> default context of sources to the iothread.

Yes I agree that the behavior will be changed in this patch that even
if the iothread user does not use the gcontext they'll also have the
context set.  I would think it should be ok because IMHO events hooked
onto the aio context should not depend on the gcontext, but indeed I'd
like to get some confirmation from others, especially the block layer.

Stefan?

Thanks,

--=20
Peter Xu
