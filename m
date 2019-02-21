Received: from eggs.gnu.org ([209.51.188.92]:44349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gwxYZ-0006C2-I7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 18:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gwxJ7-0006Y6-Ky
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:59:10 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gwxJ6-0006V8-WF
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:59:09 -0500
Date: Thu, 21 Feb 2019 17:59:06 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190221225906.GA31346@flamenco>
References: <20190219233421.388-1-richard.henderson@linaro.org>
	<20190221212130.GA6971@flamenco> <87va1c3h1y.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va1c3h1y.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Feb 21, 2019 at 22:36:25 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > This brings my arm-softmmu bootup+shutdown test to an early death:
> 
> Can you retry with --enable-tcg-debug?

Should have done so the first time. Here it is:

(gdb) r                                          
Starting program: /data/src/qemu/build/arm-softmmu/qemu-system-arm -machine type=virt -nographic -m 4096 -netdev user,id=unet,hostfwd=tcp::2222-:22 -d
evice virtio-net-device,netdev=unet -drive file=../img/arm/jessie-arm32-die-on-boot.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=m
yblock -kernel ../img/arm/aarch32-current-linux-kernel-only.img -append console=ttyAMA0\ root=/dev/vda1 -name arm,debug-threads=on -smp 1
[...]
VFS: Mounted root (ext4 filesystem) readonly on device 254:1.
devtmpfs: mounted
Freeing unused kernel memory: 300K (80669000 - 806b4000)
**
ERROR:/data/src/qemu/target/arm/helper.c:14049:cpu_get_tb_cpu_state: assertion failed (flags == check_flags): (0x10080000 == 0x10080080)

Thread 4 "CPU 0/TCG" received signal SIGABRT, Aborted.
[Switching to Thread 0x7fffee2aa700 (LWP 14033)]
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  0x00007ffff4585801 in __GI_abort () at abort.c:79
#2  0x00007ffff570f2a5 in g_assertion_message () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#3  0x00007ffff570f652 in g_assertion_message_cmpnum () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#4  0x00005555559a339b in cpu_get_tb_cpu_state (env=0x5555565af060, pc=pc@entry=0x7fffee2a98fc, cs_base=cs_base@entry=0x7fffee2a98f8,
    pflags=pflags@entry=0x7fffee2a9900) at /data/src/qemu/target/arm/helper.c:14049
#5  0x000055555588fbdb in tb_lookup__cpu_state (cf_mask=524288, flags=0x7fffee2a9900, cs_base=0x7fffee2a98f8, pc=0x7fffee2a98fc, cpu=0x0)
    at /data/src/qemu/include/exec/tb-lookup.h:28
#6  tb_find (cf_mask=524288, tb_exit=0, last_tb=0x0, cpu=0x0) at /data/src/qemu/accel/tcg/cpu-exec.c:404
#7  cpu_exec (cpu=cpu@entry=0x5555565a6db0) at /data/src/qemu/accel/tcg/cpu-exec.c:728
#8  0x000055555584e49f in tcg_cpu_exec (cpu=0x5555565a6db0) at /data/src/qemu/cpus.c:1429
#9  0x0000555555850623 in qemu_tcg_cpu_thread_fn (arg=arg@entry=0x5555565a6db0) at /data/src/qemu/cpus.c:1733
#10 0x0000555555c83416 in qemu_thread_start (args=<optimized out>) at /data/src/qemu/util/qemu-thread-posix.c:502
#11 0x00007ffff493d6db in start_thread (arg=0x7fffee2aa700) at pthread_create.c:463
#12 0x00007ffff466688f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
(gdb)

Thanks,
		Emilio
