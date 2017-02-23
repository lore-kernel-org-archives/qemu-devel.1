Received: from eggs.gnu.org ([2001:4830:134:3::10]:50944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cghzc-0003QY-Fw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 20:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cghzb-0001Sm-8d
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 20:14:48 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cghzb-0001Se-2p
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 20:14:47 -0500
Received: by mail-oi0-x241.google.com with SMTP id 2so314607oif.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 17:14:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871suqvt0z.fsf@linaro.org>
References: <20170222171327.26624-1-alex.bennee@linaro.org>
	<148778745330.150.5479386803551876071@0e2666bad730>
	<8737f6vw37.fsf@linaro.org> <871suqvt0z.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 22 Feb 2017 20:14:15 -0500
Message-ID: <CAJhHMCAwFVfW1u7VnCE2WVDtueD1+BJhq9EpSjOTGO85Q3fytw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, nikunj@linux.vnet.ibm.com, Jan Kiszka <jan.kiszka@siemens.com>, Mark Burton <mark.burton@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Sergey Fedorov <serge.fdrv@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>

On Wed, Feb 22, 2017 at 4:02 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> no-reply@patchew.org writes:
>>
>>> Hi,
>>>
>>> This series failed build test on s390x host. Please find the details
>>> below.
>
> It also failed on x86-on-x86 MTTCG as well as other tests:
>
>>> ERROR:/var/tmp/patchew-tester-tmp-_186415r/src/cpus.c:1554:qemu_mutex_l=
ock_iothread: assertion failed: (!qemu_mutex_iothread_locked())
>>> GTester: last random seed: R02Sf1ce767b432f1559eaf8cc0c5a31eb02
>>
>> Well I've seen this before if the IRQ chain doesn't do locking properly
>> but I'm at a loss why this breaks on an s390 host as the code is common.
>>
>> Does anyone have a spare s390 that I can test on?
>
> Look like I'll have to roll this in:
>
>   https://github.com/stsquad/qemu/commit/c6f4245ffd9df8ffcd2d4d655c322189=
c19a6c1a
>

I am able to successfully boot my test images using this patch (they
fail without it). Another approach might be to reset the lock in the
outer loop:

diff --git a/cpu-exec.c b/cpu-exec.c
index f3c78a9..8327050 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -684,6 +684,9 @@ int cpu_exec(CPUState *cpu)
                if the guest is in advance */
             align_clocks(&sc, cpu);
         }
+        if (qemu_mutex_iothread_locked()) {
+          qemu_mutex_unlock_iothread();
+        }
     }

     cc->cpu_exec_exit(cpu);


I think either patch is fine.

Thanks,
--=20
Pranith
