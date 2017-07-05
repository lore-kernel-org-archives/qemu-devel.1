Received: from eggs.gnu.org ([2001:4830:134:3::10]:43024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSiIU-0003eE-NQ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSiIR-00064v-GX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSiIR-00064V-7L
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 07:16:39 -0400
Date: Wed, 5 Jul 2017 13:16:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170705131634.51d62373@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170705131159.1584f668@dhcp-192-215.str.redhat.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-5-git-send-email-borntraeger@de.ibm.com>
	<20170704163730.491517ac@dhcp-192-215.str.redhat.com>
	<930cb5d9-83d1-50e7-39a7-f7eea67ef1af@linux.vnet.ibm.com>
	<e00d3b37-a79e-6779-8627-e597685aeb18@de.ibm.com>
	<20170705131159.1584f668@dhcp-192-215.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] s390x: fix realize inheritance for
 kvm-flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Wed, 5 Jul 2017 13:11:59 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 5 Jul 2017 12:20:42 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 07/04/2017 04:51 PM, Halil Pasic wrote:  
> > > 
> > > 
> > > On 07/04/2017 04:37 PM, Cornelia Huck wrote:    
> > >> On Tue,  4 Jul 2017 16:07:56 +0200
> > >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > >>    
> > >>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> > >>>
> > >>> Commit f6f4ce4211 ("s390x: add property adapter_routes_max_batch",
> > >>> 2016-12-09) introduces a common realize (intended to be common for all
> > >>> the subclasses) for flic, but fails to make sure the kvm-flic which had
> > >>> it's own is actually calling this common realize.    
> > >>
> > >> s/it's/its/
> > >>    
> > > 
> > > Valid. Sorry.
> > >     
> > >>>
> > >>> This omission fortunately does not result in a grave problem. The common
> > >>> realize was only supposed to catch a possible programming mistake by
> > >>> validating a value of a property set via the compat machine macros. Since
> > >>> there was no programming mistake we don't need this fixed for stable.
> > >>>
> > >>> Let's fix this problem by making sure kvm flic honors the realize of its
> > >>> parent class.
> > >>>
> > >>> Let us also improve on the error message we would hypothetically emit
> > >>> when the validation fails.
> > >>>
> > >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > >>> Fixes: f6f4ce4211 ("s390x: add property adapter_routes_max_batch")
> > >>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > >>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> > >>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > >>> ---
> > >>>  hw/intc/s390_flic.c     |  4 ++--
> > >>>  hw/intc/s390_flic_kvm.c | 17 +++++++++++++++++
> > >>>  2 files changed, 19 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> > >>> index a99a350..837158b 100644
> > >>> --- a/hw/intc/s390_flic.c
> > >>> +++ b/hw/intc/s390_flic.c
> > >>> @@ -101,8 +101,8 @@ static void s390_flic_common_realize(DeviceState *dev, Error **errp)
> > >>>      uint32_t max_batch = S390_FLIC_COMMON(dev)->adapter_routes_max_batch;
> > >>>  
> > >>>      if (max_batch > ADAPTER_ROUTES_MAX_GSI) {
> > >>> -        error_setg(errp, "flic adapter_routes_max_batch too big"
> > >>> -                   "%d (%d allowed)", max_batch, ADAPTER_ROUTES_MAX_GSI);
> > >>> +        error_setg(errp, "flic property adapter_routes_max_batch too big"
> > >>> +                   " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);    
> > >>
> > >> Unrelated message change?
> > >>    
> > > 
> > > I've mentioned it in the commit message. It was also introduced by the
> > > patch I'm fixing. But yes strictly it's two different problems.    
> > 
> > I will only fix the patch description ( s/it's/its/) and keep the other things
> > unchanged. Is that fine with you?  
> 
> Yup. Let's get this done.
> 
> With the changes,

s/changes/change/

One coffee is obviously not enough...

> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
