Received: from eggs.gnu.org ([2001:4830:134:3::10]:34852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5Wr9-0006zL-Tm
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5Wr5-00075p-Vl
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:29:11 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5Wr5-00075E-Ot
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:29:07 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c24so9583624wrc.6
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 06:29:07 -0700 (PDT)
References: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
	<87efjov999.fsf@linaro.org>
	<CAHP4M8W-WuBmJUdb6LGR1t3tPayrnaS+b1ZZ1zew71aM==-imA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAHP4M8W-WuBmJUdb6LGR1t3tPayrnaS+b1ZZ1zew71aM==-imA@mail.gmail.com>
Date: Mon, 09 Apr 2018 14:29:05 +0100
Message-ID: <87d0z8v78e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Crash when running hello-world unikernel for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, rumpkernel-users@freelists.org


Ajay Garg <ajaygargnsit@gmail.com> writes:

>>
>> qemu-system-x86_64 is expecting an x86 binary blob. I assume you need
>> qemu-system-arm. More importantly you need to specify a -M machine type
>> that matches whatever rumprun is expecting.
>>
>
> Oops, sorry my bad.
> Here is the updated status :
>
> ajay@latitude-3480:~/rumprun-arm-hw/rumprun$ qemu-system-arm -machine
> virt -nographic -nographic -kernel helloer.bin
> Bad ram pointer 0x1e8
> Aborted (core dumped)

Can you run under -s -S and gdb step the *guest* and see where it ends
up. The above error is usually indicative of the guest going off into
the weeds somewhere because the hardware isn't what it expects.

>
>
> ajay@latitude-3480:~/rumprun-arm-hw/rumprun$ gdb --args
> qemu-system-arm -machine virt -nographic -nographic -kernel
> helloer.bin
> GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "x86_64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
> <http://www.gnu.org/software/gdb/documentation/>.
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from qemu-system-arm...(no debugging symbols found)...don=
e.
> (gdb) r
> Starting program: /usr/bin/qemu-system-arm -machine virt -nographic
> -nographic -kernel helloer.bin
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> [New Thread 0x7fffecc88700 (LWP 14033)]
> [New Thread 0x7fffd21fc700 (LWP 14034)]
> Bad ram pointer 0x1e8
>
> Thread 3 "qemu-system-arm" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7fffd21fc700 (LWP 14034)]
> 0x00007ffff2a1b428 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> 54    ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) bt
> #0  0x00007ffff2a1b428 in __GI_raise (sig=3Dsig@entry=3D6) at
> ../sysdeps/unix/sysv/linux/raise.c:54
> #1  0x00007ffff2a1d02a in __GI_abort () at abort.c:89
> #2  0x00005555557687f1 in get_page_addr_code ()
> #3  0x000055555572d50c in ?? ()
> #4  0x000055555572e11b in cpu_arm_exec ()
> #5  0x0000555555750252 in ?? ()
> #6  0x00007ffff2db76ba in start_thread (arg=3D0x7fffd21fc700) at
> pthread_create.c:333
> #7  0x00007ffff2aed41d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
> (gdb)
>
>
> Thanks and Regards,
> Ajay


--
Alex Benn=C3=A9e
