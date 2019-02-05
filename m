Received: from eggs.gnu.org ([209.51.188.92]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqwyI-00060t-VR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqwyI-0006Bx-02
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:24:50 -0500
Date: Tue, 5 Feb 2019 10:24:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205102436.030db556.cohuck@redhat.com>
In-Reply-To: <c4fb3400-3d6d-5294-1129-415a2367619b@redhat.com>
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-3-david@redhat.com>
	<83c38b9c-4b61-0067-2053-cdfe34b128bf@linux.ibm.com>
	<c4fb3400-3d6d-5294-1129-415a2367619b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/6] s390x/pci: Fix
 hotplugging of PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, 5 Feb 2019 00:43:08 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 04.02.19 23:48, Collin Walling wrote:

> > Side note: unrelated to the changes here -- and if you can clarify for
> > me -- any idea why we do s->bus_no += 1? This throws me off a bit and
> > begs me to ask what exactly is the S390pciState object suppose to
> > represent? (My guess is that it is representative of the entire PCI
> > topology, and we increment the bus_no to denote the subordinate bus
> > number?)  
> On x86, the bios builds the topology. On spapr and s390x, the firmware
> builds the topology. The topology is constructed in a way that all buses
> can be found ("tree traversed") from the root.
> 
> In a clean topology, each bridge has it's dedicated number.
> 
> primary: The bus the bridge is attached to
> secondary: The bus the bridge spans up
> subordinate: The highest bus number that can be found from this bridge
> 
> So when we add a new bridge, we have to assign a new "global" bus number
> for the topology. This is what we do here. So we denote actually the
> "seconardy" bus nr here, which we propagate as "subordinate" up to the root.
> 
> But this is the interesting point: When hotplugging on x86 and on power,
> the _guest_ is responsible for rebuilding the topology. Not the bios,
> not the firmware. No numbers are assigned. Code like we have here does
> not exist for them.
> 
> 
> And most probably this is also broken on s390x: When hotplugging a
> bridge, we should not mess with the topology (because as Thomas noted,
> we can easily break the topology so the search does no longer work
> reliably).

One thing I'm always wondering about: How does that work on "real"
hardware? The guest basically sees uid/fid, and I'm not sure how much
topology actually shines through here (visible in some generic pci
structures?) In QEMU, we're plugging into the generic pci
infrastructure, so our behaviour may be different than what we see on
an LPAR.

> 
> But this is your task to find out :)
> 
> Although it sounds like I "speak PCI", I really only have a rough idea
> how it all (is supposed to) work(s).
> 
> So while I am fixing the current code, we should find out next if we can
> drop this "messing with the topology on hotplug" completely. Or e.g.
> rework it to have standby numbers we can use when hotplugging ...
> 
> 
> > 
> > (let me know if these kind of discussions are too noisy and deemed
> > inappropriate for the mailing list, and I'll start pestering you off-
> > list instead)  
> 
> Not at all. This allows other people to learn as well and also to jump
> in in case I make up things.
> 

Seconded. Remember that people sometimes only read along and are not
really visible in the discussion :)
