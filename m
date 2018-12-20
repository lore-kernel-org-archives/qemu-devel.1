Received: from eggs.gnu.org ([2001:4830:134:3::10]:47087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gZtnX-0005PP-Bf
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gZtnU-0002eS-TA
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:35:14 -0500
Received: from mail-it1-x134.google.com ([2607:f8b0:4864:20::134]:53046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gZtnS-0002WK-Sw
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:35:11 -0500
Received: by mail-it1-x134.google.com with SMTP id g76so1796862itg.2
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 00:35:02 -0800 (PST)
MIME-Version: 1.0
References: <CAKXe6SK+Pm8hGh=BXQ8FosVd=s4S+oc4moxJOjOq5HNeoG5Jcw@mail.gmail.com>
	<CAKXe6SK8SXVKZ23c+QNJLEGYOkY57ovFHKNwT3byTTZai3bdaw@mail.gmail.com>
	<c3b72adf-86c0-6a45-026c-838e4b7187da@redhat.com>
	<5C1ACD2D.094894.04703@m12-14.163.com>
	<B2B5C030-9D7C-47BD-B3BE-F79782C79C01@euphon.net>
In-Reply-To: <B2B5C030-9D7C-47BD-B3BE-F79782C79C01@euphon.net>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 20 Dec 2018 16:34:25 +0800
Message-ID: <CAKXe6SJo1uRf6YXfTsKuQdnmFM_iAijSGpdAwG0TRTxbceMd5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question about aio_poll and glib aio_ctx_dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>
Cc: Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Fam Zheng <fam@euphon.net> =E4=BA=8E2018=E5=B9=B412=E6=9C=8820=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:26=E5=86=99=E9=81=93=EF=BC=9A

>
>
> > On Dec 20, 2018, at 06:58, Li Qiang <liq3ea@163.com> wrote:
> >
> > Hello Paolo
> >
> > Thanks for your kind reply.
> >
> > Yes, aio_poll and aio_ctx_dispatch mostly run in different threads,
> though
> > Sometimes they can run in a thread nested from Fam=E2=80=99s slides:
> > =E2=86=92
> http://events17.linuxfoundation.org/sites/events/files/slides/Improving%2=
0the%20QEMU%20Event%20Loop%20-%203.pdf
> >
> > So you mean we can poll the same fd in two threads? If so , the =E2=80=
=98fd=E2=80=99 in
> =E2=80=98qemu_aio_context=E2=80=99 will be run twice, I think there=E2=80=
=99s
> > something I understand wrong.
> >
> > Let=E2=80=99s take an example. In the =E2=80=98v9fs_reset=E2=80=99.
> >
> > void v9fs_reset(V9fsState *s)
> > {
> >    VirtfsCoResetData data =3D { .pdu =3D { .s =3D s }, .done =3D false =
};
> >    Coroutine *co;
> >
> >    while (!QLIST_EMPTY(&s->active_list)) {
> >        aio_poll(qemu_get_aio_context(), true);
> >    }
> >
> >    co =3D qemu_coroutine_create(virtfs_co_reset, &data);
> >    qemu_coroutine_enter(co);
> >
> >    while (!data.done) {
> >        aio_poll(qemu_get_aio_context(), true);
> >    }
> > }
> >
> > Here we use aio_poll to wait the pending action to complete.
> > Here aio_poll will poll the fds in =E2=80=98qemu_aio_context=E2=80=99 i=
n vcpu thread,
> > However, the main loop is also poll the fds in =E2=80=98qemu_aio_contex=
t=E2=80=99.
> > If some =E2=80=98fd=E2=80=99 in =E2=80=98qemu_aio_context=E2=80=99 has =
events, the two thread will be
> wakeup?
> > You say both will call aio_dispatch_handlers and
> timerlistgroup_run_timers.
> > But the are the same fd, how can this happen?
>
>
>
Thanks Fam,


> I think in this case BQL is used to synchronize them so when v9fs_reset
> runs, the main loop doesn't.
>

I think you're right. The main loop will not hold BQL when polling. But it
will acquire the BQL before it can
do the dispatch. So even if an 'fd' events occurs in this case, only the
aio_poll's dispatch can run.

Thanks,
Li Qiang



>
> Thanks,
> Fam
>
> >
> > Thanks,
> > Li Qiang
> >
> >
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Paolo Bonzini
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B412=E6=9C=8820=E6=97=
=A5 4:42
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang; stefanha@redhat.com; fam@euphon.=
net; Qemu Developers; =E6=9D=8E=E5=BC=BA
> > =E4=B8=BB=E9=A2=98: Re: Question about aio_poll and glib aio_ctx_dispat=
ch
> >
> > On 19/12/18 11:05, Li Qiang wrote:
> >> Sent it to qemu-devel.
> >>
> >> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> =E4=BA=8E2018=E5=
=B9=B412=E6=9C=8819=E6=97=A5=E5=91=A8
> >> =E4=B8=89 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>    Hello Paolo, Stefan, Fam and all,
> >>
> >>    Here I have a question about 'aio_poll'.
> >>    IIUC the 'aio_poll' is (mostly) used for synchronous IO
> >>    as I see a lot of code like this:
> >>    while(condition)
> >>     aio_poll();
> >>
> >>    However it seems the 'aio_poll' and 'aio_ctx_dispatch' both poll th=
e
> fd.
> >>    So what happened when the 'fd' has events, which function will be
> >>    wakeup?
> >
> > Roughly speaking, aio_poll is used for synchronous IO and within I/O
> > threads; aio_ctx_dispatch is used within the main thread.
> >
> > Both end up calling aio_dispatch_handlers and timerlistgroup_run_timers=
.
> >
> > Paolo
> >
>
>
>
