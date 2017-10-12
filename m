Received: from eggs.gnu.org ([2001:4830:134:3::10]:51374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2Zkr-0008UL-PP
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2Zko-0003uJ-1M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2Zkn-0003sZ-Qv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:26:09 -0400
Message-ID: <1507800365.26812.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 12 Oct 2017 11:26:05 +0200
In-Reply-To: <e25a3501923944fbad8e3a560c5cf8f3@AMSPEX02CL03.citrite.net>
References: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
	<1506437019-17946-4-git-send-email-owen.smith@citrix.com>
	<20171002170132.GA2116@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710101651560.3105@sstabellini-ThinkPad-X260>
	<20171011154718.GQ1771@perard.uk.xensource.com>
	<alpine.DEB.2.10.1710111309400.3105@sstabellini-ThinkPad-X260>
	<e25a3501923944fbad8e3a560c5cf8f3@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 3/3 v4] xenfb: Add
 [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, 'Stefano Stabellini' <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Owen Smith <owen.smith@citrix.com>

  Hi,

> It's probably OS specific though. I guess the behaviour changed
> because the OS favours absolute pointing devices over relative ones
> and how it has two absolute ones to choose from. How it reconciles
> those, who knows?

Typically hid emulation calls qemu_input_handler_activate() when the
guest initializes the device, which moves the device to the top of the
priority list.

Visible effect on a typical guest with ps/2 mouse and usb-tablet is
that qemu switches from relative mode (mouse) to absolute mode (tablet)
 when the guest loads the usb hid driver.

I suspect pvmouse is doing the same thing.  So it may simply depend on
guest driver load order whenever pvmouse or usb-tablet is used.

Simplest fix is probably to only attach the device you plan to use to
the guest.  If you can't turn off pvmouse for xen guests then you might
want drop the qemu_input_handler_activate() call, so it behaves simliar
to the ps/2 mouse (is used in case no other pointer device is present).

HTH,
  Gerd
