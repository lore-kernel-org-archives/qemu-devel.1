Received: from eggs.gnu.org ([2001:4830:134:3::10]:59229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDVxT-0004MP-EH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDVxQ-0002Al-A6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:40:57 -0400
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
	<CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
Date: Fri, 19 Oct 2018 16:40:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2018-10-19 15:57, Peter Maydell wrote:
> On 19 October 2018 at 14:14, Thomas Huth <thuth@redhat.com> wrote:
>> The "unimplemented-device" is currently only used for one arm board.
>=20
> ? It's used in all the MPS boards, several of the imx SoCs,
> the nrf51 SoC used by the microbit, and by the stellaris boards.
>=20
>> Let's add a CONFIG switch to make sure that we only compile it when
>> it is really necessary.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 1 +
>>  hw/misc/Makefile.objs           | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-sof=
tmmu.mak
>> index 6f2ffc1..dc9730f 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -7,6 +7,7 @@ CONFIG_NAND=3Dy
>>  CONFIG_OR_IRQ=3Dy
>>  CONFIG_SPLIT_IRQ=3Dy
>>  CONFIG_REGISTER=3Dy
>> +CONFIG_UNIMP=3Dy
>>  CONFIG_ECC=3Dy
>>  CONFIG_SERIAL=3Dy
>>  CONFIG_SERIAL_ISA=3Dy
>=20
> This seems awkward to me. The 'unimplemented' device is supposed
> to be an entirely generic thing usable in any board model.
> If we only turn it on in the arm-softmmu.mak then it means
> faffing around with the default-configs/ whenever it gets
> used in a different architecture.

The device has been added 1.5 years ago, and so far no other target is
using it yet. So it's very seldom that you've got to expect any changes,
I think.

Anyway, it's also not only about speeding up the compilation process for
people who don't want to use the corresponding targets, this is also
very useful for downstream distributions of QEMU who want to make sure
to not compile-in more devices than urgently needed. For example we
disable this device here and the others in downstream RHEL version of
QEMU, and I guess it might be interesting for nemu, too. So having more
flexibility here in the Makefiles would be really great to decrease the
burden with downstream-specific patches...

> In particular, there's a pull request on the list that uses
> it in a sparc board, so this patch will break compile on sparc
> once that pullreq lands.

Ok, then please disregard this patch here, but it would be great if you
could still consider the other patches of this series.

 Thomas
