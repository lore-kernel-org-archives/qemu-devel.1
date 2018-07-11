Received: from eggs.gnu.org ([2001:4830:134:3::10]:37767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdHj8-000199-0H
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdHj6-00051p-RI
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:12:25 -0400
Date: Wed, 11 Jul 2018 13:12:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180711161216.GV7451@localhost.localdomain>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
	<931c0545-e3d8-fc84-9b69-59fab040265c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931c0545-e3d8-fc84-9b69-59fab040265c@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Wed, Jul 11, 2018 at 09:21:48AM +0200, Thomas Huth wrote:
> On 10.07.2018 08:50, Peter Maydell wrote:
> > On 9 July 2018 at 23:03, Thomas Huth <thuth@redhat.com> wrote:
> >> On 09.07.2018 23:42, Peter Maydell wrote:
> >>> On 9 July 2018 at 22:03, Thomas Huth <thuth@redhat.com> wrote:
> >>>> When trying to "device_add bcm2837" on a machine that is not suitable for
> >>>> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
> >>>>
> >>>> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
> >>>>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
> >>>>  "'arguments': {'command-line': 'info qtree'}}" | \
> >>>>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio
> >>>>
> >>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
> >>>>  "package": "build-all"}, "capabilities": []}}
> >>>> {"return": {}}
> >>>> {"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
> >>>>  hotplugged on this machine"}}
> >>>> Segmentation fault (core dumped)
> >>>>
> >>>> The problem is that qdev_set_parent_bus() from instance_init adds a link
> >>>> to the child devices which is not valid anymore after the device init
> >>>> failed. Thus the qdev_set_parent_bus() must rather be done in the realize
> >>>> function instead.
> >>>
> >>> Yuck. The real problem here is that we're still requiring the
> >>> code that creates these QOM devices to manually set the parent
> >>> in the first place. It's not surprising that we don't get it right
> >>> (either parenting in the wrong place or not at all). I'd much
> >>> rather see us fix that properly than keep papering over places
> >>> where we get it wrong.
> >>
> >> Sorry, I'm still not an expert in all this QOM stuff yet ... so what do
> >> you exactly recommend to do instead?
> > 
> > I'm not clear either, but I don't think that what we're
> > currently doing can be right.
> 
> Hm, ok, so how to continue here now? Shall we at least mark the
> bcm2836/7 devices with user_creatable=false, so that users can not crash
> their QEMU so easily with device_add? The problem with introspection via
> device-list-properties would still continue to exist, but I think that's
> less likely used in practice... otherwise we could still move the
> qdev_set_parent_bus() calls to the realize() function instead, and just
> add a big fat FIXME comment in front of the code block, so that we
> remember to clean that up one day...

Crashing device-list-properties should be a blocker bug, IMO.

Moving to realize is not the best solution, but I would prefer to
do that in 3.0 instead of leaving the device-list-properties
crash unfixed.

Another solution is to reintroduce
DeviceClass::cannot_destroy_with_object_finalize_yet (commit
08f00df4f4b8b4e38ad620477cc90cf5f73832d9), and set
cannot_destroy_with_object_finalize_yet=true on bcm2837.

-- 
Eduardo
