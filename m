Received: from eggs.gnu.org ([2001:4830:134:3::10]:44527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1djj6X-0006Lj-Iu
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1djj6T-0001PO-I7
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:34:41 -0400
Date: Mon, 21 Aug 2017 05:34:33 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <327375832.388365.1503308073646.JavaMail.zimbra@redhat.com>
In-Reply-To: <73d69240-d9c3-cb71-1623-501e873fc70a@redhat.com>
References: <1503297029-28436-1-git-send-email-thuth@redhat.com>
	<242295486.322283.1503300985716.JavaMail.zimbra@redhat.com>
	<73d69240-d9c3-cb71-1623-501e873fc70a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


> > 
> > Hello Thomas,
> >>
> >> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
> >> machine without specifying its 'memdev' property. This happens because
> >> pc_dimm_get_memory_region() does not check whether the 'memdev' property
> >> has properly been set by the user. Looking closer at this function, it's
> >> also obvious that it is using &error_abort to call another function - and
> >> this is bad in a function that is used in the hot-plugging calling chain
> >> since this can also cause QEMU to exit unexpectedly.
> > 
> > In place of checking if 'memdev' is already allocated/present while
> > fetching
> > 'get_functions' every place. If 'memdev' is required for memory hotplug
> > operation
> > can we just put a check at some common place and don't start or instantiate
> > if
> > 'memdev' is not present.
> > 
> > I can see:
> > 
> > 'pc_dimm_realize' function checks for : in my case prints warning
> > and avoid Qemu to start.
> > ...
> > ...
> > if (!dimm->hostmem) {
> >         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set");
> >         return;
> >     }
> > ...
> 
> That check unfortunately does not apply here: The crash happens in the
> pre_plug() handler of the spapr machine, and this is called *before* the
> realize function of the pc-dimm is called!

o.k I guessed so.
> 
> But even if we could find another common place where we could check
> dimm->hostmem first, you still have the problem that
> host_memory_backend_get_memory() could return an error and thus
> pc_dimm_get_memory_region() still needs a way to fail gracefully during
> the hotplug (or also hot-unplug) operation. So I think my patch is the
> right way to go here.

Right. Thanks for the explanation.

Pankaj
> 
>  Thomas
> 
