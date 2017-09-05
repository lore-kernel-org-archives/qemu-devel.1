Received: from eggs.gnu.org ([2001:4830:134:3::10]:34098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dp9qP-0000FP-FB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dp9qK-0008Pj-L7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:29 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dp9qK-0008Nu-DP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:24 -0400
Received: by mail-wr0-x22b.google.com with SMTP id p14so5226368wrg.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:08:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170904213851.107ed8c8@Igors-MacBook-Pro.local>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
	<20170904213851.107ed8c8@Igors-MacBook-Pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 10:08:01 +0100
Message-ID: <CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
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

On 4 September 2017 at 20:38, Igor Mammedov <imammedo@redhat.com> wrote:
> On Mon, 4 Sep 2017 17:36:59 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> I just got bitten by qdev_get_machine()'s behaviour on the user-only
>> emulators, where it can return something that isn't NULL and isn't
>> an instance of TYPE_MACHINE either.
> user-only shouldn't get to qdev_get_machine() at all,
> issue probably in container_get().

I need it in cpu_common_realizefn(), for
http://patchwork.ozlabs.org/patch/797940/

> I'd try to fix wrong user if possible and maybe add ifdef build failure
> to qdev_get_machine() so it would not build in user mode.

Can't ifdef, that source file is built once for all targets.

My fix (which I intend to send to the list today) is to make
it do the object_dynamic_cast() check -- if that doesn't give
a TYPE_MACHINE then we're in user mode and don't need to set
ignore_memory_transaction_failures on the cpu object anyway.

>> It looks like maybe this can happen in some cases in softmmu too,
>> judging by the way that qdev_get_hotplug_handler() does an
>> object_dynamic_cast() check that it really got back a TYPE_MACHINE.
> As I recall only bus or machine provide hotplug_handler currently,
> but it's possible to extend to other objects if we find use-case.
>
> We could do static cast to machine instead dynamic there but
> in hotplug case it will abort QEMU if error happens,
> hence dynamic check to avoid be more resilient during hotplug.
> (well, if qdev_get_machine() returns not machine during startup
> we would be screwed anyways, but that should break much earlier)

If this can't ever happen then we should be aborting; that's
the idea behind the cast macros doing assertions. I'm not
sure hotplug needs to be special here if it doesn't have
a genuine reason to think it might get back something of
the wrong type.

thanks
-- PMM
