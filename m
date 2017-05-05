Received: from eggs.gnu.org ([2001:4830:134:3::10]:55473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d6fqP-0000YA-7r
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d6fqM-00030P-2n
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:12:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d6fqL-00030B-TI
	for qemu-devel@nongnu.org; Fri, 05 May 2017 12:12:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45G4D7Z039590
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 12:12:32 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8qm2r1pn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 12:12:32 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 5 May 2017 10:12:31 -0600
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170505074143.GB21435@lemon.lan>
	<298bd169-6f9f-e622-1b8b-85ef126d8d0c@linux.vnet.ibm.com>
	<ca23d2f5-1296-976b-fe98-35277eb632f9@redhat.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri, 5 May 2017 12:12:26 -0400
MIME-Version: 1.0
In-Reply-To: <ca23d2f5-1296-976b-fe98-35277eb632f9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <c50c12c0-93bb-bd40-9751-d4b716407c20@linux.vnet.ibm.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 05/05/2017 11:13 AM, Paolo Bonzini wrote:
>
>
> On 05/05/2017 17:03, Eric Farman wrote:
>> We get a value of x3fffff when sending that to a scsi-disk from bios
>> code.  That's fully emulated though, in scsi_disk_emulate_inquiry.  And
>> that's the scenario that already works.
>>
>> While there is indeed code in hw/scsi/scsi-generic.c to wire that in,
>> that only happens after the I/O goes to the device itself.  The Block
>> Limits page isn't supported [1] and thus it gets rejected with "invalid
>> field in cdb".  We never get to that fixup code you reference, since the
>> returned len is zero.
>>
>> Should I be refactoring this code to always patch in that block limit
>> regardless of a response from the host/device?  (That is, when page xb0
>> isn't supported by the hw.)
>
> What is the BLKSECTGET value you get?

x140000 bytes when using /dev/sg0 (xa00 sectors when using /dev/sda).

>  Is there a sensible default value
> that you can use when page 0xb0 isn't supported by the hardware?

I was setting max_sectors to x800 with good success, which was the 
power-of-2 floor that BLKSECTGET gave us.  That kept us within the 
limits of the host biovec code.  But it's a long way from the 
virtio-scsi value of xFFFF when max_sectors isn't specified, so don't 
know what side effects that may cause.

>
> Thanks,
>
> Paolo
>
