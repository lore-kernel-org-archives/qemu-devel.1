Received: from eggs.gnu.org ([2001:4830:134:3::10]:36445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co7Nx-0005Ww-Gd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co7Nt-000336-RD
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:46:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1co7Nt-00032r-Lg
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:46:29 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 824B480F63
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:46:29 +0000 (UTC)
Date: Wed, 15 Mar 2017 11:46:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170315114623.GI7770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170315105646.32355-1-berrange@redhat.com>
	<de695865-d569-916d-218e-1faff31d6f4b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de695865-d569-916d-218e-1faff31d6f4b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: ensure $(tracetool-y) is defined in
 top level makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Mar 15, 2017 at 06:44:25AM -0500, Eric Blake wrote:
> On 03/15/2017 05:56 AM, Daniel P. Berrange wrote:
> > The build rules for trace files have a dependancy on $(tracetool-y).
> > This variable populated in the trace/Makefile.objs file and thus its
> > definition gets pulled into the top level makefile. This happens too
> > late in the process though, so by the time $(tracetool-y) is defined,
> > make has already evaluated $(tracetool-y) in the dependancies and
> > found it to be empty. The result is that when the tracetool source
> > is changed, the generated files are not rebuilt. The solution is to
> > define the variable in the top level makefile too
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Does this mean the definitions in trace/Makefile.objs are now redundant
> and can be omitted?

Hmm, I'm not sure, but quite possibly true.

> 
> > 
> > diff --git a/Makefile b/Makefile
> > index 1c4c04f..dffc74b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -85,6 +85,9 @@ GENERATED_SOURCES += $(TRACE_SOURCES)
> >  
> >  trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
> >  
> > +tracetool-y = $(SRC_PATH)/scripts/tracetool.py
> > +tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
> 
> Should this also include the comment currently in trace/Makefile.objs:
> 
> ######################################################################
> # tracetool source files
> # Every rule that invokes tracetool must depend on this so code is
> regenerated
> # if tracetool itself changes.
> 
> But it certainly looks like you're on the right track for fixing the
> issue I ran into.

IMHO such comments are pointless - they're just stating the obvious.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
