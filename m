Received: from eggs.gnu.org ([2001:4830:134:3::10]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drOq6-0003dZ-8h
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drOq5-0004Yb-Bu
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:33:26 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drOq5-0004Xx-3i
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:33:25 -0400
Received: by mail-wr0-x230.google.com with SMTP id v109so14687046wrc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:33:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911141016.2352b022@nial.brq.redhat.com>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
	<20170904213851.107ed8c8@Igors-MacBook-Pro.local>
	<CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
	<20170911141016.2352b022@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:33:03 +0100
Message-ID: <CAFEAcA_41Dkh4EdvCWWcnFHZaspOBA0FewKKK22kQ0v97pKG0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qdev_get_machine() can return something non-NULL
 but not TYPE_MACHINE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 11 September 2017 at 13:10, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 5 Sep 2017 10:08:01 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 4 September 2017 at 20:38, Igor Mammedov <imammedo@redhat.com> wrote:
>> > On Mon, 4 Sep 2017 17:36:59 +0100
>> > Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> >> I just got bitten by qdev_get_machine()'s behaviour on the user-only
>> >> emulators, where it can return something that isn't NULL and isn't
>> >> an instance of TYPE_MACHINE either.
>> > user-only shouldn't get to qdev_get_machine() at all,
>> > issue probably in container_get().
>>
>> I need it in cpu_common_realizefn(), for
>> http://patchwork.ozlabs.org/patch/797940/
> Link might be broken (unable to connect to server)

Works for me, but it is in master now anyway, commit
ed860129acd3fcd0b1.

> Anyways I'd avoid using machine from cpu_*_realizefn(),
> instead of I'd add property to CPU that has needed data
> and set it from board code. Should work fine for *-user targets
> and maintain clear separation of device impl. and board details.

It's not possible in all cases to set a CPU property from the
top level board code. In quite a lot of cases the CPU
object is created by an SoC object which is in turn
created by the board code, and there is no plumbing
there to pass arbitrary properties through to the CPU
object...

thanks
-- PMM
