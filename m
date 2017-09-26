Received: from eggs.gnu.org ([2001:4830:134:3::10]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwqGn-0007as-37
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwqGi-00072h-3x
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:51:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwqGh-00072X-Tk
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:51:24 -0400
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-3-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e1b995a5-078a-f2a1-9f3b-6c1ab0ac697b@redhat.com>
Date: Tue, 26 Sep 2017 15:51:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170926133624.155394-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 26.09.2017 15:36, Christian Borntraeger wrote:
> With newer kernels that do support the ais feature (4.13) a qemu 2.11
> will not only enable the ais feature for the 2.11 machine, but also
> for a <=2.10 compat machine. As this feature is not available in
> QEMU <=2.9 (and QEMU 2.10.1), this guest will fail to migrate
> back to an older qemu like 2.9 with:
> 
> _snip_
> error while loading state for instance 0x0 of device 's390-flic'
> _snip_
> 
> making the whole compat machine dis-functional. As a permanent fix, we
> need to fence the ais feature for machines <= 2.10
> 
> Due to ais being enabled on 2.10.0 (fixed in 2.10.1) this will prevent
> migration of ais-enabled guests from 2.10.0 with
> 
> _snip_
> qemu-system-s390x: Failed to load s390-flic/ais:tmp
> qemu-system-s390x: error while loading state for instance 0x0 of device 's390-flic'
> qemu-system-s390x: load of migration failed: Function not implemented
> _snip_
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/intc/s390_flic_kvm.c            |  4 +++-


As discussed, I think we should use cpu_model_allowed() instead.

-- 

Thanks,

David
