Received: from eggs.gnu.org ([2001:4830:134:3::10]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOT3z-0002MX-Lx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fOT3w-0003wU-Fe
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:16:43 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:44239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fOT3w-0003vf-8m
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:16:40 -0400
Received: from player697.ha.ovh.net (unknown [10.109.122.79])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 87F841B84FD
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 21:16:38 +0200 (CEST)
Date: Thu, 31 May 2018 21:16:35 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180531211635.47b1d004@bahia.lan>
In-Reply-To: <CABV8kRwhz_WhkjZzqQXXTTwRL_sLNftHAnw9LjMCbkZMLiU4Tg@mail.gmail.com>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<6205f39b495ee7356478cc53faf5e32289f57182.1527310210.git.keno@alumni.harvard.edu>
	<20180529222558.59230642@bahia.lan>
	<CABV8kRwhz_WhkjZzqQXXTTwRL_sLNftHAnw9LjMCbkZMLiU4Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/13] 9p: darwin: Handle struct dirent
 differences
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

On Thu, 31 May 2018 12:20:28 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> >> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> >> index eb68b42..3c0a6d8 100644
> >> --- a/hw/9pfs/9p-synth.c
> >> +++ b/hw/9pfs/9p-synth.c
> >> @@ -221,7 +221,11 @@ static void synth_direntry(V9fsSynthNode *node,
> >>  {
> >>      strcpy(entry->d_name, node->name);
> >>      entry->d_ino = node->attr->inode;
> >> +#ifdef CONFIG_DARWIN
> >> +    entry->d_seekoff = off + 1;  
> >
> > Hmm... what's that for ? No users in the patchset and the comment
> > below seem to indicate this wouldn't be trusted anyway.  
> 
> d_off isn't available on Darwin, so an appropriate ifdef
> is required here anyway. I figured if the offset is available
> anyway, I might as well set it, but I can drop
> this code path if you would prefer.
> 

Yeah I think I prefer you drop it.

> >> +        off_t off = v9fs_co_telldir(pdu, fidp);  
> >
> > Please declare local variables at the beginning of the function. Also,
> > v9fs_co_telldir() can fail. This requires proper error handling.  
> 
> Will do.
> 
> >> +#else
> >> +        off_t off = dent->d_off;
> >> +#endif  
> >
> > Please make this a helper and call it in v9fs_do_readdir_with_stat() as well.
> >  
> 
> Will do.
