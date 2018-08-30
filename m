Received: from eggs.gnu.org ([2001:4830:134:3::10]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fvL9t-0001z5-He
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 07:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fvL88-0003zt-ON
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 07:28:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fvL87-0003zF-Be
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 07:28:51 -0400
Date: Thu, 30 Aug 2018 13:28:49 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180830112849.medou3o5rrpbymj6@sirius.home.kraxel.org>
References: <20180720081948.23644-1-remy.noel@blade-group.com>
	<20180807131918.22bgcmfv2wu4bjda@sirius.home.kraxel.org>
	<20180807145701.GK2556@work-vm>
	<CAFEAcA9mgyCzR7-ANw0YvKdzz-0H50vETrr_sw5bH5D_2PUeNg@mail.gmail.com>
	<20180807150935.GL2556@work-vm>
	<3d89d87f-857d-ebb1-1fe7-710a52ea381d@blade-group.com>
	<d7592b8a-ccf3-7d68-9fce-30a80fa58bce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7592b8a-ccf3-7d68-9fce-30a80fa58bce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] secondary-vga: unregister vram on unplug.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Remy NOEL <remy.noel@blade-group.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > Thanks for the feedback, after closer inspection, the secondary-vga
> > refcount does, indeed, never reach 0.
> > 
> > I noticed the bug was not present in v2.12.0 and had been visible since
> > 93abfc88bd649de1933588bfc7175605331b3ea9
> > (https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07547.html).
> > 
> > This patch causes the secondary-vga object to be referenced by its
> > subregions (mrs) which are themselves referenced by its mmio region
> > which is referenced by the device causing a reference loop.
> > We should probably break this loop upon exit, however, i am not sure
> > whether we should deletes the subregions or delete the mmio properly.
> 
> I'll take a look...

Ping, any results?

I'm wondering whenever we should just revert
93abfc88bd649de1933588bfc7175605331b3ea9.

Retested hotplug with 93abfc88bd649de1933588bfc7175605331b3ea9 reverted.
Works just fine with guest kernel loaded.  Doesn't work without guest
booted (grub prompt for example), but pci hotplug requires guest
cooperation so this isn't a bug in secondary-vga ...

cheers,
  Gerd
