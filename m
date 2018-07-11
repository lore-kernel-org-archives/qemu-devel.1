Received: from eggs.gnu.org ([2001:4830:134:3::10]:55463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdLGv-00068H-1W
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdLGu-0004GP-3z
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:59:33 -0400
Date: Wed, 11 Jul 2018 16:59:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180711195924.GC7451@localhost.localdomain>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
	<CAFEAcA9GspXJg2ioLrCknBgYHJ9f6qvM=n=y0dLeU12yv_5ETA@mail.gmail.com>
	<955f26d7-5a0b-28e0-bd0f-f663593afefe@redhat.com>
	<1be41104-d896-b03b-e0f3-47ea9c3b333f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be41104-d896-b03b-e0f3-47ea9c3b333f@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Wed, Jul 11, 2018 at 09:04:35PM +0200, Thomas Huth wrote:
> On 11.07.2018 19:21, Paolo Bonzini wrote:
> > On 10/07/2018 08:50, Peter Maydell wrote:
> >>>> Yuck. The real problem here is that we're still requiring the
> >>>> code that creates these QOM devices to manually set the parent
> >>>> in the first place. It's not surprising that we don't get it right
> >>>> (either parenting in the wrong place or not at all). I'd much
> >>>> rather see us fix that properly than keep papering over places
> >>>> where we get it wrong.
> >>> Sorry, I'm still not an expert in all this QOM stuff yet ... so what do
> >>> you exactly recommend to do instead?
> >> I'm not clear either, but I don't think that what we're
> >> currently doing can be right.
> > 
> > Well, in theory it should work...  I sent the expected flow in another email.
> 
> Something that just came to my mind:
> 
> bcm2836_init() creates the TYPE_BCM2835_PERIPHERALS object with
> object_initialize(). This creates one reference to the object already.
> Then the object is linked to its parent with
> object_property_add_child(), which creates another reference to the
> object. But where are the two references correctly destroyed again? One
> is certainly destroyed by device_unparent later, but the initial one?
> Could it be that we are simply lacking one object_unref() after the
> object_property_add_child() here?

This seems to be true, but I'm confused about the reference
counting model, here:

What exactly guarantees there will be no other references to
(e.g.) `&s->control` when `s` is freed?

We know the references added by object_initialize(),
object_property_add_child() and qdev_set_parent_bus() will be
dropped, but what about other code calling object_ref()?

-- 
Eduardo
