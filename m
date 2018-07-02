Received: from eggs.gnu.org ([2001:4830:134:3::10]:33383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fZyC3-0004CP-6w
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fZyBz-00049K-8j
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:44:35 -0400
Date: Mon, 2 Jul 2018 14:44:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180702144422.18f451c9@redhat.com>
In-Reply-To: <1bb74240-d1ce-7a1e-69df-f2c7c70d1fd9@redhat.com>
References: <20180702093755.7384-1-david@redhat.com>
	<20180702093755.7384-5-david@redhat.com>
	<20180702123141.4a499198@redhat.com>
	<1bb74240-d1ce-7a1e-69df-f2c7c70d1fd9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] pc-dimm: assign and verify the
 "addr" property during pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 2 Jul 2018 12:39:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 02.07.2018 12:31, Igor Mammedov wrote:
> > On Mon,  2 Jul 2018 11:37:55 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> We can assign and verify the slot before realizing and trying to plug.  
> > s/slot/"addr"/
> >   
> >> reading/writing the address property should never fail for DIMMs, so let's
> >> reduce error handling a bit by using &error_abort. Getting access to the
> >> memory region now might however fail. So forward errors from
> >> get_memory_region() properly.
> >>
> >> As all memory devices should use the alignment of the underlying memory
> >> region for guest physical address asignment, do detection of the
> >> alignment in pc_dimm_pre_plug(), but allow pc.c to overwrite the
> >> alignment for compatibility handling.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>  
> > with commit message fixup,
> > 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > For future reference, I don't really like 2 things about patch
> >  1: mixes both error handling and functional changes (should be separate patches)
> >  2: that property setter may crash QEMU at preplug stage
> >     where it should gracefully error out (so put proper error check
> >     as follow up patch or respin this one maybe taking in account #1.)  
> 
> Thanks for the review.
> 
> 1. could have been factored out into a separate patch.
> 
> Regarding 2, I won't respin as long there is nothing else to take care
> of. As long as we are in the pc-dimm world and we have static
> properties, I don't see any reason to add error handling that cannot
> happen. It will be different once we factor out more stuff into memory
> device code. I assume you have a different opinion about that, but I
> consider these nits.
it's not really nits. it happens to work now but static properties are
just current impl. detail which can easily change without amending
*plug handlers.
It's cleaner/safer to handle errors properly and keeping device model
separate from machine helpers as much as possible from maintainer pov,
even at expense of extra boiler plate.

I expect you to re-introduce proper error checking when you
factor out memory_device_pre_plug() part /it's condition for my ack
on this patch/.
