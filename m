Received: from eggs.gnu.org ([2001:4830:134:3::10]:45089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1er6HP-0005cH-DD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1er6HL-00070D-DJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:16:39 -0500
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:40717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1er6HL-0006zR-7r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:16:35 -0500
Received: by mail-io0-x22f.google.com with SMTP id v6so4207884iog.7
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 10:16:34 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <021727AC-B64E-4D78-AD02-883408BB49AC@gmail.com>
Date: Wed, 28 Feb 2018 13:16:31 -0500
Subject: [Qemu-devel] tcg/i386: Add vector operations patch does not compile
 on Mac OS 10.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04321.html

This patch causes problems with Mac OS 10.6. It stops compilation. This =
is the error I see when I try to compile the code:

tcg/i386/tcg-target.inc.c:3495:no such instruction: `xgetbv`

This is the code that causes the problem:

asm ("xgetbv" : "=3Da" (xcrl), "=3Dd" (xcrh) : "c" (0));

This issue is documented here: =
https://bugs.launchpad.net/qemu/+bug/1751494

It looks like GNU's as command does not output Mac OS X's Mach-O object =
file format so updating this command is not going to work. I think one =
way to fix this issue is to add a test to the configure command that =
sees if a simple xgetbv test program can compile on the current system. =
If it can then use the xgetbv instruction. If it can't then use a =
generic function or what you feel is best.

I think the test program would look like this:

int main(int argc, char *argv[])
{
    asm volatile("xgetbv");
}

This may not be a valid use of the instruction but it is enough to tell =
us if this instruction can be used. On Mac OS 10.12 the program does =
compile. On Mac OS 10.6 the program failed to compile because the =
instruction is not recognized.

What do you think is the solution to this problem?
