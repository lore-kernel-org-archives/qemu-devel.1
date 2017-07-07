Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTTdl-0000DT-Ps
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dTTdk-00040X-Ol
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:49:49 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dTTdk-00040B-H8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:49:48 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so47973563wrb.1
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 06:49:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170707151829.017c9eb2@nial.brq.redhat.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
	<8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
	<CAFEAcA-G6=FfgXrHVE+eUP0YLd9Bp0b26n_0pTiW-joF++BcBg@mail.gmail.com>
	<20170707151829.017c9eb2@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jul 2017 14:49:26 +0100
Message-ID: <CAFEAcA8AF7JZLHwYge7QaG+mJFfqg9tSaDj1yYRHzJ+71Eioow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 7 July 2017 at 14:18, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 6 Jul 2017 17:26:10 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>>  * globally rename memory_region_init_ram to memory_region_init_ram_nomigrate
>>    (and document that it is the caller's job to arrange to migrate the RAM)
> it would be a bit weird when MR created as _nomigrate()
> is then registered with vmstate_register_ram() and being migrated.
>
> maybe other way around, places that don't wanna to use explicit
> vmstate_register_ram() could replace 2 calls with helper memory_region_init_ram_automigrate()

I think this is the wrong way round, because it leads to lots of
bugs. Basically it's really not obvious that you (as the author
of board or device code) need to also call a second function
to not just create a RAM region but also make it work correctly
under migration, and migration is often not tested. Working
through the automatic renames here I've found a small pile of
cases where the memory region was just not registered for
migration at all, or where it was registered using _global()
rather than passing the device as owner (which means the device
can only be created once).

Conversely, the cases which really really want to handle the
migration of the contents of the RAM MemoryRegion themselves
are very few in number, the authors of that code generally
know what they're doing, and the fact that they call a function
named foo_nomigrate() provides them with a helpful clue that
they need to think about and handle migration themselves.

This falls I think under item 7 ("the obvious use is (probably)
the correct one") in Rusty Russell's set of hard-to-misuse API
design guidelines:
http://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

thanks
-- PMM
