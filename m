Received: from eggs.gnu.org ([2001:4830:134:3::10]:35919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fLQxL-0007yw-QH
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fLQxE-0003qI-HZ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:25:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fLQxD-0003pM-6I
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:25:11 -0400
Date: Wed, 23 May 2018 12:25:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180523122506.1e858847@redhat.com>
In-Reply-To: <a70da475-a9a4-5470-7d54-5615d5beb2f3@redhat.com>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
	<20180510174519.11264-6-peter.maydell@linaro.org>
	<a70da475-a9a4-5470-7d54-5615d5beb2f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 05/21] arm/boot: split load_dtb() from
 arm_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>

On Wed, 23 May 2018 09:38:33 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 05/10/2018 07:45 PM, Peter Maydell wrote:
> > From: Igor Mammedov <imammedo@redhat.com>
> > 
> > load_dtb() depends on arm_load_kernel() to figure out place
> > in RAM where it should be loaded, but it's not required for
> > arm_load_kernel() to work. Sometimes it's neccesary for
> > devices added with -device/device_add to be enumerated in
> > DTB as well, which's lead to [1] and surrounding commits to
> > add 2 more machine_done notifiers with non obvious ordering
> > to make dynamic sysbus devices initialization happen in
> > the right order.
> > 
> > However instead of moving whole arm_load_kernel() in to
> > machine_done, it's sufficient to move only load_dtb() into
> > virt_machine_done() notifier and remove ArmLoadKernelNotifier/
> > /PlatformBusFDTNotifierParams notifiers, which saves us ~90LOC
> > and simplifies code flow quite a bit.
> > Later would allow to consolidate DTB generation within one
> > function for 'mach-virt' board and make it reentrant so it
> > could generate updated DTB in device hotplug secenarios.
> > 
> > While at it rename load_dtb() to arm_load_dtb() since it's
> > public now.
> > 
> > Add additional field skip_dtb_autoload to struct arm_boot_info
> > to allow manual DTB load later in mach-virt and to avoid touching
> > all other boards to explicitly call arm_load_dtb().
> > 
> >  1) (ac9d32e hw/arm/boot: arm_load_kernel implemented as a machine init done notifier)  
> 
> I face a regression that looks to be caused by this patch (bisect
> session result). Reverting it allows the guest to boot. Otherwise I get:
> 
> in kvm_device_access() at
> /home/augere/UPSTREAM/qemu/accel/kvm/kvm-all.c:2164:
> 2018-05-22T18:02:17.210175Z qemu-system-aarch64: KVM_SET_DEVICE_ATTR
> failed: Group 6 attr 0x000000000000c665: Invalid argument
> 
> It happens when booting with -bios option only (with dt, it boots fine).
> 
> I have not identified the root cause yet.
Problem was with broken reset order, thanks for catching it early.
Quick fix is posted under title
  "arm: fix qemu crash on startup with -bios option"
