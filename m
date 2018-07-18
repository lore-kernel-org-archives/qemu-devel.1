Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1ffmjE-00005R-Os
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1ffmj9-0004D2-Q5
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:42:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40374
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1ffmj9-0004Co-IO
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:42:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6IDdVtG001146
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:42:46 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ka5mvk9n4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 09:42:46 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 18 Jul 2018 07:42:45 -0600
References: <e16f10f5-b113-5ebe-51e9-c379ca34193d@linux.ibm.com>
	<20180717205212.GA9580@breakout>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 18 Jul 2018 09:42:42 -0400
MIME-Version: 1.0
In-Reply-To: <20180717205212.GA9580@breakout>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c39e6566-78bb-cfe9-f0df-c6cc6ec2ad29@linux.ibm.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>



On 07/17/2018 04:52 PM, Nishanth Aravamudan wrote:
> iiuc, this possibly implies AIO was not actually used previously on this
> guest (it might have silently been falling back to threaded IO?). I
> don't have access to s390x, but would it be possible to run qemu under
> gdb and see if aio_setup_linux_aio is being called at all (I think it
> might not be, but I'm not sure why), and if so, if it's for the context
> in question?
> 
> If it's not being called first, could you see what callpath is calling
> aio_get_linux_aio when this assertion trips?
> 
> Thanks!
> -Nish


Hi Nishant,

 From the coredump of the guest this is the call trace that calls 
aio_get_linux_aio:


Stack trace of thread 145158:
#0  0x000003ff94dbe274 raise (libc.so.6)
#1  0x000003ff94da39a8 abort (libc.so.6)
#2  0x000003ff94db62ce __assert_fail_base (libc.so.6)
#3  0x000003ff94db634c __assert_fail (libc.so.6)
#4  0x000002aa20db067a aio_get_linux_aio (qemu-system-s390x)
#5  0x000002aa20d229a8 raw_aio_plug (qemu-system-s390x)
#6  0x000002aa20d309ee bdrv_io_plug (qemu-system-s390x)
#7  0x000002aa20b5a8ea virtio_blk_handle_vq (qemu-system-s390x)
#8  0x000002aa20db2f6e aio_dispatch_handlers (qemu-system-s390x)
#9  0x000002aa20db3c34 aio_poll (qemu-system-s390x)
#10 0x000002aa20be32a2 iothread_run (qemu-system-s390x)
#11 0x000003ff94f879a8 start_thread (libpthread.so.0)
#12 0x000003ff94e797ee thread_start (libc.so.6)


Thanks for taking a look and responding.

Thanks
Farhan
