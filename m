Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdInQ-0006I9-Ez
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdInP-0001Sd-OW
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:20:56 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
Date: Wed, 11 Jul 2018 19:20:42 +0200
MIME-Version: 1.0
In-Reply-To: <1531170180-21199-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 09/07/2018 23:03, Thomas Huth wrote:
> 
> The problem is that qdev_set_parent_bus() from instance_init adds a link
> to the child devices which is not valid anymore after the device init
> failed. Thus the qdev_set_parent_bus() must rather be done in the realize
> function instead.

The theoretical behavior should be:

- realize fails

- object_unparent is called on the device that failed to realize (see
qdev_device_add).  object_unparent calls device_unparent

- after device_unparent finishes, the last reference to the device has
been dropped and the device is freed

- object finalization releases all properties

- this includes child properties, so for each child device
object_unparent is called

- again device_unparent is called (for the child) and this removes the
child from the bus.

Paolo
