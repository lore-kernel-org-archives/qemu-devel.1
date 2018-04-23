Received: from eggs.gnu.org ([2001:4830:134:3::10]:45839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAeTo-0003TH-Dt
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAeTl-0007iG-Rf
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:38:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fAeTl-0007hr-Lr
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:38:13 -0400
Date: Mon, 23 Apr 2018 17:38:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180423163809.GR3267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
	<20180423162142.GG1980@perard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180423162142.GG1980@perard>
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, Juergen Gross <jgross@suse.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, "Kent R. Spillner" <kspillner@acm.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

On Mon, Apr 23, 2018 at 05:21:42PM +0100, Anthony PERARD wrote:
> On Thu, Apr 19, 2018 at 05:45:19PM +0100, Ian Jackson wrote:
> > This makes it much easier to find a particular thing in config.log.
> > 
> > The information may be lacking in other shells, resulting in harmless
> > empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
> > array syntax - other shells will choke on that.)
> > 
> > The extra output is only printed if configure is run with bash.  On
> > systems where /bin/sh is not bash, it is necessary to say bash
> > ./configure to get the extra debug info in the log.
> > 
> > Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> > ---
> >  configure | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index d5435ff..a4c5292 100755
> > --- a/configure
> > +++ b/configure
> > @@ -60,6 +60,10 @@ do_compiler() {
> >      # is compiler binary to execute.
> >      local compiler="$1"
> >      shift
> > +    echo >>config.log "
> > +funcs: ${FUNCNAME}
> > +lines: ${BASH_LINENO}
> > +files: ${BASH_SOURCE}"
> >      echo $compiler "$@" >> config.log
> >      $compiler "$@" >> config.log 2>&1 || return $?
> >      # Test passed. If this is an --enable-werror build, rerun
> 
> How is this usefull? All I have in my config.log is a lot of:
>   funcs: do_compiler
>   lines: 91
>   files: ./configure
> 
> And one:
>   funcs: do_compiler
>   lines: 95
>   files: ./configure
> 
> It still don't tell me which test had runned.

In autoconf, you would generally have a line output to stdout for every
test being run, as it is done so you can see immediately which test it
stopped on. QEMU's configure by comparison is completely silent, except
for the fnal summary at the end which is fine if everything works perfectly,
but not great when it doesn't.

Personally I'd suggest we add informative messages throughout the
configure script for each check being run. If people really hate the
idea of a verbose output from configure, we could leave it silent by
default and add a '--verbose' option to turn it on.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
