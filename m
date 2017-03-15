Received: from eggs.gnu.org ([2001:4830:134:3::10]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co8cB-00080z-5I
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1co8c6-0003Iz-EG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:05:19 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1co8c6-0003I0-8c
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:05:14 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n11so22467674wma.0
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 06:05:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7A85DF989CAE8F42902CF7B31A7D94A139557B8F@shsmsx102.ccr.corp.intel.com>
References: <1489585188-14504-1-git-send-email-yang.zhong@intel.com>
	<f421ff1e-b6a3-e271-57c1-2b8b5fba6d4b@redhat.com>
	<CAFEAcA8D+WwHkzdPVizMo9BZk1wjE7O6uCz7HVY=-KYinohUvA@mail.gmail.com>
	<7A85DF989CAE8F42902CF7B31A7D94A139557B8F@shsmsx102.ccr.corp.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 13:04:52 +0000
Message-ID: <CAFEAcA-PZrnG9M4LWcbzpUUmab=nCJHMjmJa3T+oxHzQSEiaCw@mail.gmail.com>
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
To: "Zhong, Yang" <yang.zhong@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Xu, Anthony" <anthony.xu@intel.com>

On 15 March 2017 at 12:49, Zhong, Yang <yang.zhong@intel.com> wrote:
> So we can omit the cpu-memory address space allocated in the address_space_init_shareable(), which will same around 3M physical memory.

I see what you want to do...

> Maybe the below patch is much better, please help review, thanks!
>
> diff --git a/memory.c b/memory.c
> index 64b0a60..230f2cb 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2422,7 +2422,7 @@ AddressSpace *address_space_init_shareable(MemoryRegion *root, const char *name)
>      AddressSpace *as;
>
>      QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> -        if (root == as->root && as->malloced) {
> +        if (root == as->root && (as->malloced || as == &address_space_memory)) {
>              as->ref_count++;
>              return as;
>          }

...but all the stuff I said below applies to this patch.

> It looks wrong to me. address_space_memory is not allocated via address_space_init_shareable(), so it's not correct to treat it that way (we're implicitly relying on it never being destroyed). It works by accident, not by design.
>
> If we want to support sharing of address spaces which are constant and exist for the lifetime of QEMU then we should probably do it with a new function something like
>     address_space_init_static_shareable()
> which marks the AS as being (1) shareable and (2) invalid to ever try to destroy. Then you could use that for both address_space_memory and address_space_io.

We should not be special casing address_space_memory here:
if you want a mechanism for allowing static "exists for
lifetime of QEMU" address spaces to be included in the
set which can be shared, then you need to create one.

thanks
-- PMM
