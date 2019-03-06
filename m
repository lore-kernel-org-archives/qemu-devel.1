Received: from eggs.gnu.org ([209.51.188.92]:55477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1cPd-0002oH-1b
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1cPZ-0003vF-Bt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:41:07 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1cPY-0003th-Id
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 14:41:05 -0500
Received: by mail-pg1-x544.google.com with SMTP id h8so9222579pgp.6
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 11:41:02 -0800 (PST)
References: <20190304181813.8075-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2adf8423-458d-27c3-67bf-d4775104ad43@linaro.org>
Date: Wed, 6 Mar 2019 11:40:57 -0800
MIME-Version: 1.0
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/73] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

On 3/4/19 10:17 AM, Emilio G. Cota wrote:
> v6: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07650.html
> 
> All patches in the series have reviews now. Thanks everyone!
> 
> I've tested all patches with `make check-qtest -j' for all targets.
> The series is checkpatch-clean (just some warnings about __COVERITY__).
> 
> You can fetch the series from:
>   https://github.com/cota/qemu/tree/cpu-lock-v7

Having fixed the OSX build errors, Peter reported to me a hang on the x86_64
bios-tables-test with an arm32 host.  I have been able to replicate this.


(gdb) info thr
  Id   Target Id                                       Frame
  1    Thread 0xb35a72e0 (LWP 10966) "qemu-system-x86" 0xb606d138 in
pthread_cond_wait@@GLIBC_2.4 () from /usr/lib/libpthread.so.0
  2    Thread 0xb35a3d30 (LWP 10967) "qemu-system-x86" 0xb5fe70fc in syscall ()
   from /usr/lib/libc.so.6
  3    Thread 0xa07fed30 (LWP 10968) "qemu-system-x86" 0xb5fe0688 in poll ()
   from /usr/lib/libc.so.6
* 4    Thread 0x9fdfed30 (LWP 10969) "qemu-system-x86" 0xb606d138 in
pthread_cond_wait@@GLIBC_2.4 () from /usr/lib/libpthread.so.0

(gdb) thr 1
[Switching to thread 1 (Thread 0xb35a72e0 (LWP 10966))]
#0  0xb606d138 in pthread_cond_wait@@GLIBC_2.4 () from /usr/lib/libpthread.so.0
(gdb) where
#0  0xb606d138 in pthread_cond_wait@@GLIBC_2.4 () from /usr/lib/libpthread.so.0
#1  0x009a66a4 in qemu_cond_wait_impl (cond=cond@entry=0x16727b0,
    mutex=0xcad4c8 <qemu_global_mutex>,
    file=file@entry=0xa057f0 "/home/rth/qemu/qemu/cpus-common.c",
    line=line@entry=166) at /home/rth/qemu/qemu/util/qemu-thread-posix.c:161
#2  0x00692378 in run_on_cpu (cpu=cpu@entry=0x16725a8, func=<optimized out>,
    data=...) at /home/rth/qemu/qemu/cpus-common.c:166
#3  0x00604c18 in vapic_enable_tpr_reporting (enable=<optimized out>)
    at /home/rth/qemu/qemu/hw/i386/kvmvapic.c:507
#4  0x00710160 in qdev_reset_one (dev=<optimized out>, opaque=<optimized out>)
    at /home/rth/qemu/qemu/hw/core/qdev.c:250

(gdb) thr 4
[Switching to thread 4 (Thread 0x9fdfed30 (LWP 10969))]
#0  0xb606d138 in pthread_cond_wait@@GLIBC_2.4 () from /usr/lib/libpthread.so.0
(gdb) where
#0  0xb606d138 in pthread_cond_wait@@GLIBC_2.4 () from /usr/lib/libpthread.so.0
#1  0x009a66a4 in qemu_cond_wait_impl (cond=0x1692ed8,
    mutex=0xcad4c8 <qemu_global_mutex>,
    file=file@entry=0x9d0108 "/home/rth/qemu/qemu/cpus.c",
    line=line@entry=1647) at /home/rth/qemu/qemu/util/qemu-thread-posix.c:161
#2  0x00553070 in qemu_tcg_rr_cpu_thread_fn (arg=<optimized out>)
    at /home/rth/qemu/qemu/cpus.c:1647
#3  0x009a5f20 in qemu_thread_start (args=<optimized out>)
    at /home/rth/qemu/qemu/util/qemu-thread-posix.c:502


I had hoped that I would have been able to reproduce this on another host by
forcing rr mode.  But so far no luck.

Thoughts?


r~
