Received: from eggs.gnu.org ([2001:4830:134:3::10]:39765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1wJv-00089T-Cb
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1wJm-0006sS-0F
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:19:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1wJl-0006qv-Pz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:19:37 -0400
References: <88c14424-9813-5e68-0aa7-38f3cde0a491@tuxfamily.org>
	<8ae225f4-b3b8-b09d-03ed-9e8b38a051a5@denx.de>
	<53ae3fc6-90ea-a154-752d-fe50b3d01642@tuxfamily.org>
	<ec8104bb-4a82-77af-aa16-127963d9c834@denx.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdfdf890-bfa0-eadf-c1f5-bf4e9e1c23e5@redhat.com>
Date: Tue, 10 Oct 2017 17:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <ec8104bb-4a82-77af-aa16-127963d9c834@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-nios2 hangs when emulator is quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>, Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 10/10/2017 10:58, Marek Vasut wrote:
>> #0  0x00007ffff7931945 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libpthread.so.0
>> #1  0x00005555557cf9c5 in qemu_cond_wait (cond=cond@entry=0x555555b5f9c0 <qemu_pause_cond>, mutex=mutex@entry=0x555555b5fa40 <qemu_global_mutex>) at util/qemu-thread-posix.c:161
>> #2  0x0000555555606ee8 in pause_all_vcpus () at cpus.c:1620
>> #3  0x00005555555cc43a in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
>>     at vl.c:4906
>>
>> Looks like the CPU does not get stopped right? Unfortunately, I've got no
>> good clue how to debug that further right now...
> I'd look at pause_all_vcpus() and check why it is stuck.
> I'm a bit overloaded at the moment, so I don't have time to dig in it.
> 

It's actually the CPU thread that is stuck because the
start-of-translation-block test is wrong and never succeeds:

0x7fd715fff0c0:  mov    -0x14(%rsp),%ebp
0x7fd715fff0c4:  test   %ebp,%ebp
0x7fd715fff0c6:  jl     0x7fd715fff0e4

It should be using %r14, not %rsp.  I've sent a patch.

Paolo
