Received: from eggs.gnu.org ([2001:4830:134:3::10]:51973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ekGLe-0001ty-HJ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1ekGLb-0000qR-EF
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:36:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1ekGLb-0000q5-6K
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:36:43 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19LaIvS051280
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 16:36:41 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g1jy32007-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 16:36:41 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 16:36:40 -0500
Date: Fri, 9 Feb 2018 19:36:31 -0200
From: joserz@linux.vnet.ibm.com
References: <20180209202621.97852-1-yasmins@linux.vnet.ibm.com>
	<baf09d46-934f-1f82-1f68-21ae22ffd2f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <baf09d46-934f-1f82-1f68-21ae22ffd2f9@redhat.com>
Message-Id: <20180209213631.GA23661@pacoca>
Subject: Re: [Qemu-devel] [PATCH v2] dump: Show custom message for ENOSPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org

On Fri, Feb 09, 2018 at 02:57:33PM -0600, Eric Blake wrote:
> On 02/09/2018 02:26 PM, Yasmin Beatriz wrote:
> > This patch intends to make a more specific message for when
> > the system has not enough space to save guest memory.
> > 
> > Reported-by: yilzhang@redhat.com
> > Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> > Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
> > ---
> 
> > @@ -364,7 +364,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
> >       ret = fd_write_vmcore(buf, length, s);
> >       if (ret < 0) {
> > -        error_setg(errp, "dump: failed to save memory");
> > +        if (ret == -ENOSPC) {
> > +            error_setg(errp, "dump: not enough space to save memory");
> > +        } else {
> > +            error_setg(errp, "dump: failed to save memory");
> > +        }
> 
> Why is this caller the only one in the file that gets distinguished error
> messages?  And why not use error_setg_errno() instead of open-coding just
> one special errno value?  If you're changing the return value of
> fd_write_vmcore() anyways, I'd suggest that ALL callers in the file be
> updated to use error_setg_errno().

Hello Eric, thanks for reviewing it! :)

Yes, only this part has this distiguished error handling because
the whole big amount of data is managed in here, as far as we can tell
it.

It's triggered when you have one of those huge memory guests that
crashes and want to dump its memory into a host that can't offer all
these requirements. AFAIK, other callers doesn't handle so much data,
so we decided to handle only in this part to be the less intrusive
possible.

Your suggestions will be applied then!

> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
