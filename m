Received: from eggs.gnu.org ([2001:4830:134:3::10]:44872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dk8ld-0007wz-VV
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dk8lY-0000Zp-V3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:58:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44020
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dk8lY-0000Zd-PJ
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:58:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7MCsHdd047163
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:58:43 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cghkyy4pq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:58:43 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 22 Aug 2017 13:58:42 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
	<17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
	<20170822103955.1cbc0714.cohuck@redhat.com>
	<b7e7810c-7822-2fb8-2a2e-d67c08126639@linux.vnet.ibm.com>
	<20170822113914.3ff24d75.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 22 Aug 2017 14:58:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170822113914.3ff24d75.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <ff247730-9d10-352c-b6dc-8d98198181cf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 08/22/2017 11:39 AM, Cornelia Huck wrote:
> On Tue, 22 Aug 2017 11:20:51 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 08/22/2017 10:39 AM, Cornelia Huck wrote:
>>>> I'm fine either way. If I imagine having a lots of adapter types, then I
>>>> would expect a switch or a jumptable on the type before handling control
>>>> to the pci specific function. In this case statically not supported types
>>>> would probably get caught by the default branch of the switch and for a
>>>> jumptable it could even handle the dynamic case (based on the facilities)
>>>> trivially. In short both approaches can make sense.  
>>> I'm also wondering at the naming (the command sounds very
>>> pci-specific). I'd just stick with this approach (modulo a possible
>>> change of the response code, for which I need to rely on you guys).
>>>   
>>
>>
>> Well, the QEMU name of the command is misleading misleading. In the AR
>> it's called 'Configure I/O Adapter'. The PCI comes into the picture via
>> byte 8 of the SCCB, the so called adapter type. Valid values for the
>> adapter type are: 00-01 reserved; 02 PCI function; 03-FF reserved. So
>> at this point we only have PCI.
> 
> OK, misleading naming combined with missing documentation leads to
> confusion...
> 
> So:
> 
> - s/PCI/IOA/ for SCLP_CMDW_{CONFIGURE,DECONFIGURE}_PCI
nod

> - have a switch/case over byte 8 with only one case (pci)

Let's say some kind of a check for bit 8 is a good idea.

> - move the pci feature check into the pci code(? - not sure)

Don't know. Architecturally I don't see any direct connection
between the pci feature and this command.

The availability of SCLP_CMDW_{,DE}CONFIGURE_IOA is indicated
by the result of the read scp info command read info in
ReadInfo.facilities. I think we should assume that the read scp
info command is always there.

I would appreciate someone with AR access double checking.

> 
> There's still the question of when this sclp command first became
> available...
> 

I would argue that it should not be important for AR
compliance. Currently it operates only on PCI so I doubt it
pre-dates PCI. But I don't think the current implementation
is buggy because it offers the sclp command regardless
of the zPCI facility.

I don't know where should I look for the historical details
which go beyond the AR.

Halil
