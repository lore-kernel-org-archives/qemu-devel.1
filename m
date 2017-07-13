Received: from eggs.gnu.org ([2001:4830:134:3::10]:37752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVgrU-0005ZI-0O
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVgrP-0006s7-2p
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:21:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVgrO-0006rJ-PY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:21:03 -0400
Date: Thu, 13 Jul 2017 13:20:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170713162051.GV6020@localhost.localdomain>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-4-ehabkost@redhat.com>
	<2cda5b0b-0169-d12e-114e-77fcb1a4bb07@linux.vnet.ibm.com>
	<20170712192055.GL6020@localhost.localdomain>
	<fc38afe1-ee3c-f2e2-9d21-31396d271829@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc38afe1-ee3c-f2e2-9d21-31396d271829@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] Revert "machine: Convert abstract
 typename on compat_props to subclass names"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Thu, Jul 13, 2017 at 02:11:09PM +0200, Halil Pasic wrote:
> 
> 
> On 07/12/2017 09:20 PM, Eduardo Habkost wrote:
> > On Wed, Jul 12, 2017 at 07:49:22PM +0200, Halil Pasic wrote:
> >> On 07/11/2017 02:43 AM, Eduardo Habkost wrote:
> >>> This reverts commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2.
> >>>
> >>> The bug addressed by that commit is now fixed in a better way by the
> >>> commit "qdev: fix the order compat and global properties are applied".
> >>>
> >>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >>
> >> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>
> >> Note: It is not like the effect of commit 0bcba41fe3 is canceled
> >> out with your first patch in place. It depends on the client
> >> code (the implementation of the individual devices) wether
> >> this patch changes something or not. I did not check myself.
> >> So the did you verify that nothing breaks with this change applies
> >> here too.
> > 
> > I don't get this part.  I don't see how individual devices
> > implementation will be able to affect the outcome after this
> > patch is applied.
> > 
> > GlobalProperty::driver is not used as input for
> > object_property_parse() at all (see qdev_prop_set_globals()).
> > This means exactly the same property setter is invoked when
> > registering "<superclass>.<property>" or "<subclass>.<property>".
> > The only difference introduced by this series is in the ordering
> > of the object_property_parse() calls.
> > 
> > And even the object_property_parse() call ordering is not
> > affected by this patch at all, because of patch 1/3.  Patch 1/3
> > will ensure the properties will be applied in exactly the same
> > order they were registered, so this patch should introduce
> > absolutely no behavior change on any device.
> > 
> 
> Resolving this disagreement IMHO depends on resolving our disagreement
> about patch 1. Let us postpone this until we have an agreement
> there.

Your observation on patch 1 was correct, so the ordering of
object_property_parse() calls will change if using
pseries <= 2.3 and "-global spapr-pci-vfio-host-bridge".

-- 
Eduardo
