Received: from eggs.gnu.org ([2001:4830:134:3::10]:52712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duFw3-0003X8-C6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duFw0-0004RO-8p
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:39:23 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:47145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duFw0-0004QO-1t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:39:20 -0400
Received: by mail-pg0-x22f.google.com with SMTP id d8so1789426pgt.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 03:39:18 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-2-aik@ozlabs.ru>
	<c01622e7-3e6d-cf90-a28c-aa31b4857887@redhat.com>
	<2debed31-4c28-6dc3-b159-1fdc3fbf87f5@ozlabs.ru>
	<a85cbaf9-d7c7-403b-2dfc-886f9ddc0920@ozlabs.ru>
	<bdd220a9-7773-74c5-f924-112a6134d13b@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9c707630-570a-d7a1-76a4-3ddd5ae0f9b6@ozlabs.ru>
Date: Tue, 19 Sep 2017 20:39:13 +1000
MIME-Version: 1.0
In-Reply-To: <bdd220a9-7773-74c5-f924-112a6134d13b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 19/09/17 17:42, Paolo Bonzini wrote:
> On 19/09/2017 08:57, Alexey Kardashevskiy wrote:
>>>> 2) also, after patch 2 you know that the address space has no listeners
>>>> here, so the begin/commit isn't really needed.  Instead you can use the
>>>> open-coded loop to directly generate the FlatView.  This avoids touching
>>>> _all_ address spaces, which is already an improvement from O(n^2) to
>>>> O(n) rebuilds on device startup.
>> 03/13 does this already, no?
>>
> 
> No, there's still
> 
>     as->dispatch = NULL;
>     memory_region_update_pending |= root->enabled;
>     memory_region_transaction_commit();
> 
> when creating the address space, which touches all address spaces.


This does not seem helping a lot - my test without such an optimization
allocates 2966044 FVs and 2388768 with it, which is just 25%, i.e. worth
making a patch but yet getting rid of those nasty virtio-modern address
spaces will do a lot better job.

What is the exact concern about the "[PATCH qemu v3 01/13] memory: Postpone
flatview and dispatch tree building till all devices are added"? Is it that
you missed that modern AS thing in virtio and thought we can do well even
without it? Or there is something wrong with the approach?



-- 
Alexey
