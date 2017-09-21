Received: from eggs.gnu.org ([2001:4830:134:3::10]:41075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duySl-0004Si-OP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1duySf-0008F2-Rr
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:12:07 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:53099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1duySf-0008C3-M0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:12:01 -0400
Received: by mail-it0-x230.google.com with SMTP id c195so61777itb.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 03:12:01 -0700 (PDT)
References: <20170921085110.25598-1-aik@ozlabs.ru>
	<5e836306-27bd-a0fd-5bdd-8c8a510bf8eb@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <44820288-1464-de78-8a23-59cf9b945aea@ozlabs.ru>
Date: Thu, 21 Sep 2017 20:11:55 +1000
MIME-Version: 1.0
In-Reply-To: <5e836306-27bd-a0fd-5bdd-8c8a510bf8eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5 00/18] memory: Store physical root
 MR in FlatView
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 21/09/17 20:03, Paolo Bonzini wrote:
> On 21/09/2017 10:50, Alexey Kardashevskiy wrote:
>> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
>> Previous versions:
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01559.html
>> v2: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04069.html
>> v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04523.html
>> v4: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg05669.html
>>
>> This patchset tries to reduce amount of memory used by FlatViews
>> and tries share as many FVs between address spaces as possible.
> 
> Thanks, this looks good!  (Patch 18 indeed is not what I had in mind :)).


Hmmm, then what did you have in mind then?

When clear my backlog a bit, I'd give it a try.

Thanks for the ideas and review.


ps. this could make a semidecent kvm forum talk, could not it? :)

> 
> Paolo
> 
> 
>> Changelog:
>> v5:
>> * removed "memory: Give memory_region_transaction_commit a hint" (broken)
>> * added "memory: Avoid temporary FlatView allocation in a single child case"
>> but I suggest ditching it, it is just there to demonsrate how I checked
>> the suggested idea
>> * updated example of "info mtree -f -d" in 14/18 to demonstrate the result
>>
>> v4:
>> * total rework again to provide grounds for new 15/18, 17/18, 18/18
>>
>> v3:
>> * addressed comments from v2, mainly simplified the code
>>
>> v2:
>> * total rework
>>
>>
>> This is based on sha1
>> c51700273a Peter Maydell "Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170919-v2' into staging".
>>
>> Please comment. Thanks.
>>
>>
>>
>> Alexey Kardashevskiy (18):
>>   exec: Explicitly export target AS from
>>     address_space_translate_internal
>>   memory: Open code FlatView rendering
>>   memory: Move FlatView allocation to a helper
>>   memory: Move AddressSpaceDispatch from AddressSpace to FlatView
>>   memory: Remove AddressSpace pointer from AddressSpaceDispatch
>>   memory: Switch memory from using AddressSpace to FlatView
>>   memory: Cleanup after switching to FlatView
>>   memory: Rename mem_begin/mem_commit/mem_add helpers
>>   memory: Store physical root MR in FlatView
>>   memory: Alloc dispatch tree where topology is generared
>>   memory: Move address_space_update_ioeventfds
>>   memory: Share FlatView's and dispatch trees between address spaces
>>   memory: Do not allocate FlatView in address_space_init
>>   memory: Rework "info mtree" to print flat views and dispatch trees
>>   memory: Share special empty FlatView
>>   memory: Get rid of address_space_init_shareable
>>   memory: Create FlatView directly
>>   memory: Avoid temporary FlatView allocation in a single child case
>>
>>  include/exec/memory-internal.h |  16 +-
>>  include/exec/memory.h          |  76 +++++-----
>>  include/hw/arm/armv7m.h        |   2 +-
>>  cpus.c                         |   5 +-
>>  exec.c                         | 330 ++++++++++++++++++++++++----------------
>>  hw/arm/armv7m.c                |   9 +-
>>  hw/intc/openpic_kvm.c          |   2 +-
>>  memory.c                       | 335 +++++++++++++++++++++++++++++++----------
>>  monitor.c                      |   3 +-
>>  target/arm/cpu.c               |  16 +-
>>  target/i386/cpu.c              |   5 +-
>>  hmp-commands-info.hx           |   7 +-
>>  12 files changed, 533 insertions(+), 273 deletions(-)
>>
> 


-- 
Alexey
