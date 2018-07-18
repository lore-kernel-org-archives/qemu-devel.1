Received: from eggs.gnu.org ([2001:4830:134:3::10]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1ffo69-00049A-8Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1ffo66-0002IU-3k
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:10:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57526
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1ffo65-0002HP-SW
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:10:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6IF86lN112954
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 11:10:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ka6fhvd9h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 11:10:32 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 18 Jul 2018 09:10:31 -0600
References: <e16f10f5-b113-5ebe-51e9-c379ca34193d@linux.ibm.com>
	<20180717205212.GA9580@breakout>
	<c39e6566-78bb-cfe9-f0df-c6cc6ec2ad29@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 18 Jul 2018 11:10:27 -0400
MIME-Version: 1.0
In-Reply-To: <c39e6566-78bb-cfe9-f0df-c6cc6ec2ad29@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <bdbb9588-a913-c449-415b-34a25fcbde9e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [BUG?] aio_get_linux_aio: Assertion
 `ctx->linux_aio' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>



On 07/18/2018 09:42 AM, Farhan Ali wrote:
>=20
>=20
> On 07/17/2018 04:52 PM, Nishanth Aravamudan wrote:
>> iiuc, this possibly implies AIO was not actually used previously on th=
is
>> guest (it might have silently been falling back to threaded IO?). I
>> don't have access to s390x, but would it be possible to run qemu under
>> gdb and see if aio_setup_linux_aio is being called at all (I think it
>> might not be, but I'm not sure why), and if so, if it's for the contex=
t
>> in question?
>>
>> If it's not being called first, could you see what callpath is calling
>> aio_get_linux_aio when this assertion trips?
>>
>> Thanks!
>> -Nish
>=20
>=20
> Hi Nishant,
>=20
>  From the coredump of the guest this is the call trace that calls=20
> aio_get_linux_aio:
>=20
>=20
> Stack trace of thread 145158:
> #0=C2=A0 0x000003ff94dbe274 raise (libc.so.6)
> #1=C2=A0 0x000003ff94da39a8 abort (libc.so.6)
> #2=C2=A0 0x000003ff94db62ce __assert_fail_base (libc.so.6)
> #3=C2=A0 0x000003ff94db634c __assert_fail (libc.so.6)
> #4=C2=A0 0x000002aa20db067a aio_get_linux_aio (qemu-system-s390x)
> #5=C2=A0 0x000002aa20d229a8 raw_aio_plug (qemu-system-s390x)
> #6=C2=A0 0x000002aa20d309ee bdrv_io_plug (qemu-system-s390x)
> #7=C2=A0 0x000002aa20b5a8ea virtio_blk_handle_vq (qemu-system-s390x)
> #8=C2=A0 0x000002aa20db2f6e aio_dispatch_handlers (qemu-system-s390x)
> #9=C2=A0 0x000002aa20db3c34 aio_poll (qemu-system-s390x)
> #10 0x000002aa20be32a2 iothread_run (qemu-system-s390x)
> #11 0x000003ff94f879a8 start_thread (libpthread.so.0)
> #12 0x000003ff94e797ee thread_start (libc.so.6)
>=20
>=20
> Thanks for taking a look and responding.
>=20
> Thanks
> Farhan
>=20
>=20
>=20

Trying to debug a little further, the block device in this case is a=20
"host device". And looking at your commit carefully you use the=20
bdrv_attach_aio_context callback to setup a Linux AioContext.

For some reason the "host device" struct (BlockDriver bdrv_host_device=20
in block/file-posix.c) does not have a bdrv_attach_aio_context defined.
So a simple change of adding the callback to the struct solves the issue=20
and the guest starts fine.


diff --git a/block/file-posix.c b/block/file-posix.c
index 28824aa..b8d59fb 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3135,6 +3135,7 @@ static BlockDriver bdrv_host_device =3D {
      .bdrv_refresh_limits =3D raw_refresh_limits,
      .bdrv_io_plug =3D raw_aio_plug,
      .bdrv_io_unplug =3D raw_aio_unplug,
+    .bdrv_attach_aio_context =3D raw_aio_attach_aio_context,

      .bdrv_co_truncate       =3D raw_co_truncate,
      .bdrv_getlength    =3D raw_getlength,



I am not too familiar with block device code in QEMU, so not sure if=20
this is the right fix or if there are some underlying problems.

Thanks
Farhan
