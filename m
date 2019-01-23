Received: from eggs.gnu.org ([209.51.188.92]:39143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gmKnf-0002ls-CF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sourav.jb1988@gmail.com>) id 1gmKne-0001G9-Ds
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:50:47 -0500
MIME-Version: 1.0
References: <CAAJhNetR-8z37JuOmFDRuq3JfG_S03VDZkciqiKh_kieoqxQ1g@mail.gmail.com>
	<628a94ba-2202-6a15-865b-16d52653288d@redhat.com>
	<CAFEAcA8jvRRpphFS7jvisU+f0SEvU1DOhrBxgKSRWEMkZV3eOw@mail.gmail.com>
In-Reply-To: <CAFEAcA8jvRRpphFS7jvisU+f0SEvU1DOhrBxgKSRWEMkZV3eOw@mail.gmail.com>
From: ksourav <sourav.jb1988@gmail.com>
Date: Wed, 23 Jan 2019 21:20:10 +0530
Message-ID: <CAAJhNeta4fWX7y-ap-CSUhrHDGrZH_Xss6tyDa6=vn_uUJSk0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] object owner argument of
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Thanks for the reply.
Should I send patches for socs using NULL owner to qemu-trivial@nongnu.org ?

I have been reading qemu source code for soc and different device
implementation for past few days to understand qemu internals.
While I have a rough idea of qemu object model, I would like to have your input.
If someone has to learn about qemu object model or soc implementation,
what would be the correct way ?
So far I have implemented a minimal platform device and experimented
with it using linux driver on qemu. But I am wondering is there any
other way of doing things to develop understanding.

Thanks in Advance

On Wed, Jan 23, 2019 at 4:23 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 23 Jan 2019 at 06:10, Thomas Huth <thuth@redhat.com> wrote:
> > On 2019-01-23 04:07, ksourav wrote:
> > > I am trying to learn how qemu implements different soc.
> > > While reading the source code, I found that in some socs, object owner
> > > is passed as NULL to the routine memory_region_init_ram() (for example
> > > in nrf51 soc) and in some socs(for example in Allwinner A10) an
> > > object(non NULL) is passed to memory_region_initi_ram().
> > > When I checked docs/devel/memory.txt, I found below lines.
> > > "For regions that "have no owner" (NULL is passed at creation time), the
> > > machine object is actually used as the owner."
> > > Is the machine object refers to the actual board instance that will
> > > use the soc? For example microbit in case of nrf51 soc ?
> > > Is there any reason of not passing object as owner or in other words,
> > > when do we pass NULL or an object to memory_region_initi_ram() ?
> >
> > I'm not an expert here, but when you look at the description of
> > memory_region_init_ram() in include/exec/memory.h:
> >
> >  * @owner: the object that tracks the region's reference count (must be
> >  *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
> >
> > So if you're calling memory_region_init_ram() from a device's
> > instance_init() or realize() function, you should use the current device
> > state as owner. But if you want to call the function from a
> > MachineClass->init function instead already, you don't have a
> > DeviceState* yet, so you have to use NULL there.
>
> Yes. Also old-style boards which don't use MachineState directly
> will pass a NULL owner, as will very old non-QOM devices, and
> probably one or two devices with bugs. Don't copy those examples :-)
> (the nrf51_soc you mention above is an example of a bug.)
>
> The reason the owner matters here is so we clean things up correctly
> when the device goes away. So for a machine model it doesn't matter
> because the machine is never destroyed. For an SoC, that is also
> typically never destroyed and so bugs where the owner was not set
> easily go unnoticed. But there is a corner case where the user can
> introspect an object, which causes a temporary copy to go through
> instance_init, which can result in leaks if ownership is wrong.
>
> We really need to make sure we have a good grasp of this kind of
> thing and write it up somewhere (in particular the object life cycle,
> what can or should be done in instance_init, how things need to
> be parented to ensure there are no leaks, etc.)
>
> thanks
> -- PMM
