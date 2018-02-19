Received: from eggs.gnu.org ([2001:4830:134:3::10]:42992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1enpyR-0005Xa-Bj
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1enpyM-0004rG-Ai
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:15:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1enpyM-0004qc-0G
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 13:15:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JIECal015725
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 13:15:28 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g80gr10qb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 13:15:24 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 18:15:22 -0000
Date: Mon, 19 Feb 2018 19:15:18 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
	<3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
	<acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180219191518.74bde3bc@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>

On Sat, 17 Feb 2018 10:07:38 +0100
Jan Kiszka <jan.kiszka@web.de> wrote:

[...]

> > Seems like no one is doing guest debugging with kvm on x86 except
> > me, and I'm only doing it too infrequently now: This one broke that
> > use case for SMP guests long ago. How was it tested?
> > 
> > To reproduce the bug: set up an x86-64 guest kernel with > 1 core,
> > break on some prominent syscall entry (e.g. sys_execve), continue
> > the guest on hit and it will quickly lock up, even after disabling
> > the breakpoint again. Kernel version doesn't matter (was my first
> > guess), gdb is 7.7.50.20140604-cvs (OpenSUSE) here.

[...]

> Sending packet: $Hg1#e0...Ack
> Packet received: OK
> Sending packet: $mffffc90000c0bf30,8#83...Ack
> Packet received: ae180081ffffffff
> Sending packet: $mffffc90000c0bf30,8#83...Ack
> Packet received: ae180081ffffffff
> Breakpoint 1, SyS_execve (filename=7029648, argv=7583376,
> envp=7598304) at ../fs/exec.c:1923 (gdb) c
> Continuing.
> Sending packet: $vCont;s:1#23...Ack
> 
> ...and now the guest is dead. I can still interrupt it, but it's
> otherwise not working properly.

I tried, but I could not reproduce this bug neither on s390x nor on
amd64. in both cases I used recent enough versions of qemu so that
they have the patch you mentioned, and qemu was started with several
cpus (I tried 64 on s390x, and 4 on amd64).

in particular on amd64:
host: 4.4.0-112-generic (ubuntu 16.04)
QEMU version 2.10.0  (vanilla from git)
gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1

I also used the gdb script you provided but everything worked both with
-smp 1 and with -smp 4

the only issue I had was that I had to disable kaslr in the guest to be
able to do anything, but that does not seem to be the problem you have.

my primary suspicion at this point would be an issue in KVM, and not
in qemu. have you tried running it without KVM? what is the version of
qemu and kernel in the host?


Claudio
