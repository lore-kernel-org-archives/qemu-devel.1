Received: from eggs.gnu.org ([2001:4830:134:3::10]:38506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJ4ey-0001Vj-7p
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.ibm.com>) id 1fJ4eu-0003LG-7o
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.ibm.com>)
	id 1fJ4et-0003Kd-UX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:12:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GLxMe6056861
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:12:30 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0u9fmx0t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:12:30 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.ibm.com>;
	Wed, 16 May 2018 16:12:28 -0600
From: Daniel Henrique Barboza <danielhb@linux.ibm.com>
References: <42ec7519-653d-09e2-abc6-78f04733ca47@linux.ibm.com>
	<d5093823-76d8-6fd7-86f3-249d9d3518ae@redhat.com>
	<34187a39-5d59-62d4-6dd2-15f013738026@linux.ibm.com>
Date: Wed, 16 May 2018 19:12:21 -0300
MIME-Version: 1.0
In-Reply-To: <34187a39-5d59-62d4-6dd2-15f013738026@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <fcb0c9ca-10bc-1f4d-71e9-402023be5f06@linux.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>



On 05/16/2018 06:35 PM, Daniel Henrique Barboza wrote:
>
>
> On 05/16/2018 04:47 AM, Paolo Bonzini wrote:
>> On 15/05/2018 23:25, Daniel Henrique Barboza wrote:
>>> This is the current status of this investigation. I decided to start =
a
>>> discussion here, see if someone can point me something that I=20
>>> overlooked
>>> or got it wrong, before I started changing the POSIX thread pool
>>> behavior to see if I can enforce one specific POSIX thread to do a
>>> read() if we had a write() done in the same fd. Any suggestions?
>> Copying from the bug:
>>
>>> Unless we learn something new, my understanding is that we're dealing
>>> with a host side limitation/bug when calling pwritev() in a different
>>> thread than a following preadv(), using the same file descriptor
>>> opened with O_DIRECT and no WCE in the host side, the kernel can't
>>> grant data coherency, e.g:
>>>
>>> - thread A executes a pwritev() writing dataA in the disk
>>>
>>> - thread B executes a preadv() call to read the data, but this
>>> preadv() call isn't aware of the previous pwritev() call done in
>>> thread A, thus the guarantee of the preadv() call reading dataA isn't
>>> assured (as opposed to what is described in man 3 write)
>>>
>>> - the physical disk, due to the heavy load of the stress test, didn't
>>> finish writing up dataA. Since the disk itself doesn't have any
>>> internal cache to rely on, the preadv() call goes in and read an old
>>> data that differs from dataA.
>> There is a problem in the reasoning of the third point: if the physica=
l
>> disk hasn't yet finished writing up dataA, pwritev() shouldn't have
>> returned.=C2=A0 This could be a bug in the kernel, or even in the disk=
.=C2=A0 I
>> suspect the kernel because SCSI passthrough doesn't show the bug; SCSI
>> passthrough uses ioctl() which completes exactly when the disk tells
>> QEMU that the command is done---it cannot report completion too early.
>>
>> (Another small problem in the third point is that the disk actually do=
es
>> have a cache.=C2=A0 But the cache should be transparent, if it weren't=
 the
>> bug would be in the disk firmware).
>>
>> It has to be debugged and fixed in the kernel.=C2=A0 The thread pool i=
s
>> just... a thread pool, and shouldn't be working around bugs, especiall=
y
>> as serious as these.
>
> Fixing in the thread pool would only make sense if we were sure that
> the kernel was working as intended. I think the next step would be to
> look it in the kernel level and see what is not working there.
>
>>
>> A more likely possibility: maybe the disk has 4K sectors and QEMU is
>> doing read-modify-write cycles to emulate 512 byte sectors?=C2=A0 In t=
his
>> case, mismatches are not expected, since QEMU serializes RMW cycles, b=
ut
>> at least we would know that the bug would be in QEMU, and where.
>
> Haven't considered this possibility. I'll look it up if the disk has 4k
> sectors and whether QEMU is emulating 512 bytes sectors.

There are several differences between the guest and the host device=20
regarding the
kernel parameters. This is how the guest configured the SATA disk:


