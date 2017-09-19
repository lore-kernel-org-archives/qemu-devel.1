Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1duRiM-0007rj-M9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1duRiH-00067w-Cd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:14:02 -0400
Received: from bitwagon.com ([74.82.39.175]:38125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jreiser@bitwagon.com>)
	id 1duRiH-00066X-3c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 19:13:57 -0400
Received: from f25e64.local ([24.21.156.164]) by bitwagon.com
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:13:50 -0700
From: John Reiser <jreiser@bitwagon.com>
Message-ID: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
Date: Tue, 19 Sep 2017 16:13:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qmeu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Moving here from  https://bugzilla.redhat.com/show_bug.cgi?id=1493304 ]

qemu-arm from qemu-user-2.10.0-1.fc27.x86_64 (thus emulating 32-bit ARM on x86_64)
generates SIGSEGV when code modifies a never-previously executed instruction
that is on a writable page and is 848 bytes ahead of pc.
A real armv7l processor allows this and executes as desired.
Why the difference?  How can it be changed?  Where is the documentation?

=====  the real processor (RaspberryPi 3B in 32-bit mode running Fedora 27)
model name	: ARMv7 Processor rev 4 (v7l)
BogoMIPS	: 38.40
Features	: half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm crc32
CPU implementer	: 0x41
CPU architecture: 7
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4
=====

The memory region in question is allocated via
   mmap2(0xf7000000,228092,PROT_EXEC|PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0) = 0xf7000000
[and not changed via mprotect()] and written once to contain:
=====
0xf703704c:
         ldr r2,mflg_here  // pc+856
         orr r2,r2,r3  @ modify the instruction
=>      str r2,mflg_here  // pc+848    the faulting instruction

      [[snip about 848 bytes containing instructions only]]

0xf70373ac:
   mflg_here:  // The next instruction is re-written once.
         orr r3,r3,#0  @ flags |= MAP_{PRIVATE|ANON}  [QNX vs Linux]
=====

-- 
