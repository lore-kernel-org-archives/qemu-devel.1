Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcsvm-0001aV-32
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dcsvZ-0001ll-As
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:39:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dcsvZ-0001ji-2m
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:39:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E166F5F795
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 12:39:03 +0000 (UTC)
Date: Wed, 2 Aug 2017 13:38:58 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170802123858.GK4098@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-3-otubo@redhat.com>
	<20170802123356.GI4098@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802123356.GI4098@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] seccomp: add obsolete argument to
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: pbonzini@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org

On Wed, Aug 02, 2017 at 01:33:56PM +0100, Daniel P. Berrange wrote:
> On Fri, Jul 28, 2017 at 02:10:36PM +0200, Eduardo Otubo wrote:
> > This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> > option. It allows Qemu to run safely on old system that still relies on
> > old system calls.
> > 
> > Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> > ---
> >  include/sysemu/seccomp.h |  4 +++-
> >  qemu-options.hx          |  9 +++++++--
> >  qemu-seccomp.c           | 32 +++++++++++++++++++++++++++++++-
> >  vl.c                     | 16 +++++++++++++++-
> >  4 files changed, 56 insertions(+), 5 deletions(-)


> > @@ -1032,7 +1036,17 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
> >  {
> >      if (qemu_opt_get_bool(opts, "enable", false)) {
> >  #ifdef CONFIG_SECCOMP
> > -        if (seccomp_start() < 0) {
> > +        uint8_t seccomp_opts = 0x0000;
> > +        const char *value = NULL;
> > +
> > +        value = qemu_opt_get(opts, "obsolete");
> > +        if (value) {
> > +            if (strcmp(value, "allow") == 0) {
> > +                seccomp_opts |= OBSOLETE;
> > +            }
> > +        }
> 
> IIUC, the values will all be booleans, so we should just use
> 
>    if (qemu_opt_get_bool(opts, "obsolete", false))
>        seccomp_opts |= OBSOLETE;

Oh ignore this. I see from the next patch, we can't treat it as a boolean.

We should however explicitly look for 'value == deny', and then reject
all other values with an error message

> 
> > +
> > +        if (seccomp_start(seccomp_opts) < 0) {
> >              error_report("failed to install seccomp syscall filter "
> >                           "in the kernel");
> >              return -1;

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
