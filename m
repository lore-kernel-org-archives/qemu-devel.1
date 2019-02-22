Received: from eggs.gnu.org ([209.51.188.92]:56198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx4d0-00030r-Kz
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gx4cz-0002UB-Gn
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:48:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gx4cy-0002SO-Sc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:48:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF6DE81E0B
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:48:07 +0000 (UTC)
Date: Fri, 22 Feb 2019 14:47:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190222064757.GG8904@xz-x1>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-3-peterx@redhat.com>
	<CAMxuvayfSo8RTCyi4cdUyhK90FJmMfCoL5sZUY+w7Qvf+BAEQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvayfSo8RTCyi4cdUyhK90FJmMfCoL5sZUY+w7Qvf+BAEQg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] iothread: create the gcontext
 onconditionally
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

On Fri, Feb 22, 2019 at 07:29:09AM +0100, Marc-Andr=C3=A9 Lureau wrote:

[...]

> > diff --git a/iothread.c b/iothread.c
> > index 6e297e9ef1..6fa87876e0 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -65,7 +65,7 @@ static void *iothread_run(void *opaque)
> >           * We must check the running state again in case it was
> >           * changed in previous aio_poll()
> >           */
> > -        if (iothread->running && atomic_read(&iothread->worker_conte=
xt)) {
> > +        if (iothread->running && atomic_read(&iothread->run_gcontext=
)) {
> >              GMainLoop *loop;
> >
> >              g_main_context_push_thread_default(iothread->worker_cont=
ext);
> > @@ -114,6 +114,8 @@ static void iothread_instance_init(Object *obj)
> >      iothread->poll_max_ns =3D IOTHREAD_POLL_MAX_NS_DEFAULT;
> >      iothread->thread_id =3D -1;
> >      qemu_sem_init(&iothread->init_done_sem, 0);
> > +    /* By default, we don't run gcontext */
> > +    atomic_set(&iothread->run_gcontext, 0);
>=20
> I think that initialization isn't really necessary, your call.

True; it's more a hint for readers who suddenly jumped into
iothread_run.  Thanks for being kind, since I would prefer to have it
for now. ;)

[...]

> looks good otherwise,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks for the quick review,

--=20
Peter Xu
