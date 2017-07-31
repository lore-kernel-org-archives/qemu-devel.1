Received: from eggs.gnu.org ([2001:4830:134:3::10]:58076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dc9qO-0007d9-6y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dc9qL-0000rw-2J
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:30:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dc9qK-0000q9-OX
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:30:40 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6VCU1X1033983
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 08:30:39 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c21x00602-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 08:30:38 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 31 Jul 2017 13:30:35 +0100
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<20170731035137.GB21572@bjsdjshi@linux.vnet.ibm.com>
	<20170731131302.5bb2198c@gondolin>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 31 Jul 2017 14:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170731131302.5bb2198c@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <bcb1d8d2-b620-fc47-4a2f-c89bbb744d0b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com



On 07/31/2017 01:13 PM, Cornelia Huck wrote:
> On Mon, 31 Jul 2017 11:51:37 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Cornelia Huck <cohuck@redhat.com> [2017-07-27 13:59:10 +0200]:
>>
>>> On Thu, 27 Jul 2017 03:54:18 +0200
>>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
[..]
>>
>> After thinking quite a while, if we do want to add a real device object
>> for a channel path, the most intractable problem (but not the only one)
>> for me is to find a good way to map the real path with the virtual one.

Yeah, channel path virtualisation... IMHO our current solution is not
not really solving the problem. Say, do we  care about a design which
could work with live migration (@Dong Jia)?

>> How would we retrieve the information from the real one? We'd need the
>> host kernel to provide totally new interfaces for channel path
>> information synchronization and notification machenism. I don't think in
>> this case sysfs is the choice. Ioctls, vfio MMIO regions and eventfd
>> could be a better choice. I think, this is like we are trying to
>> passthru a channel path. So we'd need to have a new vfio device physical
>> driver (e.g. vfio-chp) to handle this...
> 
> And that would run into the problem of (1) the chp objects not using a
> bus on Linux, and (2) implying dedicating the chpids, which we likely
> do not want.
> 

AFAIU this is about "real-virtual" vs "virutal-virtual". I would really like
to see some design here (@Dong Jia). I'm not sure any more where do we want to go.

[..]
>>
>>>
>>> tl;dr: I don't think we want chp crws until after we have a good chp
>>> model.  
>> I have to agree.
> 
> I'm wondering whether we should just defer this to later. We can live
> with no chp crw being created (except for rchp), as due to the crw
> generation being unreliable the guest OS has to handle path changes
> without crws anyway.
> 
> We just need to make sure that pno and friends are appropriately
> reported to the guest.
> 

+1 
