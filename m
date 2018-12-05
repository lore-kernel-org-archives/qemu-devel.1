Received: from eggs.gnu.org ([2001:4830:134:3::10]:43263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gUVwc-0003WR-IN
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gUVwY-0003Ep-J7
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:06:22 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gUVwY-0003DG-Cx
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:06:18 -0500
Received: by mail-it1-f181.google.com with SMTP id b5so19814152iti.2
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 04:06:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
	<a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
	<CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
	<59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
In-Reply-To: <59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 5 Dec 2018 13:06:05 +0100
Message-ID: <CAGxU2F5qLq04XtFZqkSsDVEY_HMNvJyZQfb5aaSxfTFCdz9sZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: maran.wilson@oracle.com
Cc: Rob Bradford <robert.bradford@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, liam.merwick@oracle.com

On Tue, Dec 4, 2018 at 11:45 PM Maran Wilson <maran.wilson@oracle.com> wrote:
>
> On 12/3/2018 8:35 AM, Stefano Garzarella wrote:
> > On Mon, Dec 3, 2018 at 4:44 PM Rob Bradford <robert.bradford@intel.com> wrote:
> >> Hi Stefano, thanks for capturing all these numbers,
> >>
> >> On Mon, 2018-12-03 at 15:27 +0100, Stefano Garzarella wrote:
> >>> Hi Rob,
> >>> I continued to investigate the boot time, and as you suggested I
> >>> looked also at qemu-lite 2.11.2
> >>> (https://github.com/kata-containers/qemu) and NEMU "virt" machine. I
> >>> did the following tests using the Kata kernel configuration
> >>> (
> >>> https://github.com/kata-containers/packaging/blob/master/kernel/configs/x86_64_kata_kvm_4.14.x
> >>> )
> >>>
> >>> To compare the results with qemu-lite direct kernel load, I added
> >>> another tracepoint:
> >>> - linux_start_kernel: first entry of the Linux kernel
> >>> (start_kernel())
> >>>
> >> Great, do you have a set of patches available that all these trace
> >> points. It would be great for reproduction.
> > For sure! I'm attaching a set of patches for qboot, seabios, ovmf,
> > nemu/qemu/qemu-lite and linux 4.14 whit the tracepoints.
> > I'm also sharing a python script that I'm using with perf to extract
> > the numbers in this way:
> >
> > $ perf record -a -e kvm:kvm_entry -e kvm:kvm_pio -e
> > sched:sched_process_exec -o /tmp/qemu_perf.data &
> > $ # start qemu/nemu multiple times
> > $ killall perf
> > $ perf script -s qemu-perf-script.py -i /tmp/qemu_perf.data
> >
> >>> As you can see, NEMU is faster to jump to the kernel
> >>> (linux_start_kernel) than qemu-lite when uses qboot or seabios with
> >>> virt support, but the time to the user space is strangely high, maybe
> >>> the kernel configuration that I used is not the best one.
> >>> Do you suggest another kernel configuration?
> >>>
> >> This looks very bad. This isn't the kernel configuration we normally
> >> test with in our automated test system but is definitely one we support
> >> as part of our partnernship with the Kata team. It's a high priority
> >> for me to try and investigate that. Have you saved the kernel messages
> >> as they might be helpful?
> > Yes, I'm attaching the dmesg output with nemu and qemu.
> >
> >>> Anyway, I obtained the best boot time with qemu-lite and direct
> >>> kernel
> >>> load (vmlinux ELF image). I think because the kernel was not
> >>> compressed. Indeed, looking to the others test, the kernel
> >>> decompression (bzImage) takes about 80 ms (linux_start_kernel -
> >>> linux_start_boot). (I'll investigate better)
> >>>
> >> Yup being able to load an uncompressed kernel is one of the big
> >> advantages of qemu-lite. I wonder if we could bring that feature into
> >> qemu itself to supplement the existing firmware based kernel loading.
> > I think so, I'll try to understand if we can merge the qemu-lite
> > direct kernel loading in qemu.
>
> An attempt was made a long time ago to push the qemu-lite stuff (from
> the Intel Clear Containers project) upstream. As I understand it, the
> main stumbling block that seemed to derail the effort was that it
> involved adding Linux OS specific code to Qemu so that Qemu could do
> things like create and populate the zero page that Linux expects when
> entering startup_64().
>
> That ends up being a lot of very low-level, operating specific knowledge
> about Linux that ends up getting baked into Qemu code. And
> understandably, a number of folks saw problems with going down a path
> like that.
>
> Since then, we have put together an alternative solution that would
> allow Qemu to boot an uncompressed Linux binary via the x86/HVM direct
> boot ABI (https://xenbits.xen.org/docs/unstable/misc/pvh.html). The
> solution involves first making changes to both the ABI as well as Linux,
> and then updating Qemu to take advantage of the updated ABI which is
> already supported by both Linux and Free BSD for booting VMs. As such,
> Qemu can remain OS agnostic, and just be programmed to the published ABI.
>
> The canonical definition for the HVM direct boot ABI is in the Xen tree
> and we needed to make some minor changes to the ABI definition to allow
> KVM guests to also use the same structure and entry point. Those changes
> were accepted to the Xen tree already:
> https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg00057.html
>
> The corresponding Linux changes that would allow KVM guests to be booted
> via this PVH entry point have already been posted and reviewed:
> https://lkml.org/lkml/2018/4/16/1002
>
> The final part is the set of Qemu changes to take advantage of the above
> and boot a KVM guest via an uncompressed kernel binary using the entry
> point defined by the ABI. Liam Merwick will be posting some RFC patches
> very soon to allow this.

Hi Maran,
thank you very much for the details!

I'll take a look to the HVM direct boot ABI.

Thanks,
Stefano

>
> Thanks,
> -Maran
>
> >
> > Thanks,
> > Stefano
> >
> >
>


-- 
Stefano Garzarella
Red Hat
