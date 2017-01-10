Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQtkk-0005f5-Qf
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQtkj-0002uE-RX
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:34:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQtkj-0002u4-Lo
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:34:05 -0500
Date: Tue, 10 Jan 2017 10:34:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170110103400.GC2423@work-vm>
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-4-dgilbert@redhat.com>
	<CAFEAcA_5+WJtRSdOjTw+43Y6R_khLcQu5=yG7Hgu1v+KKbr8Rw@mail.gmail.com>
	<20170110092602.GB2423@work-vm>
	<CAFEAcA8rZa7qxFeog=wj2n4umCsjOCqM46m7MDR3PW=Rh8sBug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8rZa7qxFeog=wj2n4umCsjOCqM46m7MDR3PW=Rh8sBug@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 10 January 2017 at 09:26, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Peter Maydell (peter.maydell@linaro.org) wrote:
> >> On 9 January 2017 at 20:13, Dr. David Alan Gilbert (git)
> >> <dgilbert@redhat.com> wrote:
> >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >> >
> >> > Check qdev's call to vmstate_register_with_alias_id; that gets
> >> > most of the common uses; there's hundreds of calls via vmstate_register
> >> > which could get fixed over time.
> >>
> >> Not quite that bad, I think -- I make it just over 50 calls.
> >
> > Well kind of; it seems to be a bit more complicated than that.
> > I'd grep'd for vmstate_register and that gives me ~180 (including
> > stuff in headers).
> 
> Yes, I was specifically looking at the vmstate_register and
> vmstate_register_with_alias_id ones.
> 
> > Only 56 of those are vmstate_register() calls though, 117 are
> > vmstate_register_ram calls which I'd not previously looked at,
> > those call qemu_ram_set_idstr which looks like it suffers from
> > the same problem though.
> 
> They call qemu_ram_set_idstr with the memory region name string,
> though, which is "used for debugging; not visible to the user
> or ABI", so we can just say it's a bug to use a silly name
> and assert if it's too big, right?

qemu_ram_set_idstr already abort's if it hits a dupe (which after
making sure it doesn't overflow the buffer is what we end up with
if we have long names); so yes we already abort in that case.

However, it's a bit optimistic of the memory region to claim the name
is just for debug; Migration/ram.c transmits the RAMBlock's idstr on
the wire (as does postcopy) - so I think the memory.h comment
is wrong.

I don't think it's a big problem since you're unlikely to hit these
big names in practice; but it would be better to return an error
rather than assert/abort since then you wouldn't abort as part
of a hot-add.

So it's worth taking the common cases as this patch does; I don't
think it's worth the hastle of changing 100+ calls though.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
