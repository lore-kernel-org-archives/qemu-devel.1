Received: from eggs.gnu.org ([2001:4830:134:3::10]:50826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAEsC-0004db-6W
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAEs8-0000Pz-Vk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:13:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAEs8-0000Ps-PH
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:13:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA74A4E357
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 12:13:07 +0000 (UTC)
Date: Mon, 15 May 2017 13:13:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170515121301.GF2089@work-vm>
References: <20170503104257.5127-1-dgilbert@redhat.com>
	<dcdd1530-4e73-f998-b85f-06db4f1c4b63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcdd1530-4e73-f998-b85f-06db4f1c4b63@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block migration: Allow compile time disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jcody@redhat.com, kwolf@redhat.com, kashyap@redhat.com

* Eric Blake (eblake@redhat.com) wrote:
> On 05/03/2017 05:42 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Many users now prefer to use drive_mirror over NBD as an
> > alternative to the older migrate -b option; drive_mirror is
> > more complex to setup but gives you more options (e.g. only
> > migrating some of the disks if some of them are shared).
> > 
> > Allow the large chunk of block migration code to be compiled
> > out for those who don't use it.
> > 
> > Based on a downstream-patch we've had for a while by Jeff Cody.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> > @@ -1222,6 +1226,14 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
> >      params.blk = has_blk && blk;
> >      params.shared = has_inc && inc;
> >  
> > +#ifndef CONFIG_LIVE_BLOCK_MIGRATION
> > +    if (params.blk || params.shared) {
> > +        error_setg(errp, "QEMU compiled without old-style block migration. "
> > +                         "Use drive_mirror+NBD.");
> 
> error_setg() should not be used with '.' (it should be a single phrase,
> here you are trying to stuff in two sentences).  error_append_hint() can
> be used to supply the advice about using drive_mirror+NBD as the
> alternative.
> 
> Otherwise this looks reasonable to me.

Done as:
        error_setg(errp, "QEMU compiled without old-style block migration");
        error_append_hint(errp, "Use drive_mirror+NBD.\n");

(All the places I can see seem to have . and \n in append_hint)

Dave

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
