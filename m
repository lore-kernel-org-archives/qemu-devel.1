Received: from eggs.gnu.org ([209.51.188.92]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwDy-0004ne-Ff
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwDx-0005di-Mp
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:36:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqwDx-0005dD-Gj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:36:57 -0500
Date: Tue, 5 Feb 2019 09:36:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205083655.w7oyz7q65ifz4z3h@sirius.home.kraxel.org>
References: <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
	<1548859022-3969-3-git-send-email-liam.merwick@oracle.com>
	<20190131080352.nymxlr5nc7xtqiom@sirius.home.kraxel.org>
	<8ba1674d-915d-cd72-bee1-3a0774561318@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba1674d-915d-cd72-bee1-3a0774561318@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] usb: deal with potential Null pointer
 returned by usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, Darren.Kenny@oracle.com, Mark.Kanda@oracle.com, ameya.more@oracle.com

On Mon, Feb 04, 2019 at 11:50:33AM +0000, Liam Merwick wrote:
> On 31/01/2019 08:03, Gerd Hoffmann wrote:
> > On Wed, Jan 30, 2019 at 02:37:02PM +0000, Liam Merwick wrote:
> > > From: Liam Merwick <Liam.Merwick@oracle.com>
> > > 
> > > usb_ep_get() can return a Null pointer in the (albeit unlikely) case
> > > that a NULL USBDevice is passed in via the 'dev' parameter.
> > That should never ever happen.
> > 
> > > Reported by the Parfait static code analysis tool
> > Try add "assert(dev != NULL)" to usb_ep_get() instead of sprinkling
> > pointless checks all over the place.
> > 
> Adding "assert(dev != NULL)" to usb_ep_get() isn't sufficient for that tool
> unless the 'if (dev== NULL)' check is removed which seems a backwards step
> even if that NULL USBDevice case is impossible.

Looked at the code again.

The usb device emulation (hw/usb/dev-*.c) never ever calls usb_ep_get()
with dev == NULL.  There are some places in usb host adapter emulation
(hw/usb/hcd-*) which might do this.  uhci for example has this ...

	[ ... ]
        USBDevice *dev = uhci_find_device(s, (td->token >> 8) & 0x7f);
        USBEndpoint *ep = usb_ep_get(dev, pid, (td->token >> 15) & 0xf);

        if (ep == NULL) {
	[ ... ]

... and uhci_find_device can return NULL.

So, I'd suggest to check all usb_ep_get() callers, fix them if needed,
then remove the 'if (dev== NULL)' check in usb_ep_get() and add the
assert() instead.

cheers,
  Gerd
