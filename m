Received: from eggs.gnu.org ([2001:4830:134:3::10]:57609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gTpC1-0005QQ-Et
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gTpBy-0007Pc-OT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:27:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gTpBy-0007Op-J2
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:27:22 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so8733208itl.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 06:27:21 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
In-Reply-To: <CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 3 Dec 2018 15:27:08 +0100
Message-ID: <CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
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
To: Rob Bradford <robert.bradford@intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Hi Rob,
I continued to investigate the boot time, and as you suggested I
looked also at qemu-lite 2.11.2
(https://github.com/kata-containers/qemu) and NEMU "virt" machine. I
did the following tests using the Kata kernel configuration
(https://github.com/kata-containers/packaging/blob/master/kernel/configs/x86_64_kata_kvm_4.14.x)

To compare the results with qemu-lite direct kernel load, I added
another tracepoint:
- linux_start_kernel: first entry of the Linux kernel (start_kernel())

As you can see, NEMU is faster to jump to the kernel
(linux_start_kernel) than qemu-lite when uses qboot or seabios with
virt support, but the time to the user space is strangely high, maybe
the kernel configuration that I used is not the best one.
Do you suggest another kernel configuration?

Anyway, I obtained the best boot time with qemu-lite and direct kernel
load (vmlinux ELF image). I think because the kernel was not
compressed. Indeed, looking to the others test, the kernel
decompression (bzImage) takes about 80 ms (linux_start_kernel -
linux_start_boot). (I'll investigate better)

* QEMU
    + qboot
      qemu_init_end: 41.306968
      fw_start: 41.478601 (+0.171633)
      fw_do_boot: 47.03688 (+5.558279)
      linux_start_boot: 48.80918 (+1.7723)
      linux_start_kernel: 128.474013 (+79.664833)
      linux_start_user: 347.257097 (+218.783084)
    + seabios
      qemu_init_end: 40.703177
      fw_start: 40.902842 (+0.199665)
      fw_do_boot: 54.604878 (+13.702036)
      linux_start_boot: 56.314063 (+1.709185)
      linux_start_kernel: 136.942521 (+80.628458)
      linux_start_user: 356.211221 (+219.2687)
    + OVMF
      qemu_init_end: 44.055712
      fw_start: 168.094131 (+124.038419)
      fw_do_boot: 322.222745 (+154.128614)
      linux_start_boot: 323.809639 (+1.586894)
      linux_start_kernel: 401.756773 (+77.947134)
      linux_start_user: 604.601438 (+202.844665)
* NEMU "virt" machine
    + qboot
      qemu_init_end: 27.732925
      fw_start: 27.887483 (+0.154558)
      fw_do_boot: 29.20226 (+1.314777)
      linux_start_boot: 30.842672 (+1.640412)
      linux_start_kernel: 111.639445 (+80.796773)
      linux_start_user: 862.294876 (+750.655431)
    + seabios
      qemu_init_end: 28.203907
      fw_start: 28.68285 (+0.478943)
      fw_do_boot: 36.337377 (+7.654527)
      linux_start_boot: 37.995622 (+1.658245)
      linux_start_kernel: 118.11591 (+80.120288)
      linux_start_user: 897.110477 (+778.994567)
    + OVMF
      qemu_init_end: 31.219852
      fw_start: 153.304126 (+122.084274)
      fw_do_boot: 183.69459 (+30.390464)
      linux_start_boot: 185.296567 (+1.601977)
      linux_start_kernel: 361.11524 (+175.818673)
      linux_start_user: 1231.590077 (+870.474837)
* Qemu-lite
    + no FW (-machine pc,...,fw=off KERNEL=/path/to/vmlinux)
      qemu_init_end: 32.243801
      linux_start_kernel: 32.330323 (+0.086522)
      linux_start_user: 208.742712 (+176.412389)
    + qboot
      qemu_init_end: 25.393047
      fw_start: 25.545285 (+0.152238)
      fw_do_boot: 31.073253 (+5.527968)
      linux_start_boot: 33.139721 (+2.066468)
      linux_start_kernel: 114.604384 (+81.464663)
      linux_start_user: 287.93128 (+173.326896)
    + seabios
      qemu_init_end: 25.448283
      fw_start: 25.628977 (+0.180694)
      fw_do_boot: 38.551957 (+12.92298)
      linux_start_boot: 40.220319 (+1.668362)
      linux_start_kernel: 126.392991 (+86.172672)
      linux_start_user: 308.807806 (+182.414815)
    + OVMF
      qemu_init_end: 27.616988
      fw_start: 151.272286 (+123.655298)
      fw_do_boot: 309.068926 (+157.79664)
      linux_start_boot: 310.602074 (+1.533148)
      linux_start_kernel: 387.83349 (+77.231416)
      linux_start_user: 576.057453 (+188.223963)

Testbed:
* seabios: https://github.com/rbradford/seabios/tree/virt-x86 + patch
to disable debug writes
(https://mail.coreboot.org/pipermail/seabios/2018-December/012654.html)
* qboot: https://github.com/rbradford/qboot/tree/virt-x86
* OVMF: https://github.com/intel/ovmf-virt/tree/virt-x86
* QEMU command: $QEMU -bios $BIOS -machine
$MACHINE,accel=kvm,kernel_irqchip,nvdimm -cpu host -m
512,maxmem=1G,slots=1 -smp 1 -kernel $KERNEL -append 'root=/dev/pmem0
ro console=hvc0' -vga none -display none -no-user-config -nodefaults
-object memory-backend-file,id=mem0,share,mem-path=$ROOTFS,size=$ROOTFS_SIZE
-device nvdimm,memdev=mem0,id=nv0 -chardev stdio,id=virtiocon0 -device
virtio-serial -device virtconsole,chardev=virtiocon0

Cheers,
Stefano

On Tue, Nov 27, 2018 at 3:21 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Rob,
>
> On Tue, Nov 27, 2018 at 10:57 AM Rob Bradford <robert.bradford@intel.com> wrote:
> >
> > Hi Stefano,
> >
> > On Mon, 2018-11-26 at 17:40 +0100, Stefano Garzarella wrote:
> > > Hi Samuel, Rob,
> > > I'm proceeding to compare several x86 firmwares in order to
> > > understand
> > > which suits better with -kernel option to have a fast boot with
> > > QEMU/NEMU.
> > >
> > > For your use cases, what boot time do you expect?
> > >
> >
> > Kata Containers, one of the use cases we're looking at, is very
> > sensitive to boot time, although it is configurable, the default
> > configuration is to use qemu-lite with it's direct to kernel loader.
> >
> > That is probably a baseline we should be comparing with.
> >
> > As an aside, yesterday I posted the Seabios patches for enabling on
> > NEMU/virt:
> >
> > https://github.com/rbradford/seabios/tree/virt-x86
> >
> > I didn't yet start optimising the configuration file we use for it
> > beyond getting it < 128KiB or apply any optimisation patches.
> >
> > And I also have some qboot patches too:
> >
> > https://github.com/rbradford/qboot/tree/virt-x86
> >
> > So we're in a situation where we can start comparing other machine
> > types against virt too.
>
> Thanks for the pointers, I'll try to do the same tests with qemu-lite
> and direct kernel loader and also with NEMU "virt" machine, using your
> versions of SeaBIOS and qboot.
>
> >
> > >
> > > I compared SeaBIOS, qboot, and OVMF. I started each test using this
> > > qemu parameters: "./qemu-system-x86_64 -bios path/to/bios.bin -m 1G
> > > -cpu host -M accel=kvm -vga none -kernel path/to/bzImage -initrd
> > > path/to/rootfs.cpio ..."
> > >
> > > As Samuel suggested, I added the total time to userspace adding a
> > > probe in the kernel_init(), so the times (in msec) that I measured
> > > are:
> > > - qemu_init_end: first kvm_entry (i.e. QEMU initialized has finished)
> > > - fw_start: first entry of the firmware
> > > - fw_do_boot: after the firmware initialization (e.g. PCI setup,
> > > etc.)
> > > - linux_start_boot: before the jump to the Linux kernel
> > > - linux_start_user: before starting the init process
> > >
> > > * SeaBIOS
> > > Default configuration without debug messages (CONFIG_DEBUG_LEVEL=0) +
> > > Stephen's patch (tpm: Check for TPM related ACPI tables before
> > > attempting hw) + my patch (qemu: fast boot when linuxboot optionrom
> > > is
> > > used).
> > >  qemu_init_end: 41.634812
> > >  fw_start: 41.857374 (+0.222562)
> > >  fw_do_boot: 52.754109 (+10.896735)
> > >  linux_start_boot: 54.117220 (+1.363111)
> > >  linux_start_user: 495.684199 (+441.566979)
> > >
> > > * qboot
> > > Default configuration + my patch (pci: reduce pci_foreach() calls).
> > >  qemu_init_end: 40.233717
> > >  fw_start: 40.384048 (+0.150331)
> > >  fw_do_boot: 45.660497 (+5.276449)
> > >  linux_start_boot: 47.252119 (+1.591622)
> > >  linux_start_user: 509.173886 (+461.921767)
> > >
> > > * OVMF (https://github.com/intel/ovmf-virt)
> > > I followed this script
> > > (
> > > https://github.com/intel/nemu/blob/topic/virt-x86/tools/CI/run_nats.sh
> > > )
> > > to build OVMF.
> > > Note: I put the "fw_start" probe in the BdsEntry()
> > > [MdeModulePkg/Universal/BdsDxe/BdsEntry.c], I'm not sure if it is
> > > "near" to the real entry point.
> > >  qemu_init_end: 42.734555
> > >  fw_start: 163.611506 (+120.876951)
> > >  fw_do_boot: 369.713760 (+206.102254)
> > >  linux_start_boot: 370.960364 (+1.246604)
> > >  linux_start_user: 796.799667 (+425.839303)
> > >
> > > For OVMF case, are reasonable the times that I measured? Do you use a
> > > different configuration?
> > >
> >
> > That is the same OVMF configuration as we normally use, I have the
> > configuration file checked in. Those numbers look like the ones I
> > expect.
>
> Perfect!
>
> Please, let me know if you have something more important than boot
> time to help you.
>
> Regards,
> Stefano
>
> >
> > > Thanks,
> > > Stefano
> > >
> >
> > Great work,
> >
> > Rob
> >
>
> --
> Stefano Garzarella
> Red Hat



--
Stefano Garzarella
Red Hat
