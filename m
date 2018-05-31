Received: from eggs.gnu.org ([2001:4830:134:3::10]:33925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fORLJ-00068P-3A
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fORLF-0006zs-Tg
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:26:29 -0400
Received: from 13.mo6.mail-out.ovh.net ([188.165.56.124]:39163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fORLF-0006x2-Md
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:26:25 -0400
Received: from player732.ha.ovh.net (unknown [10.109.105.89])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id AB13A15E782
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 19:26:23 +0200 (CEST)
Date: Thu, 31 May 2018 19:26:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531192619.62550340@bahia.lan>
In-Reply-To: <CABV8kRzhiVy9ix67OfPcSZ-SNa6Zh6j5uZ05-yhKW_=Ujyd1HQ@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<033ba6f2e3f0daccb31e1930a1c65cf7a18ae66c.1527310210.git.keno@alumni.harvard.edu>
	<20180529203426.3aa6305a@bahia.lan>
	<CABV8kRzhiVy9ix67OfPcSZ-SNa6Zh6j5uZ05-yhKW_=Ujyd1HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/13] 9p: Move a couple xattr functions to
 9p-util
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

On Thu, 31 May 2018 12:14:30 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> > I'm ok with this move, but if the functions need to have distinct
> > implementations, and they really do according to patch 10, then
> > I'd rather have distinct files and rely on conditional building in
> > the makefile. Maybe rename the current file to 9p-util-linux.c
> > and introduce a 9p-util-darwin.c later.  
> 
> Sounds good, I will make this change.
> 
> >> Additionally, introduce a _follow version of fgetxattr and use it.
> >> On darwin, fgetxattr has a more general interface, so we'll need to factor
> >> it out anyway.
> >>  
> >
> > No need for the _follow version in this case.  
> 
> I'm not entirely sure what you're proposing. On darwin `fgetxattr`
> takes two extra
> arguments,

Oops you're right... so we indeed need to handle this conflicting APIs,
but fgetxattr_follow() is inapropriate, because fgetxattr() has nothing
to follow since it already has an fd... The same goes with Darwin's
version actually. The "nofollow" thingy only makes sense for those calls
that have a dirfd and pathname argument.

The OSX manpage for fgetxattr() seem to mention the XATTR_NOFOLLOW flag
for getxattr() only.

https://www.unix.com/man-page/osx/2/fgetxattr/

XATTR_NOFOLLOW  do not follow symbolic links.  getxattr() normally returns
		information from the target of path if it is a symbolic link.
		With this option, getxattr() will return extended attribute
		data from the symbolic link instead.

> so I believe it needs to be factored out nevertheless. Are you just
> proposing doing that later in the patch series?

Maybe introduce a qemu_fgetxattr() API in 9p-utils.h ? In a separate patch, or
maybe in patch 10.

#ifdef CONFIG_DARWIN
#define qemu_fgetxattr(...) fgetxattr(__VA_ARGS__, 0, 0)
#else
#define qemu_fgetxattr fgetxattr
#endif
