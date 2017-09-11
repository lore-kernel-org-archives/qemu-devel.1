Received: from eggs.gnu.org ([2001:4830:134:3::10]:38517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drNXk-0008Bz-FA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drNXf-0001xr-Jf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drNXf-0001xL-AC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:10:19 -0400
Date: Mon, 11 Sep 2017 14:10:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170911141016.2352b022@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
	<20170904213851.107ed8c8@Igors-MacBook-Pro.local>
	<CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 5 Sep 2017 10:08:01 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 4 September 2017 at 20:38, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Mon, 4 Sep 2017 17:36:59 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> >> I just got bitten by qdev_get_machine()'s behaviour on the user-only
> >> emulators, where it can return something that isn't NULL and isn't
> >> an instance of TYPE_MACHINE either.  
> > user-only shouldn't get to qdev_get_machine() at all,
> > issue probably in container_get().  
> 
> I need it in cpu_common_realizefn(), for
> http://patchwork.ozlabs.org/patch/797940/
Link might be broken (unable to connect to server)

Anyways I'd avoid using machine from cpu_*_realizefn(),
instead of I'd add property to CPU that has needed data
and set it from board code. Should work fine for *-user targets
and maintain clear separation of device impl. and board details. 

> 
> > I'd try to fix wrong user if possible and maybe add ifdef build failure
> > to qdev_get_machine() so it would not build in user mode.  
> 
> Can't ifdef, that source file is built once for all targets.
> 
> My fix (which I intend to send to the list today) is to make
> it do the object_dynamic_cast() check -- if that doesn't give
> a TYPE_MACHINE then we're in user mode and don't need to set
> ignore_memory_transaction_failures on the cpu object anyway.
> 
> >> It looks like maybe this can happen in some cases in softmmu too,
> >> judging by the way that qdev_get_hotplug_handler() does an
> >> object_dynamic_cast() check that it really got back a TYPE_MACHINE.  
> > As I recall only bus or machine provide hotplug_handler currently,
> > but it's possible to extend to other objects if we find use-case.
> >
> > We could do static cast to machine instead dynamic there but
> > in hotplug case it will abort QEMU if error happens,
> > hence dynamic check to avoid be more resilient during hotplug.
> > (well, if qdev_get_machine() returns not machine during startup
> > we would be screwed anyways, but that should break much earlier)  
> 
> If this can't ever happen then we should be aborting; that's
> the idea behind the cast macros doing assertions. I'm not
> sure hotplug needs to be special here if it doesn't have
> a genuine reason to think it might get back something of
> the wrong type.
Yep, we should abort.

> 
> thanks
> -- PMM
