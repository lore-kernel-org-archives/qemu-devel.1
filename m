Received: from eggs.gnu.org ([2001:4830:134:3::10]:44417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZZY3-0000sd-EL
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZZY2-0003wR-A1
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:53:23 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:40950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZZY2-0003vg-4E
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:53:22 -0500
Received: by mail-oi0-x230.google.com with SMTP id u83so1255999oie.7
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 01:53:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <558dc576-6d05-50d4-9f7c-73738e28ad26@huawei.com>
References: <1514440458-10515-1-git-send-email-gengdongjiu@huawei.com>
	<1514440458-10515-6-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-RC6hUMR5jPrgOB7nkWjXaPxo6dYEXO=kgC=59k7EVrw@mail.gmail.com>
	<558dc576-6d05-50d4-9f7c-73738e28ad26@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 09:53:00 +0000
Message-ID: <CAFEAcA-cAgB5TigMWUsnF74YrzWGToDht61HhOnGrSD1QBDNhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v14 5/9] target-arm: kvm64:
 inject synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>, qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>, Huangshaoyu <huangshaoyu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@linaro.org>, Richard Henderson <rth@twiddle.net>

On 11 January 2018 at 05:59, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Peter.
>
> On 2018/1/10 1:30, Peter Maydell wrote:
>> On 28 December 2017 at 05:54, Dongjiu Geng <gengdongjiu@huawei.com> wrote:

>>> +
>>> +    /* This exception comes from lower or current exception level. */
>>> +    if ((cpsr & 0xf) == PSTATE_MODE_EL0t) {
>>
>> This looks like it'll be wrong for AArch32 guests (which you can
>> still have with KVM with a 64-bit host), and even for AArch32
>> userspace in a 64-bit guest. The correct way to find out what the
>> current EL is is to use arm_current_el().

>  sorry, in the OS(include guest OS), for software error recovery,
> we only support AArch64 kernel, not support AArch32
>  kernel or AArch32 user space.

Nope, you must handle AArch32 EL1 correctly in some way, even if that
is only "this guest CPU doesn't support RAS notification and we
will not notify it". And you must absolutely support AArch32 EL0,
that's a requirement for getting this merged. It's not difficult.

thanks
-- PMM
