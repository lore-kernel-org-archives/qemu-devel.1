Received: from eggs.gnu.org ([2001:4830:134:3::10]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fLBsC-0000Vg-UK
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fLBs9-0004sq-Oz
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:19:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fLBs9-0004sc-JZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:18:57 -0400
Date: Tue, 22 May 2018 20:18:53 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180522181853.qpblfr57xkj6osmg@kamzik.brq.redhat.com>
References: <152662586393.8948.4447581734098771947.malonedeb@chaenomeles.canonical.com>
	<152700845251.16304.10440634003527247551.malone@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152700845251.16304.10440634003527247551.malone@soybean.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1771948] Re: aarch64 msr CNTFRQ_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, May 22, 2018 at 05:00:52PM -0000, Peter Maydell wrote:
> Mmm, that's not really supposed to happen. Do you have a test guest
> binary you can attach that I can reproduce with?

You can hack kvm-unit-tests to make one pretty quickly.

$ git clone git://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
$ cd kvm-unit-tests
$ cat<<EOF >insns
ldr x0, =19200000
msr cntfrq_el0, x0
b .
EOF
$ sed -i '/start:/r insns' arm/cstart64.S 
$ ./configure --arch=arm64 --cross-prefix=aarch64-linux-gnu-
$ make LOADADDR=0
$ qemu-system-aarch64 -M raspi3 -serial mon:stdio -kernel arm/selftest.flat
VNC server running on ::1:5900
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) info registers 
PC=0000000000000200  SP=0000000000000000
X00=000000000124f800 X01=0000000000000000 X02=0000000000000000 X03=0000000000000000
X04=0000000000080000 X05=0000000000000000 X06=0000000000000000 X07=0000000000000000
X08=0000000000000000 X09=0000000000000000 X10=0000000000000000 X11=0000000000000000
X12=0000000000000000 X13=0000000000000000 X14=0000000000000000 X15=0000000000000000
X16=0000000000000000 X17=0000000000000000 X18=0000000000000000 X19=0000000000000000
X20=0000000000000000 X21=0000000000000000 X22=0000000000000000 X23=0000000000000000
X24=0000000000000000 X25=0000000000000000 X26=0000000000000000 X27=0000000000000000
X28=0000000000000000 X29=0000000000000000 X30=0000000000000000 
PSTATE=000003c9 ---- NS EL2h
q00=0000000000000000:0000000000000000 q01=0000000000000000:0000000000000000
q02=0000000000000000:0000000000000000 q03=0000000000000000:0000000000000000
q04=0000000000000000:0000000000000000 q05=0000000000000000:0000000000000000
q06=0000000000000000:0000000000000000 q07=0000000000000000:0000000000000000
q08=0000000000000000:0000000000000000 q09=0000000000000000:0000000000000000
q10=0000000000000000:0000000000000000 q11=0000000000000000:0000000000000000
q12=0000000000000000:0000000000000000 q13=0000000000000000:0000000000000000
q14=0000000000000000:0000000000000000 q15=0000000000000000:0000000000000000
q16=0000000000000000:0000000000000000 q17=0000000000000000:0000000000000000
q18=0000000000000000:0000000000000000 q19=0000000000000000:0000000000000000
q20=0000000000000000:0000000000000000 q21=0000000000000000:0000000000000000
q22=0000000000000000:0000000000000000 q23=0000000000000000:0000000000000000
q24=0000000000000000:0000000000000000 q25=0000000000000000:0000000000000000
q26=0000000000000000:0000000000000000 q27=0000000000000000:0000000000000000
q28=0000000000000000:0000000000000000 q29=0000000000000000:0000000000000000
q30=0000000000000000:0000000000000000 q31=0000000000000000:0000000000000000
FPCR: 00000000  FPSR: 00000000
(qemu) q

So the attempted sysreg write causes an exception, pointing to vector
0x200.

Thanks,
drew

> 
> -- 
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1771948
> 
> Title:
>   aarch64 msr CNTFRQ_EL0
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   Hello,
> 
>   I'm running qemu 2.12 on a raspberry pi 3 with the command:
> 
>   qemu-system-aarch64 -M raspi3 -serial stdio -kernel executable.bin
> 
>   On my start file (right in the beginning with the highest EL), the
>   following instructions:
> 
>   ldr x0 , =19200000
>   msr CNTFRQ_EL0, x0
> 
>   
>   and qemu halts on the "msr CNTFRQ_EL0, x0" instruction.
> 
>   I believe this is not a normal behavior.
> 
>   Thank you
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1771948/+subscriptions
> 
