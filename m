Received: from eggs.gnu.org ([2001:4830:134:3::10]:34972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e3oqz-0005qm-R5
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e3oqw-00051w-Pi
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:45:41 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:46149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e3oqw-0004ze-IX
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 15:45:38 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2AF95E6204
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 21:45:29 +0200 (CEST)
Date: Sun, 15 Oct 2017 21:45:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171015214519.0f131869@bahia.lan>
In-Reply-To: <693169b0c0e3904c935db314432bf671.squirrel@mifritscher.de>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
	<693169b0c0e3904c935db314432bf671.squirrel@mifritscher.de>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Sun, 15 Oct 2017 21:02:56 +0200
"Michael Fritscher" <michael@fritscher.net> wrote:

> > On 29/09/2017 16:14, Michael Fritscher wrote:  
> >>> Yes, that's pretty much the only way to do it; it's not the easiest
> >>> thing because you have to use NT kernel APIs (NtCreateFile) rather than
> >>> e.g. CreateFile.  Likewise for NtQueryAttributesFile,
> >>> NtQueryDirectoryObject, etc. NtOpenDirectoryObject. :(
> >>>
> >>> Paolo
> >>>  
> >> Hi,
> >>
> >> why do I need the NT* functions instead of the "normal" ones from
> >> kernel32? And it was working even with the posix functions some time ago
> >> (Which I'll port to current qemu atm)  
> >
> > openat lets you create a file from a directory handle and relative path.
> >  CreateFile doesn't let you do that, only the ntdll functions can.
> >
> > Paolo
> >  
> 
> Hi,
> 

Hi,

> dumb question: what is the advantage of openat vs. open - only the thing
> that someone doesn't need to build the path together by hand?
> 
> If I understand the man page of openat correctly, it does _not_ prevent
> someone to break out of the jail by using e.g. ../../../blah .

Look at v9fs_walk():

        if (not_same_qid(&pdu->s->root_qid, &qid) ||
            strcmp("..", wnames[name_idx].data)) {
            err = v9fs_co_name_to_path(pdu, &dpath, wnames[name_idx].data,
                                       &path);

If we have reached the jail root and the path element is "..", we skip it,
ie, it isn't possible to go beyond the jail root.

Cheers,

--
Greg

> If this assumption is correctly perhaps it is better to avoid using the
> *at function family (as it was some time ago) and sanitize the path (by
> somehow canonizing it and than check if the beginning is ok).
> 
> Then I could use the "normal" posix function again and avoid using the NT*
> Functions directly which is not soooo nice for various reasons.
> 
> Best regards,
> Michael Fritscher
> 
