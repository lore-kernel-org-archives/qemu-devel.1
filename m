Received: from eggs.gnu.org ([2001:4830:134:3::10]:43994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gXP2T-0000Om-Ph
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gXP2P-0005Ip-UW
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:20:21 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gXP2N-0005GN-W1
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:20:17 -0500
Received: by mail-oi1-f175.google.com with SMTP id u18so1301865oie.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:20:13 -0800 (PST)
MIME-Version: 1.0
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
In-Reply-To: <CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 13 Dec 2018 12:19:59 +0100
Message-ID: <CAGxU2F79qZojm6Wuo8WM8Khmz79xkanRLZDt7uWviz=ZP6j=vw@mail.gmail.com>
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
To: qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, liam.merwick@oracle.com, maran.wilson@oracle.com, Philippe Mathieu Daude <philmd@redhat.com>

Hi all,
this is an update of QEMU/NEMU booting time.

After the preliminary results, Rob found the reason of NEMU delays:
they were related to the PIT and the PCI initialization. (He sent me a
temporary hack to fix the issues)
Afterward, he discovered that there is a huge difference between the
4.14 and 4.19 Linux Kernel. (The early TSC related code that uses the
PIT appears to have disappeared.)

For this reason, I did the same tests (without OVMF) using the Linux
kernel 4.19:
* QEMU "pc" machine
  + qboot
    qemu_init_end: 40.357177
    fw_start: 40.533092 (+0.175915)
    fw_do_boot: 45.713896 (+5.180804)
    linux_start_boot: 47.451011 (+1.737115)
    linux_start_kernel: 131.372861 (+83.92185)
    linux_start_user: 279.818064 (+148.445203)
  + seabios
    qemu_init_end: 40.551679
    fw_start: 40.757828 (+0.206149)
    fw_do_boot: 52.688499 (+11.930671)
    linux_start_boot: 53.984453 (+1.295954)
    linux_start_kernel: 136.481648 (+82.497195)
    linux_start_user: 289.62459 (+153.142942)

* NEMU "virt" machine
  + qboot
    qemu_init_end: 29.870696
    fw_start: 30.092108 (+0.221412)
    fw_do_boot: 31.514079 (+1.421971)
    linux_start_boot: 32.9857 (+1.471621)
    linux_start_kernel: 116.546745 (+83.561045)
    linux_start_user: 241.254154 (+124.707409)
  + seabios
    qemu_init_end: 29.940350
    fw_start: 30.128961 (+0.188611)
    fw_do_boot: 51.469139 (+21.340178)
    linux_start_boot: 52.743141 (+1.274002)
    linux_start_kernel: 135.128856 (+82.385715)
    linux_start_user: 259.859471 (+124.730615)

* Qemu-lite
  + no FW (-machine pc,...,fw=off KERNEL=/path/to/vmlinux)
    qemu_init_end: 32.415627
    linux_start_kernel: 32.692544 (+0.276917)
    linux_start_user: 163.238889 (+130.546345)
  + qboot
    qemu_init_end: 25.840606
    fw_start: 25.990774 (+0.150168)
    fw_do_boot: 31.400927 (+5.410153)
    linux_start_boot: 33.084469 (+1.683542)
    linux_start_kernel: 115.441407 (+82.356938)
    linux_start_user: 249.881718 (+134.440311)
  + seabios
    qemu_init_end: 26.677585
    fw_start: 26.900763 (+0.223178)
    fw_do_boot: 39.478128 (+12.577365)
    linux_start_boot: 40.870536 (+1.392408)
    linux_start_kernel: 123.600073 (+82.729537)
    linux_start_user: 264.844896 (+141.244823)

To have another reference point, I tried also the QEMU q35 machine.
disabling some buses and devices (-machine
q35,...,sata=off,smbus=off,vmport=off -no-hpet), obtaining very good
results in term of boot time:
* QEMU "q35" machine
  + qboot
   qemu_init_end: 36.667717
   fw_start: 36.847075 (+0.179358)
   fw_do_boot: 41.794749 (+4.947674)
   linux_start_boot: 43.445767 (+1.651018)
   linux_start_kernel: 126.341309 (+82.895542)
   linux_start_user: 255.269846 (+128.928537)
 + seabios
   qemu_init_end: 37.781986
   fw_start: 37.974142 (+0.192156)
   fw_do_boot: 49.079861 (+11.105719)
   linux_start_boot: 50.467159 (+1.387298)
   linux_start_kernel: 133.292707 (+82.825548)
   linux_start_user: 261.492556 (+128.199849)

NEMU is the faster, but also QEMU with q35 machine is not bad.
In the next days, I'll do other tests with Xen PVH and also
Firecracker (they use the same approach of qemu-lite "-machine
pc,...,fw=off").

Note: we added "pci=lastbus=0" to the cmdline to speed up the PCI
initialization.

Thanks,
Stefano

On Mon, Dec 3, 2018 at 3:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Hi Rob,
> I continued to investigate the boot time, and as you suggested I
> looked also at qemu-lite 2.11.2
> (https://github.com/kata-containers/qemu) and NEMU "virt" machine. I
> did the following tests using the Kata kernel configuration
> (https://github.com/kata-containers/packaging/blob/master/kernel/configs/x86_64_kata_kvm_4.14.x)
>
> To compare the results with qemu-lite direct kernel load, I added
> another tracepoint:
> - linux_start_kernel: first entry of the Linux kernel (start_kernel())
>
> As you can see, NEMU is faster to jump to the kernel
> (linux_start_kernel) than qemu-lite when uses qboot or seabios with
> virt support, but the time to the user space is strangely high, maybe
> the kernel configuration that I used is not the best one.
> Do you suggest another kernel configuration?
>
> Anyway, I obtained the best boot time with qemu-lite and direct kernel
> load (vmlinux ELF image). I think because the kernel was not
> compressed. Indeed, looking to the others test, the kernel
> decompression (bzImage) takes about 80 ms (linux_start_kernel -
> linux_start_boot). (I'll investigate better)
>
> * QEMU
>     + qboot
>       qemu_init_end: 41.306968
>       fw_start: 41.478601 (+0.171633)
>       fw_do_boot: 47.03688 (+5.558279)
>       linux_start_boot: 48.80918 (+1.7723)
>       linux_start_kernel: 128.474013 (+79.664833)
>       linux_start_user: 347.257097 (+218.783084)
>     + seabios
>       qemu_init_end: 40.703177
>       fw_start: 40.902842 (+0.199665)
>       fw_do_boot: 54.604878 (+13.702036)
>       linux_start_boot: 56.314063 (+1.709185)
>       linux_start_kernel: 136.942521 (+80.628458)
>       linux_start_user: 356.211221 (+219.2687)
>     + OVMF
>       qemu_init_end: 44.055712
>       fw_start: 168.094131 (+124.038419)
>       fw_do_boot: 322.222745 (+154.128614)
>       linux_start_boot: 323.809639 (+1.586894)
>       linux_start_kernel: 401.756773 (+77.947134)
>       linux_start_user: 604.601438 (+202.844665)
> * NEMU "virt" machine
>     + qboot
>       qemu_init_end: 27.732925
>       fw_start: 27.887483 (+0.154558)
>       fw_do_boot: 29.20226 (+1.314777)
>       linux_start_boot: 30.842672 (+1.640412)
>       linux_start_kernel: 111.639445 (+80.796773)
>       linux_start_user: 862.294876 (+750.655431)
>     + seabios
>       qemu_init_end: 28.203907
>       fw_start: 28.68285 (+0.478943)
>       fw_do_boot: 36.337377 (+7.654527)
>       linux_start_boot: 37.995622 (+1.658245)
>       linux_start_kernel: 118.11591 (+80.120288)
>       linux_start_user: 897.110477 (+778.994567)
>     + OVMF
>       qemu_init_end: 31.219852
>       fw_start: 153.304126 (+122.084274)
>       fw_do_boot: 183.69459 (+30.390464)
>       linux_start_boot: 185.296567 (+1.601977)
>       linux_start_kernel: 361.11524 (+175.818673)
>       linux_start_user: 1231.590077 (+870.474837)
> * Qemu-lite
>     + no FW (-machine pc,...,fw=off KERNEL=/path/to/vmlinux)
>       qemu_init_end: 32.243801
>       linux_start_kernel: 32.330323 (+0.086522)
>       linux_start_user: 208.742712 (+176.412389)
>     + qboot
>       qemu_init_end: 25.393047
>       fw_start: 25.545285 (+0.152238)
>       fw_do_boot: 31.073253 (+5.527968)
>       linux_start_boot: 33.139721 (+2.066468)
>       linux_start_kernel: 114.604384 (+81.464663)
>       linux_start_user: 287.93128 (+173.326896)
>     + seabios
>       qemu_init_end: 25.448283
>       fw_start: 25.628977 (+0.180694)
>       fw_do_boot: 38.551957 (+12.92298)
>       linux_start_boot: 40.220319 (+1.668362)
>       linux_start_kernel: 126.392991 (+86.172672)
>       linux_start_user: 308.807806 (+182.414815)
>     + OVMF
>       qemu_init_end: 27.616988
>       fw_start: 151.272286 (+123.655298)
>       fw_do_boot: 309.068926 (+157.79664)
>       linux_start_boot: 310.602074 (+1.533148)
>       linux_start_kernel: 387.83349 (+77.231416)
>       linux_start_user: 576.057453 (+188.223963)
>
> Testbed:
> * seabios: https://github.com/rbradford/seabios/tree/virt-x86 + patch
> to disable debug writes
> (https://mail.coreboot.org/pipermail/seabios/2018-December/012654.html)
> * qboot: https://github.com/rbradford/qboot/tree/virt-x86
> * OVMF: https://github.com/intel/ovmf-virt/tree/virt-x86
> * QEMU command: $QEMU -bios $BIOS -machine
> $MACHINE,accel=kvm,kernel_irqchip,nvdimm -cpu host -m
> 512,maxmem=1G,slots=1 -smp 1 -kernel $KERNEL -append 'root=/dev/pmem0
> ro console=hvc0' -vga none -display none -no-user-config -nodefaults
> -object memory-backend-file,id=mem0,share,mem-path=$ROOTFS,size=$ROOTFS_SIZE
> -device nvdimm,memdev=mem0,id=nv0 -chardev stdio,id=virtiocon0 -device
> virtio-serial -device virtconsole,chardev=virtiocon0
>
> Cheers,
> Stefano
>

-- 
Stefano Garzarella
Red Hat
