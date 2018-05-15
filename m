Received: from eggs.gnu.org ([2001:4830:134:3::10]:60289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIhSL-0007Wo-UD
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fIhSH-0007FK-RI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:26:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fIhSH-0007F2-Ln
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:25:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FLOKAA089770
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 17:25:56 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j04wa6pd5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 17:25:56 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Tue, 15 May 2018 17:25:53 -0400
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Tue, 15 May 2018 18:25:46 -0300
MIME-Version: 1.0
Content-Language: en-US
Message-Id: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Problem with data miscompare using scsi-hd,
 cache=none and io=threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hi,

I've been working in the last two months in a miscompare issue that=20
happens when using a raid device and a SATA as scsi-hd (emulated SCSI)=20
with cache=3Dnone and io=3Dthreads during a hardware stress test. I'll=20
summarize it here as best as I can without creating a great wall of text=20
- Red Hat folks can check [1] for all the details.

Using the following setup:

- Host is a POWER9 RHEL 7.5-alt: kernel 4.14.0-49.1.1.el7a.ppc64le,=20
qemu-kvm-ma 2.10.0-20.el7 (also reproducible with upstream QEMU)

- Guest is RHEL 7.5-alt using the same kernel as the host, using two=20
storage disks (a 1.8 Tb raid and a 446Gb SATA drive) as follows:

 =C2=A0=C2=A0=C2=A0 <disk type=3D'block' device=3D'disk'>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver name=3D'qemu' type=3D'raw' cache=3D=
'none'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <source=20
dev=3D'/dev/disk/by-id/scsi-3600605b000a2c110ff0004053d84a61b'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <target dev=3D'sdc' bus=3D'scsi'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi0-0-0-2'/>
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'drive' controller=3D'0' =
bus=3D'0' target=3D'0' unit=3D'2'/>
 =C2=A0=C2=A0=C2=A0 </disk>

Both block devices have WCE off in the host.

With this env, we found problems when running a stress test called HTX=20
[2]. At a given time (usually after 24+ hours of test) HTX finds a data=20
miscompare in one of the devices. This is an example:

-------

Device name: /dev/sdb
Total blocks: 0x74706daf, Block size: 0x200
Rule file name: /usr/lpp/htx/rules/reg/hxestorage/default.hdd
Number of Rulefile passes (cycle) completed: 0
Stanza running: rule_6, Thread no.: 8
Oper performed: wrc, Current seek type: SEQ
LBA no. where IO started: 0x94fa
Transfer size: 0x8400

Miscompare Summary:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
LBA no. where miscomapre started:=C2=A0=C2=A0=C2=A0=C2=A0 0x94fa
LBA no. where miscomapre ended:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x94f=
f
Miscompare start offset (in bytes):=C2=A0=C2=A0 0x8
Miscomapre end offset (in bytes):=C2=A0=C2=A0=C2=A0=C2=A0 0xbff
Miscompare size (in bytes):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0xbf8

Expected data (at miscomapre offset): 8c9aea5a736462000000000000007275
Actual data (at miscomapre offset): 889aea5a736462000000000000007275

-----


This means that the test executed a write at=C2=A0 LBA 0x94fa and, after=20
confirming that the write was completed, issue 2 reads in the same LBA=20
to assert the written contents and found out a mismatch.


I've tested all sort of configurations between disk vs LUN, cache modes=20
and AIO. My findings are:

- using device=3D'lun' instead of device=3D'disk', I can't reproduce the=20
issue doesn't matter what other configurations are;
- using device=3D'disk' but with cache=3D'writethrough', issue doesn't=20
happen (haven't checked other cache modes);
- using device=3D'disk', cache=3D'none' and io=3D'native', issue doesn't =
happen.


The issue seems to be tied with the combination device=3Ddisk + cache=3Dn=
one=20
+ io=3Dthreads. I've started digging into the SCSI layer all the way down=
=20
to the block backend. With a shameful amount of logs I've discovered=20
that, in the write that the test finds a miscompare, in block/file-posix.=
c:

- when doing the write, handle_aiocb_rw_vector() returns success,=20
pwritev() reports that all bytes were written
- in both reads after the write, handle_aiocb_rw_vector returns success,=20
all bytes read by preadv(). In both reads, the data read is different=20
from the data written by=C2=A0 the pwritev() that happened before

In the discussions at [1], Fam Zheng suggested a test in which we would=20
take down the number of threads created in the POSIX thread pool from 64=20
to 1. The idea is to ensure that we're using the same thread to write=20
and read. There was a suspicion that the kernel can't guarantee data=20
coherency between different threads, even if using the same fd, when=20
using pwritev() and preadv(). This would explain why the following reads=20
in the same fd would fail to retrieve the same data that was written=20
before. After doing this modification, the miscompare didn't reproduce.

After reverting the thread pool number change, I've made a couple of=20
attempts trying to flush before read() and flushing after write(). Both=20
attempts failed - the miscompare appears in both scenarios. This=20
enforces the suspicion we have above - if data coherency can't be=20
granted between different threads, flushing in different threads=20
wouldn't make a difference too. I've also tested a suggestion from Fam=20
where I started the disks with "cache.direct=3Don,cache.no-flush=3Doff" -=
=20
bug still reproduces.


This is the current status of this investigation. I decided to start a=20
discussion here, see if someone can point me something that I overlooked=20
or got it wrong, before I started changing the POSIX thread pool=20
behavior to see if I can enforce one specific POSIX thread to do a=20
read() if we had a write() done in the same fd. Any suggestions?



ps: it is worth mentioning that I was able to reproduce this same bug in=20
a POWER8 system running Ubuntu 18.04. Given that the code we're dealing=20
with doesn't have any arch-specific behavior I wouldn't be surprised if=20
this bug is also reproducible in other archs like x86.


Thanks,

Daniel

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1561017
[2] https://github.com/open-power/HTX
