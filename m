Received: from eggs.gnu.org ([2001:4830:134:3::10]:39166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gZknz-0005e0-GO
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gZknw-0001Ta-8n
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:59:07 -0500
Received: from m12-14.163.com ([220.181.12.14]:42954)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gZknu-0001Ri-KJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:59:03 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Thu, 20 Dec 2018 06:58:50 +0800
In-Reply-To: <c3b72adf-86c0-6a45-026c-838e4b7187da@redhat.com>
References: <CAKXe6SK+Pm8hGh=BXQ8FosVd=s4S+oc4moxJOjOq5HNeoG5Jcw@mail.gmail.com>
	<CAKXe6SK8SXVKZ23c+QNJLEGYOkY57ovFHKNwT3byTTZai3bdaw@mail.gmail.com>
	<c3b72adf-86c0-6a45-026c-838e4b7187da@redhat.com>
Message-Id: <5C1ACD2D.094894.04703@m12-14.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBRdWVzdGlvbiBhYm91dCBhaW9fcG9s?=
 =?utf-8?q?l_and_glib_aio=5Fctx=5Fdispatch?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, Qemu Developers <qemu-devel@nongnu.org>

Hello Paolo

Thanks for your kind reply.

Yes, aio_poll and aio_ctx_dispatch mostly run in different threads, though
Sometimes they can run in a thread nested from Fam=E2=80=99s slides:
=E2=86=92http://events17.linuxfoundation.org/sites/events/files/slides/Impr=
oving%20the%20QEMU%20Event%20Loop%20-%203.pdf

So you mean we can poll the same fd in two threads? If so , the =E2=80=98fd=
=E2=80=99 in =E2=80=98qemu_aio_context=E2=80=99 will be run twice, I think =
there=E2=80=99s=20
something I understand wrong.

Let=E2=80=99s take an example. In the =E2=80=98v9fs_reset=E2=80=99.

void v9fs_reset(V9fsState *s)
{
    VirtfsCoResetData data =3D { .pdu =3D { .s =3D s }, .done =3D false };
    Coroutine *co;

    while (!QLIST_EMPTY(&s->active_list)) {
        aio_poll(qemu_get_aio_context(), true);
    }

    co =3D qemu_coroutine_create(virtfs_co_reset, &data);
    qemu_coroutine_enter(co);

    while (!data.done) {
        aio_poll(qemu_get_aio_context(), true);
    }
}

Here we use aio_poll to wait the pending action to complete.
Here aio_poll will poll the fds in =E2=80=98qemu_aio_context=E2=80=99 in vc=
pu thread,
However, the main loop is also poll the fds in =E2=80=98qemu_aio_context=E2=
=80=99.
If some =E2=80=98fd=E2=80=99 in =E2=80=98qemu_aio_context=E2=80=99 has even=
ts, the two thread will be wakeup?
You say both will call aio_dispatch_handlers and timerlistgroup_run_timers.
But the are the same fd, how can this happen?

Thanks,
Li Qiang


=E5=8F=91=E4=BB=B6=E4=BA=BA: Paolo Bonzini
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B412=E6=9C=8820=E6=97=A5 4=
:42
=E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang; stefanha@redhat.com; fam@euphon.net;=
 Qemu Developers; =E6=9D=8E=E5=BC=BA
=E4=B8=BB=E9=A2=98: Re: Question about aio_poll and glib aio_ctx_dispatch

On 19/12/18 11:05, Li Qiang wrote:
> Sent it to qemu-devel.
>=20
> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> =E4=BA=8E2018=E5=B9=
=B412=E6=9C=8819=E6=97=A5=E5=91=A8
> =E4=B8=89 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     Hello Paolo, Stefan, Fam and all,
>=20
>     Here I have a question about 'aio_poll'.
>     IIUC the 'aio_poll' is (mostly) used for=C2=A0synchronous IO
>     as I see a lot of code like this:=C2=A0
>     while(condition)
>     =C2=A0aio_poll();
>=20
>     However it seems the 'aio_poll' and 'aio_ctx_dispatch' both poll the =
fd.
>     So what happened when the 'fd' has events, which function will be
>     wakeup?

Roughly speaking, aio_poll is used for synchronous IO and within I/O
threads; aio_ctx_dispatch is used within the main thread.

Both end up calling aio_dispatch_handlers and timerlistgroup_run_timers.

Paolo
