Received: from eggs.gnu.org ([2001:4830:134:3::10]:47251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gZn6t-0006oh-DA
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gZn6l-0003zE-P6
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:26:45 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17336
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gZn6i-0003kl-30
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:26:38 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Fam Zheng <fam@euphon.net>
In-Reply-To: <5C1ACD2D.094894.04703@m12-14.163.com>
Date: Thu, 20 Dec 2018 09:25:53 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <B2B5C030-9D7C-47BD-B3BE-F79782C79C01@euphon.net>
References: <CAKXe6SK+Pm8hGh=BXQ8FosVd=s4S+oc4moxJOjOq5HNeoG5Jcw@mail.gmail.com>
	<CAKXe6SK8SXVKZ23c+QNJLEGYOkY57ovFHKNwT3byTTZai3bdaw@mail.gmail.com>
	<c3b72adf-86c0-6a45-026c-838e4b7187da@redhat.com>
	<5C1ACD2D.094894.04703@m12-14.163.com>
Subject: Re: [Qemu-devel] Question about aio_poll and glib aio_ctx_dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>



> On Dec 20, 2018, at 06:58, Li Qiang <liq3ea@163.com> wrote:
>=20
> Hello Paolo
>=20
> Thanks for your kind reply.
>=20
> Yes, aio_poll and aio_ctx_dispatch mostly run in different threads, =
though
> Sometimes they can run in a thread nested from Fam=E2=80=99s slides:
> =
=E2=86=92http://events17.linuxfoundation.org/sites/events/files/slides/Imp=
roving%20the%20QEMU%20Event%20Loop%20-%203.pdf
>=20
> So you mean we can poll the same fd in two threads? If so , the =
=E2=80=98fd=E2=80=99 in =E2=80=98qemu_aio_context=E2=80=99 will be run =
twice, I think there=E2=80=99s=20
> something I understand wrong.
>=20
> Let=E2=80=99s take an example. In the =E2=80=98v9fs_reset=E2=80=99.
>=20
> void v9fs_reset(V9fsState *s)
> {
>    VirtfsCoResetData data =3D { .pdu =3D { .s =3D s }, .done =3D false =
};
>    Coroutine *co;
>=20
>    while (!QLIST_EMPTY(&s->active_list)) {
>        aio_poll(qemu_get_aio_context(), true);
>    }
>=20
>    co =3D qemu_coroutine_create(virtfs_co_reset, &data);
>    qemu_coroutine_enter(co);
>=20
>    while (!data.done) {
>        aio_poll(qemu_get_aio_context(), true);
>    }
> }
>=20
> Here we use aio_poll to wait the pending action to complete.
> Here aio_poll will poll the fds in =E2=80=98qemu_aio_context=E2=80=99 =
in vcpu thread,
> However, the main loop is also poll the fds in =E2=80=98qemu_aio_context=
=E2=80=99.
> If some =E2=80=98fd=E2=80=99 in =E2=80=98qemu_aio_context=E2=80=99 has =
events, the two thread will be wakeup?
> You say both will call aio_dispatch_handlers and =
timerlistgroup_run_timers.
> But the are the same fd, how can this happen?


I think in this case BQL is used to synchronize them so when v9fs_reset =
runs, the main loop doesn't.

Thanks,
Fam

>=20
> Thanks,
> Li Qiang
>=20
>=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Paolo Bonzini
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2018=E5=B9=B412=E6=9C=8820=E6=97=A5=
 4:42
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang; stefanha@redhat.com; =
fam@euphon.net; Qemu Developers; =E6=9D=8E=E5=BC=BA
> =E4=B8=BB=E9=A2=98: Re: Question about aio_poll and glib =
aio_ctx_dispatch
>=20
> On 19/12/18 11:05, Li Qiang wrote:
>> Sent it to qemu-devel.
>>=20
>> Li Qiang <liq3ea@gmail.com <mailto:liq3ea@gmail.com>> =
=E4=BA=8E2018=E5=B9=B412=E6=9C=8819=E6=97=A5=E5=91=A8
>> =E4=B8=89 =E4=B8=8B=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>    Hello Paolo, Stefan, Fam and all,
>>=20
>>    Here I have a question about 'aio_poll'.
>>    IIUC the 'aio_poll' is (mostly) used for synchronous IO
>>    as I see a lot of code like this:=20
>>    while(condition)
>>     aio_poll();
>>=20
>>    However it seems the 'aio_poll' and 'aio_ctx_dispatch' both poll =
the fd.
>>    So what happened when the 'fd' has events, which function will be
>>    wakeup?
>=20
> Roughly speaking, aio_poll is used for synchronous IO and within I/O
> threads; aio_ctx_dispatch is used within the main thread.
>=20
> Both end up calling aio_dispatch_handlers and =
timerlistgroup_run_timers.
>=20
> Paolo
>=20
