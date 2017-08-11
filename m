Received: from eggs.gnu.org ([2001:4830:134:3::10]:52706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg6ty-0007Ia-7I
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dg6tu-0002Sh-75
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dg6tt-0002Sd-Tm
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A21B0F0D9F
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 10:10:40 +0000 (UTC)
Date: Fri, 11 Aug 2017 11:10:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811101035.GH2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-2-otubo@redhat.com>
	<787616d3-955a-42d9-6c8f-1236821751c3@redhat.com>
	<20170811095112.GB11001@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170811095112.GB11001@vader>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Aug 11, 2017 at 11:51:12AM +0200, Eduardo Otubo wrote:
> On Thu, Aug 03, 2017 at 06:54:15PM +0200, Thomas Huth wrote:
> > On 28.07.2017 14:10, Eduardo Otubo wrote:
> > > This patch changes the default behavior of the seccomp filter from
> > > whitelist to blacklist. By default now all system calls are allowed and
> > > a small black list of definitely forbidden ones was created.
> > > 
> > > Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> > > ---
> > >  qemu-seccomp.c | 256 +++++++--------------------------------------------------
> > >  vl.c           |   5 +-
> > >  2 files changed, 32 insertions(+), 229 deletions(-)
> > > 
> > > diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> > > index df75d9c471..f8877b07b5 100644
> > > --- a/qemu-seccomp.c
> > > +++ b/qemu-seccomp.c
> > > @@ -31,229 +31,29 @@ struct QemuSeccompSyscall {
> > >      uint8_t priority;
> > >  };
> > [...]
> > > +static const struct QemuSeccompSyscall blacklist[] = {
> > > +    { SCMP_SYS(reboot), 255 },
> > > +    { SCMP_SYS(swapon), 255 },
> > > +    { SCMP_SYS(swapoff), 255 },
> > > +    { SCMP_SYS(syslog), 255 },
> > > +    { SCMP_SYS(mount), 255 },
> > > +    { SCMP_SYS(umount), 255 },
> > > +    { SCMP_SYS(kexec_load), 255 },
> > > +    { SCMP_SYS(afs_syscall), 255 },
> > > +    { SCMP_SYS(break), 255 },
> > > +    { SCMP_SYS(ftime), 255 },
> > > +    { SCMP_SYS(getpmsg), 255 },
> > > +    { SCMP_SYS(gtty), 255 },
> > > +    { SCMP_SYS(lock), 255 },
> > > +    { SCMP_SYS(mpx), 255 },
> > > +    { SCMP_SYS(prof), 255 },
> > > +    { SCMP_SYS(profil), 255 },
> > > +    { SCMP_SYS(putpmsg), 255 },
> > > +    { SCMP_SYS(security), 255 },
> > > +    { SCMP_SYS(stty), 255 },
> > > +    { SCMP_SYS(tuxcall), 255 },
> > > +    { SCMP_SYS(ulimit), 255 },
> > > +    { SCMP_SYS(vserver), 255 },
> > >  };
> > 
> > Does it makes sense to still keep the priority field? Everything is now
> > marked with the value 255 and I currently fail to see the point of
> > priorities when using blacklisting ... so maybe just get rid of it?
> 
> I think that's a fair point here. Don't see much of a point on such a
> small number of syscalls. I just need to double check the libseccomp
> docs if I can build the list without any priority information, but I'm
> pretty sure I've seen this before.

Just always pass 255 to libseccomp apis directly. Its merely redundant
to store the value 255 in this QEMU  specific struct.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
