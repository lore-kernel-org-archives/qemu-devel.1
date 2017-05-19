Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBlw0-00054h-KW
	for qemu-devel@nongnu.org; Fri, 19 May 2017 13:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBlvw-0007bi-MM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 13:43:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBlvw-0007bB-Cu
	for qemu-devel@nongnu.org; Fri, 19 May 2017 13:43:24 -0400
Date: Fri, 19 May 2017 18:43:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519174316.GR2081@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-4-pasic@linux.vnet.ibm.com>
	<20170508164505.GG2120@work-vm>
	<3e0195e2-ada5-2efc-1feb-e2415761e7bc@linux.vnet.ibm.com>
	<20170515180129.GC2324@work-vm>
	<2bf9d9d3-86ed-da36-dc81-415065e08a91@linux.vnet.ibm.com>
	<20170519145502.GQ2081@work-vm>
	<5a2c4261-c97e-0b0c-24c5-0500948be0e9@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2c4261-c97e-0b0c-24c5-0500948be0e9@linux.vnet.ibm.com>
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
> On 05/19/2017 04:55 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>
> >>
> >> On 05/15/2017 08:01 PM, Dr. David Alan Gilbert wrote:
> >>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>>>
> >>>>
> >>>> On 05/08/2017 06:45 PM, Dr. David Alan Gilbert wrote:
> >>>>> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >>>>>> As a preparation for switching to a vmstate based migration let us
> >>>>>> introduce vmstate entities (e.g. VMStateDescription) for the css entities
> >>>>>> to be migrated. Alongside some comments explaining or indicating the not
> >>>>>> migration of certain members are introduced too.
> >>>>>>
> >>>>>> No changes in behavior, we just added some dead code -- which should
> >>>>>> rise to life soon.
> >>>>>>
> >>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>>>>> ---
> >>>>>>  hw/s390x/css.c         | 276 +++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>  include/hw/s390x/css.h |  10 +-
> >>>>>>  2 files changed, 285 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>>>>> index c03bb20..2bda7d0 100644
> >>>>>> --- a/hw/s390x/css.c
> >>>>>> +++ b/hw/s390x/css.c
> >>>>>> @@ -20,29 +20,231 @@
> >>>>>>  #include "hw/s390x/css.h"
> >>>>>>  #include "trace.h"
> >>>>>>  #include "hw/s390x/s390_flic.h"
> >>>>>> +#include "hw/s390x/s390-virtio-ccw.h"
> >>>>>>  
> >>>>
> >>>> [..]
> >>>>
> >>>>>> +static int css_get_ind_addr(QEMUFile *f, void *pv, size_t size,
> >>>>>> +                            VMStateField *field)
> >>>>>> +{
> >>>>>> +    int32_t len;
> >>>>>> +    IndAddr **ind_addr = pv;
> >>>>>> +
> >>>>>> +    len = qemu_get_be32(f);
> >>>>>> +    if (len != 0) {
> >>>>>> +        *ind_addr = get_indicator(qemu_get_be64(f), len);
> >>>>>> +    } else {
> >>>>>> +        qemu_get_be64(f);
> >>>>>> +        *ind_addr = NULL;
> >>>>>> +    }
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int css_put_ind_addr(QEMUFile *f, void *pv, size_t size,
> >>>>>> +                            VMStateField *field, QJSON *vmdesc)
> >>>>>> +{
> >>>>>> +    IndAddr *ind_addr = *(IndAddr **) pv;
> >>>>>> +
> >>>>>> +    if (ind_addr != NULL) {
> >>>>>> +        qemu_put_be32(f, ind_addr->len);
> >>>>>> +        qemu_put_be64(f, ind_addr->addr);
> >>>>>> +    } else {
> >>>>>> +        qemu_put_be32(f, 0);
> >>>>>> +        qemu_put_be64(f, 0UL);
> >>>>>> +    }
> >>>>>> +    return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +const VMStateInfo vmstate_info_ind_addr = {
> >>>>>> +    .name = "s390_ind_addr",
> >>>>>> +    .get = css_get_ind_addr,
> >>>>>> +    .put = css_put_ind_addr
> >>>>>> +};
> >>>>>
> >>>>> You should be able to avoid this .get/.put by using VMSTATE_WITH_TMP,
> >>>>> declare a temporary struct something like:
> >>>>>   struct tmp_ind_addr {
> >>>>>      IndAddr *parent;
> >>>>>      uint32_t  len;
> >>>>>      uint64_t  addr;
> >>>>>   }
> >>>>>
> >>>>> and then your .get/.put routines turn into pre_save/post_load
> >>>>> routines to just setup the len/addr.
> >>>>>
> >>>>
> >>>> I don't think this is going to work -- unfortunately! You can see below,
> >>>> how this IndAddr* migration stuff is supposed to be used:
> >>>> the client code just uses the VMSTATE_PTR_TO_IND_ADDR macro as a
> >>>> field when describing state which needs and IndAddr* migrated.
> >>>>
> >>>> The problem is, we do not know in what state will this field
> >>>> be embedded, the pre_save/post_load called by put_tmp/get_tmp
> >>>> is however copying the pointer to this state into the parent.
> >>>> So instead of having a pointer to IndAddr* in those functions
> >>>> and updating it accordingly, I would have to find the IndAddr*
> >>>> in some arbitrary state (in our case VirtioCcwDevice) first,
> >>>> and I lack information for that.
> >>>>
> >>>> If it's hard to follow I can give you the patch I was debugging
> >>>> to come to this conclusion. (By the way I ended up with 10
> >>>> lines of code more than in this version, and although I think
> >>>> it looks nicer, it's simpler only if one knows how WITH_TMP
> >>>> works. My plan was to ask you which version do you like more
> >>>> and go with that before I realized it ain't gonna work.)
> >>>>
> >>>
> >>> Yes, I see - I've got some similar other cases; the challenge
> >>> is it's a custom allocator - 'get_indicator' - and it's used
> >>> as fields in a few places.  Hmm.
> >>>
> >>>
> >>
> >> The problem can be worked around by wrapping the WITH_TMP into a another
> >> vmsd and using VMSTATE_STRUCT for describing the field in question. It's
> >> quite some boilerplate (+16 lines). Should I post the patch here?
> > 
> > Yes please.
> > 
> --------------------------------8<------------------------------------------
> 
> From a0b6c725b114745c8434f683133995c4e33d936e Mon Sep 17 00:00:00 2001
> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> Date: Tue, 9 May 2017 12:06:42 +0200
> Subject: [PATCH 1/1] s390x/css: replace info with VMSTATE_WITH_TMP
> 
> Convert s VMSatateInfo based solution manipulating the migration stream
> directly to VMSTATE_WITH_TMP witch keeps IO and transformation logic
> separate.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 56 ++++++++++++++++++++++++++++++++------------------
>  include/hw/s390x/css.h |  4 ++--
>  2 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 694365b395..71d1b95e3f 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -224,41 +224,57 @@ const VMStateDescription vmstate_subch_dev = {
>      }
>  };
>  
> -static int css_get_ind_addr(QEMUFile *f, void *pv, size_t size,
> -                            VMStateField *field)
> -{
> +typedef struct IndAddrPtrTmp {
> +    IndAddr **parent;
> +    uint64_t addr;
>      int32_t len;
> -    IndAddr **ind_addr = pv;
> +} IndAddrPtrTmp;
>  
> -    len = qemu_get_be32(f);
> -    if (len != 0) {
> -        *ind_addr = get_indicator(qemu_get_be64(f), len);
> +static int post_load_ind_addr(void *opaque, int version_id)
> +{
> +    IndAddrPtrTmp *ptmp = opaque;
> +    IndAddr **ind_addr = ptmp->parent;
> +
> +    if (ptmp->len != 0) {
> +        *ind_addr = get_indicator(ptmp->addr, ptmp->len);
>      } else {
> -        qemu_get_be64(f);
>          *ind_addr = NULL;
>      }
>      return 0;
>  }
>  
> -static int css_put_ind_addr(QEMUFile *f, void *pv, size_t size,
> -                            VMStateField *field, QJSON *vmdesc)
> +static void pre_save_ind_addr(void *opaque)
>  {
> -    IndAddr *ind_addr = *(IndAddr **) pv;
> +    IndAddrPtrTmp *ptmp = opaque;
> +    IndAddr *ind_addr = *(ptmp->parent);
>  
>      if (ind_addr != NULL) {
> -        qemu_put_be32(f, ind_addr->len);
> -        qemu_put_be64(f, ind_addr->addr);
> +        ptmp->len = ind_addr->len;
> +        ptmp->addr = ind_addr->addr;
>      } else {
> -        qemu_put_be32(f, 0);
> -        qemu_put_be64(f, 0UL);
> +        ptmp->len = 0;
> +        ptmp->addr = 0L;
>      }
> -    return 0;
>  }
>  
> -const VMStateInfo vmstate_info_ind_addr = {
> -    .name = "s390_ind_addr",
> -    .get = css_get_ind_addr,
> -    .put = css_put_ind_addr
> +const VMStateDescription vmstate_ind_addr_tmp = {
> +    .name = "s390_ind_addr_tmp",
> +    .pre_save = pre_save_ind_addr,
> +    .post_load = post_load_ind_addr,
> +
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32(len, IndAddrPtrTmp),
> +        VMSTATE_UINT64(addr, IndAddrPtrTmp),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +const VMStateDescription vmstate_ind_addr = {
> +    .name = "s390_ind_addr_tmp",
> +    .fields = (VMStateField[]) {
> +        VMSTATE_WITH_TMP(IndAddr*, IndAddrPtrTmp, vmstate_ind_addr_tmp),
> +        VMSTATE_END_OF_LIST()
> +    }
>  };
>  
>  typedef struct CssImage {
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index be5eb81ece..efe7cafef0 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -106,10 +106,10 @@ typedef struct IndAddr {
>      QTAILQ_ENTRY(IndAddr) sibling;
>  } IndAddr;
>  
> -extern const VMStateInfo vmstate_info_ind_addr;
> +extern const VMStateDescription vmstate_ind_addr;
>  
>  #define VMSTATE_PTR_TO_IND_ADDR(_f, _s)                                   \
> -    VMSTATE_SINGLE(_f, _s, 1 , vmstate_info_ind_addr, IndAddr*)
> +    VMSTATE_STRUCT(_f, _s, 1, vmstate_ind_addr, IndAddr*)
>  
>  IndAddr *get_indicator(hwaddr ind_addr, int len);
>  void release_indicator(AdapterInfo *adapter, IndAddr *indicator);

Oh if that works that's great;  I'd thought we'd need to change
something in VMSTATE_WITH_TMP to be able to get it to be an IndAddr **parent;
there is a bit much boiler-plate but I've not got any easy
ideas for removing that for now.

Dave

> -- 
> 2.11.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
