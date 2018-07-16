Received: from eggs.gnu.org ([2001:4830:134:3::10]:42147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ff4Rb-0005sD-C2
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ff4RZ-0000o7-PN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:25:43 -0400
Date: Mon, 16 Jul 2018 11:25:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716142532.GH31657@localhost.localdomain>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
	<20180711183031.GM914@localhost.localdomain>
	<ce0b8bf9-b0e6-fe02-c685-5a6c3140a3ae@redhat.com>
	<20180711202351.GA31657@localhost.localdomain>
	<00130bb8-4dfc-3a76-3f51-9f4c6da891c0@redhat.com>
	<20180712180420.GH31657@localhost.localdomain>
	<87efg3istv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efg3istv.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Mon, Jul 16, 2018 at 08:43:24AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Thu, Jul 12, 2018 at 10:05:46AM +0200, Paolo Bonzini wrote:
> >> On 11/07/2018 22:23, Eduardo Habkost wrote:
> >> > On Wed, Jul 11, 2018 at 10:16:42PM +0200, Paolo Bonzini wrote:
> >> >> On 11/07/2018 20:30, Eduardo Habkost wrote:
> >> >>>> The theoretical behavior should be:
> >> >>> It's not clear below where you expect
> >> >>>   qdev_set_parent_bus(..., sysbus_get_default())
> >> >>> to be called (if it should be called at all).
> >> >>>
> >> >>> I don't know where it should be called, but I'm absolutely sure
> >> >>> instance_init is not the right place.
> >> >>
> >> >> I think instance_init is fine to call qdev_set_parent_bus on contained
> >> >> devices.  Why do you say it's not?
> >> > 
> >> > Because object_unref(object_new(...)) is not supposed to affect
> >> > QEMU global state at all.
> >> 
> >> It should not affect it.  Any changes to the global state done by
> >> instance_init are immediately undone when object_unref destroys the
> >> child properties of the object.
> >
> > I would prefer if it didn't, but not a big deal as long as all
> > QOM code is protected by the BQL (it is, right?).
> >
> > If we get rid of object_new() in qmp_device_list_properties(),
> > then most of the restrictions on instance_init can go away,
> > anyway.
> 
> How could we get rid of object_new()?  As long as we create properties
> in code, we need to run the code to find the properties.

By stopping registering properties at instance_init, and making
them introspectable at the class object.

-- 
Eduardo
