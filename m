Received: from eggs.gnu.org ([2001:4830:134:3::10]:45620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dajZ9-00089r-TY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dajZ8-0003Pp-OT
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:15:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dajZ8-0003No-Ef
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:15:02 -0400
Date: Thu, 27 Jul 2017 16:14:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170727161457.58b3c7d1@gondolin>
In-Reply-To: <316dd24e-cc45-8469-dd23-491c8b15480e@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<316dd24e-cc45-8469-dd23-491c8b15480e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, pmorel@linux.vnet.ibm.com

On Thu, 27 Jul 2017 15:37:08 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 07/27/2017 01:59 PM, Cornelia Huck wrote:
> > On Thu, 27 Jul 2017 03:54:18 +0200
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> >> When a channel path is hot plugged into a CSS, we should generate
> >> a channel path initialized CRW (channel report word). The current
> >> code does not do that, instead it puts a stub function with a TODO
> >> reminder there.
> >>
> >> This implements the css_generate_chp_crws() function by:
> >> 1. refactor the existing code.
> >> 2. add an @add parameter to provide future callers with the
> >>    capability of generating channel path permanent error with
> >>    facility not initialized CRW.
> >> 3. add a @hotplugged parameter, so to opt out generating initialized
> >>    CRWs for predefined channel paths.  
> > 
> > I'm not 100% sure whether the logic is correct here. Let me elaborate:
> > 
> > The current code flow when hotplugging a device is:
> > - Generate the schib.
> > - Check if any of the chpids refers to a not yet existing channel path;
> >   generate it if that is the case.
> > - Post a crw for the subchannel.
> > 
> > The second step is where the current code seems to be not quite correct
> > already. It is fine for coldplugged devices, but I really think we need
> > to make sure that all referenced channel paths are in place before we
> > hotplug a new device. It was not really relevant when we just had one
> > very virtual channel path, and 3270 is experimental so it is not a
> > problem in practice.  
> 
> What do you mean by not quite correct?  Are we somewhere in conflict with
> the AR (if yes could you give me a pointer)? Or is it a modeling concern?
> Or is it about the user interface design? Or any combination of these?

Modeling. Conceptually, you need at least one channel path to access a
device; the subchannel is more or less a followup.

As up to now, we only had a dummy channel path simply to satisfy the
architecture, it did not really matter when it was 'created'. As it is
always 'there' from beginning, there was no need for any CRW either. If
there's now a need for real channel path modeling, we unfortunately
have to give this some thought :)

> 
> > 
> > This, of course, implies we need deeper changes. We need to create the
> > channel paths before the subchannel is created and refuse hotplug of a
> > device if not all channel paths it needs are defined. This means we
> > need some things before we can claim real channel path support:
> > - Have a way to specify channel paths on the command line resp. when
> >   hotplugging. This implies they need to be real objects.
> > - Have a way to specify which channel paths belong to a subchannel in
> >   the same context. Keep existing device types working with the current
> >   method.
> > - Give channel paths states: Defined, configured. The right time for a
> >   CRW is the transition between those states.
> > - Only queue a 'device come' CRW for a subchannel if at least one of
> >   its channel paths is in the configured state. Detach or make not
> >   operational a subchannel if all of its paths are deconfigured.
> >   
> 
> AFAIU in your opinion our model is to simple and needs to get more
> complex. What benefits do we expect from the added complexity? I mean
> our current model works (and I'm not sure what limitations do we
> want to get rid of, or even what are the relevant limitations we have.)

I was under the impression that we want to support multiple, 'real'
channel paths for vfio-ccw. Did I misunderstand?

> 
> > Something along those lines also matches better what I've seen on z/VM
> > or LPAR. I realize that it's not easy :(
> > 
> > tl;dr: I don't think we want chp crws until after we have a good chp
> > model.  
> 
> I fully agree with this point.

Great.
