Received: from eggs.gnu.org ([2001:4830:134:3::10]:43160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fg2qa-0000Qh-J2
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 02:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fg2qX-0004Xh-6D
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 02:55:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fg2qW-0004Wd-SJ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 02:55:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6J6rwg0016423
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 02:55:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kahyhfttq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 02:55:26 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 19 Jul 2018 07:55:24 +0100
References: <e16f10f5-b113-5ebe-51e9-c379ca34193d@linux.ibm.com>
	<20180717205212.GA9580@breakout>
	<c39e6566-78bb-cfe9-f0df-c6cc6ec2ad29@linux.ibm.com>
	<bdbb9588-a913-c449-415b-34a25fcbde9e@linux.ibm.com>
	<20180718185202.GA24700@breakout>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 19 Jul 2018 08:55:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180718185202.GA24700@breakout>
Content-Language: en-US
Message-Id: <4ea995c1-a218-de30-1fe6-21e8e9af2bd8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [BUG?] aio_get_linux_aio: Assertion
 `ctx->linux_aio' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu block <qemu-block@nongnu.org>



On 07/18/2018 08:52 PM, Nishanth Aravamudan wrote:
> On 18.07.2018 [11:10:27 -0400], Farhan Ali wrote:
>>
>>
>> On 07/18/2018 09:42 AM, Farhan Ali wrote:
>>>
>>>
>>> On 07/17/2018 04:52 PM, Nishanth Aravamudan wrote:
>>>> iiuc, this possibly implies AIO was not actually used previously on =
this
>>>> guest (it might have silently been falling back to threaded IO?). I
>>>> don't have access to s390x, but would it be possible to run qemu und=
er
>>>> gdb and see if aio_setup_linux_aio is being called at all (I think i=
t
>>>> might not be, but I'm not sure why), and if so, if it's for the cont=
ext
>>>> in question?
>>>>
>>>> If it's not being called first, could you see what callpath is calli=
ng
>>>> aio_get_linux_aio when this assertion trips?
>>>>
>>>> Thanks!
>>>> -Nish
>>>
>>>
>>> Hi Nishant,
>>>
>>>  From the coredump of the guest this is the call trace that calls
>>> aio_get_linux_aio:
>>>
>>>
>>> Stack trace of thread 145158:
>>> #0=C2=A0 0x000003ff94dbe274 raise (libc.so.6)
>>> #1=C2=A0 0x000003ff94da39a8 abort (libc.so.6)
>>> #2=C2=A0 0x000003ff94db62ce __assert_fail_base (libc.so.6)
>>> #3=C2=A0 0x000003ff94db634c __assert_fail (libc.so.6)
>>> #4=C2=A0 0x000002aa20db067a aio_get_linux_aio (qemu-system-s390x)
>>> #5=C2=A0 0x000002aa20d229a8 raw_aio_plug (qemu-system-s390x)
>>> #6=C2=A0 0x000002aa20d309ee bdrv_io_plug (qemu-system-s390x)
>>> #7=C2=A0 0x000002aa20b5a8ea virtio_blk_handle_vq (qemu-system-s390x)
>>> #8=C2=A0 0x000002aa20db2f6e aio_dispatch_handlers (qemu-system-s390x)
>>> #9=C2=A0 0x000002aa20db3c34 aio_poll (qemu-system-s390x)
>>> #10 0x000002aa20be32a2 iothread_run (qemu-system-s390x)
>>> #11 0x000003ff94f879a8 start_thread (libpthread.so.0)
>>> #12 0x000003ff94e797ee thread_start (libc.so.6)
>>>
>>>
>>> Thanks for taking a look and responding.
>>>
>>> Thanks
>>> Farhan
>>>
>>>
>>>
>>
>> Trying to debug a little further, the block device in this case is a "=
host
>> device". And looking at your commit carefully you use the
>> bdrv_attach_aio_context callback to setup a Linux AioContext.
>>
>> For some reason the "host device" struct (BlockDriver bdrv_host_device=
 in
>> block/file-posix.c) does not have a bdrv_attach_aio_context defined.
>> So a simple change of adding the callback to the struct solves the iss=
ue and
>> the guest starts fine.
>>
>>
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 28824aa..b8d59fb 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -3135,6 +3135,7 @@ static BlockDriver bdrv_host_device =3D {
>>      .bdrv_refresh_limits =3D raw_refresh_limits,
>>      .bdrv_io_plug =3D raw_aio_plug,
>>      .bdrv_io_unplug =3D raw_aio_unplug,
>> +    .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,
>>
>>      .bdrv_co_truncate       =3D raw_co_truncate,
>>      .bdrv_getlength    =3D raw_getlength,
>>
>>
>>
>> I am not too familiar with block device code in QEMU, so not sure if
>> this is the right fix or if there are some underlying problems.
>=20
> Oh this is quite embarassing! I only added the bdrv_attach_aio_context
> callback for the file-backed device. Your fix is definitely corect for
> host device. Let me make sure there weren't any others missed and I wil=
l
> send out a properly formatted patch. Thank you for the quick testing an=
d
> turnaround!

Farhan, can you respin your patch with proper sign-off and patch descript=
ion?
Adding qemu-block.
