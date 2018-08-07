Received: from eggs.gnu.org ([2001:4830:134:3::10]:58343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn3cE-0001js-1d
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn3cC-000421-7H
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:09:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fn3cC-00041j-1V
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:09:40 -0400
Date: Tue, 7 Aug 2018 16:09:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807150935.GL2556@work-vm>
References: <20180720081948.23644-1-remy.noel@blade-group.com>
	<20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
	<20180807145701.GK2556@work-vm>
	<CAFEAcA9mgyCzR7-ANw0YvKdzz-0H50vETrr_sw5bH5D_2PUeNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9mgyCzR7-ANw0YvKdzz-0H50vETrr_sw5bH5D_2PUeNg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, remy.noel@blade-group.com, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 7 August 2018 at 15:57, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Gerd Hoffmann (kraxel@redhat.com) wrote:
> >> On Fri, Jul 20, 2018 at 10:19:48AM +0200, remy.noel@blade-group.com wrote:
> >> > From: "Remy Noel" <remy.noel@blade-group.com>
> >> >
> >> > When removing a secondary-vga device and then adding it back (or adding
> >> > an other one), qemu aborts with:
> >> >     "RAMBlock "0000:00:02.0/vga.vram" already registered, abort!".
> >> >
> >> > It is caused by the vram staying registered, preventing vga replugging.
> >>
> >> David?  Does that look ok?
> >>
> >> This balances the
> >>
> >>      vmstate_register_ram(&s->vram, s->global_vmstate ?  NULL : DEVICE(obj));
> >>
> >> call in vga_common_init().  I'm wondering whenever the manual cleanup is
> >> actually needed in case owner is not NULL?
> >
> > I can't see anyone who is calling unregister_ram or the functions it
> > calls as part of generic device cleanup, so I think it IS needed
> > to manually do it.
> >
> > Which is a bit worrying since we have vastly more register's than
> > unregister's.
> 
> Paolo suggested in an email last month that vmstate_unregister_ram()
> should simply not exist, because it doesn't actually do anything useful:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg01125.html
> 
> (ie it was added in the first place because we'd ended up with
> two identically named ramblocks, but that only happened because
> a reference-counting bug meant we hadn't deleted the first one
> properly before creating the second.)
> 
> So I think that the bug reported in this thread is similar:
> the problem is not that we're not calling vmstate_unregister_ram(),
> but that when the first instance of secondary-vga is removed
> it is not correctly destroying the ramblock.

Ah yes that makes more sense; I remember there was another similar bug
where a device screwed up and didn't delete it's RAM causing similar
problems.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
