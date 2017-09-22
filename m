Received: from eggs.gnu.org ([2001:4830:134:3::10]:59386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvNGC-0007XB-H3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvNG7-0002Uy-Ay
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:40:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58588
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dvNG6-0002UY-VU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:40:43 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MCdKnA056059
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:40:39 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d505sj8dm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:40:39 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Sep 2017 13:40:36 +0100
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
	<5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Sep 2017 14:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 09/22/2017 02:13 PM, Pierre Morel wrote:
> On 22/09/2017 10:38, Christian Borntraeger wrote:
>> Instead of unconditionally enabling the KVM AIS capability
>> in the kvm arch init function, do this in the flic realize function
>> when we know if migration is available. This requires to initialize
>> flic before the CPUs.
> 
> I am not sure to agree.
> 
> AIS facility is used for PCI (currently only PCI)
> We want to support PCI emulation and PCI VFIO
> 
> 
> Not having AIS support in the host kernel or not supporting AISM in the host kernel does not affect the emulation.
> Neither virtio-pci nor TCG.
> The only devices, (currently), which can not work without AIS and is not migratable without AISM are PCI VFIO devices.

This patch enable the conditional enablement facility for the KVM host mask. The cpu model enablement is done
differently for KVM and TCG anyway.
Right now AIS is only enabled for KVM. For TCG AIS is not implemented at all and disabled. So for whenever this
is fixed in TCG it can be handled then. 

And for emulated devices under KVM you still need the kernel support - otherwise migration is really broken for
the nimm/dimm values.
