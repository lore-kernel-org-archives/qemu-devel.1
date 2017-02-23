Received: from eggs.gnu.org ([2001:4830:134:3::10]:39548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgoci-0001UB-VB
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cgoce-00059N-Pf
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:19:36 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cgoce-00059J-Hi
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:19:32 -0500
Received: by mail-wr0-x231.google.com with SMTP id z61so16826565wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 00:19:32 -0800 (PST)
References: <20170222171327.26624-1-alex.bennee@linaro.org>
	<148778745330.150.5479386803551876071@0e2666bad730>
	<8737f6vw37.fsf@linaro.org> <871suqvt0z.fsf@linaro.org>
	<CAJhHMCAwFVfW1u7VnCE2WVDtueD1+BJhq9EpSjOTGO85Q3fytw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJhHMCAwFVfW1u7VnCE2WVDtueD1+BJhq9EpSjOTGO85Q3fytw@mail.gmail.com>
Date: Thu, 23 Feb 2017 08:19:39 +0000
Message-ID: <87zihduxno.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, nikunj@linux.vnet.ibm.com, Jan Kiszka <jan.kiszka@siemens.com>, Mark Burton <mark.burton@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Sergey Fedorov <serge.fdrv@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, KONRAD =?utf-8?B?RnLDqWTDqXJpYw==?= <fred.konrad@greensocs.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> On Wed, Feb 22, 2017 at 4:02 PM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Alex Bennée <alex.bennee@linaro.org> writes:
>>
>>> no-reply@patchew.org writes:
>>>
>>>> Hi,
>>>>
>>>> This series failed build test on s390x host. Please find the details
>>>> below.
>>
>> It also failed on x86-on-x86 MTTCG as well as other tests:
>>
>>>> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_lock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
>>>> GTester: last random seed: R02Sf1ce767b432f1559eaf8cc0c5a31eb02
>>>
>>> Well I've seen this before if the IRQ chain doesn't do locking properly
>>> but I'm at a loss why this breaks on an s390 host as the code is common.
>>>
>>> Does anyone have a spare s390 that I can test on?
>>
>> Look like I'll have to roll this in:
>>
>>   https://github.com/stsquad/qemu/commit/c6f4245ffd9df8ffcd2d4d655c322189c19a6c1a
>>
>
> I am able to successfully boot my test images using this patch (they
> fail without it). Another approach might be to reset the lock in the
> outer loop:
>
> diff --git a/cpu-exec.c b/cpu-exec.c
> index f3c78a9..8327050 100644
> --- a/cpu-exec.c
> +++ b/cpu-exec.c
> @@ -684,6 +684,9 @@ int cpu_exec(CPUState *cpu)
>                 if the guest is in advance */
>              align_clocks(&sc, cpu);
>          }
> +        if (qemu_mutex_iothread_locked()) {
> +          qemu_mutex_unlock_iothread();
> +        }

The only aesthetic objection I have is not aligning the unlocks with
where the lock are taken. That said my patch is fairly ugly in that
regard ;-)

>      }
>
>      cc->cpu_exec_exit(cpu);
>
>
> I think either patch is fine.




--
Alex Bennée
