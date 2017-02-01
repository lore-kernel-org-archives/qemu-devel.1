Received: from eggs.gnu.org ([2001:4830:134:3::10]:57894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cYrzg-00017x-Su
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cYrzc-0000F3-Sd
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:18:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cYrzc-0000Ej-Iq
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 05:18:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v11AFXRw067050
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 05:18:21 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28bb1562c0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 05:18:21 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 1 Feb 2017 10:18:19 -0000
Date: Wed, 1 Feb 2017 11:18:14 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170127182035.GC5919@work-vm>
References: <20170124184742.1639-1-dgilbert@redhat.com>
	<20170124184742.1639-3-dgilbert@redhat.com>
	<20170125114620.GA9699@lemon.Home> <20170125120053.GA2096@work-vm>
	<20170125131917.32df62ef.cornelia.huck@de.ibm.com>
	<20170125132254.GB2096@work-vm>
	<20170125152014.2ab6f901.cornelia.huck@de.ibm.com>
	<20170125144420.GE2096@work-vm>
	<20170126131402.547f1004.cornelia.huck@de.ibm.com>
	<20170127182035.GC5919@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170201111814.45c9e204.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 02/15] migration: extend VMStateInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Jianjun Duan <duanj@linux.vnet.ibm.com>

On Fri, 27 Jan 2017 18:20:36 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> > On Wed, 25 Jan 2017 14:44:20 +0000
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > 
> > > * Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> > > > On Wed, 25 Jan 2017 13:22:55 +0000
> > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > 
> > > > > * Cornelia Huck (cornelia.huck@de.ibm.com) wrote:
> > > > > > On Wed, 25 Jan 2017 12:00:53 +0000
> > > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > 
> > > > > > > OK, so it looks like that's a failure path, adding a return -ENOMEM would seem to make
> > > > > > > sense there.
> > > > > > 
> > > > > > Just saw this. I don't think we want -ENOMEM, as that would change the
> > > > > > actual state being saved, no?
> > > > > 
> > > > > But isn't that the intention of this function?
> > > > > 
> > > > >     buf = g_try_malloc0(len);
> > > > >     if (!buf) {
> > > > >         /* Storing FLIC_FAILED into the count field here will cause the
> > > > >          * target system to fail when attempting to load irqs from the
> > > > >          * migration state */
> > > > >         error_report("flic: couldn't allocate memory");
> > > > >         qemu_put_be64(f, FLIC_FAILED);
> > > > >         return;
> > > > >     }
> > > > > 
> > > > > What should happen on the destination - should the migration fail?
> > > > > If we want the migration to fail then we should now return an error
> > > > > status rather than 0, and then we see a failed migration on the source
> > > > > as well.
> > > > 
> > > > Yes. There's also another error case below where we should return an
> > > > error instead of putting FLIC_FAILED, then.
> > > > 
> > > > The problem is that this is rather hard to test: So I'd prefer to fix
> > > > the compile for now and introduce error return codes in a separate
> > > > patch.
> > > 
> > > OK, that's fair.
> > 
> > I've coded something up and tried to test it with error injection to
> > trigger the failed case, but I can't really see an improvement :(
> > 
> > Before: source logs error, target fails to load the flic with 'invalid
> > argument'
> > 
> > After: source logs error, target fails to load the flic with 'could not
> > allocate memory'
> > 
> > The migration code does not seem to do anything with the return code of
> > put methods for now, so that's not too surprising. Is anything in the
> > works?
> 
> OK, I hadn't remembered that wasn't wired up.
> 
> > For now, I'd prefer to keep the old behaviour as 'invalid argument'
> > seems like a more obvious error on the target.
> 
> Yes, agreed.
> 
> If you feel like, then I'd just change the return -ENOMEM but still
> send the FLIC_FAILED.  That way the destination still fails
> as before, and the destination will fail nicely when we wire up the
> error checks.

Yes, having both FLIC_FAILED and a nonzero return code looks like the
best approach for now.
