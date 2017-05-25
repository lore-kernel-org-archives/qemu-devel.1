Received: from eggs.gnu.org ([2001:4830:134:3::10]:41827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dDv90-00004r-FS
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dDv8x-0006Ne-EA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:57:46 -0400
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:34027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dDv8x-0006MS-8j
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:57:43 -0400
Received: by mail-io0-x229.google.com with SMTP id k91so139263992ioi.1
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 08:57:42 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 May 2017 11:57:36 -0400
Message-Id: <105DDEA9-0ABE-4D00-A493-A1666783337B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Qemu-devel] Bug report: qmp_stop() freezes QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

=46rom the cocoa interface when I select pause QEMU doesn't pause. =
Instead QEMU freezes. I have traced the problem to the qmp_stop() =
function. Here is the stack trace:

+                                                                        =
                           2433 -[QemuCocoaAppController pauseQEMU:]  =
(in qemu-system-ppc) + 30  [0x1003c9a34]  cocoa.m:1049
    +                                                                    =
                                 2433 qmp_stop  (in qemu-system-ppc) + =
105  [0x100203b0d]  qmp.c:102
    +                                                                    =
                                   2433 vm_stop  (in qemu-system-ppc) + =
57  [0x100059326]  cpus.c:1798
    +                                                                    =
                                     2433 do_vm_stop  (in =
qemu-system-ppc) + 37  [0x100057bf3]  cpus.c:930
    +                                                                    =
                                       2433 pause_all_vcpus  (in =
qemu-system-ppc) + 119  [0x100058c36]  cpus.c:1611
    +                                                                    =
                                         2433 qemu_cond_wait  (in =
qemu-system-ppc) + 47  [0x1004f1855]
    +                                                                    =
                                           2433 _pthread_cond_wait  (in =
libSystem.B.dylib) + 1286  [0x7fff82521881]
    +                                                                    =
                                             2433 __semwait_signal  (in =
libSystem.B.dylib) + 10  [0x7fff8251da6a]

I did use git bisect to find the problem but there were several patches =
that seem to prevent OpenBIOS from running so finding the exact cause of =
the problem is difficult. The closest problem patch that may be related =
to this issue is this one:

commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5
Author: Alex Benn=E9e <alex.bennee@linaro.org>
Date:   Wed Mar 15 14:48:25 2017 +0000

    ui/console: ensure graphic updates don't race with TCG vCPUs
