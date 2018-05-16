Received: from eggs.gnu.org ([2001:4830:134:3::10]:33058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJ4AB-00057Z-Ev
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJ4A8-0004CI-Bj
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:40:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fJ4A8-0004Ba-3Z
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:40:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GLdBMT066259
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 17:40:42 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0ux4j3xb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 17:40:42 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Wed, 16 May 2018 15:40:41 -0600
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
	<20180516094731.GA2741@work-vm>
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Date: Wed, 16 May 2018 18:40:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180516094731.GA2741@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7caa6dca-8b80-551b-80b5-81874d862191@linux.ibm.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org



On 05/16/2018 06:47 AM, Dr. David Alan Gilbert wrote:
> * Daniel Henrique Barboza (danielhb@linux.ibm.com) wrote:
>> Hi,
>>
>> I've been working in the last two months in a miscompare issue that ha=
ppens
>> when using a raid device and a SATA as scsi-hd (emulated SCSI) with
>> cache=3Dnone and io=3Dthreads during a hardware stress test. I'll summ=
arize it
>> here as best as I can without creating a great wall of text - Red Hat =
folks
>> can check [1] for all the details.
>>
>> Using the following setup:
>>
>> - Host is a POWER9 RHEL 7.5-alt: kernel 4.14.0-49.1.1.el7a.ppc64le,
>> qemu-kvm-ma 2.10.0-20.el7 (also reproducible with upstream QEMU)
>>
>> - Guest is RHEL 7.5-alt using the same kernel as the host, using two s=
torage
>> disks (a 1.8 Tb raid and a 446Gb SATA drive) as follows:
>>
>>  =C2=A0=C2=A0=C2=A0 <disk type=3D'block' device=3D'disk'>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <driver name=3D'qemu' type=3D'raw' cac=
he=3D'none'/>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <source dev=3D'/dev/disk/by-id/scsi-36=
00605b000a2c110ff0004053d84a61b'/>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <target dev=3D'sdc' bus=3D'scsi'/>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <alias name=3D'scsi0-0-0-2'/>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <address type=3D'drive' controller=3D'=
0' bus=3D'0' target=3D'0' unit=3D'2'/>
>>  =C2=A0=C2=A0=C2=A0 </disk>
>>
>> Both block devices have WCE off in the host.
>>
>> With this env, we found problems when running a stress test called HTX=
 [2].
>> At a given time (usually after 24+ hours of test) HTX finds a data
>> miscompare in one of the devices. This is an example:
>>
>> -------
>>
>> Device name: /dev/sdb
>> Total blocks: 0x74706daf, Block size: 0x200
>> Rule file name: /usr/lpp/htx/rules/reg/hxestorage/default.hdd
>> Number of Rulefile passes (cycle) completed: 0
>> Stanza running: rule_6, Thread no.: 8
>> Oper performed: wrc, Current seek type: SEQ
>> LBA no. where IO started: 0x94fa
>> Transfer size: 0x8400
>>
>> Miscompare Summary:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> LBA no. where miscomapre started:=C2=A0=C2=A0=C2=A0=C2=A0 0x94fa
>> LBA no. where miscomapre ended:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
94ff
>> Miscompare start offset (in bytes):=C2=A0=C2=A0 0x8
>> Miscomapre end offset (in bytes):=C2=A0=C2=A0=C2=A0=C2=A0 0xbff
>> Miscompare size (in bytes):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0xbf8
>>
>> Expected data (at miscomapre offset): 8c9aea5a736462000000000000007275
>> Actual data (at miscomapre offset): 889aea5a736462000000000000007275
> Are all the miscompares single bit errors like that one?

The miscompares differs in size. What it is displayed here is the first=20
snippet of
the miscompare data, but in this case the miscompare has 0xbf8 bytes of=20
size.

I've seen cases where the miscompare has the same size of the data=20
written - the
test initialize the disk with a known pattern (bbbbbbb for example),=20
then a miscompare
happens and it founds out that the disk had the starting pattern.


> Is the test doing single bit manipulation or is that coming out of the
> blue?

As far as I've read in the test suite code, it is writing several=20
sectors at once
then asserting that the contents were written.

>
> Dave
>
>> -----
>>
>>
>> This means that the test executed a write at=C2=A0 LBA 0x94fa and, aft=
er
>> confirming that the write was completed, issue 2 reads in the same LBA=
 to
>> assert the written contents and found out a mismatch.
>>
>>
>> I've tested all sort of configurations between disk vs LUN, cache mode=
s and
>> AIO. My findings are:
>>
>> - using device=3D'lun' instead of device=3D'disk', I can't reproduce t=
he issue
>> doesn't matter what other configurations are;
>> - using device=3D'disk' but with cache=3D'writethrough', issue doesn't=
 happen
>> (haven't checked other cache modes);
>> - using device=3D'disk', cache=3D'none' and io=3D'native', issue doesn=
't happen.
>>
>>
>> The issue seems to be tied with the combination device=3Ddisk + cache=3D=
none +
>> io=3Dthreads. I've started digging into the SCSI layer all the way dow=
n to the
>> block backend. With a shameful amount of logs I've discovered that, in=
 the
>> write that the test finds a miscompare, in block/file-posix.c:
>>
>> - when doing the write, handle_aiocb_rw_vector() returns success, pwri=
tev()
>> reports that all bytes were written
>> - in both reads after the write, handle_aiocb_rw_vector returns succes=
s, all
>> bytes read by preadv(). In both reads, the data read is different from=
 the
>> data written by=C2=A0 the pwritev() that happened before
>>
>> In the discussions at [1], Fam Zheng suggested a test in which we woul=
d take
>> down the number of threads created in the POSIX thread pool from 64 to=
 1.
>> The idea is to ensure that we're using the same thread to write and re=
ad.
>> There was a suspicion that the kernel can't guarantee data coherency b=
etween
>> different threads, even if using the same fd, when using pwritev() and
>> preadv(). This would explain why the following reads in the same fd wo=
uld
>> fail to retrieve the same data that was written before. After doing th=
is
>> modification, the miscompare didn't reproduce.
>>
>> After reverting the thread pool number change, I've made a couple of
>> attempts trying to flush before read() and flushing after write(). Bot=
h
>> attempts failed - the miscompare appears in both scenarios. This enfor=
ces
>> the suspicion we have above - if data coherency can't be granted betwe=
en
>> different threads, flushing in different threads wouldn't make a diffe=
rence
>> too. I've also tested a suggestion from Fam where I started the disks =
with
>> "cache.direct=3Don,cache.no-flush=3Doff" - bug still reproduces.
>>
>>
>> This is the current status of this investigation. I decided to start a
>> discussion here, see if someone can point me something that I overlook=
ed or
>> got it wrong, before I started changing the POSIX thread pool behavior=
 to
>> see if I can enforce one specific POSIX thread to do a read() if we ha=
d a
>> write() done in the same fd. Any suggestions?
>>
>>
>>
>> ps: it is worth mentioning that I was able to reproduce this same bug =
in a
>> POWER8 system running Ubuntu 18.04. Given that the code we're dealing =
with
>> doesn't have any arch-specific behavior I wouldn't be surprised if thi=
s bug
>> is also reproducible in other archs like x86.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1561017
>> [2] https://github.com/open-power/HTX
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
