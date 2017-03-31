Received: from eggs.gnu.org ([2001:4830:134:3::10]:50837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctvM6-00017c-F9
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctvM3-0008GX-9l
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:08:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctvM3-0008En-3Q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:08:35 -0400
References: <20170330164657.50c75e8c@nial.brq.redhat.com>
	<87k2764xex.fsf@linaro.org>
	<20170331102125.52405cd2@nial.brq.redhat.com>
	<87h9294yba.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a80467b-016d-0fef-6ab5-4e50a96bad1f@redhat.com>
Date: Fri, 31 Mar 2017 14:08:28 +0200
MIME-Version: 1.0
In-Reply-To: <87h9294yba.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-2.9 crashes in tcg_handle_interrupt() during
 winx64 boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, KONRAD Frederic <fred.konrad@greensocs.com>



On 31/03/2017 10:58, Alex Benn=C3=A9e wrote:
>=20
> Igor Mammedov <imammedo@redhat.com> writes:
>=20
>> On Thu, 30 Mar 2017 16:05:58 +0100
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>
>>> Igor Mammedov <imammedo@redhat.com> writes:
>>>
>>>> (PS: resend due to wrong qemu-devel mail list address in original
>>>> email)
>>>
>>> Le *sigh* another way of x86 generating IRQs ;-)
>>>
>>> Could you test this please?
>>>
>>> target/i386/misc_helper: wrap BQL around another IRQ generator
>>>
>>> Anything that calls into HW emulation must be protected by the BQL.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> it doesn't help,
>> it asserts in the same place anyway
>=20
> That's weird. If the lock was already held I could see it failing highe=
r
> up but this seems to imply we are dropping a lock as we descend into
> hardware emulation.

Seems weird to me too.

> How often does this leg of the helper get called?

Continuously under Windows, never on Linux.  But you can also try
kvm-unit-tests probably to trigger it:

$ qemu-system-x86_64 \
   -kernel x86/vmexit.flat -serial stdio \
   --append 'cpuid mov_to_cr8' -device isa-debug-exit,iobase=3D0xf4


Thanks,

paolo
