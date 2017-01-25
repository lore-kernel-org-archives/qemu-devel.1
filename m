Received: from eggs.gnu.org ([2001:4830:134:3::10]:52725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWQfV-0003MP-EB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cWQfS-0003EN-B6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:43:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cWQfS-0003E2-2y
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:43:30 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFFEAC04B93E
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 16:43:29 +0000 (UTC)
Date: Wed, 25 Jan 2017 16:43:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170125164324.GB6581@work-vm>
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-5-dgilbert@redhat.com>
	<87sho778qn.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sho778qn.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH 04/15] Fold postcopy_ram_discard_range into
 ram_discard_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > I'd created this weird pair of:
> >   ram_discard_range   that lived in migration/ram.c
> >      Which is built target-dependent so can access the insides of
> >      RAMBlock
> >
> >   postcopy_ram_discard_range
> >      Which actually does the discard.
> >
> > Flatten these down into ram_discard_range, this relies on the
> > CONFIG_MADVISE check to be sure we have the real DONTNEED madvise
> > rather than the posix variant that isn't guaranteed to discard pages.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> > @@ -1877,7 +1879,15 @@ int ram_discard_range(MigrationIncomingState *mis,
> >                           host_endaddr);
> >              goto err;
> >          }
> > -        ret = postcopy_ram_discard_range(mis, host_startaddr, length);
> > +        errno = ENOTSUP;
> > +#if defined(CONFIG_MADVISE)
> > +        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
> > +#endif
> 
> This really looks weird, we shouldn't arrive here if CONFIG_MADVISE is
> not configured, no?

You'd hope so ...but.

ram.c is compiled for everyone, so it's not Linux specific for example.
The definitions of QEMU_MADV_DONTNEED and qemu_madvise is a bit odd;
if you're unlucky enough to be on a platform that is
 !CONFIG_MADVISE but is CONFIG_POSIX_MADVISE  then 
you end up using posix_madvise(POSIX_MADV_DONTNEED) - which is different
semantics than madvise MADV_DONTNEED - because the posix variant treats
it as advise for the kernel, where the madvise() case treats
it as an instruction to throw the page away (I'm not sure how
portable that semantic is).

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
