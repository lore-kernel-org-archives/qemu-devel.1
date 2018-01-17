Received: from eggs.gnu.org ([2001:4830:134:3::10]:53551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebtU3-0004gj-4u
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebtTz-00069N-6R
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:34:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebtTy-00067V-U9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:34:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB6577CB84
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 19:34:45 +0000 (UTC)
Date: Wed, 17 Jan 2018 21:34:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180117213122-mutt-send-email-mst@kernel.org>
References: <20180117164118.8510-1-berrange@redhat.com>
	<20180117164118.8510-5-berrange@redhat.com>
	<d2b317c1-4ba9-ee88-2f4f-43be23b382a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b317c1-4ba9-ee88-2f4f-43be23b382a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] hw: convert virtio-input-hid device
 to keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Jan 17, 2018 at 01:02:07PM -0600, Eric Blake wrote:
> On 01/17/2018 10:41 AM, Daniel P. Berrange wrote:
> > Replace the keymap_qcode table with automatically generated
> > tables.
> > 
> > Missing entries in keymap_qcode now fixed:
> > 
> 
> > 
> > When a keycode is removed from the list of possible keycodes that host can
> > send to the guest, it means that the guest OS will think it is possible
> > to receive a key that in pratice can never be generated, which is harmless.
> 
> s/pratice/practice/
> 
> > 
> > When a keycode is added to the list of possible keycodes that the host can
> > send to the guest, it means that the guest OS can see an unexpected event.
> > The Linux virtio_input.c driver code simply forwards this event to the
> > input_event() method in the Linux input subsystem. This in turn calls
> > input_handle_event(), which then calls input_get_disposition(). This method
> > checks if the input event is present in the permitted keys bitmap, and if
> > not returns INPUT_IGNORE_EVENT. Thus the unexpected event will get dropped,
> > which is harmless.
> > 
> > If the guest OS reboots, or otherwise re-initializes the virt-input device,
> > it will read the new keycode bitmap. No matter how many keys are defined,
> > the config space has a fixed 128 byte bitmap. There is, however, a size
> > field defiend which says how many bytes in the bitmap are used. So the guest
> 
> s/defiend/defined/
> 
> > OS reads the size of the bitmap, and then it reads the data from bitmap upto
> 
> s/upto/up to/
> 
> > the designated size. So if the guest OS re-initializes at precisely the time
> > that QEMU is migrated across versions, in the worst case, it could conceivably
> > read the old size field, but then get the newly updated bitmap.  If a key were
> > added this is harmless, since it simply means it may not process the newly
> > added key. If a key were removed, then it could be readnig a byte from the
> 
> s/readnig/reading/
> 
> > bitmap that was not initialized. Fortunately QEMU always memsets() the entire
> 
> maybe s/memsets()/memset()s/
> 
> > bitmap to 0, prior to setting keybits. Thus the guest OS will simply read
> > zeros, which is again harmless.
> > 
> > Based on this analysis, it is believed that there is no need to preserve the
> > virtio-input-hid keymaps across migration, as the host<->guest ABI change is
> > harmless and self-resolving at time of guest reboot.
> > 
> > NB, this behaviour should perhaps be formalized in the virtio-input spec
> > to declare how guest OS drivers should be written to be robust in their
> > handling of the potentially changable key bitmaps.
> 
> Your analysis of the issues, as well as the advice to enhance the
> virtio-input spec to document that a guest must not react negatively to
> the change, both sound reasonable.


If anyone has the time to finalize the spec patch and send it to
the virtio tc, that would be very welcome!
IIRC the last revision was
	[virtio-dev] [PATCH v2] Add virtio input device specification.


> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  hw/input/virtio-input-hid.c | 136 +++-----------------------------------------
> >  1 file changed, 9 insertions(+), 127 deletions(-)
> 
> Fun diffstat ratio!
> 
> I have not closely reviewed the series, so much as noticing the grammar
> on the fly.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
