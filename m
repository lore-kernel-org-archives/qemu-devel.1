Received: from eggs.gnu.org ([2001:4830:134:3::10]:43250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwXVE-0006Ud-Nw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwXV9-0004VT-SW
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwXV9-0004VG-Jj
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 13:49:03 -0400
Date: Mon, 25 Sep 2017 14:48:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170925174819.GB3030@localhost.localdomain>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On Mon, Sep 25, 2017 at 04:26:44PM +0100, Peter Maydell wrote:
> On 25 September 2017 at 16:19, Thomas Huth <thuth@redhat.com> wrote:
> > Not sure whether this works for the virtio-xxx-device devices,
> > though, since they are marked as user_creatable = true currently...
> 
> That's deliberate -- for the arm boards with virtio-mmio
> the board creates a bunch of virtio-mmio transports and the
> virtio-foo-device can be user created to plug into those.

Do they support device_add virtio-xxx-device, though?  If they
don't, should we report it as hotpluggable on a future QMP
query-device-type command?

> 
> If overall trying to do the 'right thing' is tricky here
> then perhaps we can start by flipping the default to
> not-hotpluggable and marking some devices hotpluggable
> that in theory shouldn't be with a comment about why.

Finding the full list of those devices is the tricky part.

> 
> Incidentally I think there's still some advantage in the
> "created as part of some other device" devices having
> to be explicitly marked hotpluggable, because those
> devices do still need some specific code in them to
> handle it (ie code to release the resources that are
> created in the device's realize method).

I agree this is still useful.

I was trying represent something different: I was looking for a
flag meaning "supports device_add", while the current meaning is
"supports late instantiation".

On all devices, device_add support requires late instantiation.
On most user-creatable devices, late instantiation support
implies device_add support (virtio-*-device is the only
exception).

This confusion can be solved by documenting
DeviceClass::hotpluggable as "may support device_add, as long as
the machine and bus lets you do it", so there's no harm in
setting it to true on virtio-*-device.

This won't allow us to automatically tell if a device can be
safely instantiated without a hotplug controller, though.

-- 
Eduardo
