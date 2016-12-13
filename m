Received: from eggs.gnu.org ([2001:4830:134:3::10]:36926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cGl3K-0002mv-3V
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cGl3F-0005G1-2a
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:15:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cGl3E-0005Fk-SC
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:15:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so17674977wme.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 03:15:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-9-pbonzini@redhat.com>
	<20161212141728.GI4074@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95bed9f0-3167-2d84-b7ac-de149bfc544f@redhat.com>
Date: Tue, 13 Dec 2016 12:14:14 +0100
MIME-Version: 1.0
In-Reply-To: <20161212141728.GI4074@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] virtio: use MemoryRegionCache to
 access descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: borntraeger@de.ibm.com, famz@redhat.com, qemu-devel@nongnu.org, mst@redhat.com



On 12/12/2016 15:17, Stefan Hajnoczi wrote:
>>      unsigned int total_bufs, in_total, out_total;
>> -    void *desc_ptr = NULL;
>> -    hwaddr len = 0;
>> +    MemoryRegionCache *desc_cache = NULL;
>> +    MemoryRegionCache vring_desc_cache;
>> +    MemoryRegionCache indirect_desc_cache;
>> +    int64_t len = 0;
>>      int rc;
>>  
>> +    rcu_read_lock();
>
> Please document the purpose of the rcu_read_lock() in virtio code.

Wrong patch, this should be in patch 10 (and then the answer is simply
that VRingMemoryRegionCaches is protected by RCU).

> Also, do the goto err cases call rcu_read_unlock()?

Yes, it does; the err label ends with a "goto done".

Paolo
