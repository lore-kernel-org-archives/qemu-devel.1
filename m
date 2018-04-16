Received: from eggs.gnu.org ([2001:4830:134:3::10]:40901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1f80Io-0005Lx-29
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1f80In-0005cj-3L
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:19:58 -0400
Date: Mon, 16 Apr 2018 11:19:41 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180416091941.7n24dd3qjyuqh4h6@kamzik.brq.redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-9-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_O3QK0t5DHfnAFEOHv_yyxvL9HZX+0geHs0ibVVwTbNQ@mail.gmail.com>
	<57b01152-1179-9735-eb6a-a9dbfc933a6c@redhat.com>
	<CAFEAcA-wT8vERbkjq_HoROi1ymPauAe+y3oc16zoCJXsHKqBoQ@mail.gmail.com>
	<94299045-3027-517c-d634-4613f78de163@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94299045-3027-517c-d634-4613f78de163@redhat.com>
Subject: Re: [Qemu-devel] [RFC 8/8] hw/arm/virt: Allow up to 512 vcpus along
 with KVM VGICv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Wei Huang <wei@redhat.com>, Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

On Fri, Apr 13, 2018 at 04:11:24PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 13/04/18 16:06, Peter Maydell wrote:
> > On 13 April 2018 at 15:01, Auger Eric <eric.auger@redhat.com> wrote:
> >> On 13/04/18 15:41, Peter Maydell wrote:
> >>> I think it would be better to explicitly check "do we have
> >>> support for split redistributors" rather than looking at
> >>> KVM_MAX_VCPUS. It's not impossible that a distro kernel
> >>> might have chosen to backport support for one but not the
> >>> other.
> >>
> >> The issue is we have race here:
> >> to check whether the new ATTR is supported I need to query the GICV3 KVM
> >> device. This later is created in the GICv3 initialize. But to initialize
> >> the VGIC I need the VCPUs to be created. And to create the VCPUs I need
> >> to check their max number. Or do I miss somethinh?
> >>
> >> The KVM device create dry-run mode cannot be used here. I would need to
> >> really create the KVM device and then delete it. The issue is there is
> >> no kvm device DELETE ioctl at kernel level since KVM devices are deleted
> >> on VM deletion if I understand correctly. Adding a KVM device delete at
> >> kernel level may not be straightforward as I suspect some
> >> simplifications could be made in KVM device deletion knowing the VM was
> >> under deletion.
> > 
> > Two possibilities:
> > 
> > (1) do like we do in kvm_arm_get_host_cpu_features() where we
> > create a scratch VM to interrogate it and then throw it away
> > when we have the info we need
> Oh OK. I did not know this was in place. At first sight, this looks
> simpler than (2) to me. I will investigate this solution.

But (1) isn't awesome. It'd be better if we could avoid scratch VMs
altogether as they slow VM launch and create confusing traces when
debugging. Also, it's just not a pretty way to do things. If we must
keep a scratch VM, then let's at least make sure we only have one,
i.e. put all probing into a single scratch VM.

> 
> Thanks!
> 
> Eric
> > 
> > (2) add an API to the kernel to make it easier to query it
> > for this sort of feature

This is the cleaner choice, but I wasn't opposed to the max-vcpus
query getting double-duty though. While the backporting argument is
a good point, I'm not sure we've ever really cared about what
issues backporters have had to endure when they cherry-pick features
before.

Thanks,
drew


> > 
> > thanks
> > -- PMM
> > 
> 
