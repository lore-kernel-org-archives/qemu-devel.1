Received: from eggs.gnu.org ([2001:4830:134:3::10]:50039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fhdub-0000w2-2i
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fhduW-0003pX-7K
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:42:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fhduV-0003pI-W1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:42:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6NGe2qj110420
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:42:10 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kdj7xjc2b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:42:10 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 23 Jul 2018 10:42:09 -0600
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
	<20180723163011.GH20596@stefanha-x1.localdomain>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 23 Jul 2018 12:42:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180723163011.GH20596@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <81e4d6fe-1736-b3cc-45ec-ecaa07098906@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nishanth Aravamudan <naravamudan@digitalocean.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 07/23/2018 12:30 PM, Stefan Hajnoczi wrote:
> On Fri, Jul 20, 2018 at 03:11:14PM -0400, Farhan Ali wrote:
>> I am seeing another issue pop up, in a different test. Even though it's a
>> different assertion, it might be related based on the call trace.
> 
> Which test case?

This test case involved one guest with 2 disks, with an iothread for 
each disk. The guest was running a memory workload.

> 
>> Stack trace of thread 276199:
>> #0  0x000003ff8473e274 raise (libc.so.6)
>> #1  0x000003ff847239a8 abort (libc.so.6)
>> #2  0x000003ff847362ce __assert_fail_base (libc.so.6)
>> #3  0x000003ff8473634c __assert_fail (libc.so.6)
>> #4  0x000002aa30aba0c4 iov_memset (qemu-system-s390x)
>> #5  0x000002aa30aba9a6 qemu_iovec_memset (qemu-system-s390x)
>> #6  0x000002aa30a23e88 qemu_laio_process_completion (qemu-system-s390x)
> 
> What are the values of laiocb->qiov->size and laiocb->ret?

The laiocb->qiov->size was 4096 and laiocb->ret was 8192

> 
>> #7  0x000002aa30a23f68 qemu_laio_process_completions (qemu-system-s390x)
>> #8  0x000002aa30a2418e qemu_laio_process_completions_and_submit
>> (qemu-system-s390x)
>> #9  0x000002aa30a24220 qemu_laio_poll_cb (qemu-system-s390x)
>> #10 0x000002aa30ab22c4 run_poll_handlers_once (qemu-system-s390x)
>> #11 0x000002aa30ab2e78 aio_poll (qemu-system-s390x)
>> #12 0x000002aa30a29f4e bdrv_do_drained_begin (qemu-system-s390x)
>> #13 0x000002aa30a2a276 bdrv_drain (qemu-system-s390x)
>> #14 0x000002aa309d45aa bdrv_set_aio_context (qemu-system-s390x)
>> #15 0x000002aa3085acfe virtio_blk_data_plane_stop (qemu-system-s390x)
>> #16 0x000002aa3096994c virtio_bus_stop_ioeventfd.part.1 (qemu-system-s390x)
>> #17 0x000002aa3087d1d6 virtio_vmstate_change (qemu-system-s390x)
>> #18 0x000002aa308e8a12 vm_state_notify (qemu-system-s390x)
>> #19 0x000002aa3080ed54 do_vm_stop (qemu-system-s390x)
>> #20 0x000002aa307bea04 main (qemu-system-s390x)
>> #21 0x000003ff84723dd2 __libc_start_main (libc.so.6)
>> #22 0x000002aa307c0414 _start (qemu-system-s390x)
>>
>>
>> The failing assertion is:
>>
>> qemu-kvm: util/iov.c:78: iov_memset: Assertion `offset == 0' failed.
> 
> I wonder if the offset is beyond the end of the iovecs.
> 
> Thanks,
> Stefan
> 

Thanks
Farhan
