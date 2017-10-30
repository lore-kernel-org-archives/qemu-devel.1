Received: from eggs.gnu.org ([2001:4830:134:3::10]:45787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9BZ8-0004h9-Sk
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9BZ3-0007Ce-7t
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:01:26 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:48018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9BZ3-0007CD-3t
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 11:01:21 -0400
Received: by mail-qk0-x241.google.com with SMTP id m189so16459855qke.4
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 08:01:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171030040056.11780-1-f4bug@amsat.org>
	<20171030082029.GY2993@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <676bb129-8e09-1e83-7340-66c770d04537@amsat.org>
Date: Mon, 30 Oct 2017 12:01:10 -0300
MIME-Version: 1.0
In-Reply-To: <20171030082029.GY2993@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] vl: only display available accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, qemu-devel@nongnu.org, "Emilio G . Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/30/2017 05:20 AM, Eduardo Habkost wrote:
> On Mon, Oct 30, 2017 at 01:00:56AM -0300, Philippe Mathieu-Daudé wrote:
>>     - I don't think this is the nicest way, too much #ifdef'fery in main()
> 
> I suggest using object_class_get_list(TYPE_ACCEL, false).

OK, this gives:

$ qemu-system-x86_64 -accel help
Possible accelerators:
  xen
  kvm
  qtest

I was not aware of the qtest accel :)

(gdb) r -accel qtest -nographic
Starting program: x86_64-softmmu/qemu-system-x86_64 -accel qtest -nographic
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7fffd7f4b700 (LWP 4085)]
[New Thread 0x7fffd774a700 (LWP 4086)]
Thread 1 "qemu-system-x86" received signal SIGTERM, Terminated.
0x00007fffde70f731 in __GI_ppoll (fds=0x555556bcc9e0, nfds=5,
timeout=<optimized out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
39	../sysdeps/unix/sysv/linux/ppoll.c: No such file or directory.
(gdb) i th
  Id   Target Id         Frame
* 1    Thread 0x7ffff7f9eec0 (LWP 4080) "qemu-system-x86"
0x00007fffde70f731 in __GI_ppoll (fds=0x555556bcc9e0, nfds=5,
    timeout=<optimized out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
  2    Thread 0x7fffd7f4b700 (LWP 4085) "qemu-system-x86" syscall () at
../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
  3    Thread 0x7fffd774a700 (LWP 4086) "qemu-system-x86" do_sigwait
(set=<optimized out>, set@entry=0x7fffd7747700,
    sig=sig@entry=0x7fffd77476fc) at ../sysdeps/unix/sysv/linux/sigwait.c:64
(gdb) bt
#0  0x00007fffde70f731 in __GI_ppoll (fds=0x555556bcc9e0, nfds=5,
timeout=<optimized out>, sigmask=0x0)
    at ../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000555555c3702c in qemu_poll_ns (fds=0x555556bcc9e0, nfds=5,
timeout=1000000000) at util/qemu-timer.c:334
#2  0x0000555555c37f66 in os_host_main_loop_wait (timeout=1000000000) at
util/main-loop.c:255
#3  0x0000555555c38026 in main_loop_wait (nonblocking=0) at
util/main-loop.c:515
#4  0x00005555558aa6fc in main_loop () at vl.c:1995
#5  0x00005555558b1fc3 in main (argc=4, argv=0x7fffffffe088,
envp=0x7fffffffe0b0) at vl.c:4948
