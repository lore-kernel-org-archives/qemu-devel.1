Received: from eggs.gnu.org ([2001:4830:134:3::10]:55938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dpF6G-0001pT-2s
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dpF68-0002iO-CR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:45:12 -0400
Date: Tue, 5 Sep 2017 16:44:49 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170905144449.yiupcvhbnfc3sakn@kamzik.brq.redhat.com>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<1500471597-2517-5-git-send-email-drjones@redhat.com>
	<CAFEAcA_xDei18gfdLuo5=aPM=9D9Ou6LBLfT+gtGUKgcpDC88A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_xDei18gfdLuo5=aPM=9D9Ou6LBLfT+gtGUKgcpDC88A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target/arm/kvm: pmu: improve error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christoffer Dall <cdall@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Mon, Sep 04, 2017 at 03:17:21PM +0100, Peter Maydell wrote:
> On 19 July 2017 at 14:39, Andrew Jones <drjones@redhat.com> wrote:
> > If a KVM PMU init or set-irq attr call fails we just silently stop
> > the PMU DT node generation. The only way they could fail, though,
> > is if the attr's respective KVM has-attr call fails. But that should
> > never happen if KVM advertises the PMU capability, because both
> > attrs have been available since the capability was introduced. Let's
> > just abort if this should-never-happen stuff does happen, because,
> > if it does, then something is obviously horribly wrong.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  hw/arm/virt.c        |  9 +++------
> >  target/arm/kvm32.c   |  3 +--
> >  target/arm/kvm64.c   | 28 ++++++++++++++++++++--------
> >  target/arm/kvm_arm.h | 15 ++++-----------
> >  4 files changed, 28 insertions(+), 27 deletions(-)
> 
> This breaks compile on 32-bit ARM:
> 
> /home/peter.maydell/qemu/target/arm/kvm32.c:530:5: error: conflicting
> types for 'kvm_arm_pmu_init'
>  int kvm_arm_pmu_init(CPUState *cs)
>      ^
> In file included from /home/peter.maydell/qemu/target/arm/kvm32.c:21:0:
> /home/peter.maydell/qemu/target/arm/kvm_arm.h:199:6: note: previous
> declaration of 'kvm_arm_pmu_init' w
> as here
>  void kvm_arm_pmu_init(CPUState *cs);
>       ^

Argh. Sorry about that. I could have sworn I compile-tested for 32-bit
ARM. Maybe I changed the series afterwards and forgot to compile-test
again...

> 
> Looks like you forgot to update the 32-bit version of the function
> to the new API; I'll just fix up the patch in my queue.

Thanks!

drew
