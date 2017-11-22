Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHXq7-0003M2-8c
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHXq4-0006T3-54
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:25:31 -0500
Date: Wed, 22 Nov 2017 17:25:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122172522.281cfb4b.cohuck@redhat.com>
In-Reply-To: <594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 22 Nov 2017 15:45:56 +0100
Boris Fiuczynski <fiuczy@linux.vnet.ibm.com> wrote:

> On 11/22/2017 01:13 PM, Cornelia Huck wrote:
> >>>>>> +    object_class_property_add_bool(klass, "cssid-unrestricted",
> >>>>>> +                                   prop_get_true, NULL, NULL);  
> >>>>> This looks really, really strange. This is a property that is always
> >>>>> true if it exists.
> >>>>>        
> >>>> Won't argue about that. The libvirt guys are actually not interested
> >>>> int he value at all: only that there is such a property.  
> >>> So what about a machine property? Wouldn't that help as well?
> >>>      
> >> Technically it is doable. The property would be still a weird
> >> one, but from QEMU perspective in a less weird place. I was also
> >> arguing that from OO perspective this kind of a don't care about
> >> it's value property is weird, but AFAIK not having the info if
> >> we can do something with a device at the device is weird from
> >> Libvirt perspective. I'm really uncomforble with speaking for
> >> Libvirt/Boris. Hope he will make his point tomorrow.
> >>  
> >>> Or a css object?
> >>>      
> >> My first internal-only version used this approach, but
> >> I was asked to do it like this.  
> > If we formulate this rather as "we now expose the default css", we (a)
> > have something that really makes the most sense at a channel subsystem
> > or machine level, and (b) can be detected by libvirt as an indicator of
> > "no restriction for virtual vs. non-virtual".  
> 
> I think that there are good reasons for using a device property as well 
> as for using a machine property. Technically both options are possible 
> (even for libvirt :) without too much rope...). At first my personal 
> choice was to express the changed behavior/capability on the device 
> level since that is what a user defines on the command line and also 
> where he gets restricted to use a css matching his device type.
>  From the libvirt perspective we would have supported vfio-ccw devices 
> only if the vfio-ccw would be allowed to be defined with unrestricted 
> cssids.

Thanks, I can now understand where that property came from.

> As I wrote before I also understand the reasoning to express the channel 
> subsystem wide changed behavior as a machine option. In that case 
> libvirt would need to check that both capabilities (vfio-ccw and machine 
> option cssid-unrestricted) are set and not just 
> vfio-cww.cssid-unrestricted. All doable. A qemu command line user would 
> obviously need to know the correlation of the machine option and the ccw 
> devices but that certainly is also nothing new.
> When talking to Christian and Halil I started to favor the idea of a new 
> css object especially when thinking about the future in which the user 
> might want to specify the default css. It for sure would also be able to 
> be set with the use of a machine option but a css object would at that 
> point be much a nicer and more capable approach. What do you think?

I think exposing the css object and making the default_css property
available is the cleanest solution (especially if we want more css
properties in the future). The only drawback I see is that it needs
more coding (and probably care to keep it backwards compatible.)

Halil, do you think you can come up with something?
