Received: from eggs.gnu.org ([2001:4830:134:3::10]:52346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTlVl-0001xJ-Qh
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTlVk-0007mq-Bn
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:59:17 -0400
Date: Fri, 15 Jun 2018 11:59:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615115912.59bae274@redhat.com>
In-Reply-To: <3ba714d3-2031-5ddd-d21a-afdaee97f685@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-8-david@redhat.com>
	<20180613150320.3d6d11ca@redhat.com>
	<430ef63d-0e9b-5925-5d5a-b6804ec7d988@redhat.com>
	<045b1a53-fdf2-36db-2898-cfee0849232a@redhat.com>
	<20180614170051.62104d16@redhat.com>
	<3ba714d3-2031-5ddd-d21a-afdaee97f685@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu, 14 Jun 2018 17:11:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 14.06.2018 17:00, Igor Mammedov wrote:
> > On Wed, 13 Jun 2018 16:50:54 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 13.06.2018 16:07, David Hildenbrand wrote:  
> >>> On 13.06.2018 15:03, Igor Mammedov wrote:    
> >>>> On Mon, 11 Jun 2018 14:16:51 +0200
> >>>> David Hildenbrand <david@redhat.com> wrote:
> >>>>    
> >>>>> We already verify when realizing that the memdev property has been
> >>>>> set. We have no more accesses to get_memory_region() before the device
> >>>>> is realized.    
> >>>> this stems from assumption that get_memory_region shouldn't be called
> >>>> before devices realize is executed, which I don't agree to begin with.
> >>>>
> >>>> However wrt error handling, we should probably leave device internal error
> >>>> up to devices and make check for error only in pre_plug handler
> >>>> (since pre_plug was successful, the rest machine helpers would have
> >>>> access to the same region until device is removed.
> >>>>    
> >>>
> >>> Something like a generic Device "validate()"/"pre_realize()" function,
> >>> that can be called before realize() and validates all properties
> >>> (+initializes derived properties) would be something I could agree to.
> >>>
> >>> Then we could drop all error handling from access functions (as they
> >>> have been validated early during pre_plug())
> >>>
> >>> Moving all checks out of realize into pre_plug() looks ugly, because we
> >>> have implementation details split across c-files.
> >>>     
> >>
> >> I am thinking about something like this
> >>
> >> From ee8da4f5774ff5fa190466674e36ee99020033c4 Mon Sep 17 00:00:00 2001
> >> From: David Hildenbrand <david@redhat.com>
> >> Date: Wed, 13 Jun 2018 16:41:12 +0200
> >> Subject: [PATCH RFC] device: add "prepare()" function
> >>
> >> The realize() function usually does several things. It validates
> >> properties, inititalizes state based on properties and performs
> >> e.g. registrations in the system that require "unrealize()" to be called
> >> when removing the device.
> >>
> >> In a pre_plug hotplug handler, we usually want to access certain
> >> properties or derived properties, e.g. to perform advanced checks
> >> (for resource asignment). Now we have the problem, that realize() was
> >> not called yet once we reach pre_plug(). So we theoretically have to
> >> duplicate checks and add error paths for cases that can
> >> theoretically never happen.  
> > I care less about duplicate checks in completely different parts of code,
> > and I'd even insist on device:realize checks being self contained and not
> > rely on any other external checks performed by users of device. And vice
> > verse layer that uses device should do it's own checks when necessary
> > and not rely on device's verification. That way loosely coupled code
> > wouldn't fall apart whenever we drop or change checks in one of the parts.
> > 
> > The only case where I'd make concession is minimizing error handling
> > on hot path for performance reasons and this is not the case here.
> >   
> >> Let's add the "prepare()" callback, which can be used to validate
> >> properties and inititalize some state based on these. It will be called
> >> once all static properties have been inititalized, but before the
> >> pre_plug hotplug handler is activated. The pre_plug handler can than
> >> rely on the fact that basic checks already were performed.  
> > 
> > pre_plug isn't part of device, it's a separate part that might vary
> > depending on machine and which might modify device properties along
> > the way and then exaggerating we would need 'prepare2()' and after
> > that 'pre_plug2()' and ...  
> 
> That's how two parties (device vs hotplug handler) work together to get
> results done ... Just like inititalize() -> realized() vs. pre_plug ->
> plug(). There has to be some hand shaking.
In general hotplug handler is optional, for example a board might
create initial memory wit fixed layout as:
  dev = object_new(dimm)
  set memdev + set addr
  qdev_init_no_fail()

generalized pc-dimm helpers for hotplug handler is just impl. detail,
a board might have other ideas how to use pc-dimm and choose to
implement wiring differently. So device model should do sanity checks
independently from whomever uses it.

> > 
> > Hence I dislike idea of adding more callbacks. I'd rather have a property
> > setter do the job of initializing state of device when necessary instead
> > of adding more callbacks. Which is in nvdimm case a bit more code compared
> > to doing it in realize() but should be possible to implement.  
> 
> Although I strongly disagree (especially about the fact of calling class
> functions *anytime* after a device has been created but not initialized)
> I will implement it like that for now (otherwise I won't be making any
> progress here but instead be creating more and more problems to solve).
> 
> 
> nvdimm will only have static properties. When realizing or when calling
> get_memory_region(), properties will be checked and the nvdimm_mr
> inititalized, if not already done.
I'm not a fun of using class callbacks (due undefined semantic),
but since we are already using it here, that might just work
in this case.
