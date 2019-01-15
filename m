Received: from eggs.gnu.org ([209.51.188.92]:48340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjTBo-0002Hn-Tf
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjTBi-0001HE-Mv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:11:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjTBd-0001E4-6w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:11:42 -0500
References: <20190102141603.3681-1-lvivier@redhat.com>
	<ea341cde-f1d6-1a25-e64f-3426adc10c3b@redhat.com>
	<ac0fd4eb-b148-7854-80e9-e37d441f3116@redhat.com>
	<cfce9856-5cdd-81d9-62cf-e31daac3dd93@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f23c61ef-8503-920b-9059-e74af8cc4953@redhat.com>
Date: Tue, 15 Jan 2019 19:11:33 +0100
MIME-Version: 1.0
In-Reply-To: <cfce9856-5cdd-81d9-62cf-e31daac3dd93@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus: ignore ESRCH in
 qemu_cpu_kick_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 15/01/19 17:34, Laurent Vivier wrote:
> On 08/01/2019 19:47, Laurent Vivier wrote:
>> On 08/01/2019 00:02, Paolo Bonzini wrote:
>>> On 02/01/19 15:16, Laurent Vivier wrote:
>>>> We can have a race condition between qemu_cpu_kick_thread() and
>>>> qemu_kvm_cpu_thread_fn() when we hotunplug a CPU. In this case,
>>>> qemu_cpu_kick_thread() can try to kick a thread that is exiting.
>>>> pthread_kill() returns an error and qemu is stopped by an exit(1).
>>>>
>>>> =C2=A0=C2=A0=C2=A0 qemu:qemu_cpu_kick_thread: No such process
>>>>
>>>> We can ignore safely this error.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>> =C2=A0 cpus.c | 2 +-
>>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/cpus.c b/cpus.c
>>>> index 0ddeeefc14..4717490bd0 100644
>>>> --- a/cpus.c
>>>> +++ b/cpus.c
>>>> @@ -1778,7 +1778,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu=
)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->thread_kicked =3D true;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D pthread_kill(cpu->thread->thr=
ead, SIG_IPI);
>>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>>> +=C2=A0=C2=A0=C2=A0 if (err && err !=3D ESRCH) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stder=
r, "qemu:%s: %s", __func__, strerror(err));
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>
>>> You could in principle be sending the signal to another thread, so th=
e
>>> fix is a bit hackish.=C2=A0 However, I don't have a better idea that =
is not
>>> racy. :(
>>>
>>> The problem is that qemu_cpu_kick does not use any spinlock or mutex =
to
>>> synchronize against cpu_remove_sync's qemu_thread_join.=C2=A0 I think=
 once
>>> the you reach qemu_cpu_kick in cpu_remove_sync (so if cpu->unplug) yo=
u
>>> do not need to reset cpu->thread_kicked anymore, but I don't think
>>> that's enough to fix it.
>>
>> Will you take the patch through one of your pull requests or should I
>> add it to the trivial-patches branch?
>=20
> Paolo?

I queued it now, thanks.

Paolo
