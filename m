Received: from eggs.gnu.org ([2001:4830:134:3::10]:39904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcdkx-0008TM-Uk
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcdkx-0002hJ-7w
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:31:39 -0400
Date: Mon, 9 Jul 2018 18:31:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180709213131.GD7451@localhost.localdomain>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531170180-21199-1-git-send-email-thuth@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jul 09, 2018 at 11:03:00PM +0200, Thomas Huth wrote:
> When trying to "device_add bcm2837" on a machine that is not suitable for
> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio

Interesting, how did you find this bug?

Running "info qtree" and other queries on device-crash-test
sounds like a good idea.  I will add it to my TODO list.

> 
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
>  hotplugged on this machine"}}
> Segmentation fault (core dumped)
> 
> The problem is that qdev_set_parent_bus() from instance_init adds a link
> to the child devices which is not valid anymore after the device init
> failed. Thus the qdev_set_parent_bus() must rather be done in the realize
> function instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
[...]

-- 
Eduardo
