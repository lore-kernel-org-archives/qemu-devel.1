Received: from eggs.gnu.org ([2001:4830:134:3::10]:51195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95so-0000Zm-H5
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e95sl-0002de-FP
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:57:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e95sl-0002dO-9l
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 04:57:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9U8sP0P040060
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 04:57:16 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dwy50wmnb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 04:57:15 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 08:57:13 -0000
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20171029121122.122412ca.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 09:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171029121122.122412ca.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e49b2898-a5b3-ff39-3c6e-b1708f1c8425@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel <qemu-devel@nongnu.org>, Erik Skultety <eskultet@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

adding qemu devel and add Daniel and Erik from libvirt to keep them in the loop. 

On 10/29/2017 12:11 PM, Cornelia Huck wrote:
> On Fri, 13 Oct 2017 13:38:45 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Tony Krowiak (19):
>>   KVM: s390: SIE considerations for AP Queue virtualization
>>   KVM: s390: refactor crypto initialization
>>   s390/zcrypt: new AP matrix bus
>>   s390/zcrypt: create an AP matrix device on the AP matrix bus
>>   s390/zcrypt: base implementation of AP matrix device driver
>>   s390/zcrypt: register matrix device with VFIO mediated device
>>     framework
>>   KVM: s390: introduce AP matrix configuration interface
>>   s390/zcrypt: support for assigning adapters to matrix mdev
>>   s390/zcrypt: validate adapter assignment
>>   s390/zcrypt: sysfs interfaces supporting AP domain assignment
>>   s390/zcrypt: validate domain assignment
>>   s390/zcrypt: sysfs support for control domain assignment
>>   s390/zcrypt: validate control domain assignment
>>   KVM: s390: Connect the AP mediated matrix device to KVM
>>   s390/zcrypt: introduce ioctl access to VFIO AP Matrix driver
>>   KVM: s390: interface to configure KVM guest's AP matrix
>>   KVM: s390: validate input to AP matrix config interface
>>   KVM: s390: New ioctl to configure KVM guest's AP matrix
>>   s390/facilities: enable AP facilities needed by guest
> 
> I'll try to summarize all of this in my own words, both to make sure I
> understand the design correctly and to give others a different view on
> this.
> 
> [I'm completely disregarding control domains here.]
> 
> On s390, we have cryptographic coprocessor cards, which are modeled on
> Linux as devices on the AP bus. There's also a concept called domains,
> which means an individual queue of a crypto device is basically a
> (card,domain) tuple. We model this something like the following
> (assuming we have access to cards 3 and 4 and domains 1 and 2):
> 
> AP -> card3 -> queue (3,1)
>             -> queue (3,2)
>    -> card4 -> queue (4,1)
>             -> queue (4,2)
> 
> (The AP bus is a bit different for backwards compat.)
> 
> If we want to virtualize this, we can use a feature provided by the
> hardware. We basically attach a satellite control block to our main
> hardware virtualization control block and the hardware takes care of
> (mostly) everything.
> 
> For this control block, we don't specify explicit tuples, but a list of
> cards and a list of domains. The guest will get access to the cross
> product.
> 
> Because of this, we need to take care that the lists provided to
> different guests don't overlap; i.e., we need to enforce sane
> configurations. Otherwise, one guest may get access to things like
> secret keys for another guest.
> 
> The idea of this patch set is to introduce a new device, the matrix
> device. This matrix device hangs off a different root and acts as the
> node where mdev devices hang off.
> 
> If you now want to give the tuples (4,1) and (4,2), you need to do the
> following:
> 
> - Unbind the (4,1) and (4,2) tuples from their ap bus driver.
> - Bind the (4,1) and (4,2) tuples to the ap matrix driver.
> - Create the mediated device.
> - Assign card 4 and domains 1 and 2.
> 
> QEMU will now simply consume the mediated device and things should work.
> 

This is probably the shortest possible summary I can imagine.
Tony can you double check if it matches your understanding as well?
