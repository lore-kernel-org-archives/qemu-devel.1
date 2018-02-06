Received: from eggs.gnu.org ([2001:4830:134:3::10]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eiqzS-0001XN-Sk
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eiqzR-0001xn-SR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:20:02 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eiqzR-0001xI-Jl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 19:20:01 -0500
Received: by mail-lf0-x241.google.com with SMTP id a204so213485lfa.2
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:20:01 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <431ec46d-33dd-71d8-9ea1-f331ba01bd62@amsat.org>
References: <20180201205307.30343-1-christoffer.dall@linaro.org>
	<431ec46d-33dd-71d8-9ea1-f331ba01bd62@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 5 Feb 2018 16:19:29 -0800
Message-ID: <CAKmqyKPppEnzgOZ+ZJSeEWXO5ELE9tQfAYqvcfRJ-R__1LgxJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/arm/kvm: gic: Prevent creating
 userspace GICv3 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alex Bennee <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Feb 5, 2018 at 4:10 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Hi Christoffer,
>
> On 02/01/2018 05:53 PM, Christoffer Dall wrote:
>> KVM doesn't support emulating a GICv3 in userspace, only GICv2.  We
>> currently attempt this anyway, and as a result a KVM guest doesn't
>> receive interrupts and the user is left wondering why.  Report an error
>> to the user if this particular combination is requested.
>>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> ---
>>  target/arm/kvm_arm.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index ff53e9fafb..cfb7e5af72 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -234,6 +234,10 @@ static inline const char *gicv3_class_name(void)
>
> Any reason why these functions are inlined in this include?
>
> Also - not related to your patch - while gicv3_class_name() is
> self-explicit, gic_class_name() isn't (to me at least).
>
> There are many check for gic_version 1/2/3 in virt.c, which we could
> clean using more generic functions such gic_class_name(int gic_version)
> and Co.
>
> Alistair/Edgar:
> Why the ZynqMP is not using the GICv3 for the APU? I remember hearing
> something about not fully implemented so not working correctly.

The ZynqMP only has a GICv2.

Maybe you are thinking of the virtualisation features? Mainline
doesn't have those fully implemented so they don't work correctly.

Alistair

>
>>          exit(1);
>>  #endif
>>      } else {
>> +        if (kvm_enabled()) {
>> +            error_report("Userspace GICv3 is not supported with KVM");
>> +            exit(1);
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> +        }
>>          return "arm-gicv3";
>>      }
>>  }
>>
>
> Regards,
>
> Phil.
>
