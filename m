Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d7qey-0002eF-WD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d7qev-0007lA-4a
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:57:41 -0400
Received: from mail.kernel.org ([198.145.29.136]:49056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d7qeu-0007kk-Uc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 17:57:37 -0400
Date: Mon, 8 May 2017 14:57:32 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
Message-ID: <alpine.DEB.2.10.1705081454510.24729@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1705081334150.24729@sstabellini-ThinkPad-X260>
	<1f0bf90b-a706-01c8-cad1-6dea6620deef@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] Fix issues affecting Xen 9pfs discovered
 by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com, xen-devel@lists.xensource.com, aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org

On Mon, 8 May 2017, Eric Blake wrote:
> On 05/08/2017 03:45 PM, Stefano Stabellini wrote:
> > Fix two resource leaks on error paths, discovered by Coverity.
> > Check for errors returned by fcntl, also found by Coverity.
> > 
> > CID:1374836
> > CID:1374831
> > 
> 
> > @@ -378,7 +380,10 @@ static int xen_9pfs_connect(struct XenDevice *xendev)
> >          if (xen_9pdev->rings[i].evtchndev == NULL) {
> >              goto out;
> >          }
> > -        fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev), F_SETFD, FD_CLOEXEC);
> > +        if (fcntl(xenevtchn_fd(xen_9pdev->rings[i].evtchndev),
> > +                  F_SETFD, FD_CLOEXEC) == -1) {
> > +            goto out;
> 
> Directly calling fcntl(F_SETFD) without first reading fcntl(F_GETFD) is
> (theoretically) incorrect.  Better might be using qemu_set_cloexec()
> instead of open-coding something.

Makes sense but the unchecked return of fcntl, discovered by Coverity,
would remain unfixed by calling qemu_set_cloexec here. I don't think I
am up for fixing all the call sites of qemu_set_cloexec.

I am going to drop this change, and resend this patch was only the other
two fixes, fixing 1374836 only.
