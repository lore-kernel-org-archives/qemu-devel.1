Received: from eggs.gnu.org ([209.51.188.92]:46538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmG9n-0001VL-Gw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmG9l-0002NJ-E8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:53:19 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmG9l-0002Lf-7s
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:53:17 -0500
Received: by mail-ot1-x336.google.com with SMTP id s13so1517923otq.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 02:53:13 -0800 (PST)
MIME-Version: 1.0
References: <CAAJhNetR-8z37JuOmFDRuq3JfG_S03VDZkciqiKh_kieoqxQ1g@mail.gmail.com>
	<628a94ba-2202-6a15-865b-16d52653288d@redhat.com>
In-Reply-To: <628a94ba-2202-6a15-865b-16d52653288d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jan 2019 10:53:01 +0000
Message-ID: <CAFEAcA8jvRRpphFS7jvisU+f0SEvU1DOhrBxgKSRWEMkZV3eOw@mail.gmail.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: ksourav <sourav.jb1988@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 23 Jan 2019 at 06:10, Thomas Huth <thuth@redhat.com> wrote:
> On 2019-01-23 04:07, ksourav wrote:
> > I am trying to learn how qemu implements different soc.
> > While reading the source code, I found that in some socs, object owner
> > is passed as NULL to the routine memory_region_init_ram() (for example
> > in nrf51 soc) and in some socs(for example in Allwinner A10) an
> > object(non NULL) is passed to memory_region_initi_ram().
> > When I checked docs/devel/memory.txt, I found below lines.
> > "For regions that "have no owner" (NULL is passed at creation time), the
> > machine object is actually used as the owner."
> > Is the machine object refers to the actual board instance that will
> > use the soc? For example microbit in case of nrf51 soc ?
> > Is there any reason of not passing object as owner or in other words,
> > when do we pass NULL or an object to memory_region_initi_ram() ?
>
> I'm not an expert here, but when you look at the description of
> memory_region_init_ram() in include/exec/memory.h:
>
>  * @owner: the object that tracks the region's reference count (must be
>  *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
>
> So if you're calling memory_region_init_ram() from a device's
> instance_init() or realize() function, you should use the current device
> state as owner. But if you want to call the function from a
> MachineClass->init function instead already, you don't have a
> DeviceState* yet, so you have to use NULL there.

Yes. Also old-style boards which don't use MachineState directly
will pass a NULL owner, as will very old non-QOM devices, and
probably one or two devices with bugs. Don't copy those examples :-)
(the nrf51_soc you mention above is an example of a bug.)

The reason the owner matters here is so we clean things up correctly
when the device goes away. So for a machine model it doesn't matter
because the machine is never destroyed. For an SoC, that is also
typically never destroyed and so bugs where the owner was not set
easily go unnoticed. But there is a corner case where the user can
introspect an object, which causes a temporary copy to go through
instance_init, which can result in leaks if ownership is wrong.

We really need to make sure we have a good grasp of this kind of
thing and write it up somewhere (in particular the object life cycle,
what can or should be done in instance_init, how things need to
be parented to ensure there are no leaks, etc.)

thanks
-- PMM
