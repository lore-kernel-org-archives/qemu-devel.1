Received: from eggs.gnu.org ([2001:4830:134:3::10]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gWMvI-0004qw-T9
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gWMvG-0001aU-Un
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:52:40 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:37676
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1gWMvD-0001W7-48
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:52:37 -0500
References: <20181207155911.12710-1-peter.maydell@linaro.org>
	<c2f3400e-84d9-d380-3259-7e3231ff12f6@adacore.com>
	<CAFEAcA_vuA=P2JDmaWZ3XQrcrjnKpewhgxbMA8YWXxo=vU981A@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <e19cf13a-2629-6184-9a9c-0e9b6dba2104@adacore.com>
Date: Mon, 10 Dec 2018 15:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_vuA=P2JDmaWZ3XQrcrjnKpewhgxbMA8YWXxo=vU981A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, "patches@linaro.org" <patches@linaro.org>



Le 12/10/18 =C3=A0 3:39 PM, Peter Maydell a =C3=A9crit=C2=A0:
> On Mon, 10 Dec 2018 at 14:30, KONRAD Frederic
> <frederic.konrad@adacore.com> wrote:
>>
>> Hi Peter,
>>
>> Thanks for that patch!
>>
>> I'm seeing the same kind of issue when I run 8 qemu in parallel but it=
 doesn't
>> seem to be fixed by this patch. Is it supposed to fix the issue when w=
e are
>> doing a reset_request through a MMIO device?
>>
>> It happens (rarely) with this kind of guest code:
>>
>> exit:
>>     write to the register to reset the device
>> loop:
>>     branch loop
>>
>> The code after the reset is executed.. can't we exit the loop directly=
 with
>> cpu_loop_exit after cpu_exit?
>=20
> cpu_loop_exit would abort the execution of the store instruction
> that writes to the reset register. I'm not sure that's a great
> idea. My thought was more that we should just make sure that insn
> is the last one in the TB, so effectively we execute that insn and
> then reset the system before executing any further insns. Thinking
> it over though I'm not sure that we do do anything that could
> avoid having more insns following in the same TB, unless you're
> using singlestep or icount...

Exactly I think we don't do anything for that.. But we can't guess which =
IO will
require the loop to be exited though..

Fred

>=20
> thanks
> -- PMM
>=20
