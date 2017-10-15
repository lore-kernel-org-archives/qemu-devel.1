Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e3owJ-0006zd-Ir
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e3owE-0007Z1-ND
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:51:11 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:51162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e3owE-0007XD-GK
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:51:06 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0AF1FE7680
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 21:51:04 +0200 (CEST)
Date: Sun, 15 Oct 2017 21:50:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171015215055.19dbecc1@bahia.lan>
In-Reply-To: <f43e0c376d23066ee08736c43f99100d.squirrel@mifritscher.de>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
	<693169b0c0e3904c935db314432bf671.squirrel@mifritscher.de>
	<f43e0c376d23066ee08736c43f99100d.squirrel@mifritscher.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, gkurz@linux.vnet.ibm.com

On Sun, 15 Oct 2017 21:13:34 +0200
"Michael Fritscher" <michael@fritscher.net> wrote:

> >
> > Hi,
> >
> > dumb question: what is the advantage of openat vs. open - only the thing
> > that someone doesn't need to build the path together by hand?
> >
> > If I understand the man page of openat correctly, it does _not_ prevent
> > someone to break out of the jail by using e.g. ../../../blah .
> > If this assumption is correctly perhaps it is better to avoid using the
> > *at function family (as it was some time ago) and sanitize the path (by
> > somehow canonizing it and than check if the beginning is ok).
> >
> > Then I could use the "normal" posix function again and avoid using the NT*
> > Functions directly which is not soooo nice for various reasons.
> >
> > Best regards,
> > Michael Fritscher
> >  
> 
> Hi again,
> 
> I see one thing: symlinks somewhere in the path (which seemed to be the
> reason introducing the *at family). But I think that this can be handled
> by canonlizing the path, too. realpath should do the job quite well.
> 

Unfortunately now because we have TOCTOU condition here: some path element
could be replaced by a symlink after realpath() but before we actually pass
the resulting path to a syscall.

> Best regards,
> Michael Fritscher
> 
