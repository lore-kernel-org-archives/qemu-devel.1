Received: from eggs.gnu.org ([2001:4830:134:3::10]:33174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clC6I-0000xy-Fs
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clC6E-0003sf-EC
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:12:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1clC6E-0003r2-4R
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:12:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v27A9fwa057881
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 05:12:08 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2917pnfywh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 05:12:07 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 7 Mar 2017 10:12:04 -0000
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
	<20170307025328.53409-2-haoqf@linux.vnet.ibm.com>
	<20170307092951.GA5871@noname.str.redhat.com>
	<80495689-674c-5dde-ae49-d80a2eb20372@linux.vnet.ibm.com>
	<20170307100328.GC2869@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 7 Mar 2017 11:11:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170307100328.GC2869@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <b4a3c3ff-06d2-94d7-9f55-2476896ccd86@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vmstate: draft fix for failed
 iotests case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, famz@redhat.com, mreitz@redhat.com, quintela@redhat.com



On 03/07/2017 11:03 AM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 03/07/2017 10:29 AM, Kevin Wolf wrote:
>>> Am 07.03.2017 um 03:53 hat QingFeng Hao geschrieben:
>>>> I am not very clear about the logic in vmstate.c, but from its context in
>>>> vmstate_save_state, it seems size should not be 0, otherwise the followed
>>>> for loop will keep working on the same element. So I just add a simple
>>>> check to pass that case, not sure if it's right but it can pass iotest
>>>> case 68 and 91 now.

[..]

>>
>> I have looked onto the issue. It affects s390x only if we
>> are running without KVM. Basically, S390CPU.irqstate is unused
>> if we do not use KVM, and thus no buffer is allocated.
>>
>> IMHO this is a missing field and the cleaner way to handle such
>> missing fields is exist. However this used to work, and I recommended
>> QuiFeng Hao to discuss the problem upstream.
>>
>> By the way, I think, if we want to go back to the old behavior
>> and support VMS_VBUFFER with size 0 and nullptr, a much
>> cleaner way to do the fix is to change the assert to:
>>
>> assert(first_elem  || !n_elems || !size)
>>
>> Obviously the other clean way to fix is to implement exists.
>>
>> I think the migration maintainers (Juan and Dave) should make a
>> call regarding if the described usage  of VMS_BUFFER is a legal
>> or an illegal one.
> 
> So is it this code in target/s390x/machine.c ?
> 
>         VMSTATE_VBUFFER_UINT32(irqstate, S390CPU, 4, NULL,
>                                irqstate_saved_size),
> 

Yes!

> it should be legal for that to be zero length.
> It also makes sense that if that's zero length it should be OK for
> the pointer to be NULL.
> 
> I think it's best if you do change that assert.
> 

Makes sense. I think QingFeng will agree too and send a
new version soon.

Regards,
Halil

> Dave
