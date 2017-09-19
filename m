Received: from eggs.gnu.org ([2001:4830:134:3::10]:56538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duG3s-00027W-R9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duG3p-0008St-Ok
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:47:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duG3p-0008SS-He
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:47:25 -0400
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
	<bdd220a9-7773-74c5-f924-112a6134d13b@redhat.com>
	<9c707630-570a-d7a1-76a4-3ddd5ae0f9b6@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb0004db-6e35-0181-552a-62e133eb7f76@redhat.com>
Date: Tue, 19 Sep 2017 12:47:22 +0200
MIME-Version: 1.0
In-Reply-To: <9c707630-570a-d7a1-76a4-3ddd5ae0f9b6@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v3 01/13] memory: Postpone flatview
 and dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 19/09/2017 12:39, Alexey Kardashevskiy wrote:
>> No, there's still
>>
>>     as->dispatch = NULL;
>>     memory_region_update_pending |= root->enabled;
>>     memory_region_transaction_commit();
>>
>> when creating the address space, which touches all address spaces.
> 
> This does not seem helping a lot - my test without such an optimization
> allocates 2966044 FVs and 2388768 with it, which is just 25%, i.e. worth
> making a patch but yet getting rid of those nasty virtio-modern address
> spaces will do a lot better job.

Have you tried resolving aliases that are implemented with containers
and one subregion?

> What is the exact concern about the "[PATCH qemu v3 01/13] memory: Postpone
> flatview and dispatch tree building till all devices are added"? Is it that
> you missed that modern AS thing in virtio and thought we can do well even
> without it?

I am afraid that some of the special sysbus devices (not PCI, those go
through the bus master DMA region and it's empty on startup) might write
to memory during initialization.

Thanks,

Paolo

> Or there is something wrong with the approach?
