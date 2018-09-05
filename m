Received: from eggs.gnu.org ([2001:4830:134:3::10]:46809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxY7W-0002sG-Jz
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fxY7T-0006gF-Bq
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:45:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fxY7T-0006dV-1i
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C0F77F6BB
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 13:45:17 +0000 (UTC)
Date: Wed, 5 Sep 2018 10:45:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180905134512.GL12698@habkost.net>
References: <1536067356-44609-1-git-send-email-imammedo@redhat.com>
	<1536067356-44609-2-git-send-email-imammedo@redhat.com>
	<20180905021255.GK12698@habkost.net>
	<20180905112511.1d245cc8@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905112511.1d245cc8@igors-macbook-pro.local>
Subject: Re: [Qemu-devel] [PATCH v5 1/2] vl.c deprecate incorrect CPUs
 topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, drjones@redhat.com

On Wed, Sep 05, 2018 at 11:25:11AM +0200, Igor Mammedov wrote:
> On Tue, 4 Sep 2018 23:12:55 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Sep 04, 2018 at 03:22:35PM +0200, Igor Mammedov wrote:
> > > -smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
> > > so that total number of logical CPUs [sockets * cores * threads]
> > > would be equal to [maxcpus], however historically we didn't have
> > > such check in QEMU and it is possible to start VM with an invalid
> > > topology.
> > > Deprecate invalid options combination so we can make sure that
> > > the topology VM started with is always correct in the future.
> > > Users with an invalid sockets/cores/threads/maxcpus values should
> > > fix their CLI to make sure that
> > >    [sockets * cores * threads] == [maxcpus]
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > v5:
> > >   - extend deprecation doc, adding that maxcpus should be multiple of
> > >     present on CLI [sockets/cores/threads] options
> > >     (Eduardo Habkost <ehabkost@redhat.com>)
> > > v4:
> > >   - missed dot comment, fix it with s/./,/ (Andrew Jones <drjones@redhat.com>)
> > > v3:
> > >   - more spelling fixes (Andrew Jones <drjones@redhat.com>)
> > >   - place deprecation check after (sockets * cores * threads > max_cpus) check
> > >     (Eduardo Habkost <ehabkost@redhat.com>)
> > > v2:
> > >   - spelling&&co fixes (Andrew Jones <drjones@redhat.com>)
> > > ---
> > >  qemu-deprecated.texi | 19 +++++++++++++++++++
> > >  vl.c                 |  7 +++++++
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > > index 87212b6..827c3ce 100644
> > > --- a/qemu-deprecated.texi
> > > +++ b/qemu-deprecated.texi
> > > @@ -159,6 +159,25 @@ The 'file' driver for drives is no longer appropriate for character or host
> > >  devices and will only accept regular files (S_IFREG). The correct driver
> > >  for these file types is 'host_cdrom' or 'host_device' as appropriate.
> > >  
> > > +@subsection -smp X,[socket=a,core=b,thread=c],maxcpus=Y (since 3.1)
> > 
> > Minor: I suggest using @var markup, or maybe just use
> > "-smp (invalid topologies) (since 3.1)" as subsection title for simplicity?
> > 
> > > +
> > > +CPU topology properties should describe whole machine topology including
> > > +possible CPUs, but historically it was possible to start QEMU with
> > > +an incorrect topology where
> > > +  sockets * cores * threads >= X && X < maxcpus
> > 
> > Minor: this line formatting is lost on the HTML output.  I
> > suggest using @var and/or @math.
> > 
> > Minor: I suggest not using C syntax.
> > 
> > i.e. use something like:
> > 
> >   @math{@var{n} <= @var{sockets} * @var{cores} * @var{threads} < @var{maxcpus}},
> > 
> > > +which could lead to an incorrect topology enumeration by the guest.
> > > +Support for invalid topologies will be removed, the user must ensure
> > > +topologies described with -smp include all possible cpus, i.e.
> > > +  sockets * cores * threads == maxcpus
> > 
> > Minor: same as above.  I suggest:
> > 
> >   @math{@var{sockets} * @var{cores} * @var{threads} = @var{maxcpus}}.
> > 
> > 
> > > +Note: it's assumed that maxcpus value must be multiple of the topology
> > > +options present on command line to avoid creating an invalid topology.
> > > +If maxcpus isn't be multiple of present topology options then the condition
> > > +(sockets * cores * threads == maxcpus) can't be satisfied and it will
> > > +trigger deprecation warning which later will be converted to a error.
> > > +If you get deprecation warning it's recommended to explicitly specify
> > > +a correct topology to make warning go away and ensure that it will
> > > +continue working in the future.
> > 
> > I don't understand the purpose of the "Note:" section.  It seems to duplicate
> > what was already said in the lines above it.  Can we just remove it?
> Well, didn't I say that no additional explanation needed in v4?
> Note section was added per your suggestion to explicitly say that maxcpus
> should be multiple of options present on CLI.

You are right: I did ask for additional clarification on the
documentation, because it was not clear that the warning can
still appear even if some of the sockets/cores/threads options
were omitted.  The note didn't make that clearer to me, though.

In either case, this can be done on a follow-up patch if
necessary.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
