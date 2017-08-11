Received: from eggs.gnu.org ([2001:4830:134:3::10]:46465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dg6bE-0005hb-J2
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dg6b9-0001fq-Ob
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:51:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dg6b9-0001fJ-Hb
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 05:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D2D6AB474
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:51:18 +0000 (UTC)
Date: Fri, 11 Aug 2017 11:51:12 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170811095112.GB11001@vader>
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-2-otubo@redhat.com>
	<787616d3-955a-42d9-6c8f-1236821751c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <787616d3-955a-42d9-6c8f-1236821751c3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/6] seccomp: changing from whitelist to
 blacklist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com

On Thu, Aug 03, 2017 at 06:54:15PM +0200, Thomas Huth wrote:
> On 28.07.2017 14:10, Eduardo Otubo wrote:
> > This patch changes the default behavior of the seccomp filter from
> > whitelist to blacklist. By default now all system calls are allowed and
> > a small black list of definitely forbidden ones was created.
> > 
> > Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> > ---
> >  qemu-seccomp.c | 256 +++++++--------------------------------------------------
> >  vl.c           |   5 +-
> >  2 files changed, 32 insertions(+), 229 deletions(-)
> > 
> > diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> > index df75d9c471..f8877b07b5 100644
> > --- a/qemu-seccomp.c
> > +++ b/qemu-seccomp.c
> > @@ -31,229 +31,29 @@ struct QemuSeccompSyscall {
> >      uint8_t priority;
> >  };
> [...]
> > +static const struct QemuSeccompSyscall blacklist[] = {
> > +    { SCMP_SYS(reboot), 255 },
> > +    { SCMP_SYS(swapon), 255 },
> > +    { SCMP_SYS(swapoff), 255 },
> > +    { SCMP_SYS(syslog), 255 },
> > +    { SCMP_SYS(mount), 255 },
> > +    { SCMP_SYS(umount), 255 },
> > +    { SCMP_SYS(kexec_load), 255 },
> > +    { SCMP_SYS(afs_syscall), 255 },
> > +    { SCMP_SYS(break), 255 },
> > +    { SCMP_SYS(ftime), 255 },
> > +    { SCMP_SYS(getpmsg), 255 },
> > +    { SCMP_SYS(gtty), 255 },
> > +    { SCMP_SYS(lock), 255 },
> > +    { SCMP_SYS(mpx), 255 },
> > +    { SCMP_SYS(prof), 255 },
> > +    { SCMP_SYS(profil), 255 },
> > +    { SCMP_SYS(putpmsg), 255 },
> > +    { SCMP_SYS(security), 255 },
> > +    { SCMP_SYS(stty), 255 },
> > +    { SCMP_SYS(tuxcall), 255 },
> > +    { SCMP_SYS(ulimit), 255 },
> > +    { SCMP_SYS(vserver), 255 },
> >  };
> 
> Does it makes sense to still keep the priority field? Everything is now
> marked with the value 255 and I currently fail to see the point of
> priorities when using blacklisting ... so maybe just get rid of it?

I think that's a fair point here. Don't see much of a point on such a
small number of syscalls. I just need to double check the libseccomp
docs if I can build the list without any priority information, but I'm
pretty sure I've seen this before.

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
