Received: from eggs.gnu.org ([2001:4830:134:3::10]:42393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6WS-0007Pj-3M
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6WO-00043i-SK
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:12:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dx6WM-00040b-FD
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:12:40 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R7BMpl116326
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:12:09 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d806h2x3b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:12:09 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 08:12:06 +0100
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-3-borntraeger@de.ibm.com>
	<e1b995a5-078a-f2a1-9f3b-6c1ab0ac697b@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 09:12:03 +0200
MIME-Version: 1.0
In-Reply-To: <e1b995a5-078a-f2a1-9f3b-6c1ab0ac697b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5770bcf6-3608-11e7-7f4e-a91f5046c8c1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] s390x/ais: disable ais for compat
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 09/26/2017 03:51 PM, David Hildenbrand wrote:
> On 26.09.2017 15:36, Christian Borntraeger wrote:
>> With newer kernels that do support the ais feature (4.13) a qemu 2.11
>> will not only enable the ais feature for the 2.11 machine, but also
>> for a <=2.10 compat machine. As this feature is not available in
>> QEMU <=2.9 (and QEMU 2.10.1), this guest will fail to migrate
>> back to an older qemu like 2.9 with:
>>
>> _snip_
>> error while loading state for instance 0x0 of device 's390-flic'
>> _snip_
>>
>> making the whole compat machine dis-functional. As a permanent fix, we
>> need to fence the ais feature for machines <= 2.10
>>
>> Due to ais being enabled on 2.10.0 (fixed in 2.10.1) this will prevent
>> migration of ais-enabled guests from 2.10.0 with
>>
>> _snip_
>> qemu-system-s390x: Failed to load s390-flic/ais:tmp
>> qemu-system-s390x: error while loading state for instance 0x0 of device 's390-flic'
>> qemu-system-s390x: load of migration failed: Function not implemented
>> _snip_
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  hw/intc/s390_flic_kvm.c            |  4 +++-
> 
> 
> As discussed, I think we should use cpu_model_allowed() instead.
I think I still prefer the explicit check for ais-enabled to make managedsave
(on the same system) continue to work if the user does not specify a cpu model 
at all (which will then fallback to the host model). We already fence other
things (like guarded storage) and yes it will grow over time but the 
*_allowed things seem to be the smallest maintenance issue in this area.
