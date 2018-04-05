Received: from eggs.gnu.org ([2001:4830:134:3::10]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f44vc-00047a-Ks
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f44va-0008E4-11
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 09:27:48 -0400
Date: Thu, 5 Apr 2018 15:27:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180405152734.2e984bc5.cohuck@redhat.com>
In-Reply-To: <20180405151255.63da677e@bahia.lan>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
	<20180405021437.16761-14-david@gibson.dropbear.id.au>
	<20180405151255.63da677e@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13 13/13] target/ppc: Fold slb_nr
 into PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com

On Thu, 5 Apr 2018 15:12:55 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu,  5 Apr 2018 12:14:37 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:

> > @@ -4000,7 +4000,12 @@ DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
> >   * pseries-2.12
> >   */
> >  #define SPAPR_COMPAT_2_12                                              \
> > -    HW_COMPAT_2_12  
> 
> This hunk doesn't apply on master, nor on your ppc-for-2.13 branch...
> 
> It looks like a patch to introduce the 2.13 machine type is missing.
> 
> FWIW, Connie has already queued a patch to do so for s390x, that also
> introduces HW_COMPAT_2_12.
> 
> https://github.com/cohuck/qemu/commit/b54cde7350b6681b4349b904e0f9a8a8d58c0951
> 
> Maybe the HW_COMPAT_ macros should be added in a standalone patch ?
> 
> Cc'ing Connie for insights.
> 
> > +    HW_COMPAT_2_12                                                     \
> > +    {                                                                  \
> > +        .driver = TYPE_POWERPC_CPU,                                    \
> > +            .property = "pre-2.13-migration",                          \
> > +            .value    = "on",                                          \  

I think the usual procedure is

- every arch that uses compat machines queues a patch that creates the
  new compat machine(s) and adds an empty HW_COMPAT_<version>
- whoever has their queue pulled first wins wrt hw_compat

So, I'm happy with anyone adding the empty HW_COMPAT_2_12 -- it needn't
be me :)

[We could also introduce the 2.13 machines for all architectures in one
sweep, but I think that would be generating needless churn for arch
maintainers.]
