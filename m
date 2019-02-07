Received: from eggs.gnu.org ([209.51.188.92]:42642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grhFF-0002jo-T9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grhFD-0005Vg-KV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:49:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1grhFB-0005Ty-Jp
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:49:23 -0500
Date: Thu, 7 Feb 2019 11:49:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190207114913.2c5f2c5b.cohuck@redhat.com>
In-Reply-To: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Giovanni Mascellani <gio@debian.org>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

On Thu, 07 Feb 2019 09:46:07 -0000
Giovanni Mascellani <gio@debian.org> wrote:

> Public bug reported:
> 
> qemu-s390x in user mode crashes with SIGILL (under host architecture
> x86_64, running Debian unstable) when executing target instruction
> "stck" ("STORE CLOCK", see
> https://www-01.ibm.com/support/docview.wss?uid=isg26480faec85f44e2385256d5200627dee&aid=1),
> which is basically a kind of equivalent of Intel "rdtsc". The same
> instruction works fine under qemu-s390x in system mode. The bug is
> reproducible with both the qemu version distributed in Debian unstable
> and with the latest upstream master (commit
> 47994e16b1d66411953623e7c0bf0cdcd50bd507).

Did that work before commit 7de3b1cdc67 ("s390x/tcg: properly implement
the TOD")?

> 
> This bug manifested itself as a crash of ssh-keygen program, which uses
> "stck" to obtain some bits of randomness during key creation. Bisection
> of the code led to the attached minimal example. Compile with (inside an
> s390x system):
> 
>  $ gcc -c -o test.o test.c
>  $ gcc -c -o rdtsc.o rdtsc.S
>  $ gcc -o test test.o rdtsc.o
> 
> Then run test. It will crash with SIGILL in user mode and run fine in
> system mode. Also, compare with the original file at
> https://github.com/openssl/openssl/blob/master/crypto/s390xcpuid.pl#L139
> (there the instruction "stckf" is also used; it is probable that it has
> the same problem if it is supported altogether, but it did not test for
> this).

stckf will end up at the same helper, so it seems likely to hit the
same problem.

> 
> Running qemu-s390x with options -d
> in_asm,out_asm,op,op_opt,exec,nochain,cpu gives the trace attached in
> log.txt.

I think the problem is that the helper tries to access the todstate
object, which we won't have in user mode IIUC. David?
