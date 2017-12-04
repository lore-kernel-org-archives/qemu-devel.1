Received: from eggs.gnu.org ([2001:4830:134:3::10]:43676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eLqyD-0007GH-Sv
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 08:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eLqy9-0003zc-AB
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 08:39:41 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eLqy9-0003zL-1x
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 08:39:37 -0500
Received: by mail-wr0-x242.google.com with SMTP id z34so17326550wrz.10
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 05:39:36 -0800 (PST)
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<87fu8qsuwu.fsf@linaro.org>
	<1f60c7d8-a7c8-d8ac-21cd-64c5062f3859@physik.fu-berlin.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1f60c7d8-a7c8-d8ac-21cd-64c5062f3859@physik.fu-berlin.de>
Date: Mon, 04 Dec 2017 13:39:34 +0000
Message-ID: <87efoasjc9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1735384 <1735384@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> On 12/04/2017 10:29 AM, Alex Benn=C3=A9e wrote:
>> It's hard to imagine a scenario where taking the tb_lock() for resolving
>> something that will fail is going to be an improvement. However maybe
>> there is a subtle difference with sh4's javavm implementation.
>
> So, OpenJDK doesn't have a SH-specific implementation of the JVM, it just
> uses the Zero variant, which is a pure C++ implementation of the JVM.
>
> The same implementation is used on any other architecture like older ARM
> (< ARMv7). I just tested it on ARMv4T and it doesn't crash there on
> qemu-user.
>
> However, SH4 is special due to its implementation of atomics in user
> space called gUSA for which support to qemu-user has been recently
> added by Richard Hendersson. Maybe the problem lies there.
>
>> A backtrace QEMU after the segv would be useful here.
>
> I forgot what the proper procedure is for running qemu-user inside
> GDB. Could you help me with that?

Either call directly:

  gdb --args qemu-foo <userspace args>

Or alternatively:

  qemu-foo -g 1234 <userspace args>

And then:

  gdb qemu-foo -p <pid of qemu-foo>

And finally attaching to the gdbstub:

  gdb-multiarch -ex "target remote localhost:1234"
  c

Or just make sure your environment is generating core dumps you can
backtrace at leisure:

  gdb qemu-foo core
  bt


>
> The strace looks like this in any case:
>
> 28856 access("/etc/ld.so.nohwcap",F_OK) =3D -1 errno=3D2 (No such file or=
 directory)
> 28856 open("/lib/sh4-linux-gnu/libgcc_s.so.1",O_RDONLY|O_CLOEXEC) =3D 3
> 28856 read(3,0x7fffacd4,512) =3D 512
> 28856 fstat64(3,0x7fffabe8) =3D 0
> 28856 mmap(NULL,189084,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE,3,0)=
 =3D 0x7ee27000
> 28856 mprotect(0x7ee45000,61440,PROT_NONE) =3D 0
> 28856 mmap(0x7ee54000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE=
|MAP_FIXED,3,0x1d000) =3D 0x7ee54000
> 28856 close(3) =3D 0
> 28856 mprotect(0x7ee54000,4096,PROT_READ) =3D 0
> 28856 mprotect(0x7eee8000,4096,PROT_READ) =3D 0
> 28856 mprotect(0x7f05c000,20480,PROT_READ) =3D 0
> 28856 mprotect(0x7f5c8000,53248,PROT_READ) =3D 0
> 28856 getpid() =3D 28856
> 28856 munmap(0x7f065000,50134) =3D 0
> 28856 getpid() =3D 28856
> 28856 mmap(NULL,1572864,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x=
20000,-1,0) =3D 0x7eca7000
> 28856 mprotect(0x7eca7000,4096,PROT_NONE) =3D 0
> 28856 clone(CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLON=
E_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,child_stack=
=3D0x7ee26048,parent_tidptr=3D0x7ee26528,tls=3D0x7ee26930,child_tidptr=3D0x=
7ee26528) =3D 28860
> 28856 futex(0x7ee26528,FUTEX_WAIT,28860,NULL,0x7f77c6e8,2138556136)28856 =
set_robust_list(2128766256,12,-1,2128766652,-1,2128764832) =3D -1 errno=3D3=
8 (Function not implemented)
> --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3D1, si_addr=3D0x289da000} ---
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
> (sid-sh4-sbuild)root@nofan:/local_scratch/sid-sh4-sbuild#
>
> Adrian
>
> --
>   .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>    `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


--
Alex Benn=C3=A9e
