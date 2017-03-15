Received: from eggs.gnu.org ([2001:4830:134:3::10]:44353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co6Nr-0005YU-0y
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co6Nq-0008WS-2E
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:42:23 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1co6Np-0008Vx-QT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:42:21 -0400
Received: by mail-wm0-x236.google.com with SMTP id n11so84138945wma.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 03:42:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f421ff1e-b6a3-e271-57c1-2b8b5fba6d4b@redhat.com>
References: <1489585188-14504-1-git-send-email-yang.zhong@intel.com>
	<f421ff1e-b6a3-e271-57c1-2b8b5fba6d4b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 10:41:59 +0000
Message-ID: <CAFEAcA8D+WwHkzdPVizMo9BZk1wjE7O6uCz7HVY=-KYinohUvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, anthony.xu@intel.com

On 15 March 2017 at 08:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 15/03/2017 14:39, Yang Zhong wrote:
>> Since cpu-memory and memory have same address space,one malloced
>> memory is enough. This patch will skip memory malloc for memory
>> address space,which will reduce around 3M physical memory in heap.
>>
>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>> ---
>>  memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/memory.c b/memory.c
>> index 64b0a60..0003b1e 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -2422,7 +2422,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
>>      AddressSpace *as;
>>
>>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>> -        if (root == as->root && as->malloced) {
>> +        if (root == as->root && as == &address_space_memory) {
>
> Of course you need to keep the as->malloced check, don't you?
>
>>              as->ref_count++;
>>              return as;
>>          }
>>
>
> This is not really beautiful, but compared to v1 and v2 it has the
> advantage that it works (with the as->malloced check reintroduced).
> Peter, you introduced address_space_init_shareable, what do you think?

It looks wrong to me. address_space_memory is not allocated
via address_space_init_shareable(), so it's not correct
to treat it that way (we're implicitly relying on it never
being destroyed). It works by accident, not by design.

If we want to support sharing of address spaces which are
constant and exist for the lifetime of QEMU then we should
probably do it with a new function something like
    address_space_init_static_shareable()
which marks the AS as being (1) shareable and (2) invalid
to ever try to destroy. Then you could use that for both
address_space_memory and address_space_io.

thanks
-- PMM
