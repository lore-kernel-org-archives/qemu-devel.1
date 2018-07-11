Received: from eggs.gnu.org ([2001:4830:134:3::10]:38748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdJsu-0008Gr-KM
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdJst-0003kW-SA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 14:30:40 -0400
Date: Wed, 11 Jul 2018 15:30:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180711183031.GM914@localhost.localdomain>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Wed, Jul 11, 2018 at 07:20:42PM +0200, Paolo Bonzini wrote:
> On 09/07/2018 23:03, Thomas Huth wrote:
> > 
> > The problem is that qdev_set_parent_bus() from instance_init adds a link
> > to the child devices which is not valid anymore after the device init
> > failed. Thus the qdev_set_parent_bus() must rather be done in the realize
> > function instead.
> 
> The theoretical behavior should be:

It's not clear below where you expect
  qdev_set_parent_bus(..., sysbus_get_default())
to be called (if it should be called at all).

I don't know where it should be called, but I'm absolutely sure
instance_init is not the right place.

> 
> - realize fails
> 
> - object_unparent is called on the device that failed to realize (see
> qdev_device_add).  object_unparent calls device_unparent
> 
> - after device_unparent finishes, the last reference to the device has
> been dropped and the device is freed
> 
> - object finalization releases all properties
> 
> - this includes child properties, so for each child device
> object_unparent is called
> 
> - again device_unparent is called (for the child) and this removes the
> child from the bus.
> 
> Paolo

-- 
Eduardo
