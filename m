Received: from eggs.gnu.org ([2001:4830:134:3::10]:38673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT6Hs-0003rE-QZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT6Hp-00049x-I8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:58:12 -0400
Date: Wed, 13 Jun 2018 15:57:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613155759.4e78aec0@redhat.com>
In-Reply-To: <1bb1ffd0-2d96-09bb-09aa-348016e452c1@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-6-david@redhat.com>
	<20180613130113.64852912@redhat.com>
	<1bb1ffd0-2d96-09bb-09aa-348016e452c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/11] spapr: move memory hotplug size
 check into plug code
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
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Haozhong Zhang <haozhong.zhang@intel.com>, Junyan He <junyan.he@intel.com>

On Wed, 13 Jun 2018 13:05:53 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 13.06.2018 13:01, Igor Mammedov wrote:
> > On Mon, 11 Jun 2018 14:16:49 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> This might look like a step backwards, but it is not. get_memory_region()
> >> should not be called on uninititalized devices. In general, only
> >> properties should be access, but no "derived" satte like the memory
> >> region.
> >>
> >> 1. We need duplicate error checks if memdev is actually already set.
> >>    realize() performs these checks, no need to duplicate.  
> > it's not duplicate, if a machine doesn't access to memory region
> > in preplug time (hence doesn't check), then device itself would check it,
> > check won't be missed by accident.
> > (yep it's more code but more robust at the same time, so I'd leave it as is)  
> 
> Checking at two places for the same thing == duplicate checks
device models and there users are separate entities hence I consider
checks are separate. If user code can be written without adding extra checks
it's fine. But if device model doesn't have its own checks when and is
used in by new user code without checks also, it's going to break.

So it would be hard to convince me that consolidating error handling
between in-depended layers is a good idea in general and particularly
in this case.

I'd just drop this error cleanups altogether so that they won't get
in the way of actual changes you are aiming for (unless you have to do it).

> >> 2. This is bad practise as one can see when looking at the NVDIMM
> >>    implemetation. The call does not return sane data before the device
> >>    is realized. Although spapr does not use NVDIMM, conceptually it is
> >>    wrong.
> >>
> >> So let's just move this call to the right place. We can then cleanup
> >> get_memory_region().  
> > So I have to say no to this particular patch.
> > It is indeed a step backwards and it looks like workaround for broken nvdimm impl.
> > 
> > Firstly, memdev property must be set for dimm device and
> > a user accessing memory region first must check for error.
> > More details below.
> >   
> 
> You assume that any class function can be called at any time. And I
> don't think this is the way to go.
Not any time, in the case of get_memory_region() it should work at
pre_plug() time as all the pieces for it are already there.
So we should make it work correctly for NVDIMM instead of 
succumbing to it and running wild.
we should stick to canonical sequence
  object_new -> set props -> realize
I don't see any reason to violate it in this case other than laziness.
