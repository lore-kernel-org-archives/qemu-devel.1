Received: from eggs.gnu.org ([2001:4830:134:3::10]:45885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dg6Z8-0003ta-Fv
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dg6Z4-00076S-I8
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dg6Z4-00074Z-8b
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:49:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05F40C09673F
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:49:09 +0000 (UTC)
Date: Fri, 11 Aug 2017 11:49:04 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170811094904.GA11001@vader>
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-3-otubo@redhat.com>
	<20170802123356.GI4098@redhat.com> <20170811091248.GA3051@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811091248.GA3051@vader>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com

On Fri, Aug 11, 2017 at 11:12:48AM +0200, Eduardo Otubo wrote:
> On Wed, Aug 02, 2017 at 01:33:56PM +0100, Daniel P. Berrange wrote:
> > On Fri, Jul 28, 2017 at 02:10:36PM +0200, Eduardo Otubo wrote:
> > > This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
> > > option. It allows Qemu to run safely on old system that still relies on
> > > old system calls.
> > > 
> > > Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> > > ---
> > >  include/sysemu/seccomp.h |  4 +++-
> > >  qemu-options.hx          |  9 +++++++--
> > >  qemu-seccomp.c           | 32 +++++++++++++++++++++++++++++++-
> > >  vl.c                     | 16 +++++++++++++++-
> > >  4 files changed, 56 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> > > index cfc06008cb..7a7bde246b 100644
> > > --- a/include/sysemu/seccomp.h
> > > +++ b/include/sysemu/seccomp.h
> > > @@ -15,7 +15,9 @@
> > >  #ifndef QEMU_SECCOMP_H
> > >  #define QEMU_SECCOMP_H
> > >  
> > > +#define OBSOLETE    0x0001
> > 
> > Please namespace this - its far too generic a term to expose to other
> > source files. I'd suggest 
> > 
> >   QEMU_SECCOMP_SET_OBSOLETE
> > 
> > > -int seccomp_start(void);
> > > +int seccomp_start(uint8_t seccomp_opts);
> > 
> > This only allows for 8 sets. Perhaps its enough, but I'd suggest
> > just using a uint32_t straight away.
> > 
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 746b5fa75d..54e492f36a 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -4004,13 +4004,18 @@ Old param mode (ARM only).
> > >  ETEXI
> > >  
> > >  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> > > -    "-sandbox <arg>  Enable seccomp mode 2 system call filter (default 'off').\n",
> > > +    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
> > > +    "                obsolete: Allow obsolete system calls\n",
> > >      QEMU_ARCH_ALL)
> > >  STEXI
> > > -@item -sandbox @var{arg}
> > > +@item -sandbox @var{arg}[,obsolete=@var{string}]
> > >  @findex -sandbox
> > >  Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
> > >  disable it.  The default is 'off'.
> > > +@table @option
> > > +@item obsolete=@var{string}
> > > +Enable Obsolete system calls
> > 
> > Lets explain this a bit more.
> > 
> > E obsolete system calls that are provided by the kernel, but typically no
> > longer used by modern C library implementations. 
> > 
> > > +@end table
> > >  ETEXI
> > >  
> > >  DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,
> > > diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> > > index f8877b07b5..c6a8b28260 100644
> > > --- a/qemu-seccomp.c
> > > +++ b/qemu-seccomp.c
> > > @@ -31,6 +31,20 @@ struct QemuSeccompSyscall {
> > >      uint8_t priority;
> > >  };
> > >  
> > > +static const struct QemuSeccompSyscall obsolete[] = {
> > > +    { SCMP_SYS(readdir), 255 },
> > > +    { SCMP_SYS(_sysctl), 255 },
> > > +    { SCMP_SYS(bdflush), 255 },
> > > +    { SCMP_SYS(create_module), 255 },
> > > +    { SCMP_SYS(get_kernel_syms), 255 },
> > > +    { SCMP_SYS(query_module), 255 },
> > > +    { SCMP_SYS(sgetmask), 255 },
> > > +    { SCMP_SYS(ssetmask), 255 },
> > > +    { SCMP_SYS(sysfs), 255 },
> > > +    { SCMP_SYS(uselib), 255 },
> > > +    { SCMP_SYS(ustat), 255 },
> > > +};
> > > +
> > >  static const struct QemuSeccompSyscall blacklist[] = {
> > >      { SCMP_SYS(reboot), 255 },
> > >      { SCMP_SYS(swapon), 255 },
> > > @@ -56,7 +70,20 @@ static const struct QemuSeccompSyscall blacklist[] = {
> > >      { SCMP_SYS(vserver), 255 },
> > >  };
> > >  
> > > -int seccomp_start(void)
> > > +static int is_obsolete(int syscall)
> > > +{
> > > +    unsigned int i = 0;
> > > +
> > > +    for (i = 0; i < ARRAY_SIZE(obsolete); i++) {
> > > +        if (syscall == obsolete[i].num) {
> > > +            return 1;
> > > +        }
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +int seccomp_start(uint8_t seccomp_opts)
> > >  {
> > >      int rc = 0;
> > >      unsigned int i = 0;
> > > @@ -69,6 +96,9 @@ int seccomp_start(void)
> > >      }
> > >  
> > >      for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
> > > +        if ((seccomp_opts & OBSOLETE) && is_obsolete(blacklist[i].num)) {
> > > +            continue;
> > > +        }
> > 
> > IMHO this is leading to a rather inefficient approach. Why not extend
> > QemuSeccompSyscall struct so that it has another field to list which
> > set it belongs to. Then you can do
> > 
> > 
> >   static const struct QemuSeccompSyscall blacklist[] = {
> >     { SCMP_SYS(reboot), 255, QEMU_SECCOMP_SET_DEFAULT },
> >     { SCMP_SYS(swapon), 255, QEMU_SECCOMP_SET_DEFAULT },
> >      ....
> >     { SCMP_SYS(readdir), 255, QEMU_SECCOMP_SET_OBSOLETE },
> >     { SCMP_SYS(_sysctl), 255, QEMU_SECCOMP_SET_OBSOLETE },
> >     ...
> > 
> > And then to process this you can do
> > 
> >       for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
> >           if (blacklist[i].set != QEMU_SECCOMP_SET_OBSOLETE &&
> >               blacklist[i].set & seccomp_opts) {
> > 	      continue;
> 
> I agree with all the rest except with this one. This would require a
> change on libseccomp itself. Not sure a change on the library would be
> suited for now.
> 
> I'm working and reviewing all the comments today, so I'll try to post
> a new version later today.

Let me reply this before you do: My mistake, this structure model does
not belong to libseccomp. My bad. So yeah, I can change it to optimize
things here. Thanks for the idea :)

> 
> > 	  }
> > 
> > 
> > >          rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
> > >          if (rc < 0) {
> > >              goto seccomp_return;
> > > diff --git a/vl.c b/vl.c
> > > index 15b98800e9..cbe09c94af 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -271,6 +271,10 @@ static QemuOptsList qemu_sandbox_opts = {
> > >              .name = "enable",
> > >              .type = QEMU_OPT_BOOL,
> > >          },
> > > +        {
> > > +            .name = "obsolete",
> > > +            .type = QEMU_OPT_STRING,
> > > +        },
> > >          { /* end of list */ }
> > >      },
> > >  };
> > > @@ -1032,7 +1036,17 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
> > >  {
> > >      if (qemu_opt_get_bool(opts, "enable", false)) {
> > >  #ifdef CONFIG_SECCOMP
> > > -        if (seccomp_start() < 0) {
> > > +        uint8_t seccomp_opts = 0x0000;
> > > +        const char *value = NULL;
> > > +
> > > +        value = qemu_opt_get(opts, "obsolete");
> > > +        if (value) {
> > > +            if (strcmp(value, "allow") == 0) {
> > > +                seccomp_opts |= OBSOLETE;
> > > +            }
> > > +        }
> > 
> > IIUC, the values will all be booleans, so we should just use
> > 
> >    if (qemu_opt_get_bool(opts, "obsolete", false))
> >        seccomp_opts |= OBSOLETE;
> > 
> > > +
> > > +        if (seccomp_start(seccomp_opts) < 0) {
> > >              error_report("failed to install seccomp syscall filter "
> > >                           "in the kernel");
> > >              return -1;
> > 
> > Regards,
> > Daniel
> > -- 
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
> -- 
> Eduardo Otubo
> Senior Software Engineer @ RedHat

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
