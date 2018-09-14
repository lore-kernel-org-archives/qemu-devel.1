Received: from eggs.gnu.org ([2001:4830:134:3::10]:42994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1g0owS-00005M-F9
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1g0owO-0002z8-BC
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1g0owN-0002xH-8P
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:19:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F398C31649B7
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 14:19:20 +0000 (UTC)
Date: Fri, 14 Sep 2018 16:19:07 +0200
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20180914141907.GB13956@beluga.usersys.redhat.com>
References: <20180910064340.30745-1-kraxel@redhat.com>
	<20180910064340.30745-3-kraxel@redhat.com>
	<20180910125409.2b49be3b@t450s.home>
	<20180911043843.egzz6pqe5ouzju3g@sirius.home.kraxel.org>
	<20180912111354.4163d9ce@t450s.home>
	<20180914105009.uemha46ml2m74civ@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180914105009.uemha46ml2m74civ@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] hw/vfio/display: add ramfb
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri, Sep 14, 2018 at 12:50:09PM +0200, Gerd Hoffmann wrote:
>   Hi,
>
> > > Also libvirt manages hotpluggability per device *class*, not per device
> > > *instance*.  So a device being hotpluggable or not depending on some
> > > device property is a problem for libvirt ...
> > >
> > > I'm open to suggestions how to handle this better, as long as the
> > > libvirt people are on board with the approach.
> >
> > Ok, so we need a new class to handle making a device non-hotpluggable,
> > but I'm still not sure whether we should make:
> >
> >  -device vfio-pci-ramfb
> >
> > or
> >
> >  -device vfio-pci-nohotplug,ramfb=on
> >
> > Where ramfb would be a property only available on the nohotplug class
> > variant.
>
> I'm fine with the latter.
>
> > The latter seems to provide a lot more flexibility, but which
> > is more practical for libvirt?
>
> Any comment from the libvirt camp?

We had a discussion about this a few months ago [1] where we spoke about
-device vfio-pci-ramfb. However, as Alex has pointed out, the latter proposal
gives us more flexibility in terms of introduction of other device properties
which are unrelated to ramfb but still might require non-hotpluggable device.
Either way, libvirt needs a capability to test whether we should favour this
new device over plain vfio-pci if an mdev with display='on' is required.
What about new device properties (specifically mdev)? In the discussion below,
Gerd noted that apart from the ramfb stuff and the fact that one can be
hotplugged while the latter can not, these are identical (option-wise), is that
to stay, IOW are we going to keep these two device classes in sync when
introducing new vfio-pci device options or are these going to divert more? Is
it even possible? What I mean by that is that I'd like to avoid is a situation
where there are 2 disjunct sets of options which could potentially lead to
problems in decision making in libvirt and we don't like making decisions.

Anyhow, I don't feel like any of the proposals has a strong
advantage/disadvantage in usage for libvirt, both will require a capability and
both would be special cased in our cmdline code depending on the 'display'
attribute. Luckily, we don't have mdev migration yet, so it's good we don't
have to worry about that at this point yet.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg03430.html

Erik