# grep . /sys/block/sdb/queue/*
/sys/block/sdb/queue/add_random:1
/sys/block/sdb/queue/chunk_sectors:0
/sys/block/sdb/queue/dax:0
/sys/block/sdb/queue/discard_granularity:4096
/sys/block/sdb/queue/discard_max_bytes:1073741824
/sys/block/sdb/queue/discard_max_hw_bytes:1073741824
/sys/block/sdb/queue/discard_zeroes_data:0
/sys/block/sdb/queue/hw_sector_size:512
/sys/block/sdb/queue/io_poll:0
/sys/block/sdb/queue/io_poll_delay:0
grep: /sys/block/sdb/queue/iosched: Is a directory
/sys/block/sdb/queue/iostats:1
/sys/block/sdb/queue/logical_block_size:512
/sys/block/sdb/queue/max_discard_segments:1
/sys/block/sdb/queue/max_hw_sectors_kb:32767
/sys/block/sdb/queue/max_integrity_segments:0
/sys/block/sdb/queue/max_sectors_kb:256
/sys/block/sdb/queue/max_segments:126
/sys/block/sdb/queue/max_segment_size:65536
/sys/block/sdb/queue/minimum_io_size:262144
/sys/block/sdb/queue/nomerges:0
/sys/block/sdb/queue/nr_requests:128
/sys/block/sdb/queue/optimal_io_size:262144
/sys/block/sdb/queue/physical_block_size:512
/sys/block/sdb/queue/read_ahead_kb:4096
/sys/block/sdb/queue/rotational:1
/sys/block/sdb/queue/rq_affinity:1
/sys/block/sdb/queue/scheduler:noop [deadline] cfq
/sys/block/sdb/queue/unpriv_sgio:0
grep: /sys/block/sdb/queue/wbt_lat_usec: Invalid argument
/sys/block/sdb/queue/write_cache:write back
/sys/block/sdb/queue/write_same_max_bytes:262144
/sys/block/sdb/queue/write_zeroes_max_bytes:262144
/sys/block/sdb/queue/zoned:none


The same device in the host:

$ grep . /sys/block/sdc/queue/*
/sys/block/sdc/queue/add_random:1
/sys/block/sdc/queue/chunk_sectors:0
/sys/block/sdc/queue/dax:0
/sys/block/sdc/queue/discard_granularity:0
/sys/block/sdc/queue/discard_max_bytes:0
/sys/block/sdc/queue/discard_max_hw_bytes:0
/sys/block/sdc/queue/discard_zeroes_data:0
/sys/block/sdc/queue/hw_sector_size:512
/sys/block/sdc/queue/io_poll:0
/sys/block/sdc/queue/io_poll_delay:0
grep: /sys/block/sdc/queue/iosched: Is a directory
/sys/block/sdc/queue/iostats:1
/sys/block/sdc/queue/logical_block_size:512
/sys/block/sdc/queue/max_discard_segments:1
/sys/block/sdc/queue/max_hw_sectors_kb:256
/sys/block/sdc/queue/max_integrity_segments:0
/sys/block/sdc/queue/max_sectors_kb:256
/sys/block/sdc/queue/max_segments:64
/sys/block/sdc/queue/max_segment_size:65536
/sys/block/sdc/queue/minimum_io_size:512
/sys/block/sdc/queue/nomerges:0
/sys/block/sdc/queue/nr_requests:128
/sys/block/sdc/queue/optimal_io_size:0
/sys/block/sdc/queue/physical_block_size:512
/sys/block/sdc/queue/read_ahead_kb:4096
/sys/block/sdc/queue/rotational:1
/sys/block/sdc/queue/rq_affinity:1
/sys/block/sdc/queue/scheduler:noop [deadline] cfq
/sys/block/sdc/queue/unpriv_sgio:0
grep: /sys/block/sdc/queue/wbt_lat_usec: Invalid argument
/sys/block/sdc/queue/write_cache:write through
/sys/block/sdc/queue/write_same_max_bytes:0
/sys/block/sdc/queue/write_zeroes_max_bytes:0
/sys/block/sdc/queue/zoned:none



Physical block size is 512 in both guest and host but there are a lot of=20
differences
in how the guest sees the device. Not sure if there is something suspicio=
us
in these differences that can bring some light in the problem though.


Daniel


>
>
>>
>> Paolo
>>
>
