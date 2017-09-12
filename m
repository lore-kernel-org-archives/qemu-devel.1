Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drfnl-0004q8-DK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drfnh-0008ET-3D
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drfng-0008EF-Se
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:40:05 -0400
Date: Tue, 12 Sep 2017 09:40:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912094001.04e7a84a@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA_41Dkh4EdvCWWcnFHZaspOBA0FewKKK22kQ0v97pKG0Q@mail.gmail.com>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
	<20170904213851.107ed8c8@Igors-MacBook-Pro.local>
	<CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
	<20170911141016.2352b022@nial.brq.redhat.com>
	<CAFEAcA_41Dkh4EdvCWWcnFHZaspOBA0FewKKK22kQ0v97pKG0Q@mail.gmail.com>
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

On Mon, 11 Sep 2017 14:33:03 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 11 September 2017 at 13:10, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Tue, 5 Sep 2017 10:08:01 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> >> On 4 September 2017 at 20:38, Igor Mammedov <imammedo@redhat.com> wrote:  
> >> > On Mon, 4 Sep 2017 17:36:59 +0100
> >> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >> >  
> >> >> I just got bitten by qdev_get_machine()'s behaviour on the user-only
> >> >> emulators, where it can return something that isn't NULL and isn't
> >> >> an instance of TYPE_MACHINE either.  
> >> > user-only shouldn't get to qdev_get_machine() at all,
> >> > issue probably in container_get().  
> >>
> >> I need it in cpu_common_realizefn(), for
> >> http://patchwork.ozlabs.org/patch/797940/  
> > Link might be broken (unable to connect to server)  
> 
> Works for me, but it is in master now anyway, commit
> ed860129acd3fcd0b1.
> 
> > Anyways I'd avoid using machine from cpu_*_realizefn(),
> > instead of I'd add property to CPU that has needed data
> > and set it from board code. Should work fine for *-user targets
> > and maintain clear separation of device impl. and board details.  
> 
> It's not possible in all cases to set a CPU property from the
> top level board code. In quite a lot of cases the CPU
> object is created by an SoC object which is in turn
> created by the board code, and there is no plumbing
> there to pass arbitrary properties through to the CPU
> object...
there is a cleaner way without cpu accessing machine,
make it property of cpu and use compat machinery that
was invented for fixing up stuff of this kind.

SET_MACHINE_COMPAT(MachineClass,
                   { .driver = "arm-cpu",
                     .property = "foo",
                     .value    = "off",
                   }
                  )

> 
> thanks
> -- PMM
