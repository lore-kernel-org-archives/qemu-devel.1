Received: from eggs.gnu.org ([2001:4830:134:3::10]:34031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dkkjo-00030w-Lk
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dkkjl-00080Z-IR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 01:31:28 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1503543783-17192-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7995c721-963c-2552-e1a1-767f461ae63a@redhat.com>
Date: Thu, 24 Aug 2017 07:31:18 +0200
MIME-Version: 1.0
In-Reply-To: <1503543783-17192-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/ide/microdrive: Mark the
 dscm1xxxx device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Cc: qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, qemu-devel@nongnu.org

On 24/08/2017 05:03, Thomas Huth wrote:
> QEMU currently aborts with an assertion message when the user is trying
> to remove a dscm1xxxx again:
> 
> $ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
> QEMU 2.9.93 monitor - type 'help' for more information
> (qemu) device_add dscm1xxxx,id=xyz
> (qemu) device_del xyz
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
> 
> Looks like this device has to be wired up in code and is not meant
> to be hot-pluggable, so let's mark it with user_creatable = false.

The hotpluggable flag should be just a hint from the device, independent
of any knowledge of the board's behavior.  So a better question is why
qbus_is_hotpluggable was true at device_add time (I suppose
qdev_get_hotplug_handler was NULL at device_add time).

BTW, maybe we can get rid of qbus_is_hotpluggable by doing something
like this:

1) This code in device_set_realized:

        hotplug_ctrl = qdev_get_hotplug_handler(dev);
        if (hotplug_ctrl) {
            hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
            if (local_err != NULL) {
                goto fail;
            }
        }

can fail with an error (QERR_DEVICE_NO_HOTPLUG is already there) if
dev->hotplugged && !hotplug_ctrl.

2) In device_add, this code is now superfluous:

    if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
        return NULL;
    }

3) in device_get_hotpluggable, the right side of the && can be replaced
with "qdev_get_hotplug_handler(dev) != NULL", getting rid of
qbus_is_hotpluggable.

Paolo
