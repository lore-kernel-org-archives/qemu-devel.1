Received: from eggs.gnu.org ([2001:4830:134:3::10]:53888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn3Q6-0000sw-Bu
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn3Q1-0005NX-Gz
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:57:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fn3Q1-0005NI-B8
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:57:05 -0400
Date: Tue, 7 Aug 2018 15:57:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807145701.GK2556@work-vm>
References: <20180720081948.23644-1-remy.noel@blade-group.com>
	<20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: remy.noel@blade-group.com, qemu-devel@nongnu.org

* Gerd Hoffmann (kraxel@redhat.com) wrote:
> On Fri, Jul 20, 2018 at 10:19:48AM +0200, remy.noel@blade-group.com wrote:
> > From: "Remy Noel" <remy.noel@blade-group.com>
> > 
> > When removing a secondary-vga device and then adding it back (or adding
> > an other one), qemu aborts with:
> >     "RAMBlock "0000:00:02.0/vga.vram" already registered, abort!".
> > 
> > It is caused by the vram staying registered, preventing vga replugging.
> 
> David?  Does that look ok?
> 
> This balances the
> 
>      vmstate_register_ram(&s->vram, s->global_vmstate ?  NULL : DEVICE(obj));
> 
> call in vga_common_init().  I'm wondering whenever the manual cleanup is
> actually needed in case owner is not NULL?

I can't see anyone who is calling unregister_ram or the functions it
calls as part of generic device cleanup, so I think it IS needed
to manually do it.

Which is a bit worrying since we have vastly more register's than
unregister's.

Dave

> thanks,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
