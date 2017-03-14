Received: from eggs.gnu.org ([2001:4830:134:3::10]:59355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnl0f-0004Eo-9M
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnl0c-0001UE-3B
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:53:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnl0b-0001U5-R5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:52:58 -0400
Date: Tue, 14 Mar 2017 11:52:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314115253.GL2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] seccomp: add elevateprivileges
 argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org, thuth@redhat.com

On Tue, Mar 14, 2017 at 12:47:10PM +0100, Paolo Bonzini wrote:
> 
> 
> On 14/03/2017 12:32, Eduardo Otubo wrote:
> > This patch introduces the new argument [,elevateprivileges=deny] to the
> > `-sandbox on'. It avoids Qemu process to elevate its privileges by
> > blacklisting all set*uid|gid system calls
> > 
> > Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> > ---
> >  include/sysemu/seccomp.h |  1 +
> >  qemu-options.hx          |  8 ++++++--
> >  qemu-seccomp.c           | 28 ++++++++++++++++++++++++++++
> >  vl.c                     | 11 +++++++++++
> >  4 files changed, 46 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
> > index 7a7bde246b..e6e78d85ce 100644
> > --- a/include/sysemu/seccomp.h
> > +++ b/include/sysemu/seccomp.h
> > @@ -16,6 +16,7 @@
> >  #define QEMU_SECCOMP_H
> >  
> >  #define OBSOLETE    0x0001
> > +#define PRIVILEGED  0x0010
> >  
> >  #include <seccomp.h>
> >  
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 1403d0c85f..47018db5aa 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3732,8 +3732,10 @@ Old param mode (ARM only).
> >  ETEXI
> >  
> >  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> > -    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
> > -    "                              obsolete: Allow obsolete system calls",
> > +    "-sandbox on[,obsolete=allow][,elevateprivileges=deny]\n" \
> > +    "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
> > +    "                               obsolete: Allow obsolete system calls\n" \
> > +    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls",
> 
> Why allow these by default?

The goal is that '-sandbox on' should not break *any* QEMU feature. It
needs to be a safe thing that people can unconditionally turn on without
thinking about it.  The QEMU bridge helper  requires setuid privs, hence
elevated privileges needs to be permitted by default. Similarly I could
see the qemu ifup  scripts, or migrate 'exec' command wanting to elevate
privs via setuid binaries if QEMU was running unprivileged.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
