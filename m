Received: from eggs.gnu.org ([2001:4830:134:3::10]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dS2L7-0008A6-Jt
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dS2L4-000547-FS
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:28:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dS2L4-00053X-5O
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:28:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v63EJL5Q024495
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 10:28:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bf630kw82-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 10:28:32 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 3 Jul 2017 08:28:31 -0600
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
	<20170424105344.GF2362@work-vm>
	<75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
	<097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
	<20170426110144.GF2098@work-vm>
	<cbf8c55d-9473-9f6f-eb89-779afe7c1fd2@de.ibm.com>
	<cec279c5-9900-ca28-103b-b95c36d9d989@de.ibm.com>
	<20170630163139.GC2437@work-vm>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 3 Jul 2017 16:28:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170630163139.GC2437@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 8bit
Message-Id: <41ed4636-0e22-5236-b9db-d9e925c28584@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, thuth@redhat.com, Andrea Arcangeli <aarcange@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On 06/30/2017 06:31 PM, Dr. David Alan Gilbert wrote:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>> On 04/26/2017 01:45 PM, Christian Borntraeger wrote:
>>
>>>> Hmm, I have a theory, if the flags field has bit 1 set, i.e. RAM_SAVE_FLAG_COMPRESS
>>>> then try changing ram_handle_compressed to always do the memset.
>>>
>>> FWIW, changing ram_handle_compressed to always memset makes the problem go away.
>>
>> It is still running fine now with the "always memset change"
> 
> Did we ever nail down a fix for this; as I remember Andrea said
> we shouldn't need to do that memset, but we came to the conclusion
> it was something specific to how s390 protection keys worked.

It was specific to s390. Newer Linuxes do not use the storage keys,
so we enable them lazily. If a guest goes from keyless to keyed, the
kernel will mark the VM to no longer use the zero page and the  walk all
pages of that guests and zaps the empty_zero page from the page table.
All normal code will then fault in a cow copy of the zero page on the
next access. 
The postcopy logic now at least reads all zero pages to prevent faults
on these addresses. If a running guest switches to key-mode afterwards
(but during postcopy) then we might get a fault for a zero page.

Still not sure about the best solution. (see  s390_enable_skey in arch/s390/mm/gmap.c)
