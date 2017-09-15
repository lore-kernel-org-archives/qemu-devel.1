Received: from eggs.gnu.org ([2001:4830:134:3::10]:38738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsg2E-0006bU-Pg
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsg2B-0003lv-KS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsg2B-0003lY-EK
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 22:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43FFA20275
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 02:07:10 +0000 (UTC)
Date: Fri, 15 Sep 2017 10:07:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915020701.GK3617@pxdev.xzpeter.org>
References: <1505420311-23744-1-git-send-email-mgamal@redhat.com>
	<96709f6f-b4c8-f752-fd0d-f73de9023bcc@redhat.com>
	<20170914203138.GD23492@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170914203138.GD23492@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] amd_iommu: Return error on machines with
 no PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com, Mohammed Gamal <mgamal@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On Thu, Sep 14, 2017 at 05:31:38PM -0300, Eduardo Habkost wrote:
> On Thu, Sep 14, 2017 at 10:24:23PM +0200, Thomas Huth wrote:
> > On 14.09.2017 22:18, Mohammed Gamal wrote:
> > > Starting the following command line causes a segfault
> > > qemu-system-x86_64 -S -machine isapc,accel=kvm -device amd-iommu
> > > 
> > > This is due to the fact that the machine type 'isapc' doesn't have
> > > a PCI bus, while amd_iommu doesn't check if the machine has PCI support
> > > and subsequently does a null-pointer access. AMD IOMMU shouldn't even work
> > > if the target machine doesn't have PCI.
> > > 
> > > Add a check for PCI on the given machine type and return an error if PCI
> > > is not supported.
> > > 
> > > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> > > ---
> > >  hw/i386/amd_iommu.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > > index 334938a..9a667b7 100644
> > > --- a/hw/i386/amd_iommu.c
> > > +++ b/hw/i386/amd_iommu.c
> > > @@ -1153,6 +1153,13 @@ static void amdvi_realize(DeviceState *dev, Error **err)
> > >      }
> > >  
> > >      bus = pcms->bus;
> > > +
> > > +    if (!bus) {
> > > +        error_setg(err, "Machine-type '%s' does not support PCI",
> > > +                   mc->name);
> > > +        return;
> > > +    }
> > > +
> > >      s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> > >                                       amdvi_uint64_equal, g_free, g_free);
> > >  
> > > 
> > 
> > Patch looks fine to me, but I think it would also be sufficient to
> > change the check at the beginning of the function to test "if (!pcms ||
> > !pcms->bus)" instead of just "if (!pcms)" ... the error message
> > "Machine-type 'xxx' not supported by amd-iommu" is also adequate if
> > there is no PCI bus available on the system.
> 
> I agree this would be much simpler.

Even, shall we move the pcms && bus check into x86_iommu_realize()
directly?  Then we will only need one single patch for Intel/AMD, and
it's also a cleanup.  Thanks,

-- 
Peter Xu
