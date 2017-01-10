Received: from eggs.gnu.org ([2001:4830:134:3::10]:58652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQtvI-0000iR-K3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQtvH-00071o-PO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:45:00 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:34738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQtvH-00070F-AM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:44:59 -0500
Received: by mail-ua0-x231.google.com with SMTP id 35so49961969uak.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 02:44:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170110103400.GC2423@work-vm>
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-4-dgilbert@redhat.com>
	<CAFEAcA_5+WJtRSdOjTw+43Y6R_khLcQu5=yG7Hgu1v+KKbr8Rw@mail.gmail.com>
	<20170110092602.GB2423@work-vm>
	<CAFEAcA8rZa7qxFeog=wj2n4umCsjOCqM46m7MDR3PW=Rh8sBug@mail.gmail.com>
	<20170110103400.GC2423@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 10:44:37 +0000
Message-ID: <CAFEAcA8ek-VPxFx4g+mDS2JEwY-VywUYojTtDQ5LMsG70UnfyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/3] vmstate registration: check return
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

On 10 January 2017 at 10:34, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> However, it's a bit optimistic of the memory region to claim the name
> is just for debug; Migration/ram.c transmits the RAMBlock's idstr on
> the wire (as does postcopy) - so I think the memory.h comment
> is wrong.

We'd better fix that, then, or we'll find ourselves breaking
migration compat by accident...

> I don't think it's a big problem since you're unlikely to hit these
> big names in practice; but it would be better to return an error
> rather than assert/abort since then you wouldn't abort as part
> of a hot-add.

Almost all of the calls aren't going to be hot-add, though.

> So it's worth taking the common cases as this patch does; I don't
> think it's worth the hastle of changing 100+ calls though.

You also have the code paths via memory_region_allocate_system_memory
which end up calling vmstate_register_ram_global which then calls
qemu_ram_set_idstr -- none of that has support for returning an
error.

(Aside: at some point I want to introduce a
memory_region_allocate_aux_memory() which wraps the common
pattern
    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
    vmstate_register_ram_global(mr);
so we have a simple way to create RAM blocks which aren't
the main system ram, by analogy with memory_region_allocate_system_memory().)

thanks
-- PMM
