Received: from eggs.gnu.org ([2001:4830:134:3::10]:50139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e1phm-0004uY-Jo
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e1phh-0002bB-L2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:15:58 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1e1phh-0002at-EF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 04:15:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so2743263wmd.5
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 01:15:53 -0700 (PDT)
References: <88c14424-9813-5e68-0aa7-38f3cde0a491@tuxfamily.org>
	<8ae225f4-b3b8-b09d-03ed-9e8b38a051a5@denx.de>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <53ae3fc6-90ea-a154-752d-fe50b3d01642@tuxfamily.org>
Date: Tue, 10 Oct 2017 10:15:49 +0200
MIME-Version: 1.0
In-Reply-To: <8ae225f4-b3b8-b09d-03ed-9e8b38a051a5@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] qemu-system-nios2 hangs when emulator is quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 10.10.2017 09:57, Marek Vasut wrote:
> On 10/10/2017 09:20 AM, Thomas Huth wrote:
>>  Hi Chris, hi Marek,
> 
> Hi,
> 
>> I recently noticed that when I start qemu-system-nios2 (build from the
>> very latest git master branch) and then type "quit" at the monitor (or
>> simply try to close the GTK window), QEMU does not shut down right and
>> hangs somewhere in pause_all_vcpus() forever.
>> Do you have any idea what might be wrong here?
> 
> Nope, can you debug it and ev. send patch ?

Backtrace looks like this:

#0  0x00007ffff7931945 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libpthread.so.0
#1  0x00005555557cf9c5 in qemu_cond_wait (cond=cond@entry=0x555555b5f9c0 <qemu_pause_cond>, mutex=mutex@entry=0x555555b5fa40 <qemu_global_mutex>) at util/qemu-thread-posix.c:161
#2  0x0000555555606ee8 in pause_all_vcpus () at cpus.c:1620
#3  0x00005555555cc43a in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at vl.c:4906

Looks like the CPU does not get stopped right? Unfortunately, I've got no
good clue how to debug that further right now...

> We're talking about git HEAD, right ?

Yes.

 Thomas
