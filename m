Received: from eggs.gnu.org ([2001:4830:134:3::10]:39533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvNhw-0002Lu-Nq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvNhr-0003Fi-Oq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:37:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvNhr-0003FY-Ie
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:37:07 -0400
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-8-alex.bennee@linaro.org>
	<000201d2ad05$e28626d0$a7927470$@ru> <8760ikblf7.fsf@linaro.org>
	<874ly4bgbu.fsf@linaro.org>
	<3c4f3f42-3b33-8e0a-b3f4-0963670b47de@redhat.com>
	<8737dobbhm.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe4ee48e-9a96-bcc4-54ec-86d53212d75b@redhat.com>
Date: Tue, 4 Apr 2017 14:37:01 +0200
MIME-Version: 1.0
In-Reply-To: <8737dobbhm.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v1 7/9] cpus: move icount preparation
 out of tcg_exec_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>



On 04/04/2017 14:31, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 04/04/2017 12:46, Alex Benn=C3=A9e wrote:
>>>> In theory the main-loop should be sequenced before or after vCPU eve=
nts
>>>> because of the BQL. I'm not sure why this is not currently the case.
>>>
>>> It seems cpu_handle_exception doesn't take the BQL until
>>> replay_exception() has done its thing. This is fixable but the functi=
on
>>> is a mess so I'm trying to neaten that up first.
>>
>> Long term neither cpu_handle_exception nor cpu_handle_interrupt need t=
he
>> BQL at all.
>=20
> Well for record/replay they might. Otherwise we end up moving the recor=
d
> stream on even though a checkpoint might be being written by the
> main-loop.
>=20
> As far as the cc->do_interrupt() stuff is concerned it will be guest
> dependant because you could end up in device emulation code down this
> path which must be protected by the BQL - the arm_gic code being a good
> example.

I think recording an event could be split in two parts:

- recording the (icount, event) tuple and getting back a unique event id

- waiting for all events with lower event id to be complete before
starting to process this one

This doesn't require the BQL, you can use a condition variable on
replay_lock (but you do need to unlock/lock the BQL around it if
currently taken).

The complicated part is ensuring that there are no deadlocks where the
I/O thread needs the VCPU thread to proceed, but the VCPU thread is
waiting on the I/O thread's event processing.

Paolo
