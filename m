Received: from eggs.gnu.org ([2001:4830:134:3::10]:38314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9y4-0005JX-EY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9y0-00059Y-Gn
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:49:28 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dT9y0-00059C-9e
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:49:24 -0400
Received: by mail-wr0-f174.google.com with SMTP id k67so10532025wrc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 09:49:24 -0700 (PDT)
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
	<8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
	<CAFEAcA-G6=FfgXrHVE+eUP0YLd9Bp0b26n_0pTiW-joF++BcBg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f24131b0-4fbb-8f65-d9d4-703fd8bce1b2@redhat.com>
Date: Thu, 6 Jul 2017 18:49:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-G6=FfgXrHVE+eUP0YLd9Bp0b26n_0pTiW-joF++BcBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add new utility function
 memory_region_allocate_aux_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 06/07/2017 18:26, Peter Maydell wrote:
> 
> I think that to avoid getting tangled up in trying to fix
> or deal with these handful of oddball cases at the same time
> as doing a global change to the easy cases, we should:
> 
>  * globally rename memory_region_init_ram to memory_region_init_ram_nomigrate
>    (and document that it is the caller's job to arrange to migrate the RAM)
>  * add new memory_region_init_ram which does memory_region_init_ram_nomigrate
>    + vmstate_register_ram
>  * coccinelle patch to switch to using that new function where possible
>  * get that lot committed, because it touches so many files and
>    is a recipe for conflicts
>  * look at the remaining handful of _nomigrate calls and perhaps
>    switch them where that would be a bug fix
> 
> Q: should we have _nomigrate versions of any of the other
> memory_region_init_ram* functions? I think it makes sense
> for only the basic _init_ram to do the migration for you,
> because that's the only case where the memory system is
> creating the backing storage for the caller, rather than the
> caller passing in the backing storage.

memory_region_init_ram_from_file theoretically would also fit this
description, but all of its callers would use the _nomigrate version.

Paolo

> "Be consistent for
> the full set of functions" would be the other obvious approach;
> I don't think I care too much either way.
