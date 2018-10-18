Received: from eggs.gnu.org ([2001:4830:134:3::10]:58030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gD3vE-00069r-Ld
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gD3vA-00086x-KT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gD3vA-00080M-CH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 04:44:44 -0400
Date: Thu, 18 Oct 2018 10:44:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181018084441.pgvhx5rirr5vhrj4@sirius.home.kraxel.org>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

> > + * supported address at the moment, other identifiers can be introduced
> > later.
> > + * <DOMAIN> is the PCI domain, followed by <SLOT>.<FUNCTION> of any PCI
> > bridges
> > + * in the chain leading to the device. The last <SLOT>.<FUNCTION> is the
> > + * graphics device.
> 
> Maybe better to specify also the encoding, like decimal/hexadecimal and number
> of digits.

lspci style (i.e. slot is two digits hex, function is one digit).

> > +/**
> > + * spice_qxl_monitor_set_device_display_id:
> > + * @instance the QXL instance to set the device display ID to
> > + * @monitor_id the SPICE monitor ID to set the device display ID to
> > + * @device_display_id the actual ID of the display (output) on the graphics
> > device

Hmm, why do we need the monitor_id here?

The reason to have this function is to allow the guest agent figure
which channel is which head in case we have multiple display channels
registered for one device.

For linux-qxl multihead we don't need this as all heads use the same
display channel, right?

> > +SPICE_GNUC_VISIBLE
> > +void spice_qxl_monitor_set_device_display_id(QXLInstance *instance,
> > +                                             uint32_t monitor_id,
> > +                                             uint32_t device_display_id)
> 
> I still don't understand why, as suggested by Gerd, we need another function
> instead of 2 additional parameters to the above API specifying start and
> number, this API looks much more prone to errors.

We can also just add a device_display_id parameter to the other
function, that should work too.

> Also there's no much documentation for this "device display ID" in the code,
> potentially can be generated with something like:

It's the head index, starting at zero.

cheers,
  Gerd
