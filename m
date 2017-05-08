Received: from eggs.gnu.org ([2001:4830:134:3::10]:57135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d7cf8-0004TW-0L
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d7cf4-0003jz-R9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d7cf4-0003jq-IP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:00:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v486wTrI050777
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 03:00:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aajkvk7tr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 03:00:47 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 8 May 2017 01:00:47 -0600
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170505074143.GB21435@lemon.lan>
	<298bd169-6f9f-e622-1b8b-85ef126d8d0c@linux.vnet.ibm.com>
	<ca23d2f5-1296-976b-fe98-35277eb632f9@redhat.com>
	<c50c12c0-93bb-bd40-9751-d4b716407c20@linux.vnet.ibm.com>
	<eecd3b1f-a554-b64e-30ba-a45b053f5260@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 8 May 2017 09:00:41 +0200
MIME-Version: 1.0
In-Reply-To: <eecd3b1f-a554-b64e-30ba-a45b053f5260@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <5d72d4cc-da61-9bbf-3f4c-61fd1c799cd8@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/5] Enable virtio-scsi boot from
 /dev/sgX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fam Zheng <famz@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

On 05/06/2017 10:24 AM, Paolo Bonzini wrote:
> 
> 
> On 05/05/2017 18:12, Eric Farman wrote:
>>
>>
>> On 05/05/2017 11:13 AM, Paolo Bonzini wrote:
>>>
>>>
>>> On 05/05/2017 17:03, Eric Farman wrote:
>>>> We get a value of x3fffff when sending that to a scsi-disk from bios
>>>> code.  That's fully emulated though, in scsi_disk_emulate_inquiry.  And
>>>> that's the scenario that already works.
>>>>
>>>> While there is indeed code in hw/scsi/scsi-generic.c to wire that in,
>>>> that only happens after the I/O goes to the device itself.  The Block
>>>> Limits page isn't supported [1] and thus it gets rejected with "invalid
>>>> field in cdb".  We never get to that fixup code you reference, since the
>>>> returned len is zero.
>>>>
>>>> Should I be refactoring this code to always patch in that block limit
>>>> regardless of a response from the host/device?  (That is, when page xb0
>>>> isn't supported by the hw.)
>>>
>>> What is thec value you get?
>>
>> x140000 bytes when using /dev/sg0 (xa00 sectors when using /dev/sda).
>>
>>>  Is there a sensible default value
>>> that you can use when page 0xb0 isn't supported by the hardware?
>>
>> I was setting max_sectors to x800 with good success, which was the
>> power-of-2 floor that BLKSECTGET gave us.  That kept us within the
>> limits of the host biovec code.  But it's a long way from the
>> virtio-scsi value of xFFFF when max_sectors isn't specified, so don't
>> know what side effects that may cause.
> 
> It's just slower, but 0x800 is already a megabyte worth of data so it's
> not going to be that much slower.
> 
> Paolo
> 

Eric, maybe that would be a safe variant. The bios boot code is not
performance optimized anyway. Lets just always use a maximum size that 
will always work.
