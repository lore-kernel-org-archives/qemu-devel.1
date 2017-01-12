Received: from eggs.gnu.org ([2001:4830:134:3::10]:43772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRaPs-0006dc-HQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRaPn-00041A-JW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:07:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:54454)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRaPn-0003za-BB
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:07:19 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <000301d259dc$f9d097c0$ed71c740$@ru>
	<000601d25a95$12b1b9f0$38152dd0$@ru>
	<20161220102126.GE5602@stefanha-x1.localdomain>
	<002501d25ab1$af024b00$0d06e100$@ru>
	<CAJSP0QXm9ssLC5C+gV_agkEW_fdUY=NWBMvHqMh55UhYTR276g@mail.gmail.com>
	<000301d25b4f$20018440$60048cc0$@ru>
	<CAJSP0QW1pOcthcEt16Pp5xQu3miUh2Leq3kn3yvQqWqhi1P=QQ@mail.gmail.com>
	<000801d26bd9$dca56db0$95f04910$@ru> <87o9zd3jta.fsf@linaro.org>
In-Reply-To: <87o9zd3jta.fsf@linaro.org>
Date: Thu, 12 Jan 2017 11:07:09 +0300
Message-ID: <000e01d26caa$dfdb3150$9f9193f0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] qemu-2.8-rc4 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: 'Stefan Hajnoczi' <stefanha@gmail.com>, 'qemu-devel' <qemu-devel@nongnu.org>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, 'Peter Maydell' <peter.maydell@linaro.org>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> >> >
> >> > Yes, this option helps.
> >> > Thank you.
> >>
> >> Good news.  This can be fixed in 2.8.1 once someone finds a =
solution.
> >
> > It seems that something still goes wrong.
> > I'm using this workaround, but there is a kind of deadlock in =
translation.
> > call_rcu_thread hangs at some moment in qemu_event_wait.
> >
> > As far as I understand, it is used by QHT in translate-all.c.
> > I can't get more information yet, because logging makes everything =
too slow.
>=20
> There are a number of users of RCU bit for QHT I think it only gets
> activated when it needs to re-size its hash table on insertion of new
> TranslationBlocks.
>=20
> Can you get a backtrace of all threads when it deadlocks?

Sorry, this is another problem which occurs only in icount replay mode:
1. cpu_handle_exception tries to force exception when is cannot occur =
due to
   running out all the planned instructions:
    } else if (replay_has_exception()
               && cpu->icount_decr.u16.low + cpu->icount_extra =3D=3D 0) =
{
        /* try to cause an exception pending in the log */
        cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
        *ret =3D -1;
        return true;

2. tb_find calls tb_gen_code, which cannot allocate new translation =
block=20
   and calls tb_flush (which only queues the flushing) and cpu_loop_exit
3. cpu_loop_exit returns to infinite loop of cpu_exec and the condition
            if (cpu_handle_exception(cpu, &ret)) {
                break;
            }
   is checked again causing an infinite loop.

TB cache is not flushed because we never execute that break and real =
work of tb_flush
is made outside this loop.

Pavel Dovgalyuk
