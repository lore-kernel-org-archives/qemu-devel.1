Received: from eggs.gnu.org ([2001:4830:134:3::10]:33276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dNMp0-0006Ni-4b
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dNMow-0003tc-Vl
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:20:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dNMow-0003rf-Il
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:20:06 -0400
Date: Tue, 20 Jun 2017 13:20:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170620172002.GA23332@flamenco>
References: <CADR1n+V8R1LOGzbwdBDt5axeZ0mqh=WSCsfUo0Vr2nmE6BYqTQ@mail.gmail.com>
	<8760fqorbp.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8760fqorbp.fsf@frigg.lan>
Subject: Re: [Qemu-devel] Tracing guest virtual addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: Jayanto Minocha <jayanto@gmail.com>, qemu-devel@nongnu.org

On Tue, Jun 20, 2017 at 14:02:02 +0300, Lluís Vilanova wrote:
> Jayanto Minocha writes:
> 
> > Hi,
> > I think there have been a few threads on the mailing list regarding tracing
> > guest virtual addresses for load and store instructions, but I have been
> > unable to get it to work. I am trying this for an AArch64 machine, and am
> > using the softmmu.
> 
> > The tracing infrastructure provides the following event:
> 
> > vcpu tcg guest_mem_before(...).
> 
> > But that is only used to instrument the cpu_ld/cpu_st macros, which is only
> > called in the case of a tlb miss.
> 
> > I've been going over the archives, and it looks like I need to instrument
> > tcg_out_tlb_load. Am I on the right path ?
> 
> That event should trace all guest memory accesses performed by the CPU. If you
> found any case where this does not hold, it is likely a bug and I'd appreciate
> it if you can point me to the smallest possible failing example.

I'm having trouble with this as well, although I'm pretty sure I must be doing
something wrong (never used the tracing infrastructure before). Here's what
I'm doing:

$ git show --pretty=short
commit e85c0d14014514a2f0faeae5b4c23fab5b234de4
Merge: 65a0e3e 7f3cf2d
Author: Peter Maydell <peter.maydell@linaro.org>

    Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging


$ git diff
diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 2de8359..385a462 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -2,7 +2,7 @@

 # TCG related tracing (mostly disabled by default)
 # cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"

diff --git a/trace-events b/trace-events
index bae63fd..7df49a3 100644
--- a/trace-events
+++ b/trace-events
@@ -106,7 +106,7 @@ vcpu guest_cpu_reset(void)
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-disable vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"

 # @num: System call number.
 # @arg*: System call argument value.

$ mkdir build
$ cd build
$ ../configure --target-list=arm-softmmu,x86_64-linux-user --enable-trace-backends=simple && make -j 12
[...]

$ cat ../ev
guest_mem_before_exec
guest_mem_before_trans
exec_tb

$ x86_64-linux-user/qemu-x86_64 -trace events=../ev /bin/date
Tue Jun 20 13:11:49 EDT 2017

$ ls -lt | head | grep trace
-rw-rw-r--  1 cota cota   169721 Jun 20 13:11 trace-2150

$ scripts/simpletrace.py trace-events-all trace-2150
exec_tb 0.000 pid=2150 tb=0x7f5896667010 pc=0x4000801cc0
exec_tb 21.648 pid=2150 tb=0x7f5896667088 pc=0x4000805c00
[...]

100% of the file is exec_tb lines, i.e. no memory references whatsoever.

Similar results with arm-softmmu.

Thanks,

		Emilio
