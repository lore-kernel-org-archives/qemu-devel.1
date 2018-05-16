Received: from eggs.gnu.org ([2001:4830:134:3::10]:59934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fIt28-0006WH-UD
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fIt27-0000wX-BZ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 05:47:44 -0400
Date: Wed, 16 May 2018 10:47:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180516094731.GA2741@work-vm>
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Problem with data miscompare using scsi-hd,
 cache=none and io=threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

* Daniel Henrique Barboza (danielhb@linux.ibm.com) wrote:
> Hi,
>=20
> I've been working in the last two months in a miscompare issue that hap=
pens
> when using a raid device and a SATA as scsi-hd (emulated SCSI) with
> cache=3Dnone and io=3Dthreads during a hardware stress test. I'll summa=
rize it
> here as best as I can without creating a great wall of text - Red Hat f=
olks
> can check [1] for all the details.
>=20
> Using the following setup:
>=20
> - Host is a POWER9 RHEL 7.5-alt: kernel 4.14.0-49.1.1.el7a.ppc64le,
> qemu-kvm-ma 2.10.0-20.el7 (also reproducible with upstream QEMU)
>=20
> - Guest is RHEL 7.5-alt using the same kernel as the host, using two st=
orage
> disks (a 1.8 Tb raid and a 446Gb SATA drive) as follows:
>=20
> =A0=A0=A0 <disk type=3D'block' device=3D'disk'>
> =A0=A0=A0=A0=A0 <driver name=3D'qemu' type=3D'raw' cache=3D'none'/>
> =A0=A0=A0=A0=A0 <source dev=3D'/dev/disk/by-id/scsi-3600605b000a2c110ff=
0004053d84a61b'/>
> =A0=A0=A0=A0=A0 <target dev=3D'sdc' bus=3D'scsi'/>
> =A0=A0=A0=A0=A0 <alias name=3D'scsi0-0-0-2'/>
> =A0=A0=A0=A0=A0 <address type=3D'drive' controller=3D'0' bus=3D'0' targ=
et=3D'0' unit=3D'2'/>
> =A0=A0=A0 </disk>
>=20
> Both block devices have WCE off in the host.
>=20
> With this env, we found problems when running a stress test called HTX =
[2].
> At a given time (usually after 24+ hours of test) HTX finds a data
> miscompare in one of the devices. This is an example:
>=20
> -------
>=20
> Device name: /dev/sdb
> Total blocks: 0x74706daf, Block size: 0x200
> Rule file name: /usr/lpp/htx/rules/reg/hxestorage/default.hdd
> Number of Rulefile passes (cycle) completed: 0
> Stanza running: rule_6, Thread no.: 8
> Oper performed: wrc, Current seek type: SEQ
> LBA no. where IO started: 0x94fa
> Transfer size: 0x8400
>=20
> Miscompare Summary:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> LBA no. where miscomapre started:=A0=A0=A0=A0 0x94fa
> LBA no. where miscomapre ended:=A0=A0=A0=A0=A0=A0 0x94ff
> Miscompare start offset (in bytes):=A0=A0 0x8
> Miscomapre end offset (in bytes):=A0=A0=A0=A0 0xbff
> Miscompare size (in bytes):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0xbf8
>=20
> Expected data (at miscomapre offset): 8c9aea5a736462000000000000007275
> Actual data (at miscomapre offset): 889aea5a736462000000000000007275

Are all the miscompares single bit errors like that one?
Is the test doing single bit manipulation or is that coming out of the
blue?

Dave

> -----
>=20
>=20
> This means that the test executed a write at=A0 LBA 0x94fa and, after
> confirming that the write was completed, issue 2 reads in the same LBA =
to
> assert the written contents and found out a mismatch.
>=20
>=20
> I've tested all sort of configurations between disk vs LUN, cache modes=
 and
> AIO. My findings are:
>=20
> - using device=3D'lun' instead of device=3D'disk', I can't reproduce th=
e issue
> doesn't matter what other configurations are;
> - using device=3D'disk' but with cache=3D'writethrough', issue doesn't =
happen
> (haven't checked other cache modes);
> - using device=3D'disk', cache=3D'none' and io=3D'native', issue doesn'=
t happen.
>=20
>=20
> The issue seems to be tied with the combination device=3Ddisk + cache=3D=
none +
> io=3Dthreads. I've started digging into the SCSI layer all the way down=
 to the
> block backend. With a shameful amount of logs I've discovered that, in =
the
> write that the test finds a miscompare, in block/file-posix.c:
>=20
> - when doing the write, handle_aiocb_rw_vector() returns success, pwrit=
ev()
> reports that all bytes were written
> - in both reads after the write, handle_aiocb_rw_vector returns success=
, all
> bytes read by preadv(). In both reads, the data read is different from =
the
> data written by=A0 the pwritev() that happened before
>=20
> In the discussions at [1], Fam Zheng suggested a test in which we would=
 take
> down the number of threads created in the POSIX thread pool from 64 to =
1.
> The idea is to ensure that we're using the same thread to write and rea=
d.
> There was a suspicion that the kernel can't guarantee data coherency be=
tween
> different threads, even if using the same fd, when using pwritev() and
> preadv(). This would explain why the following reads in the same fd wou=
ld
> fail to retrieve the same data that was written before. After doing thi=
s
> modification, the miscompare didn't reproduce.
>=20
> After reverting the thread pool number change, I've made a couple of
> attempts trying to flush before read() and flushing after write(). Both
> attempts failed - the miscompare appears in both scenarios. This enforc=
es
> the suspicion we have above - if data coherency can't be granted betwee=
n
> different threads, flushing in different threads wouldn't make a differ=
ence
> too. I've also tested a suggestion from Fam where I started the disks w=
ith
> "cache.direct=3Don,cache.no-flush=3Doff" - bug still reproduces.
>=20
>=20
> This is the current status of this investigation. I decided to start a
> discussion here, see if someone can point me something that I overlooke=
d or
> got it wrong, before I started changing the POSIX thread pool behavior =
to
> see if I can enforce one specific POSIX thread to do a read() if we had=
 a
> write() done in the same fd. Any suggestions?
>=20
>=20
>=20
> ps: it is worth mentioning that I was able to reproduce this same bug i=
n a
> POWER8 system running Ubuntu 18.04. Given that the code we're dealing w=
ith
> doesn't have any arch-specific behavior I wouldn't be surprised if this=
 bug
> is also reproducible in other archs like x86.
>=20
>=20
> Thanks,
>=20
> Daniel
>=20
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1561017
> [2] https://github.com/open-power/HTX
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
