Received: from eggs.gnu.org ([2001:4830:134:3::10]:49318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBjJF-000761-V9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBjJC-0005as-QG
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBjJC-0005ag-Hi
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:55:14 -0400
Date: Fri, 19 May 2017 15:55:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519145502.GQ2081@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-4-pasic@linux.vnet.ibm.com>
	<20170508164505.GG2120@work-vm>
	<3e0195e2-ada5-2efc-1feb-e2415761e7bc@linux.vnet.ibm.com>
	<20170515180129.GC2324@work-vm>
	<2bf9d9d3-86ed-da36-dc81-415065e08a91@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf9d9d3-86ed-da36-dc81-415065e08a91@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] s390x/css: add vmstate entities for
 css
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/15/2017 08:01 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>
> >>
> >> On 05/08/2017 06:45 PM, Dr. David Alan Gilbert wrote:
> >>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>>> As a preparation for switching to a vmstate based migration let us
> >>>> introduce vmstate entities (e.g. VMStateDescription) for the css entities
> >>>> to be migrated. Alongside some comments explaining or indicating the not
> >>>> migration of certain members are introduced too.
> >>>>
> >>>> No changes in behavior, we just added some dead code -- which should
> >>>> rise to life soon.
> >>>>
> >>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/s390x/css.c         | 276 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>  include/hw/s390x/css.h |  10 +-
> >>>>  2 files changed, 285 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>>> index c03bb20..2bda7d0 100644
> >>>> --- a/hw/s390x/css.c
> >>>> +++ b/hw/s390x/css.c
> >>>> @@ -20,29 +20,231 @@
> >>>>  #include "hw/s390x/css.h"
> >>>>  #include "trace.h"
> >>>>  #include "hw/s390x/s390_flic.h"
> >>>> +#include "hw/s390x/s390-virtio-ccw.h"
> >>>>  
> >>
> >> [..]
> >>
> >>>> +static int css_get_ind_addr(QEMUFile *f, void *pv, size_t size,
> >>>> +                            VMStateField *field)
> >>>> +{
> >>>> +    int32_t len;
> >>>> +    IndAddr **ind_addr = pv;
> >>>> +
> >>>> +    len = qemu_get_be32(f);
> >>>> +    if (len != 0) {
> >>>> +        *ind_addr = get_indicator(qemu_get_be64(f), len);
> >>>> +    } else {
> >>>> +        qemu_get_be64(f);
> >>>> +        *ind_addr = NULL;
> >>>> +    }
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static int css_put_ind_addr(QEMUFile *f, void *pv, size_t size,
> >>>> +                            VMStateField *field, QJSON *vmdesc)
> >>>> +{
> >>>> +    IndAddr *ind_addr = *(IndAddr **) pv;
> >>>> +
> >>>> +    if (ind_addr != NULL) {
> >>>> +        qemu_put_be32(f, ind_addr->len);
> >>>> +        qemu_put_be64(f, ind_addr->addr);
> >>>> +    } else {
> >>>> +        qemu_put_be32(f, 0);
> >>>> +        qemu_put_be64(f, 0UL);
> >>>> +    }
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +const VMStateInfo vmstate_info_ind_addr = {
> >>>> +    .name = "s390_ind_addr",
> >>>> +    .get = css_get_ind_addr,
> >>>> +    .put = css_put_ind_addr
> >>>> +};
> >>>
> >>> You should be able to avoid this .get/.put by using VMSTATE_WITH_TMP,
> >>> declare a temporary struct something like:
> >>>   struct tmp_ind_addr {
> >>>      IndAddr *parent;
> >>>      uint32_t  len;
> >>>      uint64_t  addr;
> >>>   }
> >>>
> >>> and then your .get/.put routines turn into pre_save/post_load
> >>> routines to just setup the len/addr.
> >>>
> >>
> >> I don't think this is going to work -- unfortunately! You can see below,
> >> how this IndAddr* migration stuff is supposed to be used:
> >> the client code just uses the VMSTATE_PTR_TO_IND_ADDR macro as a
> >> field when describing state which needs and IndAddr* migrated.
> >>
> >> The problem is, we do not know in what state will this field
> >> be embedded, the pre_save/post_load called by put_tmp/get_tmp
> >> is however copying the pointer to this state into the parent.
> >> So instead of having a pointer to IndAddr* in those functions
> >> and updating it accordingly, I would have to find the IndAddr*
> >> in some arbitrary state (in our case VirtioCcwDevice) first,
> >> and I lack information for that.
> >>
> >> If it's hard to follow I can give you the patch I was debugging
> >> to come to this conclusion. (By the way I ended up with 10
> >> lines of code more than in this version, and although I think
> >> it looks nicer, it's simpler only if one knows how WITH_TMP
> >> works. My plan was to ask you which version do you like more
> >> and go with that before I realized it ain't gonna work.)
> >>
> > 
> > Yes, I see - I've got some similar other cases; the challenge
> > is it's a custom allocator - 'get_indicator' - and it's used
> > as fields in a few places.  Hmm.
> > 
> > 
> 
> The problem can be worked around by wrapping the WITH_TMP into a another
> vmsd and using VMSTATE_STRUCT for describing the field in question. It's
> quite some boilerplate (+16 lines). Should I post the patch here?

Yes please.

> We could also consider making WITH_TMP act as a normal field. 
> Working on the whole state looks like a bit like a corner case:
> we have some stuff adjacent in the migration stream, and we have
> to map it on multiple fields (and vice-versa). Getting the whole
> state with a pointer to a certain field could work via container_of.

You do need to know which field you're working on to be able to safely
use container_of, so I'm not sure how it would work for you in this
case.

The other thought I'd had was that perhaps we could change the temporary
structure in VMSTATE_WITH_TMP to:

  struct foo {
     struct whatever **parent;

so now you could write to *parent in cases like these.

> Btw, I would rather call it get_indicator a factory method or even a
> constructor than an allocator, but I think we understand each-other
> anyway.

Yes; I'm not too worried about the actual name as long as it's short
and obvious.

I'd thought of 'allocator' since in most cases it's used where the
load-time code allocates memory for the object being loaded.
A constructor is normally something I think of as happening after
allocation; and a factory, hmm maybe.  However, if it does the right
thing I wouldn't object to any of those names.

Dave
P.S. I'm out for about a week.

> Regards,
> Halil
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
