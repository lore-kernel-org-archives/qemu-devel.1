Received: from eggs.gnu.org ([2001:4830:134:3::10]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dQDFQ-0005aP-Cw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dQDFP-0001G2-8N
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:43:12 -0400
Date: Wed, 28 Jun 2017 15:43:00 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170628134300.att7dnov44aiidoe@kamzik.brq.redhat.com>
References: <1498577737-130264-1-git-send-email-agraf@suse.de>
	<20170628115110.nq7wdsrhxxjelzq6@kamzik.brq.redhat.com>
	<9e3a0693-d69b-4ae7-c449-457f7428fbff@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3a0693-d69b-4ae7-c449-457f7428fbff@suse.de>
Subject: Re: [Qemu-devel] [PATCH v3] ARM: KVM: Enable in-kernel timers with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, cdall@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 28, 2017 at 02:36:17PM +0200, Alexander Graf wrote:
> 
> 
> On 28.06.17 13:51, Andrew Jones wrote:
> > On Tue, Jun 27, 2017 at 05:35:37PM +0200, Alexander Graf wrote:
> > > When running with KVM enabled, you can choose between emulating the
> > > gic in kernel or user space. If the kernel supports in-kernel virtualization
> > > of the interrupt controller, it will default to that. If not, if will
> > > default to user space emulation.
> > > 
> > > Unfortunately when running in user mode gic emulation, we miss out on
> > > interrupt events which are only available from kernel space, such as the timer.
> > > This patch leverages the new kernel/user space pending line synchronization for
> > > timer events. It does not handle PMU events yet.
> > > 
> > > Signed-off-by: Alexander Graf <agraf@suse.de>
> > > Reviewed-by: Andrew Jones <drjones@redhat.com>
> > > 
> > > ---
> > > 
> > > v1 -> v2:
> > > 
> > >    - whitespace fixes
> > >    - use !! to determine whether bit is set
> > >    - call in-kernel device IRQs out by their name everywhere
> > > 
> > > v2 -> v3:
> > > 
> > >    - fix last occurence of calling out timer IRQs explicitly
> > > ---
> > >   accel/kvm/kvm-all.c    |  5 +++++
> > >   accel/stubs/kvm-stub.c |  5 +++++
> > >   hw/intc/arm_gic.c      |  7 +++++++
> > >   include/sysemu/kvm.h   | 11 +++++++++++
> > >   target/arm/cpu.h       |  3 +++
> > >   target/arm/kvm.c       | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   6 files changed, 82 insertions(+)
> > > 
> > 
> > Tried testing this on a gicv3 machine, a ThunderX2. The guest kernel
> 
> Did you patch QEMU to automatically choose the gic version?

Nope, I was just trying to use a pre-existing guest config on that host,
which had gic-version=3 on its command line.

> The upstream
> default is to have gicv2 as the guest gic type. And gicv2 should work just
> fine.

Yup, works for me now (with its limitations - had to reduce the number of
cpus the pre-existing guest config had configured to 8.)

Thanks,
drew
