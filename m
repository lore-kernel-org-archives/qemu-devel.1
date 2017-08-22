Received: from eggs.gnu.org ([2001:4830:134:3::10]:41829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkA9m-0003GG-Dc
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkA9h-0000RF-GG
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:27:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38528
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkA9h-0000R5-7F
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:27:45 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7MEP64C119123
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 10:27:44 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cgkcnpsfj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 10:27:43 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 22 Aug 2017 15:27:41 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
	<17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
	<20170822103955.1cbc0714.cohuck@redhat.com>
	<b7e7810c-7822-2fb8-2a2e-d67c08126639@linux.vnet.ibm.com>
	<20170822113914.3ff24d75.cohuck@redhat.com>
	<ff247730-9d10-352c-b6dc-8d98198181cf@linux.vnet.ibm.com>
	<20170822152434.068b5038.cohuck@redhat.com>
	<20170822160621.6efb55aa.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 22 Aug 2017 16:27:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170822160621.6efb55aa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f6ec4f46-9b55-709d-a7e6-67224fe93834@linux.vnet.ibm.com>
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



On 08/22/2017 04:06 PM, Cornelia Huck wrote:
> On Tue, 22 Aug 2017 15:24:34 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Tue, 22 Aug 2017 14:58:37 +0200
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 08/22/2017 11:39 AM, Cornelia Huck wrote:  
>>>> On Tue, 22 Aug 2017 11:20:51 +0200
>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>>>>> Well, the QEMU name of the command is misleading misleading. In the AR
>>>>> it's called 'Configure I/O Adapter'. The PCI comes into the picture via
>>>>> byte 8 of the SCCB, the so called adapter type. Valid values for the
>>>>> adapter type are: 00-01 reserved; 02 PCI function; 03-FF reserved. So
>>>>> at this point we only have PCI.   
> 
> OK, I need one more piece of information. 
> 
> We obviously need to check whether the sccb we got is long enough
> before we try to access the command-specific field. How long is the
> sccb supposed to be for configure I/O adapter? For pci, 16 bytes; in
> general, I would guess that it needs to include at least atype and some
> placeholder for the payload. What does the AR say?
>

The first 2 bytes of the SCCB designate it's length. For this particular
command it's at least 16 bytes (regardless of pci). The length is
marked as may be changed by the SCLP.
 
 
> Looking at the pci code, I also noted that it cheerfully uses the aid
> field of the sccb before checking whether it is actually long enough...
> 
