Received: from eggs.gnu.org ([2001:4830:134:3::10]:49656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cECk7-0007O0-HR
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:13:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cECk2-0001sw-JN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:12:59 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:53665
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cECk2-0001sm-9G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:12:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB6AALUg115584
	for <qemu-devel@nongnu.org>; Tue, 6 Dec 2016 05:12:53 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 275qv2ca3c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 05:12:52 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Dec 2016 03:12:52 -0700
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161201192652.9509-13-stefanha@redhat.com>
	<14acce63-5f93-ca54-477a-3a998769bbe9@de.ibm.com>
	<20161206092029.GA12630@stefanha-x1.localdomain>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Dec 2016 11:12:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161206092029.GA12630@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <826ff365-4ef1-6118-f677-ccfd86ea337b@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/13] aio: self-tune polling time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Karl Rister <krister@redhat.com>

On 12/06/2016 10:20 AM, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2016 at 09:06:17PM +0100, Christian Borntraeger wrote:
>> On 12/01/2016 08:26 PM, Stefan Hajnoczi wrote:
>>> This patch is based on the algorithm for the kvm.ko halt_poll_ns
>>> parameter in Linux.  The initial polling time is zero.
>>>
>>> If the event loop is woken up within the maximum polling time it means
>>> polling could be effective, so grow polling time.
>>>
>>> If the event loop is woken up beyond the maximum polling time it means
>>> polling is not effective, so shrink polling time.
>>>
>>> If the event loop makes progress within the current polling time then
>>> the sweet spot has been reached.
>>>
>>> This algorithm adjusts the polling time so it can adapt to variations in
>>> workloads.  The goal is to reach the sweet spot while also recognizing
>>> when polling would hurt more than help.
>>>
>>> Two new trace events, poll_grow and poll_shrink, are added for observing
>>> polling time adjustment.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Not sure way, but I have 4 host ramdisks with the same iothread as guest
>> virtio-blk. running fio in the guest on one of these disks will poll, as
>> soon as I have 2 disks  in fio I almost always see shrinks (so polling 
>> stays at 0) and almost no grows.
> 
> Shrinking occurs when polling + ppoll(2) time exceeds poll-max-ns.
> 
> What is the value of poll-max-ns

I used 50000ns as poll value. When using 500000ns it is polling again.

> and how long is run_poll_handlers_end - run_poll_handlers_begin?

Too long. I looked again and I realized that I used cache=none without
io=native. After adding io=native things are better. Even with 4 disks
polling still happens. So it seems that the mileage will vary depending
on the settings

Christian
