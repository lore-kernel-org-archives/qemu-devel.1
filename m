Received: from eggs.gnu.org ([2001:4830:134:3::10]:34067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ff9UL-0002LD-Ss
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ff9UL-0006e3-12
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 15:48:53 -0400
Date: Mon, 16 Jul 2018 16:48:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716194843.GM31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-4-git-send-email-thuth@redhat.com>
	<20180713212613.GU31657@localhost.localdomain>
	<b4d13b88-e758-2fde-d290-0fdd00b524b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d13b88-e758-2fde-d290-0fdd00b524b2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/16] hw/arm/bcm2836: Fix crash with
 device_add bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Jul 16, 2018 at 09:09:13AM +0200, Thomas Huth wrote:
> On 13.07.2018 23:26, Eduardo Habkost wrote:
> > On Fri, Jul 13, 2018 at 10:27:31AM +0200, Thomas Huth wrote:
> >> When trying to "device_add bcm2837" on a machine that is not suitable for
> >> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
> >>
> >> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
> >>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
> >>  "'arguments': {'command-line': 'info qtree'}}" | \
> >>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio
> >>
> >> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
> >>  "package": "build-all"}, "capabilities": []}}
> >> {"return": {}}
> >> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
> >>  hotplugged on this machine"}}
> >> Segmentation fault (core dumped)
> >>
> >> The qdev_set_parent_bus() from instance_init adds a link to the child devices
> >> which is not valid anymore after the bcm2837 instance has been destroyed.
> >> Unfortunately, the child devices do not get destroyed / unlinked correctly
> >> because both object_initialize() and object_property_add_child() increase
> >> the reference count of the child objects by one, but only one reference
> >> is dropped when the parent gets removed. So let's use the new functions
> >> object_initialize_child() and sysbus_init_child_obj() instead to create
> >> the objects, which will take care of creating the child objects with the
> >> correct reference count of one.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > The usage of &error_abort in code that can be triggered from
> > device-list-properties still makes me nervous, but that's a
> > separate issue.
> 
> I first had similar thoughts, but I think it's a clear coding issue if
> the abort triggers here (and not something that the user should normally
> be able to trigger somehow), so error_abort should be ok in this case.

Agreed.  We don't really have an option, as instance_init can't
report errors.

-- 
Eduardo
