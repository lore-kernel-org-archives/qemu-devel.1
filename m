Received: from eggs.gnu.org ([2001:4830:134:3::10]:38181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et7mB-0007O8-K5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1et7m8-0003EI-G2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:16:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1et7m8-0003E2-Bi
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:16:44 -0500
References: <20180305083655.6186-1-pbonzini@redhat.com>
	<36ea5e9f-a6c8-fc36-34c6-4295f441c5eb@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8de2fd6-a34b-4efa-d3ec-4fbc76c3dac4@redhat.com>
Date: Tue, 6 Mar 2018 09:16:38 +0100
MIME-Version: 1.0
In-Reply-To: <36ea5e9f-a6c8-fc36-34c6-4295f441c5eb@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] memory: address_space_to_flatview
 needs RCU lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 06/03/2018 08:47, Alexey Kardashevskiy wrote:
> On 05/03/18 19:36, Paolo Bonzini wrote:
>> I noticed that the introduction of flatview_{read,write} placed
>> address_space_to_flatview outside the RCU lock.  This is wrong and has
>> to be fixed, because address_space_to_flatview does an atomic_rcu_read.
>> These patches fix this one function at a time.
> 
> out of curiosity - has this caused any actual bug? should be hard to
> reproduce, I suppose...

No, I just noticed it by code inspection, while looking at a
reimplementation of MemoryRegionCache (reverted in 2.9).  One of the
differences between address_space_read and address_space_read_cached was
that the latter expects to be called within rcu_read_lock, so it was
surprising that address_space_read was expecting the same. :)

Paolo
